cask "swift-android-toolchain@nightly-6.2" do
  # note: Casks do not support aliases and symbolic links require exact cask
  # name match, so new versions (e.g., swift-android-toolchain@6.1.x.rb)
  # will need to be manually copied over to swift-android-toolchain@6.1.rb
  version "nightly-6.2"
  sha256 "616ee6ba58a56f2039b94718e852fa9c6e8117747b4489eeb6f7c394cdab8727"

  # https://github.com/skiptools/swift-android-toolchain/releases/download/6.2-DEVELOPMENT-SNAPSHOT-2025-07-09-a/swift-6.2-DEVELOPMENT-SNAPSHOT-2025-07-09-a-android-0.1.artifactbundle.tar.gz
  swift_version = "6.2-DEVELOPMENT-SNAPSHOT-2025-07-09-a"

  #artifact = "swift-#{version}-RELEASE-android-24-0.1.artifactbundle"
  swift_android = "swift-#{swift_version}-android-0.1"
  artifact = "#{swift_android}.artifactbundle"

  url "https://source.skip.tools/swift-android-toolchain/releases/download/#{swift_version}/#{artifact}.tar.gz"
  name "swift-android-toolchain@#{version}"
  desc "Swift Android Toolchain"
  homepage "https://skip.tools"

  depends_on cask: "skiptools/skip/swift-host-toolchain@#{version}"
  depends_on cask: "skiptools/skip/skip"
  depends_on cask: "android-ndk"
  depends_on macos: ">= :ventura"

  swiftcmd = Pathname.new("~/Library/Developer/Toolchains/swift-#{swift_version}.xctoolchain/usr/bin/swift").expand_path
  sdkpath = Pathname.new("~/Library/org.swift.swiftpm/swift-sdks/#{artifact}").expand_path

  postflight do
    system_command "xattr",
        args: ["-d", "-r", "-s", "com.apple.quarantine", "#{staged_path}/#{artifact}"],
        must_succeed: true
    system_command "#{swiftcmd}",
        args: ["sdk", "install", "#{staged_path}/#{artifact}"],
        must_succeed: true

    system_command "env",
        args: ["ANDROID_NDK_HOME=#{HOMEBREW_PREFIX}/share/android-ndk", "#{sdkpath}/swift-android/scripts/setup-android-sdk.sh"],
        must_succeed: true
  end

  uninstall_preflight do
    system "#{swiftcmd}", "sdk", "remove", "#{swift_android}"
  end

  #uninstall delete: "~/Library/Developer/Skip/SDKs/swift-#{version}-RELEASE-android-sdk"
end
