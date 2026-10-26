cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.20"
  sha256 arm:          "bd3c6aacb46fecacaea34eac2445489c42e97800099057687a28654230467178",
         x86_64:       "bd3c6aacb46fecacaea34eac2445489c42e97800099057687a28654230467178",
         arm64_linux:  "b98f5de51818c4802d584c2802f96d45fbf1babc7c1c25f94dc6cb6e7b88f57f",
         x86_64_linux: "b98f5de51818c4802d584c2802f96d45fbf1babc7c1c25f94dc6cb6e7b88f57f"

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
