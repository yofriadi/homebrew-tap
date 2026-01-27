class Opencode < Formula
  desc "The AI coding agent built for terminal with custom fixes"
  homepage "https://github.com/yofriadi/opencode"
  head "https://github.com/yofriadi/opencode.git", branch: "dev"
  license "MIT"

  depends_on "bun"
  depends_on "ripgrep"
  depends_on "git"

  def install
    ENV["BUN_INSTALL"] = "#{HOMEBREW_PREFIX}/bin/bun"

    system "git", "clone", "https://github.com/yofriadi/opencode.git", "."
    system "git", "checkout", "dev"
    system "bun", "install"
    system "bun", "run", "build"

    bin.install "packages/cli/dist/index.js" => "opencode"
  end

  test do
    assert_match "opencode", shell_output("#{bin}/opencode --version")
  end
end