cask "swift-host-toolchain@6.0.1" do
  version "6.0.1"
  sha256 "924a9ecd4c2f8f6fe284ab0c966305e32eb98d17d4abfa47289bb0a061f72f89"

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

  #uninstall pkgutil: "org.swift.600202408011a"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  #zap trash: ""
end
