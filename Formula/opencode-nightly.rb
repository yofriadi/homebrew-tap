class OpencodeNightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  version "2026-01-27"
  license "MIT"

  depends_on "ripgrep"

  url "https://github.com/yofriadi/opencode/releases/download/v#{version}/ocn-darwin-arm64.zip"
  sha256 "abec2921148725b6d746f050f7e1ae5c44739e513e73c79a9c0c826732053869"

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
