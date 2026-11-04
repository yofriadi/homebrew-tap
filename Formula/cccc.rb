class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.6/cccc-v1.8.6-aarch64-apple-darwin.tar.gz"
      sha256 "e34d6bc3e41cb945927dadd09a7573b00c61707ed9c180a5a7b31e2ee127b296"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.6/cccc-v1.8.6-x86_64-apple-darwin.tar.gz"
      sha256 "ff4a8937133f524e9f0e4e261d312fbd207aaf73c4e00bde8abe280af63632de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.6/cccc-v1.8.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "12e8ec6268d70ebb77b22f445c969bfe9ca3476853b29e6aa4029bfcb062d526"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.6/cccc-v1.8.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7f31cf0aba7694baa05b7a2e5f4a50af3308d02a3df0dc9778e828b7116aa968"
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
