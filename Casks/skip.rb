cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.6"
  sha256 arm:          "77b49c9d29711053febe8b6ca0457faafb175f7ceb06ff7bd68533bdaa551d3b",
         x86_64:       "77b49c9d29711053febe8b6ca0457faafb175f7ceb06ff7bd68533bdaa551d3b",
         arm64_linux:  "ce18a0bcf433a9017db9b0a61454cd39639c9aade3e34cb2aaff3b9363dc757f",
         x86_64_linux: "ce18a0bcf433a9017db9b0a61454cd39639c9aade3e34cb2aaff3b9363dc757f"

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
