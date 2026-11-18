class Cccc < Formula
  desc "Measure Cognitive and Cyclomatic Complexity of source code"
  homepage "https://github.com/moznion/cccc"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.9.2/cccc-v1.9.2-aarch64-apple-darwin.tar.gz"
      sha256 "8e8166931165add165dd7854b39a00c499087b45f566728367b49ad4117c069d"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.9.2/cccc-v1.9.2-x86_64-apple-darwin.tar.gz"
      sha256 "ef282c7a33932e2e9c8515ea3316ed97b245a010d365bf0de6645800a97723ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/moznion/cccc/releases/download/v1.9.2/cccc-v1.9.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3688ac31b37d84905a3190c09747f7cbc7c7b36a094495cd65468c28a5315fe6"
    end
    on_intel do
      url "https://github.com/moznion/cccc/releases/download/v1.9.2/cccc-v1.9.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "eb964d5fa9daa8cb557499722865cd89cbd77764485899ddce4e0a5a2cb667a5"
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
