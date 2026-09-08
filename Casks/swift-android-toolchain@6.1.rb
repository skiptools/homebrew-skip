cask "swift-android-toolchain@6.1" do
  # note: Casks do not support aliases and symbolic links require exact cask
  # name match, so new versions (e.g., swift-android-toolchain@6.1.x.rb)
  # will need to be manually copied over to swift-android-toolchain@6.1.rb
  version "6.1"
  sha256 "f8696e3e84111b8c2c6f6e564b6266357987ea8d4aa3b2cf92f144357acde1c9"

  sdk_name = "swift-#{version}-RELEASE-android-24-0.1"
  artifact = "#{sdk_name}.artifactbundle"

  url "https://github.com/skiptools/swift-android-toolchain/releases/download/#{version}/#{artifact}.tar.gz"
  name "swift-android-toolchain@#{version}"
  desc "Swift Android Toolchain"
  homepage "https://skip.tools"

  depends_on cask: "skiptools/skip/swift-host-toolchain@#{version}"
  depends_on cask: "skiptools/skip/skip"
  depends_on macos: :ventura

  swiftcmd = "Library/Developer/Toolchains/swift-#{version}-RELEASE.xctoolchain/usr/bin/swift"
  swiftpm_paths = ["Library/org.swift.swiftpm", "Library/Caches/org.swift.swiftpm"]

  postflight_steps do
    run "xattr",
        args:         ["-d", "-r", "-s", "com.apple.quarantine", "{{staged_path}}/#{artifact}"],
        must_succeed: false
    run swiftcmd,
        base:           :home,
        args:           ["sdk", "install", "{{staged_path}}/#{artifact}"],
        writable_paths: swiftpm_paths,
        writable_base:  :home,
        must_succeed:   false
  end

  uninstall_preflight_steps do
    run swiftcmd,
        base:           :home,
        args:           ["sdk", "remove", sdk_name],
        writable_paths: swiftpm_paths,
        writable_base:  :home,
        must_succeed:   false
  end

  #uninstall delete: "~/Library/Developer/Skip/SDKs/swift-#{version}-RELEASE-android-sdk"
end
