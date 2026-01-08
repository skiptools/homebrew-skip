cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.36"
  sha256 arm:          "08fc709ec24def7950b04f47bacfb83ab3f5dd7056b8500720ca6ea119938333",
         x86_64:       "08fc709ec24def7950b04f47bacfb83ab3f5dd7056b8500720ca6ea119938333",
         arm64_linux:  "b8a8904666968235a9f8758455d68f4d2993839d4a84b024fefde8f054cb0681",
         x86_64_linux: "b8a8904666968235a9f8758455d68f4d2993839d4a84b024fefde8f054cb0681"

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
