class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.4/cccc-v1.8.4-aarch64-apple-darwin.tar.gz"
      sha256 "f8f015ce3ec60db09bb6823aae9dc9e6bfdb13d79ae50a1bcfd3518357deeda9"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.4/cccc-v1.8.4-x86_64-apple-darwin.tar.gz"
      sha256 "4fde0cf0eec82dc78a0587f1bfae5ecf154bfb2f3959cff9deba2b35d430c662"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.4/cccc-v1.8.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "caad978e8595db0ba07585aad6b63affdee0d28f191b620d1cfd02e51e31186b"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.4/cccc-v1.8.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "64b3084e05cf2f75d4af57268a2b898526c04be7bc31d0a36708081b13a64f97"
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
