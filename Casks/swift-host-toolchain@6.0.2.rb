cask "swift-host-toolchain@6.0.2" do
  version "6.0.2"
  sha256 "b11e34e49f218d027f00bf71c8bdc9a0cfa29c5eb5939996bf3509516ab015e9"

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

  #uninstall pkgutil: "org.swift.600202408011a"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  #zap trash: ""
end
