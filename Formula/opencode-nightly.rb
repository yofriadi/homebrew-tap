class OpencodeNightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  version "1.1.36-20260127"
  license "MIT"

  depends_on "ripgrep"

  url "https://github.com/yofriadi/opencode/releases/download/v#{version}/ocn-darwin-arm64.zip"
  sha256 "75d566c6286e417cc0c4fba7d73b5c1d9dc1a06cba71c1b517c8d069c1a31ae5"

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
