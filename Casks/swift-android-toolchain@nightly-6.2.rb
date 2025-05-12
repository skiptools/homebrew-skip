cask "swift-android-toolchain@nightly-6.2" do
  # note: Casks do not support aliases and symbolic links require exact cask
  # name match, so new versions (e.g., swift-android-toolchain@6.1.x.rb)
  # will need to be manually copied over to swift-android-toolchain@6.1.rb
  version "nightly-6.2"
  sha256 "77bc7bc8f08b4c265c2fbbe155ab7d029e223581e420ae84717ca415bdff6726"

  # https://github.com/skiptools/swift-android-toolchain/releases/download/6.2-DEVELOPMENT-SNAPSHOT-2025-05-07-a/swift-6.2-DEVELOPMENT-SNAPSHOT-2025-05-07-a-android-0.1.artifactbundle.tar.gz
  swift_version = "6.2-DEVELOPMENT-SNAPSHOT-2025-05-07-a"

  #artifact = "swift-#{version}-RELEASE-android-24-0.1.artifactbundle"
  artifact "swift-#{swift_version}-android-0.1.artifactbundle"

  url "https://source.skip.tools/swift-android-toolchain/releases/download/#{swift_version}/#{artifact}.tar.gz"
  name "swift-android-toolchain@#{version}"
  desc "Swift Android Toolchain"
  homepage "https://skip.tools"

  depends_on cask: "skiptools/skip/swift-host-toolchain@#{version}"
  depends_on cask: "skiptools/skip/skip"
  depends_on macos: ">= :ventura"

  swiftcmd = Pathname.new("~/Library/Developer/Toolchains/swift-#{version}-RELEASE.xctoolchain/usr/bin/swift").expand_path

  postflight do
    system "xattr", "-d", "-r", "-s", "com.apple.quarantine", "#{staged_path}/#{artifact}"
    system "#{swiftcmd}", "sdk", "install", "#{staged_path}/#{artifact}"
  end

  uninstall_preflight do
    system "#{swiftcmd}", "sdk", "remove", "swift-#{version}-RELEASE-android-24-0.1"
  end

  #uninstall delete: "~/Library/Developer/Skip/SDKs/swift-#{version}-RELEASE-android-sdk"
end
