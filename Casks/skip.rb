cask "skip" do
  version "0.5.91"
  sha256 "ee9697072a224aebd4daddd58de404141b0b34f2d96517e15ddab742be494d05"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
  depends_on macos: ">= :ventura"

  binary "skip"

  postflight do
    system "xattr", "-c", "#{staged_path}/skip"
  end
end
