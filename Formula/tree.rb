class Tree < Formula
  desc "Cross-platform tree CLI implemented in Rust by peteretelej"
  homepage "https://github.com/peteretelej/tree"
  version "1.3.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/peteretelej/tree/releases/download/v#{version}/tree-v#{version}-macOS-arm64.tar.gz"
    sha256 "dd11cd1bf0fe6ae06e4a624a3b4084c0fe503ae473c9fb3ab1ac53ed4e25a5c3"
  else
    url "https://github.com/peteretelej/tree/releases/download/v#{version}/tree-v#{version}-macOS-amd64.tar.gz"
    sha256 "80637807d628a3d57fabc2fb56db3c341c26ced3fdc5f429429f21424be29f3b"
  end

  def install
    bin.install "tree"
  end

  test do
    assert_match "tree", shell_output("#{bin}/tree --version")
  end
end
