cask "skip" do
  version "0.5.78"
  sha256 "be60f991736b60f10fb01a055ee014efd9f9fa40c2565423055ff9dcd75d2c84"

  url "https://github.com/skiptools/skip/releases/download/#{version}/skipstone.plugin.zip",
      verified: "github.com/skiptools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
  #depends_on cask: "android-studio"
  depends_on macos: ">= :mojave"

  binary "skipstone.artifactbundle/skipstone"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/skipstone.artifactbundle/skipstone"
  end
end
