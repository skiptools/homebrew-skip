cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.4"
  sha256 arm:          "9a652c526c859b6b30f5a567bba124c8115d3f1abdd5232ca39486578f762ddb",
         x86_64:       "9a652c526c859b6b30f5a567bba124c8115d3f1abdd5232ca39486578f762ddb",
         arm64_linux:  "a1c3c39636d57f4306d494b536ac3ec84166038764e63d32e250ec62c1fd79f2",
         x86_64_linux: "a1c3c39636d57f4306d494b536ac3ec84166038764e63d32e250ec62c1fd79f2"

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
