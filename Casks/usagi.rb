cask "usagi" do
  version "1.0.2"
  sha256 "e6e759b0d135fd81ce054aac47e6393c28412d2e3e68cb669ec1d4e560ce2a03"

  url "https://github.com/Extransload/usagi/releases/download/v#{version}/Usagi-#{version}.zip"
  name "Usagi"
  desc "Menu bar meter for Claude Code and Codex usage limits"
  homepage "https://github.com/Extransload/usagi"

  depends_on macos: :sonoma

  app "Usagi.app"

  # Usagi is not notarized; clear the download quarantine so it opens without a Gatekeeper block.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Usagi.app"],
        must_succeed: false
  end

  uninstall quit: "io.github.extransload.usagi"

  zap trash: "~/.config/usagi"
end
