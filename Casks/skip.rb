cask "skip" do
  version "0.5.72"
  sha256 "df4d19fee5fc3fd1074339d21f5b570bc3b332a6df05814c0d0938493cc64593"

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
