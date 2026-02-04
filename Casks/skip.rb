cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.1"
  sha256 arm:          "c52b690e5e3f5601d7a6101c38477a6d136485a26a2087de87230c78a1a10d34",
         x86_64:       "c52b690e5e3f5601d7a6101c38477a6d136485a26a2087de87230c78a1a10d34",
         arm64_linux:  "367bdd8ee45f173648aaf2aabef110c4f07ba2bd073bf1b9abdc7912026c2a40",
         x86_64_linux: "367bdd8ee45f173648aaf2aabef110c4f07ba2bd073bf1b9abdc7912026c2a40"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.dev"

  depends_on formula: "swiftly"
  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-platform-tools"
  depends_on cask: "android-commandlinetools"

  binary "skip.artifactbundle/bin/skip"

  postflight do
    system "swiftly", "init", "--assume-yes", "--no-modify-profile", "--skip-install"
    system "#{staged_path}/skip.artifactbundle/bin/skip", "welcome", "--first-run"
  end
end
