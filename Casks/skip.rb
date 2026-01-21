cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.40"
  sha256 arm:          "2677f9150f86aa0ea0941b8102551c071e9b1d9e9ff49f87ef911af1b1fe9ddc",
         x86_64:       "2677f9150f86aa0ea0941b8102551c071e9b1d9e9ff49f87ef911af1b1fe9ddc",
         arm64_linux:  "365e4016b3f0ff9dca87d0c9fe16fec2925113649ea1bad182e93cff407ab8b2",
         x86_64_linux: "365e4016b3f0ff9dca87d0c9fe16fec2925113649ea1bad182e93cff407ab8b2"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.dev"

  depends_on formula: "swiftly"
  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-platform-tools"
  depends_on cask: "android-commandlinetools"

  binary "skip.artifactbundle/bin/skip"

  postflight do
    system "swiftly", "init", "--assume-yes", "--no-modify-profile", "--skip-install"
    system "#{staged_path}/skip.artifactbundle/bin/skip", "welcome", "--first-run"
  end
end
