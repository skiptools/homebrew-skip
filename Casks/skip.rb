cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.34"
  sha256 arm:          "4a341b5c4966c21efc124fde5216d07d6167d72df50c5521c8e8fa56ac2b12e7",
         x86_64:       "4a341b5c4966c21efc124fde5216d07d6167d72df50c5521c8e8fa56ac2b12e7",
         arm64_linux:  "04b676765ccabb8a5de8cd80cbda13c242a77c9161e9911c917f2569925b6956",
         x86_64_linux: "04b676765ccabb8a5de8cd80cbda13c242a77c9161e9911c917f2569925b6956"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.tools/"

  depends_on formula: "swiftly"
  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-platform-tools"

  binary "skip.artifactbundle/bin/skip"

  postflight do
    system "swiftly", "init", "--assume-yes", "--no-modify-profile", "--skip-install"
    system "#{staged_path}/skip.artifactbundle/bin/skip", "welcome", "--first-run"
  end

  caveats do
    license "https://skip.tools/eula"
  end
end
