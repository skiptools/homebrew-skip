cask "swift-android-toolchain@6.1" do
  # note: Casks do not support aliases and symbolic links require exact cask
  # name match, so new versions (e.g., swift-android-toolchain@6.1.x.rb)
  # will need to be manually copied over to swift-android-toolchain@6.1.rb
  version "6.1"
  sha256 "649597bc0e0cce345bc8f076b8b2627bb01302b60be670b9d05c8a3a2b7f87e8"

  artifact = "swift-#{version}-RELEASE-android-24-0.1.artifactbundle"

  url "https://source.skip.tools/swift-android-toolchain/releases/download/#{version}/#{artifact}.tar.gz"
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
