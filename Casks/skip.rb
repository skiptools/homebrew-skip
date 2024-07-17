cask "skip" do
  version "0.10.5"
  sha256 "8f0ca029d632393186ffd5e3f8e14ee9cc75b7a63b55a4c792568961c663ac7b"

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
