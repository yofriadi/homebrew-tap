class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.9.1/cccc-v1.9.1-aarch64-apple-darwin.tar.gz"
      sha256 "fa3dd60b03c6906ee037980ab3f33ea9e03c064ce33d0d6558b789ca12c8c84f"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.9.1/cccc-v1.9.1-x86_64-apple-darwin.tar.gz"
      sha256 "6e6205104c7af861f6f9082371dfd2f2e465a4ea7b1ec9fb00e7c1ad81ab115d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.9.1/cccc-v1.9.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fd3773d8b143077f8065e8138a433eb4aad03c7266e84ec9845d0ef56f2a2179"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.9.1/cccc-v1.9.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2de53ed83e828319e84a0e2501e28656c4dfe91b6e2e9a012e8d0a5f370151e2"
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
