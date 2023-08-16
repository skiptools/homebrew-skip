cask "skip" do
  version "0.5.75"
  sha256 "f1887c78214992ae288c137b8eb7e450db7a2a08b5fc146114f1aded2a3eaeb3"

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
