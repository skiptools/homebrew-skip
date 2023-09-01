cask "skip" do
  version "0.6.11"
  sha256 "84dbebfad58613a64ffded8921ee77c74bdbb70542fcb57224223e60734872e9"

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
    system "#{staged_path}/skip", "welcome", "--first-run"
  end
end
