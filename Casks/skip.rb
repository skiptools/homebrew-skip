cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.7"
  sha256 arm:          "4b869840f230f74bfddd4b61a8709eceb72f180446d6c90248e5681712fd7127",
         x86_64:       "4b869840f230f74bfddd4b61a8709eceb72f180446d6c90248e5681712fd7127",
         arm64_linux:  "1818dd9944c356a395e29adaf0fd82dc7980bcea162c30eb2347846473ea5b3b",
         x86_64_linux: "1818dd9944c356a395e29adaf0fd82dc7980bcea162c30eb2347846473ea5b3b"

  url "https://github.com/skiptools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "github.com/skiptools/skip/"
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
