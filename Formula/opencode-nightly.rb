class OpencodeNightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  url "https://github.com/yofriadi/opencode.git", branch: "dev"
  version "0.0.1"

  license "MIT"

  depends_on "oven-sh/bun/bun"
  depends_on "ripgrep"
  depends_on "git"

  def install
    system "bun", "install"

    cd "packages/opencode" do
      system "bun", "run", "build", "--", "--single"
    end

    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    name = "opencode-#{platform}-#{arch}"
    bin.install "packages/opencode/dist/#{name}/bin/opencode" => "ocn"
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
