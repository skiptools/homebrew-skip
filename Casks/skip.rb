cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.17"
  sha256 arm:          "5bae1a33fa1357152b3f0eb83382fe979960d59b0373a7abf5dd35a275fe0069",
         x86_64:       "5bae1a33fa1357152b3f0eb83382fe979960d59b0373a7abf5dd35a275fe0069",
         arm64_linux:  "813ea419806d672408eaddf37ddda33299c2915d1b61b3adc24d70d3d00ae34b",
         x86_64_linux: "813ea419806d672408eaddf37ddda33299c2915d1b61b3adc24d70d3d00ae34b"

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
