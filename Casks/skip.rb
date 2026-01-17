cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.38"
  sha256 arm:          "e719da717d2ae9d5812067f830d48f44e68f8e5133b26411237b3211fc78d644",
         x86_64:       "e719da717d2ae9d5812067f830d48f44e68f8e5133b26411237b3211fc78d644",
         arm64_linux:  "b2991afc42a5122bc27389def9cb88920a24d6b5f7e1af10e4ef9b96b8a49ae7",
         x86_64_linux: "b2991afc42a5122bc27389def9cb88920a24d6b5f7e1af10e4ef9b96b8a49ae7"

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
