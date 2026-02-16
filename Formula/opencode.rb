class Opencode < Formula
  desc "AI coding agent"
  homepage "https://github.com/yofriadi/opencode"
  url "https://github.com/yofriadi/opencode/releases/download/v1.1.51-20260205/ocn-darwin-arm64.zip"
  version "1.1.51-20260205"
  sha256 "3cb56c01d1b93529c8011988e104553a96aed3103c656426d7beec66b176e88b"
  license "MIT"

  depends_on :macos
  depends_on "ripgrep"

  def install
    bin.install "opencode" => "oc"
  end

  def caveats
    <<~EOS
      Opencode has been installed as:
        oc
    EOS
  end

  test do
    assert_match "opencode", shell_output("#{bin}/oc --version")
  end
end
