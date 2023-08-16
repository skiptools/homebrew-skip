cask "skip" do
  version "0.5.57"
  sha256 "1725f982a656a21e0d12d933a59da218fc9fe8c17429b911c165bb9bc543a647"

  url "https://github.com/skiptools/skip/releases/download/#{version}/skip.zip",
      verified: "github.com/skiptools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
  #depends_on cask: "android-studio"

  binary "skip"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/skip"
  end
end
