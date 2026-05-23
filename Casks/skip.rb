cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.19"
  sha256 arm:          "f62f892ded57127d2c3328690498492638ea2152a20a171cf63bbce832eab7d0",
         x86_64:       "f62f892ded57127d2c3328690498492638ea2152a20a171cf63bbce832eab7d0",
         arm64_linux:  "17227a0a6b9d269d8dd396d5b84f5e86ae332366d3766e698da7cdf011a18555",
         x86_64_linux: "17227a0a6b9d269d8dd396d5b84f5e86ae332366d3766e698da7cdf011a18555"

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
