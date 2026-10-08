#!/usr/bin/env bash
set -euo pipefail

# Check latest upstream version
UPSTREAM_TAG=$(gh api repos/moznion/cccc/releases/latest --jq .tag_name)
UPSTREAM_VER="${UPSTREAM_TAG#v}"

# Extract current version from Formula/cccc.rb
CURRENT_VER=$(grep -oE 'releases/download/v[0-9.]+' Formula/cccc.rb | head -1 | sed 's#releases/download/v##')

echo "Current version in tap: $CURRENT_VER"
echo "Latest upstream version: $UPSTREAM_VER"

FORCE="${1:-false}"

if [ "$FORCE" != "true" ] && { [ -z "$UPSTREAM_VER" ] || [ "$UPSTREAM_VER" = "$CURRENT_VER" ]; }; then
  echo "Formula is already up-to-date."
  exit 0
fi

BRANCH="cccc-${UPSTREAM_VER}"

# Check if PR already exists
if gh pr list --head "$BRANCH" --state all --json number --jq '.[0].number' 2>/dev/null | grep -q '^[0-9]'; then
  echo "Pull request or branch for $BRANCH already exists. Skipping."
  exit 0
fi

# Fetch checksums from upstream release assets
BASE_URL="https://github.com/moznion/cccc/releases/download/${UPSTREAM_TAG}"
SHA_MAC_ARM=$(curl -sSfL "${BASE_URL}/cccc-${UPSTREAM_TAG}-aarch64-apple-darwin.sha256" | awk '{print $1}')
SHA_MAC_INTEL=$(curl -sSfL "${BASE_URL}/cccc-${UPSTREAM_TAG}-x86_64-apple-darwin.sha256" | awk '{print $1}')
SHA_LINUX_ARM=$(curl -sSfL "${BASE_URL}/cccc-${UPSTREAM_TAG}-aarch64-unknown-linux-musl.sha256" | awk '{print $1}')
SHA_LINUX_INTEL=$(curl -sSfL "${BASE_URL}/cccc-${UPSTREAM_TAG}-x86_64-unknown-linux-musl.sha256" | awk '{print $1}')

if [ -z "$SHA_MAC_ARM" ] || [ -z "$SHA_MAC_INTEL" ] || [ -z "$SHA_LINUX_ARM" ] || [ -z "$SHA_LINUX_INTEL" ]; then
  echo "Error: Failed to fetch all required checksums for ${UPSTREAM_TAG}."
  exit 1
fi

git checkout -b "$BRANCH"

cat <<EOF > Formula/cccc.rb
class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "${BASE_URL}/cccc-${UPSTREAM_TAG}-aarch64-apple-darwin.tar.gz"
      sha256 "${SHA_MAC_ARM}"
    end
    on_intel do
      url "${BASE_URL}/cccc-${UPSTREAM_TAG}-x86_64-apple-darwin.tar.gz"
      sha256 "${SHA_MAC_INTEL}"
    end
  end

  on_linux do
    on_arm do
      url "${BASE_URL}/cccc-${UPSTREAM_TAG}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "${SHA_LINUX_ARM}"
    end
    on_intel do
      url "${BASE_URL}/cccc-${UPSTREAM_TAG}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "${SHA_LINUX_INTEL}"
    end
  end

  def install
    bin.install "cccc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cccc --version")
    (testpath/"test.rs").write <<~RUST
      fn main() {
        println!("hello");
      }
    RUST
    assert_match "cyclomatic", shell_output("#{bin}/cccc test.rs")
  end
end
EOF

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add Formula/cccc.rb
git commit -m "cccc: bump to ${UPSTREAM_VER}"
git push -u origin "$BRANCH"

gh pr create \
  --base master \
  --head "$BRANCH" \
  --title "cccc: bump to ${UPSTREAM_VER}" \
  --body "Automated version bump for \`cccc\` to \`${UPSTREAM_VER}\`."
