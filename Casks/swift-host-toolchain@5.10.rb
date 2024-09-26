cask "swift-host-toolchain@5.10" do
  version "5.10.1"
  sha256 "c4e1d693d48c7ffd67724b74ffcbdca0aca05b37d2c41649aab13d2c649d19e7"

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

  #uninstall pkgutil: "org.swift.5101202406041a"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  #zap trash: ""
end
