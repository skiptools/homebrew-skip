cask "swift-android-toolchain@6.0" do
  # note: Casks do not support aliases and symbolic links require exact cask
  # name match, so new versions (e.g., swift-android-toolchain@6.0.x.rb)
  # will need to be manually copied over to swift-android-toolchain@6.0.rb
  version "6.0.3"
  sha256 "4566f23ae2d36dc5c02e915cd67d83b2af971faca4b2595fdd75cf0286acfac1"

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
