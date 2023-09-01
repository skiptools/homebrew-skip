cask "skip" do
  version "0.6.9"
  sha256 "cf040f172547d02c3ce5b0f18184e1816a33324dbb5924cb6855acd0a1a9ffc4"

  url "https://source.skip.tools/skip/releases/download/#{version}/skip.zip",
      verified: "source.skip.tools/skip/"
  name "Skip"
  desc "Tool for creating dual-platform iPhone/Android apps in Swift"
  homepage "https://skip.tools/"

  depends_on formula: "gradle"
  depends_on macos: ">= :ventura"

  binary "skip"
  zap trash: "~/.skiptools"

  postflight do
    system "xattr", "-c", "#{staged_path}/skip"
  end

  caveats do
    free_license "https://eval.skip.tools"
    license "https://skip.tools/eula"
  end

end
