cask "skip" do
  version "0.6.38"
  sha256 "c7bda572ab4748223a565dbd6e26307c76ae4f2eb92e9b22650f78071aecf782"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
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
