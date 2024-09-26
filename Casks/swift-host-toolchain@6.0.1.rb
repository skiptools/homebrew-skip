cask "swift-host-toolchain@6.0.1" do
  version "6.0.1"
  sha256 "335e8cd87e00302c19acb819ba356d03a561b1d0edc217b97dbdbf287306788d"

  url "https://download.swift.org/swift-#{version}-release/xcode/swift-#{version}-RELEASE/swift-#{version}-RELEASE-osx.pkg"
  name "swift-#{version}"
  desc "Swift Open Source Xcode Toolchain"
  homepage "https://swift.org"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  #livecheck do
  #  url ""
  #  strategy ""
  #end

  depends_on macos: ">= :ventura"

  # this tries to install for all users by default, which requires sudo
  #pkg "swift-#{version}-RELEASE-osx.pkg"

  # this installs into ~/Library/Developer/Toolchains which does not need sudo
  installer script: {
    executable: "/usr/sbin/installer",
    args:       ["-pkg", "#{staged_path}/swift-#{version}-RELEASE-osx.pkg", "-target", "CurrentUserHomeDirectory"]
  }

  swift_package = Pathname.new("~/Library/Developer/Toolchains/swift-#{version}-RELEASE.xctoolchain/usr/bin/swift-package").expand_path

  # patch the swift-package command to enable running tests on Android
  # https://github.com/finagolfin/swift-android-sdk/issues/173
  postflight do
    system_command "perl", args: ["-pi", "-e", "s%canImport\\(Bionic%canImport\\(Android%", swift_package]
    system_command "perl", args: ["-pi", "-e", "s%import Bionic%import Android%", swift_package]
    system_command "perl", args: ["-pi", "-e", "s%TSCBasic, would be%TSCBasic, would %", swift_package]
    system_command "codesign", args: ["-f", "-s", "-", swift_package]
  end

  #uninstall pkgutil: "org.swift.600202408011a"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  #zap trash: ""
end
