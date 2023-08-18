cask "skip" do
  version "0.5.82"
  sha256 "f82dac70c017d872d3f0797d0e3359512354bc9ec38150ec042f9ec93d9c4470"

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
