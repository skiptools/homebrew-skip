cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.18"
  sha256 arm:          "e6a70fda7b274da2aec13ec0e35532e8e57d8a4bf6ed8b07b4103b46728e1569",
         x86_64:       "e6a70fda7b274da2aec13ec0e35532e8e57d8a4bf6ed8b07b4103b46728e1569",
         arm64_linux:  "8bf8a3a32919127b7011b1f418a57bf6e374259e8a9b099686993ab1413be0ae",
         x86_64_linux: "8bf8a3a32919127b7011b1f418a57bf6e374259e8a9b099686993ab1413be0ae"

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
