cask "swift-host-toolchain@nightly-6.2" do
  version "nightly-6.2"
  sha256 "f03a82e47984e727073dbdaa42b9445ae278f7b5c19a31a870b738dd768d60a4"

  swift_release = "swift-6.2-DEVELOPMENT-SNAPSHOT-2025-05-07-a"

  #url "https://download.swift.org/swift-#{version}-release/xcode/swift-#{version}-RELEASE/swift-#{version}-RELEASE-osx.pkg"
  url "https://download.swift.org/swift-6.2-branch/xcode/#{swift_release}/#{swift_release}-osx.pkg"
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
