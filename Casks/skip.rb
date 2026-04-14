cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.7"
  sha256 arm:          "fd1622bcd334847eb28788e1897a374e5bd4aa3a906801a65aebae21323275c0",
         x86_64:       "fd1622bcd334847eb28788e1897a374e5bd4aa3a906801a65aebae21323275c0",
         arm64_linux:  "8a7da7d91e351f7fcb9dc30ef5f3ef26123955937e6efe0642543f67ff0fdbdb",
         x86_64_linux: "8a7da7d91e351f7fcb9dc30ef5f3ef26123955937e6efe0642543f67ff0fdbdb"

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
