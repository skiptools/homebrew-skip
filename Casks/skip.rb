cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.33"
  sha256 arm:          "24be2a90101a963db3a2d21d57315cebf45201e3195ab0e83b7cdf9db5c46b9e",
         x86_64:       "24be2a90101a963db3a2d21d57315cebf45201e3195ab0e83b7cdf9db5c46b9e",
         arm64_linux:  "bf50a2a39c5ab0ce23f8d230838e3006f7302e298672fbbc539c6df4cb28544c",
         x86_64_linux: "bf50a2a39c5ab0ce23f8d230838e3006f7302e298672fbbc539c6df4cb28544c"

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
