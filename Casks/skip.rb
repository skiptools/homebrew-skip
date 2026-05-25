cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.1"
  sha256 arm:          "aac6ef9a36aa6ff41afeac78c3cbd9705acee4b3c71e39a5b72c02e134a4315a",
         x86_64:       "aac6ef9a36aa6ff41afeac78c3cbd9705acee4b3c71e39a5b72c02e134a4315a",
         arm64_linux:  "85fc61382ebe17f18a4bfc66a19c3b156c607ee13412cd362eb221b042204a22",
         x86_64_linux: "85fc61382ebe17f18a4bfc66a19c3b156c607ee13412cd362eb221b042204a22"

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
