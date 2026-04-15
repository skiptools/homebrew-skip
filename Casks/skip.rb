cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.8"
  sha256 arm:          "8b83896e58e592818a66660e210006412d0db20867da0c5a09a5047ca96f5d87",
         x86_64:       "8b83896e58e592818a66660e210006412d0db20867da0c5a09a5047ca96f5d87",
         arm64_linux:  "a9133b9625005a01e56eae8ba1c8548be49f5428fdcbe677b1de14f934f5aa1e",
         x86_64_linux: "a9133b9625005a01e56eae8ba1c8548be49f5428fdcbe677b1de14f934f5aa1e"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.dev"

  depends_on formula: "swiftly"
  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-commandlinetools"

  binary "skip.artifactbundle/bin/skip"

  postflight do
    # awaiting https://github.com/swiftlang/swiftly/pull/503
    if OS.mac?
      system_command "#{Formula["swiftly"].bin}/swiftly",
        args: ["init", "--assume-yes", "--no-modify-profile", "--skip-install"],
        must_succeed: true
    end
    system_command "#{staged_path}/skip.artifactbundle/bin/skip",
      args: ["welcome", "--first-run"],
      must_succeed: true
  end
end
