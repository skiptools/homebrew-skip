cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.9"
  sha256 arm:          "fbb0c374cb20a1a92d995f93220e305c58c55ce32bbb723968e8fffaf4b8ba75",
         x86_64:       "fbb0c374cb20a1a92d995f93220e305c58c55ce32bbb723968e8fffaf4b8ba75",
         arm64_linux:  "ec620a1cd1db6a6ba3910dc067b032b1cfa569f5b8a541895060a68e908d38fd",
         x86_64_linux: "ec620a1cd1db6a6ba3910dc067b032b1cfa569f5b8a541895060a68e908d38fd"

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
