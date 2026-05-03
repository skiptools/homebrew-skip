cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.13"
  sha256 arm:          "52275465f1ececd05d76e955122a14b8ed08fcb14a6e92723f4a9fe9bdef99b5",
         x86_64:       "52275465f1ececd05d76e955122a14b8ed08fcb14a6e92723f4a9fe9bdef99b5",
         arm64_linux:  "133a2561338487e77223e46fbdc3ed2da1b9aa6932c319e53bfb519ea5a2731d",
         x86_64_linux: "133a2561338487e77223e46fbdc3ed2da1b9aa6932c319e53bfb519ea5a2731d"

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
