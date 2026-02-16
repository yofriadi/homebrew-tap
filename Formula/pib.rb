class Pib < Formula
  desc "AI coding agent CLI (pi Bun fork)"
  homepage "https://github.com/yofriadi/pi-bun-mono"
  url "https://github.com/yofriadi/pi-bun-mono/releases/download/v0.52.10/pi-darwin-x64.tar.gz"
  sha256 "a4eb22c01f90ea10003da2023c3b65eabfcbdfb13b9090f94d53d2396b942a44"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/yofriadi/pi-bun-mono/releases/download/v0.52.10/pi-darwin-arm64.tar.gz"
      sha256 "657c7cb75f0085d6d3068f55e469d30e909361f112ecf9cb300e84e396726494"
    end
  end

  def install
    libexec.install Dir["*"]

    # Keep upstream metadata so pib shares the same config tree as pi (~/.pi/agent).
    bin.install_symlink libexec/"pi" => "pib"
  end

  test do
    assert_match "0.52.10", shell_output("#{bin}/pib --version")
    assert_match "AI coding assistant", shell_output("#{bin}/pib --help")
  end
end
