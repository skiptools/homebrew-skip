cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.9.8"
  sha256 arm:          "b452f271deee9be0ef6211d99692f5061f190dcd5c5584914bc0472595bedbe7",
         x86_64:       "b452f271deee9be0ef6211d99692f5061f190dcd5c5584914bc0472595bedbe7",
         arm64_linux:  "0d30f1503850bed868c1e1d63116f460cff4049e2106ff12ebc84d07d8633053",
         x86_64_linux: "0d30f1503850bed868c1e1d63116f460cff4049e2106ff12ebc84d07d8633053"

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
