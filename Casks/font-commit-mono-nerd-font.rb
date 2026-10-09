cask "font-commit-mono-nerd-font" do
  version "1.143"
  sha256 "759db44ceb9e905c7ce2755e69c3a590d8dc8a3955196a33173d45ade5121674"

  url "https://github.com/yofriadi/homebrew-tap/releases/download/commit-mono-v#{version}/CommitMonoNerdFont-v#{version}.tar.xz"
  name "Commit Mono Nerd Font"
  desc "Anonymous and neutral programming typeface with Nerd Font glyphs and named weights"
  homepage "https://commitmono.com/"

  livecheck do
    url "https://api.github.com/repos/eigilnikolajsen/commit-mono/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.sub(/^v/, "")
    end
  end

  font "CommitMonoNerdFont-Bold.otf"
  font "CommitMonoNerdFont-BoldItalic.otf"
  font "CommitMonoNerdFont-ExtraBold.otf"
  font "CommitMonoNerdFont-ExtraBoldItalic.otf"
  font "CommitMonoNerdFont-ExtraLight.otf"
  font "CommitMonoNerdFont-ExtraLightItalic.otf"
  font "CommitMonoNerdFont-Italic.otf"
  font "CommitMonoNerdFont-Light.otf"
  font "CommitMonoNerdFont-LightItalic.otf"
  font "CommitMonoNerdFont-Medium.otf"
  font "CommitMonoNerdFont-MediumItalic.otf"
  font "CommitMonoNerdFont-Regular.otf"
  font "CommitMonoNerdFont-SemiBold.otf"
  font "CommitMonoNerdFont-SemiBoldItalic.otf"
  font "CommitMonoNerdFont-Thin.otf"
  font "CommitMonoNerdFont-ThinItalic.otf"
  font "CommitMonoNerdFontMono-Bold.otf"
  font "CommitMonoNerdFontMono-BoldItalic.otf"
  font "CommitMonoNerdFontMono-ExtraBold.otf"
  font "CommitMonoNerdFontMono-ExtraBoldItalic.otf"
  font "CommitMonoNerdFontMono-ExtraLight.otf"
  font "CommitMonoNerdFontMono-ExtraLightItalic.otf"
  font "CommitMonoNerdFontMono-Italic.otf"
  font "CommitMonoNerdFontMono-Light.otf"
  font "CommitMonoNerdFontMono-LightItalic.otf"
  font "CommitMonoNerdFontMono-Medium.otf"
  font "CommitMonoNerdFontMono-MediumItalic.otf"
  font "CommitMonoNerdFontMono-Regular.otf"
  font "CommitMonoNerdFontMono-SemiBold.otf"
  font "CommitMonoNerdFontMono-SemiBoldItalic.otf"
  font "CommitMonoNerdFontMono-Thin.otf"
  font "CommitMonoNerdFontMono-ThinItalic.otf"
end
