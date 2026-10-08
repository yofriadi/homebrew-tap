class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.7.1/cccc-v1.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "bb80e21b0a0ef19a08dbb7e86cb87718d1b4960976cc6600c7f1fa7373c1848a"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.7.1/cccc-v1.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "3dcde2f100558213a5acb96a54c8e9c8fd495a4caf18cef3a8522b3c673262fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.7.1/cccc-v1.7.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1dc67123cac31a20d4b316ba596e369daf02f35c378dd9052d0e64c92ad43177"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.7.1/cccc-v1.7.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6b7688d357da22b37a3f4129a1f0ec84d1f2ff97b015ea40fc8dfa4c778e5373"
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
