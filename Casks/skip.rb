cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.19"
  sha256 arm:          "e7337fcbfaf2e39b0a5ad312e83feba35832b09950076524e1ef530ea250579b",
         x86_64:       "e7337fcbfaf2e39b0a5ad312e83feba35832b09950076524e1ef530ea250579b",
         arm64_linux:  "2f71b8d865f25815b607ded9e989acebaf4a2bbb7a9d3ef118816fb9a529e790",
         x86_64_linux: "2f71b8d865f25815b607ded9e989acebaf4a2bbb7a9d3ef118816fb9a529e790"

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
