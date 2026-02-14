cask "skip" do
  os macos: "macos", linux: "linux"

  version "1.7.2"
  sha256 arm:          "5aa8ac4f01253ce36ca50f61b2c3f40a225afb01c1ab4453031e3ce3427daacf",
         x86_64:       "5aa8ac4f01253ce36ca50f61b2c3f40a225afb01c1ab4453031e3ce3427daacf",
         arm64_linux:  "e2c91081f238ce14f9fe92062ae91d19f0514b5f313434eab62c2602e91c7277",
         x86_64_linux: "e2c91081f238ce14f9fe92062ae91d19f0514b5f313434eab62c2602e91c7277"

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
    generate_completions_from_executable("#{staged_path}/skip.artifactbundle/bin/skip", "--generate-completion-script")
  end
end
