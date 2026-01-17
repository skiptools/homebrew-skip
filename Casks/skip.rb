cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.39"
  sha256 arm:          "8a90533df0b794edab07cf2b488b7d88e34a5a3e9c103caeaa93861e181fc050",
         x86_64:       "8a90533df0b794edab07cf2b488b7d88e34a5a3e9c103caeaa93861e181fc050",
         arm64_linux:  "f23b0e4ab5139bbf9749d117d018f60dc496d6f8ce09b34aabeeb8454f0bf71b",
         x86_64_linux: "f23b0e4ab5139bbf9749d117d018f60dc496d6f8ce09b34aabeeb8454f0bf71b"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.tools/"

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

  caveats do
    license "https://skip.tools/eula"
  end
end
