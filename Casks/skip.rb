cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.3"
  sha256 arm:          "2512c485c68d412d2d112a09103c4de2482d8308350cd5904e21d88d83d8e931",
         x86_64:       "2512c485c68d412d2d112a09103c4de2482d8308350cd5904e21d88d83d8e931",
         arm64_linux:  "3e24532a67826977662b575275a72bdc5abb2505ed39ec5bc542cb4444238e8c",
         x86_64_linux: "3e24532a67826977662b575275a72bdc5abb2505ed39ec5bc542cb4444238e8c"

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
