class Pi < Formula
  desc "AI coding agent CLI"
  homepage "https://github.com/yofriadi/pi-bun-mono"
  version "0.52.9"
  revision 1
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/yofriadi/pi-bun-mono/releases/download/v#{version}/pi-darwin-arm64.tar.gz"
      sha256 "c4551cd1f859114846aadfb33f47f0327fa1ce243d6c619411dc3ee9ab3ac8d8"
    else
      url "https://github.com/yofriadi/pi-bun-mono/releases/download/v#{version}/pi-darwin-x64.tar.gz"
      sha256 "0ff8350b7f2833586318a4076e8fc910f27839543fbd7212dd44d406dec154e5"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"pi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pi --version")
  end
end
