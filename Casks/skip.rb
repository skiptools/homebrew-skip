cask "skip" do
  version "1.6.11"
  sha256 "f1c7855dd065d72c1c5c1134422c9a5ee56b844005eca261f9bbbc9f55246491"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-platform-tools"
  depends_on cask: "android-commandlinetools"
  depends_on macos: ">= :ventura"

  binary "skip.artifactbundle/macos/skip"

  postflight do
    system "xattr", "-c", "#{staged_path}/skip.artifactbundle/macos/skip"
    system "#{staged_path}/skip.artifactbundle/macos/skip", "welcome", "--first-run"
  end

  caveats do
    license "https://skip.tools/eula"
  end
end
