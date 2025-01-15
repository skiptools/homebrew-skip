cask "skip" do
  version "1.2.20"
  sha256 "eca8c68f4880aa796bbf9ac25de05adc5c02d5afc454a603699d350285b04e69"

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
