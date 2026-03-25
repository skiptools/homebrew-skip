cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.0"
  sha256 arm:          "2dca94f678fe16021d4dc9e8d44531f2e43149758717e3a0ee74010cd5e777ec",
         x86_64:       "2dca94f678fe16021d4dc9e8d44531f2e43149758717e3a0ee74010cd5e777ec",
         arm64_linux:  "bc9b01692d399af6dd2f4fb8d917eac442445603e89c37d69c8fcd59a060d3a3",
         x86_64_linux: "bc9b01692d399af6dd2f4fb8d917eac442445603e89c37d69c8fcd59a060d3a3"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.dev"

  depends_on formula: "swiftly"
  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-commandlinetools"

  binary "skip.artifactbundle/bin/skip"

  postflight do
    # awaiting https://github.com/swiftlang/swiftly/pull/503
    if OS.mac?
      system_command "#{Formula["swiftly"].bin}/swiftly",
        args: ["init", "--assume-yes", "--no-modify-profile", "--skip-install"],
        must_succeed: true
    end
    system_command "#{staged_path}/skip.artifactbundle/bin/skip",
      args: ["welcome", "--first-run"],
      must_succeed: true
  end
end
