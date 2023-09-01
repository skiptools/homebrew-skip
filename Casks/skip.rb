cask "skip" do
  version "0.6.10"
  sha256 "d548b1e7a24b93d5c6bdf5f7c7af6c450d593bb09456e75ea8e5c24725744919"

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
    system "#{staged_path}/skip", "welcome"
  end
end
