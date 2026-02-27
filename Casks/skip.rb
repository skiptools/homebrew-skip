cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.4"
  sha256 arm:          "f5c00afd2450001a76c52c965ed9f3a3f60dd77fd4f05f5e3f7756fda67d6d98",
         x86_64:       "f5c00afd2450001a76c52c965ed9f3a3f60dd77fd4f05f5e3f7756fda67d6d98",
         arm64_linux:  "15a7b99c9fa1cd956dec1fd03b7ea5b6c1febfc2a32e2a1c45eabc1e440dcf6d",
         x86_64_linux: "15a7b99c9fa1cd956dec1fd03b7ea5b6c1febfc2a32e2a1c45eabc1e440dcf6d"

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
