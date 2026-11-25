cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.23"
  sha256 arm:          "2a68e9cb6f4491b7f94e6c13b93cbae2736053980f3126e71345c6d8f15f5c9f",
         x86_64:       "2a68e9cb6f4491b7f94e6c13b93cbae2736053980f3126e71345c6d8f15f5c9f",
         arm64_linux:  "1a49e071d052413be0d21e224be4b22d8159b55abdda8fba0372ba4c2ae3245d",
         x86_64_linux: "1a49e071d052413be0d21e224be4b22d8159b55abdda8fba0372ba4c2ae3245d"

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
