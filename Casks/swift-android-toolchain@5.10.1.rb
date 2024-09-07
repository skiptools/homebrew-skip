cask "swift-android-toolchain@5.10.1" do
  version "5.10.1"
  sha256 "015d304c12f77b9ea109c70ed8673a0c07109cc7b26069532f997069516a3762"

  url "https://github.com/skiptools/swift-android-toolchain/releases/download/#{version}/swift-#{version}-android-sdk.tar.xz"
  name "swift-android-toolchain@#{version}"
  desc "Swift Android Toolchain"
  homepage "https://skip.tools"

  depends_on macos: ">= :ventura"
  depends_on cask: "android-ndk"
  depends_on cask: "skiptools/skip/skip"
  depends_on cask: "skiptools/skip/swift-host-toolchain@#{version}"

  postflight do
    puts "Creating toolchain link at ~/Library/Developer/Skip/SDKs/swift-#{version}-android-sdk"
    target = Pathname.new("~/Library/Developer/Skip/SDKs/swift-#{version}-android-sdk").expand_path
    FileUtils.mkdir_p target
    File.symlink("#{staged_path}/swift-#{version}-android-sdk/usr", "#{target}/usr")  
  end
end
