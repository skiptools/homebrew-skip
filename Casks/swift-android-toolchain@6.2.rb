cask "swift-android-toolchain@6.2" do
  # note: Casks do not support aliases and symbolic links require exact cask
  # name match, so new versions (e.g., swift-android-toolchain@6.1.x.rb)
  # will need to be manually copied over to swift-android-toolchain@6.1.rb
  version "6.2.3"
  sha256 "e2dc075abe4555c88c2291aea88b349c7e4b3cb848ce4a99b1591217303e81e6"

  # https://github.com/skiptools/swift-android-toolchain/releases/download/6.2.3/swift-6.2.3-RELEASE_android.artifactbundle.tar.gz
  swift_version = "6.2.3"
  swift_version_id = "#{swift_version}-RELEASE"

  #artifact = "swift-#{version}-RELEASE-android-24-0.1.artifactbundle"
  swift_android = "swift-#{swift_version_id}_android"
  artifact = "#{swift_android}.artifactbundle"

  url "https://github.com/skiptools/swift-android-toolchain/releases/download/#{swift_version}/#{artifact}.tar.gz"
  name "swift-android-toolchain@#{version}"
  desc "Swift Android Toolchain"
  homepage "https://skip.tools"

  depends_on cask: "skiptools/skip/swift-host-toolchain@#{version}"
  depends_on cask: "skiptools/skip/skip"
  depends_on cask: "android-ndk"
  depends_on macos: :ventura

  swiftcmd = "Library/Developer/Toolchains/swift-#{swift_version_id}.xctoolchain/usr/bin/swift"
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
