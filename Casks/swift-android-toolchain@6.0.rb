cask "swift-android-toolchain@6.0" do
  version "6.0.1"
  sha256 "335e8cd87e00302c19acb819ba356d03a561b1d0edc217b97dbdbf287306788d"

  url "https://github.com/skiptools/swift-android-toolchain/releases/download/#{version}/swift-#{version}-RELEASE-android-sdk.tar.xz"
  name "swift-android-toolchain@#{version}"
  desc "Swift Android Toolchain"
  homepage "https://skip.tools"

  depends_on cask: "android-ndk"
  depends_on cask: "android-commandlinetools"
  depends_on cask: "skiptools/skip/skip"
  depends_on cask: "skiptools/skip/swift-host-toolchain@#{version}"
  depends_on macos: ">= :ventura"

  postflight do
    folder = "swift-#{version}-RELEASE-android-sdk"
    puts "Creating toolchain link at ~/Library/Developer/Skip/SDKs/#{folder}"
    target = Pathname.new("~/Library/Developer/Skip/SDKs").expand_path
    FileUtils.mkdir_p target
    File.symlink("#{staged_path}/#{folder}", "#{target}/#{folder}")
  end

  uninstall delete: "~/Library/Developer/Skip/SDKs/swift-#{version}-RELEASE-android-sdk"
end
