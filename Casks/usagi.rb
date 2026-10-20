cask "usagi" do
  version "1.0.0"
  sha256 "edeef92b3502fd6089b74b4a37ab7f80c7f24bcfcb9efb0447a8c0399a4c1256"

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
