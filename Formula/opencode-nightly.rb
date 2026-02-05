class OpencodeNightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  version "1.1.51-20260205"
  license "MIT"

  depends_on "ripgrep"

  url "https://github.com/yofriadi/opencode/releases/download/v#{version}/ocn-darwin-arm64.zip"
  sha256 "3cb56c01d1b93529c8011988e104553a96aed3103c656426d7beec66b176e88b"

  def install
    bin.install "opencode" => "ocn"
  end

  def caveats
    <<~EOS
      Your fork of opencode has been installed as:
        ocn

      This prevents conflicts with the official 'opencode' binary.
    EOS
  end

  test do
    assert_match "opencode", shell_output("#{bin}/ocn --version")
  end
end
