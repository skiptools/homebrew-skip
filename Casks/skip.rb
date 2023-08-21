cask "skip" do
  version "0.5.93"
  sha256 "7114110692a9554645b3b2bf356f75148de50808fefec3e4bb283a42afc8c835"

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
