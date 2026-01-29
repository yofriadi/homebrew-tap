class CmdWrapped < Formula
  desc "CLI tool to view Unix shell history statistics"
  homepage "https://github.com/YiNNx/cmd-wrapped"
  version "0.4.1"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/YiNNx/cmd-wrapped/releases/download/v#{version}/cmd-wrapped-arm64-apple-darwin.zip"
    sha256 "4b659cab817f88236fc7f3e6bd1d0deb18d6db7eced88dea803cbc4baa04c1ec"
  else
    url "https://github.com/YiNNx/cmd-wrapped/releases/download/v#{version}/cmd-wrapped-x86_64-apple-darwin.zip"
    sha256 "becccebfd6830cc17b6259edacc3a9daba61a2a3db20d018ef78e0df6a5bb213"
  end

  def install
    binary_name = Hardware::CPU.arm? ? "cmd-wrapped-arm64-apple-darwin" : "cmd-wrapped-x86_64-apple-darwin"
    bin.install binary_name => "cmd-wrapped"
  end

  test do
    system "#{bin}/cmd-wrapped", "--help"
  end
end
