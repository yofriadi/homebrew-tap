class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.10.0/cccc-v1.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "3437ca355624ddd4b8b45fba3a8bf46465ab1c30a9d68c85af7a026ba254fbc6"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.10.0/cccc-v1.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "a1a74a5b635bae620ed47732005f622faebb731842449c19e17e512ed16be97f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.10.0/cccc-v1.10.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "557813fe1a982993e91fe3e561f0174d76ef60d6965d5a44d2607ece1ec9db69"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.10.0/cccc-v1.10.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a11f0fbd560de11078283a2d54aee0d29cf0061585f45ab45cdb810d95db2a84"
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
