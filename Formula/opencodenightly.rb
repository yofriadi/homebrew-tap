class Opencodenightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  url "https://github.com/yofriadi/opencode.git", branch: "dev"
  version "0.0.1"
  
  license "MIT"

  depends_on "node"
  depends_on "ripgrep"
  depends_on "git"

  def install
    unless which("bun")
      system "sh", "-c", "curl -fsSL https://bun.sh/install | bash"
      ENV.prepend_path "/opt/homebrew/.bun/bin"
    end

    system "bun", "install"
    system "bun", "run", "build"

    bin.install "packages/cli/dist/index.js" => "ocn"
  end

  def caveats
    <<~EOS
      Your fork of opencode has been installed as:
        ocn

      This prevents conflicts with official 'opencode' binary.
    EOS
  end

  test do
    assert_match "opencode", shell_output("#{bin}/ocn --version")
  end
end