cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.8"
  sha256 arm:          "265a7fc72d4b36259b35d624fc20df78c0afe7398addc9c1612ebb08c5061f8e",
         x86_64:       "265a7fc72d4b36259b35d624fc20df78c0afe7398addc9c1612ebb08c5061f8e",
         arm64_linux:  "e37870eea11b0ec8216fdb1dd3a466ac8d5335e4a7c0d7c4259ae6123f86c328",
         x86_64_linux: "e37870eea11b0ec8216fdb1dd3a466ac8d5335e4a7c0d7c4259ae6123f86c328"

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
