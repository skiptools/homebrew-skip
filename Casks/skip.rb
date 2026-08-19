cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.6"
  sha256 arm:          "e0599cbc4ea3c23998b6918b8058e9b18c2faf4517c945bceb08034a3f1c05e1",
         x86_64:       "e0599cbc4ea3c23998b6918b8058e9b18c2faf4517c945bceb08034a3f1c05e1",
         arm64_linux:  "91ab743fb25de8d0914eac5e3618f3329a1ac49eb7bb052c0e5b69ec608ddaad",
         x86_64_linux: "91ab743fb25de8d0914eac5e3618f3329a1ac49eb7bb052c0e5b69ec608ddaad"

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
