cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.6.35"
  sha256 arm:          "4da75fe03b5f80c1a968718015959b179232aecf46fc77fd7d285a1775d293f5",
         x86_64:       "4da75fe03b5f80c1a968718015959b179232aecf46fc77fd7d285a1775d293f5",
         arm64_linux:  "4439c21b87276c5945b2a40b63c1a5ed97de61e9f25e0308d86a1aebe458cf83",
         x86_64_linux: "4439c21b87276c5945b2a40b63c1a5ed97de61e9f25e0308d86a1aebe458cf83"

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
