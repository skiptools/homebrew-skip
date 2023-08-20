cask "skip" do
  version "0.5.89"
  sha256 "e635676bd204f020e430ae0a3e0a8355c3ca6a54d9efaa117dad27ff17f02be2"

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
