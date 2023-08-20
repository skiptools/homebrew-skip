cask "skip" do
  version "0.5.87"
  sha256 "d6ada9c368659a593c127de608ad43d36c8d0f5a730a5813e215f557ec1c5cca"

  url "https://github.com/skiptools/skip/releases/download/#{version}/skip.zip",
      verified: "github.com/skiptools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
  #depends_on cask: "android-studio"
  depends_on macos: ">= :mojave"

  binary "skip"

  postflight do
    system "xattr", "-c", "#{staged_path}/skip"
  end
end
