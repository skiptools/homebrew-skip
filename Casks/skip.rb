cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.10"
  sha256 arm:          "5223a15f6d2a7935b862904502f98ebc275d75998c79d7d66f3263ec3dd57bbe",
         x86_64:       "5223a15f6d2a7935b862904502f98ebc275d75998c79d7d66f3263ec3dd57bbe",
         arm64_linux:  "6a34d879ed3c6ca3476897346638c63d4f3815c9f2f9f1e1684d62d9835b056f",
         x86_64_linux: "6a34d879ed3c6ca3476897346638c63d4f3815c9f2f9f1e1684d62d9835b056f"

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
