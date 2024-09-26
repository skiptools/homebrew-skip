cask "swift-android-toolchain@5.10" do
  # note: Casks do not support aliases and symbolic links require exact cask
  # name match, so new versions (e.g., swift-android-toolchain@6.0.x.rb)
  # will need to be manually copied over to swift-android-toolchain@6.0.rb
  version "5.10.1"
  sha256 "83b1fbfb47f24b6e3bc44c0f368919e9c8f02f5002bed7dab517f56b8d89eb38"

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
