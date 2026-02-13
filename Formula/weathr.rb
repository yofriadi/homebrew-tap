class Weathr < Formula
  desc "Weather CLI"
  homepage "https://github.com/veirt/weathr"
  url "https://github.com/veirt/weathr/archive/refs/tags/v1.2.3.tar.gz"
  sha256 "705aef1706e08dff92979f960f9534e8c02cb81ac8b2c0325e2b86dca05a5ff6"
  license "GPL-3.0-only"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/weathr --version")
  end
end
