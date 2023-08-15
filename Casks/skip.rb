cask "skip" do
  version "0.5.41"
  sha256 "886c9fb26f308cd6dcf1b357d4d13a81fe8a616c3ed0118ba8f648d532df20b1"

  url "https://github.com/skiptools/skip/releases/download/#{version}/skipstone.plugin.zip",
      verified: "github.com/skiptools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  #depends_on formula: "gradle"
  #depends_on cask: "android-studio"

  binary "skipstone"
end
