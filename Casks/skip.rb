cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.5"
  sha256 arm:          "30ffcb82a545dc9000efa315e587e07bb6ab904aef22228a3648569eed16f636",
         x86_64:       "30ffcb82a545dc9000efa315e587e07bb6ab904aef22228a3648569eed16f636",
         arm64_linux:  "fdf4940b86a797551b1629fe9c8148b57ee2723145a2e1e5bafe0baaff17b865",
         x86_64_linux: "fdf4940b86a797551b1629fe9c8148b57ee2723145a2e1e5bafe0baaff17b865"

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
