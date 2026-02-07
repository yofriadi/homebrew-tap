class PiAgentRust < Formula
  desc "High-performance AI coding agent CLI written in Rust"
  homepage "https://github.com/Dicklesworthstone/pi_agent_rust"
  url "https://github.com/Dicklesworthstone/pi_agent_rust.git",
    branch: "main",
    revision: "0b29275dfad309dc1c4bd0714af188af8e5c4b53"
  version "0.1.0"
  license "MIT"

  depends_on "fd" => :recommended
  depends_on "ripgrep" => :recommended
  depends_on "rust" => :build

  def install
    system "cargo", "install", "--path", ".", "--no-default-features"
    bin.install "target/release/pi" => "pir"
  end

  test do
    assert_match "pi", shell_output("#{bin}/pir --version")
  end
end
