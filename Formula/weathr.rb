class Weathr < Formula
  desc "Weather CLI"
  homepage "https://github.com/veirt/weathr"
  url "https://github.com/veirt/weathr/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "88eebe264fc874be24b0f250d19b48eaecf050b268af6f333ec1ce6da13a30f0"
  license "GPL-3.0-only"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/weathr --version")
  end
end
