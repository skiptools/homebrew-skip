cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.7"
  sha256 arm:          "b549f01762b112bf1520e42295c7055473329236efb1e732cd58a41d8f1542ed",
         x86_64:       "b549f01762b112bf1520e42295c7055473329236efb1e732cd58a41d8f1542ed",
         arm64_linux:  "755284585239951987ba4884572d75716392f8c93837e1696a175a9984b64f6e",
         x86_64_linux: "755284585239951987ba4884572d75716392f8c93837e1696a175a9984b64f6e"

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
