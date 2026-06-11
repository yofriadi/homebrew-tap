class Ticgit < Formula
  desc "Git-native, distributed issue tracker"
  homepage "https://github.com/schacon/ticgit"
  url "https://github.com/schacon/ticgit/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "04f9fa1532ac4e32054c66a0e1e0053bcca92332299f3f0b7afd8cf9787acbfc"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/ticgit")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ti --version")
  end
end
