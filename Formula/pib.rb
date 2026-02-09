require "json"

class Pib < Formula
  desc "AI coding agent CLI (pi Bun fork)"
  homepage "https://github.com/yofriadi/pi-bun-mono"
  version "0.52.9"
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

    # Current release archives ship with pi metadata/binary names.
    # Rebrand locally so runtime/help/default config use pib.
    package_json_path = libexec/"package.json"
    package_json = JSON.parse(package_json_path.read)
    package_json["piConfig"] ||= {}
    package_json["piConfig"]["name"] = "pib"
    package_json["piConfig"]["configDir"] = ".pib"
    package_json_path.write(JSON.pretty_generate(package_json))

    bin.install_symlink libexec/"pi" => "pib"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pib --version")
    assert_match "pib - AI coding assistant", shell_output("#{bin}/pib --help")
  end
end
