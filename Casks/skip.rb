cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.2"
  sha256 arm:          "5c3fe2f47fdacc1e822c79c2d3c10d869d99981e074e46e53d6124206836ec82",
         x86_64:       "5c3fe2f47fdacc1e822c79c2d3c10d869d99981e074e46e53d6124206836ec82",
         arm64_linux:  "ce5e57b730e1633a57bb31010ba77b9a4f66ca514af4413e0723147e863c8e0d",
         x86_64_linux: "ce5e57b730e1633a57bb31010ba77b9a4f66ca514af4413e0723147e863c8e0d"

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
