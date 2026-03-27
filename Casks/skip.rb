cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.2"
  sha256 arm:          "ac21f7c7a42476e82f7971e46dd462d6bcc0cef2d1c3d9f02926bcb93b4c917d",
         x86_64:       "ac21f7c7a42476e82f7971e46dd462d6bcc0cef2d1c3d9f02926bcb93b4c917d",
         arm64_linux:  "c9a471dc33970d355488a1007af8cce9d08b67dacad97702d17b5aa6cc6932d6",
         x86_64_linux: "c9a471dc33970d355488a1007af8cce9d08b67dacad97702d17b5aa6cc6932d6"

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
