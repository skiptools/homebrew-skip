cask "skip" do
  version "0.5.94"
  sha256 "b2e54b5ac717e122524b04e8476ecb5c3e3fe76eab4a6be30c450c934e40ac2d"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
  depends_on macos: ">= :ventura"

  binary "skip"

  postflight do
    system "xattr", "-c", "#{staged_path}/skip"
  end
end
