cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.11"
  sha256 arm:          "b0c8864748a6b21f9376e8fbe79e44c1162f5f203c8f1e94c3c542b7ee0d5b33",
         x86_64:       "b0c8864748a6b21f9376e8fbe79e44c1162f5f203c8f1e94c3c542b7ee0d5b33",
         arm64_linux:  "2eb7619f9fbac1c21d8fe0b1a85b83b649c1c79f0e1fa918e3107442dbd9345f",
         x86_64_linux: "2eb7619f9fbac1c21d8fe0b1a85b83b649c1c79f0e1fa918e3107442dbd9345f"

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
