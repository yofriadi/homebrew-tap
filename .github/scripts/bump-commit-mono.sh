#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

cd "${REPO_ROOT}"

# Check latest upstream version
UPSTREAM_TAG=$(gh api repos/eigilnikolajsen/commit-mono/releases/latest --jq .tag_name)
UPSTREAM_VER="${UPSTREAM_TAG#v}"

# Extract current version from Casks/font-commit-mono.rb
CURRENT_VER=$(grep -E '^\s*version\s+"' Casks/font-commit-mono.rb | head -1 | sed -E 's/.*version "([^"]+)".*/\1/')

echo "Current version in tap: ${CURRENT_VER}"
echo "Latest upstream version: ${UPSTREAM_VER}"

FORCE="${1:-false}"

if [ "${FORCE}" != "true" ] && { [ -z "${UPSTREAM_VER}" ] || [ "${UPSTREAM_VER}" = "${CURRENT_VER}" ]; }; then
  echo "font-commit-mono is already up-to-date."
  exit 0
fi

BRANCH="commit-mono-${UPSTREAM_VER}"

# Check if PR already exists
if gh pr list --head "${BRANCH}" --state all --json number --jq '.[0].number' 2>/dev/null | grep -q '^[0-9]'; then
  echo "Pull request or branch for ${BRANCH} already exists. Skipping."
  exit 0
fi

RELEASE_TAG="commit-mono-v${UPSTREAM_VER}"
ZIP_NAME="CommitMono-all-v${UPSTREAM_VER}.zip"

# Build the all-variants archive
node "${SCRIPT_DIR}/build-commit-mono.mjs" "${UPSTREAM_VER}" "${ZIP_NAME}"

SHA=$(shasum -a 256 "${ZIP_NAME}" | awk '{print $1}')
echo "Generated ${ZIP_NAME} with sha256: ${SHA}"

# Create GitHub release on yofriadi/homebrew-tap if it does not already exist
if ! gh release view "${RELEASE_TAG}" >/dev/null 2>&1; then
  echo "Creating release ${RELEASE_TAG}..."
  gh release create "${RELEASE_TAG}" "${ZIP_NAME}" \
    --title "Commit Mono All Variants v${UPSTREAM_VER}" \
    --notes "Automated all-variants release of Commit Mono v${UPSTREAM_VER} for Homebrew tap."
else
  echo "Release ${RELEASE_TAG} already exists, uploading asset..."
  gh release upload "${RELEASE_TAG}" "${ZIP_NAME}" --clobber
fi

rm -f "${ZIP_NAME}"

git checkout -b "${BRANCH}"

cat <<EOF > Casks/font-commit-mono.rb
cask "font-commit-mono" do
  version "${UPSTREAM_VER}"
  sha256 "${SHA}"

  url "https://github.com/yofriadi/homebrew-tap/releases/download/${RELEASE_TAG}/CommitMono-all-v#{version}.zip"
  name "Commit Mono"
  homepage "https://commitmono.com/"

  livecheck do
    url "https://github.com/eigilnikolajsen/commit-mono/releases"
    strategy :github_latest
  end

  font "CommitMono-200-Italic.otf"
  font "CommitMono-200-Regular.otf"
  font "CommitMono-225-Italic.otf"
  font "CommitMono-225-Regular.otf"
  font "CommitMono-250-Italic.otf"
  font "CommitMono-250-Regular.otf"
  font "CommitMono-275-Italic.otf"
  font "CommitMono-275-Regular.otf"
  font "CommitMono-300-Italic.otf"
  font "CommitMono-300-Regular.otf"
  font "CommitMono-325-Italic.otf"
  font "CommitMono-325-Regular.otf"
  font "CommitMono-350-Italic.otf"
  font "CommitMono-350-Regular.otf"
  font "CommitMono-375-Italic.otf"
  font "CommitMono-375-Regular.otf"
  font "CommitMono-400-Italic.otf"
  font "CommitMono-400-Regular.otf"
  font "CommitMono-425-Italic.otf"
  font "CommitMono-425-Regular.otf"
  font "CommitMono-450-Italic.otf"
  font "CommitMono-450-Regular.otf"
  font "CommitMono-475-Italic.otf"
  font "CommitMono-475-Regular.otf"
  font "CommitMono-500-Italic.otf"
  font "CommitMono-500-Regular.otf"
  font "CommitMono-525-Italic.otf"
  font "CommitMono-525-Regular.otf"
  font "CommitMono-550-Italic.otf"
  font "CommitMono-550-Regular.otf"
  font "CommitMono-575-Italic.otf"
  font "CommitMono-575-Regular.otf"
  font "CommitMono-600-Italic.otf"
  font "CommitMono-600-Regular.otf"
  font "CommitMono-625-Italic.otf"
  font "CommitMono-625-Regular.otf"
  font "CommitMono-650-Italic.otf"
  font "CommitMono-650-Regular.otf"
  font "CommitMono-675-Italic.otf"
  font "CommitMono-675-Regular.otf"
  font "CommitMono-700-Italic.otf"
  font "CommitMono-700-Regular.otf"
  font "CommitMono-VF.ttf"

  # No zap stanza required
end
EOF

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add Casks/font-commit-mono.rb
git commit -m "font-commit-mono: bump to ${UPSTREAM_VER}"
git push -u origin "${BRANCH}"

gh pr create \
  --base master \
  --head "${BRANCH}" \
  --title "font-commit-mono: bump to ${UPSTREAM_VER}" \
  --body "Automated version bump for \`font-commit-mono\` all-variants to \`${UPSTREAM_VER}\`."
