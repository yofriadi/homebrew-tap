class OpencodeNightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  url "https://github.com/yofriadi/opencode.git", branch: "dev"
  version "0.0.1"
  
  license "MIT"

  depends_on "bun"
  depends_on "ripgrep"
  depends_on "git"

  def install
    system "bun", "install"
    system "bun", "run", "build"

    bin.install "packages/cli/dist/index.js" => "opencode-nightly"
  end

  def caveats
    <<~EOS
      Your fork of opencode has been installed as:
        opencode-nightly

      This prevents conflicts with official 'opencode' binary.
    EOS
  end

  test do
    assert_match "opencode", shell_output("#{bin}/opencode-nightly --version")
  end
end