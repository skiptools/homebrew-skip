cask "skip" do
  version "1.3.6"
  sha256 "a72a6e9a2a9b5755a8cf77ddc437d6a5b97a31701ea7f171b028a31f005e809e"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-platform-tools"
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
