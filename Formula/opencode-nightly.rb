class OpencodeNightly < Formula
  desc "The AI coding agent (Nightly Fork)"
  homepage "https://github.com/yofriadi/opencode"
  version "1.1.39-20260128"
  license "MIT"

  depends_on "ripgrep"

  url "https://github.com/yofriadi/opencode/releases/download/v#{version}/ocn-darwin-arm64.zip"
  sha256 "bbc9461b286e9ea68c2802e0331e0c330178bfa52852b88fdac08d5a2754b981"

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
