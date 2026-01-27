class OpencodeNightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  version "0.0.1"

  license "MIT"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/yofriadi/opencode/releases/download/v#{version}/opencode-nightly-darwin-arm64.zip"
      sha256 :no_check
    else
      url "https://github.com/yofriadi/opencode/releases/download/v#{version}/opencode-nightly-darwin-x64.zip"
      sha256 :no_check
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/yofriadi/opencode/releases/download/v#{version}/opencode-nightly-linux-arm64.tar.gz"
      sha256 :no_check
    else
      url "https://github.com/yofriadi/opencode/releases/download/v#{version}/opencode-nightly-linux-x64.tar.gz"
      sha256 :no_check
    end
  end

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
