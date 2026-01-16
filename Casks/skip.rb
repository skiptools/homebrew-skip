cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.37"
  sha256 arm:          "f34c9cd28f51c4ee7c3ab7089d2daac5f6dd067c45c9a301b80f73fbacdcd8e4",
         x86_64:       "f34c9cd28f51c4ee7c3ab7089d2daac5f6dd067c45c9a301b80f73fbacdcd8e4",
         arm64_linux:  "45723a8e62d4d646fd0a9f07a9b13b52c2161f3e5961c17d85f15cdc38a6b25b",
         x86_64_linux: "45723a8e62d4d646fd0a9f07a9b13b52c2161f3e5961c17d85f15cdc38a6b25b"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.tools/"

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

  caveats do
    license "https://skip.tools/eula"
  end
end
