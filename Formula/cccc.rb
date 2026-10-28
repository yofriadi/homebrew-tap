class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.5/cccc-v1.8.5-aarch64-apple-darwin.tar.gz"
      sha256 "486ded852eaa3483956acde058e32b3616a4883c84ba1f424852680e61963801"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.5/cccc-v1.8.5-x86_64-apple-darwin.tar.gz"
      sha256 "9ef0ad139665f0ecccecbb183cc851c87068d7bbf4fb9f1e572387b871a47ea8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.5/cccc-v1.8.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "62004c8f7bfd5c452a5e0afe54248919d7f3156ab707c24d33715566ffc3182e"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.5/cccc-v1.8.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7419ea8d8828c3d405694be400da1b21cdb854e9af1c10110d5d970bc1700094"
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
