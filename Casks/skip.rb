cask "skip" do
  version "0.5.88"
  sha256 "ab8bb0889150c5564de8c852d0f09054a7290c0a00dfba5d120f318c44b8addb"

  url "https://github.com/skiptools/skip/releases/download/#{version}/skip.zip",
      verified: "github.com/skiptools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
  #depends_on cask: "android-studio"
  depends_on macos: ">= :mojave"

  binary "skip"

  postflight do
    system "xattr", "-c", "#{staged_path}/skip"
  end
end
