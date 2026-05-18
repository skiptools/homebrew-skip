cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.15"
  sha256 arm:          "ba09f962eb781618ddbf5e6872d6bf999970a7b537499773d853f8dc4d5a0a96",
         x86_64:       "ba09f962eb781618ddbf5e6872d6bf999970a7b537499773d853f8dc4d5a0a96",
         arm64_linux:  "58784fd5fc2f19f0932ad57cfea68fb8f7e3b6e52cc13d6d04d6e061d7c5b2bc",
         x86_64_linux: "58784fd5fc2f19f0932ad57cfea68fb8f7e3b6e52cc13d6d04d6e061d7c5b2bc"

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
