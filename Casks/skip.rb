cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.21"
  sha256 arm:          "1143f4c604a429f0130f4e48a02a1cf830ca1a2db9b0ba318362c67407e53ad9",
         x86_64:       "1143f4c604a429f0130f4e48a02a1cf830ca1a2db9b0ba318362c67407e53ad9",
         arm64_linux:  "b1367e51651ada77b7e34af829818ad62974af4e51677dcfa7bb8e0ac69fc4af",
         x86_64_linux: "b1367e51651ada77b7e34af829818ad62974af4e51677dcfa7bb8e0ac69fc4af"

  url "https://github.com/skiptools/skip/releases/download/#{version}/skip-#{os}.zip"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.dev"

  depends_on formula: "swiftly"
  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-commandlinetools"

  binary "skip.artifactbundle/bin/skip"

  postflight_steps do
    # awaiting https://github.com/swiftlang/swiftly/pull/503
    on_macos do
      run "opt/swiftly/bin/swiftly",
          base:           :homebrew_prefix,
          args:           ["init", "--assume-yes", "--no-modify-profile", "--skip-install"],
          # swiftly init creates ~/.swiftly, ~/.swiftly/bin and the toolchains
          # dir; declare ~/Library/Developer so it can create Toolchains inside
          # it even when the Developer dir does not exist yet
          writable_paths: [".swiftly", "Library/Developer"],
          writable_base:  :home
    end
    run "skip.artifactbundle/bin/skip",
        base: :staged_path,
        args: ["welcome", "--first-run"]
  end
end
