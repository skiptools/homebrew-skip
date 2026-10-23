cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.17"
  sha256 arm:          "c8413f4ec481616ff7a9f65389e06ba89f9089b795722398dceba536bd6f5a8e",
         x86_64:       "c8413f4ec481616ff7a9f65389e06ba89f9089b795722398dceba536bd6f5a8e",
         arm64_linux:  "f74c725a9a26702e643f2cd655a79d1724f886d505d500a4472cae2c939ac373",
         x86_64_linux: "f74c725a9a26702e643f2cd655a79d1724f886d505d500a4472cae2c939ac373"

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
