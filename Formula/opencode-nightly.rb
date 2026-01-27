class OpencodeNightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  version "2026.01.27"

  license "MIT"

  depends_on "ripgrep"

  url "https://github.com/yofriadi/opencode/releases/download/v#{version}/ocn-darwin-arm64.zip"
  sha256 "add3f2c743c9fad4ed415b7464214debd2ca43e58e4ac482909c00724f5eba21"

  def install
    bin.install "opencode" => "ocn"
  end

  def caveats
    <<~EOS
      Your fork of opencode has been installed as:
        ocn

      This prevents conflicts with the official 'opencode' binary.
    EOS
  end

  test do
    assert_match "opencode", shell_output("#{bin}/ocn --version")
  end
end
