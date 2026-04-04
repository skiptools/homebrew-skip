cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.8.4"
  sha256 arm:          "0f6fa00bf1d3d207c7a96aad49361c2a24cacee6fe3dc2cea490ba17008ba622",
         x86_64:       "0f6fa00bf1d3d207c7a96aad49361c2a24cacee6fe3dc2cea490ba17008ba622",
         arm64_linux:  "b2c64498cabffe351f7e9480354367522cd0bf88957178d2b7995ef3b1af77e5",
         x86_64_linux: "b2c64498cabffe351f7e9480354367522cd0bf88957178d2b7995ef3b1af77e5"

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
