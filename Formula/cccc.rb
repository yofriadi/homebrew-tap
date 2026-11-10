class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.9.0/cccc-v1.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "94eaa9acc0c0cddfccd219357197d7073035efb6fdd370efe8bbcfaf731020fa"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.9.0/cccc-v1.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "0abca4c87927bf6aa381ae554b7fb627c058e1dd8ae237de54676bcd616abfe9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.9.0/cccc-v1.9.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3306a2c0b74cfaaab4ec9d8718e735bc30aca356450cc54126fb49155bb7b698"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.9.0/cccc-v1.9.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9cd24cc14fd6e1ea66ea8104ff63a46a2058cfec4a4a1531f8fe812bb23fbe20"
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
