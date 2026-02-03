cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.0"
  sha256 arm:          "b4e5a62b3cc436824dc9555bf71938d9e9aebcbd992c77ca96c7165dddb3b836",
         x86_64:       "b4e5a62b3cc436824dc9555bf71938d9e9aebcbd992c77ca96c7165dddb3b836",
         arm64_linux:  "8aadf8b801159768552b7f12bc80151cc33c05128436b82f0fa78ff6edafd5fd",
         x86_64_linux: "8aadf8b801159768552b7f12bc80151cc33c05128436b82f0fa78ff6edafd5fd"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip-#{os}.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating and building universal swift apps"
  homepage "https://skip.dev"

  depends_on formula: "swiftly"
  depends_on formula: "temurin"
  depends_on formula: "gradle"
  depends_on cask: "android-platform-tools"
  depends_on cask: "android-commandlinetools"

  binary "skip.artifactbundle/bin/skip"

  postflight do
    system "swiftly", "init", "--assume-yes", "--no-modify-profile", "--skip-install"
    system "#{staged_path}/skip.artifactbundle/bin/skip", "welcome", "--first-run"
  end
end
