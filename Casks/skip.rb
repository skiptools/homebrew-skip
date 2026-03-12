cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.6"
  sha256 arm:          "a06e753a4955e3eb0a9ba974bc7e86ae01b1b2c062c4600cea5e507d8ce40dc1",
         x86_64:       "a06e753a4955e3eb0a9ba974bc7e86ae01b1b2c062c4600cea5e507d8ce40dc1",
         arm64_linux:  "ed9b4b809c90401fcb40fc1af8a49ad2279bd8ea0e31256a841a5f75bb0c7c4c",
         x86_64_linux: "ed9b4b809c90401fcb40fc1af8a49ad2279bd8ea0e31256a841a5f75bb0c7c4c"

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
