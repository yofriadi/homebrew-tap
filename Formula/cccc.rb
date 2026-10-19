class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  bottle do
    root_url "https://github.com/yofriadi/homebrew-tap/releases/download/cccc-1.8.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c40964fba16b04e48f99501a433c1487956cbdf8c68310ec2e93666bcd461393"
  end

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.3/cccc-v1.8.3-aarch64-apple-darwin.tar.gz"
      sha256 "838c487bd646b8223f89b22d2d6da34ee8972bf4d17d4abfe8726b30f3fdae89"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.3/cccc-v1.8.3-x86_64-apple-darwin.tar.gz"
      sha256 "0cc75222bef2b5d730012401c73cd09492f18e2ad1423645415447281a561abd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.3/cccc-v1.8.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8aad9b34f398f32cafb2825dc2e7d68ab2dea51bd00e1bec1d2fb8370c8506f2"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.3/cccc-v1.8.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9596a70e920ca9fd22ea541b773c2ddc6a63af4390da8864ebdfbcdc5949aa97"
    end
  end

  def install
    bin.install "cccc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cccc --version")
    (testpath/"test.rs").write <<~RUST
      fn main() {
        println!("hello");
      }
    RUST
    assert_match "cyclomatic", shell_output("#{bin}/cccc test.rs")
  end
end
