cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.5"
  sha256 arm:          "3cf07daad97bf48145c4da0f91f5388e85a50a6016db2c35b0f6a84a6193a2df",
         x86_64:       "3cf07daad97bf48145c4da0f91f5388e85a50a6016db2c35b0f6a84a6193a2df",
         arm64_linux:  "17acfff4459c48b8245a8b77ce96a784c2a27fe4ff2e7e988128ff147085ed99",
         x86_64_linux: "17acfff4459c48b8245a8b77ce96a784c2a27fe4ff2e7e988128ff147085ed99"

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
