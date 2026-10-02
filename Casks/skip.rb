cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.13"
  sha256 arm:          "8a0242c19a65e3cb0c1af0cbceb79a7294bd545b47748c007c0a69dc41c9bfdc",
         x86_64:       "8a0242c19a65e3cb0c1af0cbceb79a7294bd545b47748c007c0a69dc41c9bfdc",
         arm64_linux:  "d4e8a81218331b5933eb055a7a616bfd3397e0c0abecfec6dee37ba1b3213147",
         x86_64_linux: "d4e8a81218331b5933eb055a7a616bfd3397e0c0abecfec6dee37ba1b3213147"

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
