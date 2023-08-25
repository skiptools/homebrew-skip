cask "skip" do
  version "0.6.4"
  sha256 "11590a3577fa616e39f2d7e2242b349d679ac70b90181becb7d11f20b6fa9942"

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
