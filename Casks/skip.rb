cask "skip" do
  version "0.7.13"
  sha256 "b97eb0c6c77c853c406462d3cba1e2f4c5ebc7f615fa5e9e182dfcedd2a923fe"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
  depends_on formula: "openjdk@17"
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
