class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.10.1/cccc-v1.10.1-aarch64-apple-darwin.tar.gz"
      sha256 "4289cf624eccb9c0b3f56370a78f0e892dbe5e8e9c3891ec4ed3b22d9d7e81dc"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.10.1/cccc-v1.10.1-x86_64-apple-darwin.tar.gz"
      sha256 "38c4d05eb9e6f19a4197d78dfa00f238e1bc2c679ba8b2fb6b2c5ef70fc39ebb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.10.1/cccc-v1.10.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3cfbcdab8dc02a4ee005e26a60afd6be0a336f3fb32b2c6a6278a4a008259d9b"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.10.1/cccc-v1.10.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ea3bd2de22be84dff572c1fa7b4bd7b739f0f7cdb61585eb13844b80f61ac610"
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
