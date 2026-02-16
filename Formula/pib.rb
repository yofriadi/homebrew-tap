class Pib < Formula
  desc "AI coding agent CLI (pi Bun fork)"
  homepage "https://github.com/yofriadi/pi-bun-mono"
  url "https://github.com/yofriadi/pi-bun-mono/releases/download/v0.52.12/pi-darwin-x64.tar.gz"
  sha256 "33c0026169448d995493b7e621019a374f5351e2ff978fd21fbe6f97177b0c57"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/yofriadi/pi-bun-mono/releases/download/v0.52.12/pi-darwin-arm64.tar.gz"
      sha256 "3ad99379246a26428a724f62b767ec534e9d62bd157c8149e108bd4ebdf22ef3"
    end
  end

  def install
    libexec.install Dir["*"]

    # Keep upstream metadata so pib shares the same config tree as pi (~/.pi/agent).
    bin.install_symlink libexec/"pi" => "pib"
  end

  test do
    assert_match "0.52.12", shell_output("#{bin}/pib --version")
    assert_match "AI coding assistant", shell_output("#{bin}/pib --help")
  end
end
