cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.9"
  sha256 arm:          "29237e05eb6c7114bed5acc66dc3112bc3118e6583a5b6528b432b952d5709ea",
         x86_64:       "29237e05eb6c7114bed5acc66dc3112bc3118e6583a5b6528b432b952d5709ea",
         arm64_linux:  "c5df110705af3ce1b5a318b0fa35b43e1fd27e9bf6675e7cfb273f1b28aa0d0a",
         x86_64_linux: "c5df110705af3ce1b5a318b0fa35b43e1fd27e9bf6675e7cfb273f1b28aa0d0a"

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
