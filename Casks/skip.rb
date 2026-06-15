cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.3"
  sha256 arm:          "e9ee385884e4cb199a7d3c2755cad7c74a3cefd26c13f08e33795fe5e41dc208",
         x86_64:       "e9ee385884e4cb199a7d3c2755cad7c74a3cefd26c13f08e33795fe5e41dc208",
         arm64_linux:  "cb8c63622c6566bba7aeabd6024a440868646c830c6f37e52f9c2e9395204bb7",
         x86_64_linux: "cb8c63622c6566bba7aeabd6024a440868646c830c6f37e52f9c2e9395204bb7"

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
