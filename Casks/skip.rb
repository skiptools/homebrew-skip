cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.10"
  sha256 arm:          "e92bb0c9f1f84733e7e9326c7ae26b71603de93eda6029b9e2e9fa27ea305b0a",
         x86_64:       "e92bb0c9f1f84733e7e9326c7ae26b71603de93eda6029b9e2e9fa27ea305b0a",
         arm64_linux:  "51c94d399865f6024302143aae7d70a367b8713fb7a37770343cc4b77b83924d",
         x86_64_linux: "51c94d399865f6024302143aae7d70a367b8713fb7a37770343cc4b77b83924d"

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
