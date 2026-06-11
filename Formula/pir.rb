class Pir < Formula
  desc "AI coding agent CLI (Rust implementation)"
  homepage "https://github.com/Dicklesworthstone/pi_agent_rust"
  url "https://github.com/Dicklesworthstone/pi_agent_rust/releases/download/v0.1.2/pi"
  version "0.1.2"
  sha256 "4c25523eb4d4230dc87fab2b0de5d900e81bf08df2eb8cc70f899f8ffbf88cfa"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/pi_agent_rust/releases/download/v0.1.2/pi-aarch64-apple-darwin"
      sha256 "9212f6fedca80e459372709cfb31c594aec917ab2aefbb07ca880b561739716c"
    end
  end

  def install
    binary_name = Hardware::CPU.arm? ? "pi-aarch64-apple-darwin" : "pi"
    bin.install binary_name => "pir"
  end

  test do
    assert_match "0.1.2", shell_output("#{bin}/pir --version")
  end
end
