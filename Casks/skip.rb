cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.14"
  sha256 arm:          "2f71a2aeba9b143708c0bcf5b1723f3930cec7eea8b5beeabc3dbc561aef7007",
         x86_64:       "2f71a2aeba9b143708c0bcf5b1723f3930cec7eea8b5beeabc3dbc561aef7007",
         arm64_linux:  "fa6151b672422d8bada067a5cd7ccca24489acec1e2e1fc408e9e0d81ef63786",
         x86_64_linux: "fa6151b672422d8bada067a5cd7ccca24489acec1e2e1fc408e9e0d81ef63786"

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
