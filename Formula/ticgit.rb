class Ticgit < Formula
  desc "Git-native, distributed issue tracker"
  homepage "https://github.com/schacon/ticgit"
  url "https://github.com/schacon/ticgit/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "04f9fa1532ac4e32054c66a0e1e0053bcca92332299f3f0b7afd8cf9787acbfc"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/yofriadi/homebrew-tap/releases/download/ticgit-0.3.1_1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9d3f5cd4dcecf973706410f5fd1ed25c6ae40ab015057680b2fe694aedef1137"
  end

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/ticgit")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ti --version")
  end
end
