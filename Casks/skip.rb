cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.16"
  sha256 arm:          "315f68eb27e80defd78c93eca90d8548088dfd8bcf7620e2e403f2098fe1296e",
         x86_64:       "315f68eb27e80defd78c93eca90d8548088dfd8bcf7620e2e403f2098fe1296e",
         arm64_linux:  "ba4ea7a97417df3cea9027824fdc9fbec983f09fec8a768052fd32cc501bc2cf",
         x86_64_linux: "ba4ea7a97417df3cea9027824fdc9fbec983f09fec8a768052fd32cc501bc2cf"

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
