class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  bottle do
    root_url "https://github.com/yofriadi/homebrew-tap/releases/download/cccc-1.7.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d6eca0c782b454ac1b15ff28336d5ca32901ddf645a374dbfdd78263d33438a8"
  end

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.7.0/cccc-v1.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "babeea26b5304e41ed503b799a59924bbe90b44806bd2ad176e643159fb7213b"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.7.0/cccc-v1.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "ac3edcd5e64c26933b18952df350401e1379220208cb78a414d8d4c3f1879d2e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.7.0/cccc-v1.7.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f775a19ebd58fc7a4cd64769b8d442425d8afde66207386db04eb87747ed75b8"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.7.0/cccc-v1.7.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "75d2fb5486238eeb40a80fec2de8fe5075e6ce567b6741a56fa511ed2082e45a"
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
