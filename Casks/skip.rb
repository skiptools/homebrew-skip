cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.5"
  sha256 arm:          "5e1d88158c3f3e51f53a314bbc867e2ecffca126c6a6ab59263b7ea4c2a25c4c",
         x86_64:       "5e1d88158c3f3e51f53a314bbc867e2ecffca126c6a6ab59263b7ea4c2a25c4c",
         arm64_linux:  "67535a2aa66f4c0079e3e58c7076bc9aaa2558d63105604328e53833258a93d0",
         x86_64_linux: "67535a2aa66f4c0079e3e58c7076bc9aaa2558d63105604328e53833258a93d0"

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
