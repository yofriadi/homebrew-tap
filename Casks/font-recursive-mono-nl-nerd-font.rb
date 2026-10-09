cask "font-recursive-mono-nl-nerd-font" do
  version "1.085"
  sha256 "3a39cdcf420c14e4a675230d0709c34dc7572a905685a908b01452c7d142f698"

  url "https://github.com/yofriadi/homebrew-tap/releases/download/recursive-v#{version}/RecMonoLinearNLNerdFont-v#{version}.tar.xz"
  name "Recursive Mono Linear NL Nerd Font"
  desc "Variable-inspired programming font without ligatures, patched with Nerd Font glyphs"
  homepage "https://www.recursive.design/"

  livecheck do
    url "https://api.github.com/repos/arrowtype/recursive/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.sub(/^v/, "")
    end
  end

  font "RecMonoLinearNLNerdFont-Black.otf"
  font "RecMonoLinearNLNerdFont-BlackItalic.otf"
  font "RecMonoLinearNLNerdFont-Bold.otf"
  font "RecMonoLinearNLNerdFont-BoldItalic.otf"
  font "RecMonoLinearNLNerdFont-ExtraBlack.otf"
  font "RecMonoLinearNLNerdFont-ExtraBlackItalic.otf"
  font "RecMonoLinearNLNerdFont-ExtraBold.otf"
  font "RecMonoLinearNLNerdFont-ExtraBoldItalic.otf"
  font "RecMonoLinearNLNerdFont-Italic.otf"
  font "RecMonoLinearNLNerdFont-Light.otf"
  font "RecMonoLinearNLNerdFont-LightItalic.otf"
  font "RecMonoLinearNLNerdFont-Medium.otf"
  font "RecMonoLinearNLNerdFont-MediumItalic.otf"
  font "RecMonoLinearNLNerdFont-Regular.otf"
  font "RecMonoLinearNLNerdFont-SemiBold.otf"
  font "RecMonoLinearNLNerdFont-SemiBoldItalic.otf"
  font "RecMonoLinearNLNerdFontMono-Black.otf"
  font "RecMonoLinearNLNerdFontMono-BlackItalic.otf"
  font "RecMonoLinearNLNerdFontMono-Bold.otf"
  font "RecMonoLinearNLNerdFontMono-BoldItalic.otf"
  font "RecMonoLinearNLNerdFontMono-ExtraBlack.otf"
  font "RecMonoLinearNLNerdFontMono-ExtraBlackItalic.otf"
  font "RecMonoLinearNLNerdFontMono-ExtraBold.otf"
  font "RecMonoLinearNLNerdFontMono-ExtraBoldItalic.otf"
  font "RecMonoLinearNLNerdFontMono-Italic.otf"
  font "RecMonoLinearNLNerdFontMono-Light.otf"
  font "RecMonoLinearNLNerdFontMono-LightItalic.otf"
  font "RecMonoLinearNLNerdFontMono-Medium.otf"
  font "RecMonoLinearNLNerdFontMono-MediumItalic.otf"
  font "RecMonoLinearNLNerdFontMono-Regular.otf"
  font "RecMonoLinearNLNerdFontMono-SemiBold.otf"
  font "RecMonoLinearNLNerdFontMono-SemiBoldItalic.otf"
end
