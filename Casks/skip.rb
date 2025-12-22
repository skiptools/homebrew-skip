cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.32"
  sha256 arm:          "e3e6276b535b894ae06c7081fc979bc2cfac0b482bedab80b38a6ec319760702",
         x86_64:       "e3e6276b535b894ae06c7081fc979bc2cfac0b482bedab80b38a6ec319760702",
         arm64_linux:  "b1a461a6cd64c07866e969569f0997fc99beadb02868966a67051efbc62bb9c4",
         x86_64_linux: "b1a461a6cd64c07866e969569f0997fc99beadb02868966a67051efbc62bb9c4"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.tools/"

  depends_on formula: "swiftly"
  depends_on formula: "openjdk"
  depends_on formula: "gradle"
  depends_on cask: "android-platform-tools"

  binary "skip.artifactbundle/bin/skip"

  postflight do
    system "swiftly", "init", "--assume-yes", "--no-modify-profile", "--skip-install"
    system "#{staged_path}/skip.artifactbundle/bin/skip", "welcome", "--first-run"
  end

  caveats do
    license "https://skip.tools/eula"
  end
end
