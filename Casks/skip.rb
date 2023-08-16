cask "skip" do
  version "0.5.74"
  sha256 "9609b98945d8182edabfbaa41dc5de0ebe3bfaa3d9c0886cfc7d37f7ec5c9142"

  url "https://github.com/skiptools/skip/releases/download/#{version}/skip.zip",
      verified: "github.com/skiptools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"

  binary "skip"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/skip"
  end
end
