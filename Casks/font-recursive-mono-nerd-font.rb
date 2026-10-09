cask "font-recursive-mono-nerd-font" do
  version "1.085"
  sha256 "2f97cdb4ffa8d92b8b10c5087d562c6b40356980826bf1d5455f928a28936092"

  url "https://github.com/yofriadi/homebrew-tap/releases/download/recursive-v#{version}/RecMonoLinearNerdFont-v#{version}.tar.xz"
  name "Recursive Mono Linear Nerd Font"
  desc "Variable-inspired programming font with all weights, patched with Nerd Font glyphs"
  homepage "https://www.recursive.design/"

  livecheck do
    url "https://api.github.com/repos/arrowtype/recursive/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.sub(/^v/, "")
    end
  end

  font "RecMonoLinearNerdFont-Black.otf"
  font "RecMonoLinearNerdFont-BlackItalic.otf"
  font "RecMonoLinearNerdFont-Bold.otf"
  font "RecMonoLinearNerdFont-BoldItalic.otf"
  font "RecMonoLinearNerdFont-ExtraBlack.otf"
  font "RecMonoLinearNerdFont-ExtraBlackItalic.otf"
  font "RecMonoLinearNerdFont-ExtraBold.otf"
  font "RecMonoLinearNerdFont-ExtraBoldItalic.otf"
  font "RecMonoLinearNerdFont-Italic.otf"
  font "RecMonoLinearNerdFont-Light.otf"
  font "RecMonoLinearNerdFont-LightItalic.otf"
  font "RecMonoLinearNerdFont-Medium.otf"
  font "RecMonoLinearNerdFont-MediumItalic.otf"
  font "RecMonoLinearNerdFont-Regular.otf"
  font "RecMonoLinearNerdFont-SemiBold.otf"
  font "RecMonoLinearNerdFont-SemiBoldItalic.otf"
  font "RecMonoLinearNerdFontMono-Black.otf"
  font "RecMonoLinearNerdFontMono-BlackItalic.otf"
  font "RecMonoLinearNerdFontMono-Bold.otf"
  font "RecMonoLinearNerdFontMono-BoldItalic.otf"
  font "RecMonoLinearNerdFontMono-ExtraBlack.otf"
  font "RecMonoLinearNerdFontMono-ExtraBlackItalic.otf"
  font "RecMonoLinearNerdFontMono-ExtraBold.otf"
  font "RecMonoLinearNerdFontMono-ExtraBoldItalic.otf"
  font "RecMonoLinearNerdFontMono-Italic.otf"
  font "RecMonoLinearNerdFontMono-Light.otf"
  font "RecMonoLinearNerdFontMono-LightItalic.otf"
  font "RecMonoLinearNerdFontMono-Medium.otf"
  font "RecMonoLinearNerdFontMono-MediumItalic.otf"
  font "RecMonoLinearNerdFontMono-Regular.otf"
  font "RecMonoLinearNerdFontMono-SemiBold.otf"
  font "RecMonoLinearNerdFontMono-SemiBoldItalic.otf"
end
