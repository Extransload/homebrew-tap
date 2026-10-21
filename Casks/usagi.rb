cask "usagi" do
  version "1.0.10"
  sha256 "454941033bb3835f999f3a410c654d5e75c78fa448d11106423f15cab3abd3fc"

  url "https://github.com/Extransload/usagi/releases/download/v#{version}/Usagi-#{version}.zip"
  name "Usagi"
  desc "Menu bar meter for Claude Code and Codex usage limits"
  homepage "https://github.com/Extransload/usagi"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Usagi.app"

  # Usagi is not notarized; clear the download quarantine so it opens without a Gatekeeper block.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Usagi.app"],
        must_succeed: false
  end

  uninstall quit: "io.github.extransload.usagi"

  zap trash: [
    "~/.config/usagi",
    "~/Library/Caches/io.github.extransload.usagi",
    "~/Library/HTTPStorages/io.github.extransload.usagi",
    "~/Library/LaunchAgents/io.github.extransload.usagi.plist",
    "~/Library/Preferences/io.github.extransload.usagi.plist",
    "~/Library/WebKit/io.github.extransload.usagi",
  ]
end
