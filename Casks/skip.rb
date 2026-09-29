cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.12"
  sha256 arm:          "b9627f129b0ed81b66cc19fe2da15127b9854d4685079fe42c12e90e6017fa57",
         x86_64:       "b9627f129b0ed81b66cc19fe2da15127b9854d4685079fe42c12e90e6017fa57",
         arm64_linux:  "2e3f36c75a29ba8277732bc92df2c37ccb0aebcec78dd5672481c558becdf236",
         x86_64_linux: "2e3f36c75a29ba8277732bc92df2c37ccb0aebcec78dd5672481c558becdf236"

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
