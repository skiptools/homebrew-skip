cask "swift-android-toolchain@nightly-6.2" do
  # note: Casks do not support aliases and symbolic links require exact cask
  # name match, so new versions (e.g., swift-android-toolchain@6.1.x.rb)
  # will need to be manually copied over to swift-android-toolchain@6.1.rb
  version "nightly-6.2"
  sha256 "546078395418c13e9f79618f1d8f33df24658d32755e3fc51febf78b43f73b9d"

  # https://github.com/skiptools/swift-android-toolchain/releases/download/6.2-DEVELOPMENT-SNAPSHOT-2025-08-28-a/swift-6.2-DEVELOPMENT-SNAPSHOT-2025-08-28-a-android-0.1.artifactbundle.tar.gz
  swift_version = "6.2-DEVELOPMENT-SNAPSHOT-2025-08-28-a"

  #artifact = "swift-#{version}-RELEASE-android-24-0.1.artifactbundle"
  swift_android = "swift-#{swift_version}-android-0.1"
  artifact = "#{swift_android}.artifactbundle"

  url "https://github.com/skiptools/swift-android-toolchain/releases/download/#{swift_version}/#{artifact}.tar.gz"
  name "swift-android-toolchain@#{version}"
  desc "Swift Android Toolchain"
  homepage "https://skip.tools"

  depends_on cask: "skiptools/skip/swift-host-toolchain@#{version}"
  depends_on cask: "skiptools/skip/skip"
  depends_on cask: "android-ndk"
  depends_on macos: :ventura

  swiftcmd = "Library/Developer/Toolchains/swift-#{swift_version}.xctoolchain/usr/bin/swift"
  sdkpath = "Library/org.swift.swiftpm/swift-sdks/#{artifact}"
  swiftpm_paths = ["Library/org.swift.swiftpm", "Library/Caches/org.swift.swiftpm"]

  postflight_steps do
    run "xattr",
        args: ["-d", "-r", "-s", "com.apple.quarantine", "{{staged_path}}/#{artifact}"]
    run swiftcmd,
        base:           :home,
        args:           ["sdk", "install", "{{staged_path}}/#{artifact}"],
        writable_paths: swiftpm_paths,
        writable_base:  :home

    run "#{sdkpath}/swift-android/scripts/setup-android-sdk.sh",
        base:           :home,
        env:            { "ANDROID_NDK_HOME" => "{{HOMEBREW_PREFIX}}/share/android-ndk" },
        writable_paths: swiftpm_paths,
        writable_base:  :home
  end

  uninstall_preflight_steps do
    run swiftcmd,
        base:           :home,
        args:           ["sdk", "remove", swift_android],
        writable_paths: swiftpm_paths,
        writable_base:  :home,
        must_succeed:   false
  end

  #uninstall delete: "~/Library/Developer/Skip/SDKs/swift-#{version}-RELEASE-android-sdk"
end
