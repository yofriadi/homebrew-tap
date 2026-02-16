class Weathr < Formula
  desc "Weather CLI"
  homepage "https://github.com/veirt/weathr"
  url "https://github.com/veirt/weathr/archive/refs/tags/v1.2.3.tar.gz"
  sha256 "705aef1706e08dff92979f960f9534e8c02cb81ac8b2c0325e2b86dca05a5ff6"
  license "GPL-3.0-only"
  revision 4

  bottle do
    root_url "https://github.com/yofriadi/homebrew-tap/releases/download/weathr-1.2.3_3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "603f648be1d475c460ed8ab05b9c915ecec559f51d75b6c4c79d269c69deaa0b"
  end

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/weathr --version")
  end
end
