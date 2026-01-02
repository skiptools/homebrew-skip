cask "swift-host-toolchain@6.2.3" do
  version "6.2.3"
  sha256 "c1ed84cf543286c549caaccc47e0b47d8c61c3c8fedbce1205dedcbebe7601a8"

  swift_release = "swift-6.2.3-RELEASE"

  url "https://download.swift.org/swift-#{version}-release/xcode/#{swift_release}/#{swift_release}-osx.pkg"
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

  # This installs into ~/Library/Developer/Toolchains which does not need sudo
  # Homebrew won't support local packages wth the standard pkg: stanza
  # See: https://github.com/Homebrew/brew/pull/14393
  installer script: {
    executable: "/usr/sbin/installer",
    args:       ["-pkg", "#{staged_path}/#{swift_release}-osx.pkg", "-target", "CurrentUserHomeDirectory"]
  }

  swift_package = Pathname.new("~/Library/Developer/Toolchains/#{swift_release}.xctoolchain/usr/bin/swift-package").expand_path

  # this only works for globally installed packages not CurrentUserHomeDirectory
  #uninstall pkgutil: "org.swift.6020202410241a"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  #zap trash: ""
end
