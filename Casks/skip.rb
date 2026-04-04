cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.3"
  sha256 arm:          "ff0e7ffccc8e377b4c6244b4b69d27a2f9d97320abab74b0afb60324583d828f",
         x86_64:       "ff0e7ffccc8e377b4c6244b4b69d27a2f9d97320abab74b0afb60324583d828f",
         arm64_linux:  "8a318eaccbd538d1795b1b9c102c1e531c8727d9238186cf45a3d564959d47c5",
         x86_64_linux: "8a318eaccbd538d1795b1b9c102c1e531c8727d9238186cf45a3d564959d47c5"

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
