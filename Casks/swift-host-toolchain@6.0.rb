cask "swift-host-toolchain@6.0" do
  version "6.0"
  sha256 "2b53b7ceaadded915213a7155131e0f14bef8e766859f88c68d128822058d159"

  url "https://download.swift.org/swift-#{version}-release/xcode/swift-#{version}-RELEASE/swift-#{version}-RELEASE-osx.pkg"
  name "swift-6.0"
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

  #uninstall pkgutil: "org.swift.5101202406041a"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  #zap trash: ""
end
