cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.0"
  sha256 arm:          "1d1c1845e6f061e52ece36180be741c4382604c4aa8c00d2aece1c193ed02a66",
         x86_64:       "1d1c1845e6f061e52ece36180be741c4382604c4aa8c00d2aece1c193ed02a66",
         arm64_linux:  "f0e0e53e97c43f86b7e4e5005d09efc53c4892a0af1cfd87d10b67228cc19f60",
         x86_64_linux: "f0e0e53e97c43f86b7e4e5005d09efc53c4892a0af1cfd87d10b67228cc19f60"

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
