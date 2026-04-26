cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.11"
  sha256 arm:          "f48718991893b5a5f4878541a21ab5b9219e2845234b7ba22f80818028d3d32a",
         x86_64:       "f48718991893b5a5f4878541a21ab5b9219e2845234b7ba22f80818028d3d32a",
         arm64_linux:  "2bf7cb1b15391d9241707eacc3806e28ec8a5b95a4dda251efbae8f418460dc5",
         x86_64_linux: "2bf7cb1b15391d9241707eacc3806e28ec8a5b95a4dda251efbae8f418460dc5"

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
