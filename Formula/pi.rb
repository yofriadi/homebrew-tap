class Pi < Formula
  desc "AI coding agent CLI"
  homepage "https://github.com/yofriadi/pi-bun-mono"
  version "0.52.9"
  revision 2
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/yofriadi/pi-bun-mono/releases/download/v#{version}/pi-darwin-arm64.tar.gz"
      sha256 "8ddf93c2288ce2635725fc8c0015fb138e9af8991edde0c528206ae21c5b68f4"
    else
      url "https://github.com/yofriadi/pi-bun-mono/releases/download/v#{version}/pi-darwin-x64.tar.gz"
      sha256 "2f105b01bc3b43815d4b51bc527f1acfd666f2d02d33ca0c91fabb22077876a5"
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
