class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.0/cccc-v1.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "a238b8f121291f81df68359c111a9ba49cf48106fbedda63f4a48f1adc092408"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.0/cccc-v1.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "3b36ec66a6822f36dbcfd3e353fb1804e98e8160f1e12acb5331b692101b4cf2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.8.0/cccc-v1.8.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ba179065369af907b1f6dd4bd7c50c4f99567159882c2f6a004e7b32234c7469"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.8.0/cccc-v1.8.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0350111e3b649c327e62c99da0a35c77f65884f5e4279a968f4371f73a6a5480"
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
