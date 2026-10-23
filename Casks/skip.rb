cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.18"
  sha256 arm:          "e4a7cfe94422fdde73c7a7d5c74cdf9e58d6f2543585e3bd4b4267600a534b61",
         x86_64:       "e4a7cfe94422fdde73c7a7d5c74cdf9e58d6f2543585e3bd4b4267600a534b61",
         arm64_linux:  "eaa9426b3ffa4bc7a40568c52121dc783871fb0d1ce1900d8c40f8aa6315b7ba",
         x86_64_linux: "eaa9426b3ffa4bc7a40568c52121dc783871fb0d1ce1900d8c40f8aa6315b7ba"

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
