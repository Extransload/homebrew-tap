# Written by scripts/homebrew-cask.mjs in https://github.com/Extransload/TablePeek on each
# stable release; edits here are replaced by the next one.
cask "tablepeek" do
  version "0.14.1"
  sha256 "592c6418f55634d4fc2b8cdc0ad99c418f83fe7bb1626b52ba896a6874afd50f"

  url "https://github.com/Extransload/TablePeek/releases/download/v#{version}/TablePeek-v#{version}-aarch64-apple-darwin.dmg"
  name "TablePeek"
  desc "Local-first database client"
  homepage "https://github.com/Extransload/TablePeek"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app installs its own updates (Settings > General).
  auto_updates true
  depends_on arch: :arm64
  depends_on :macos

  app "TablePeek.app"

  # The app carries an ad-hoc signature only, no Developer ID: without the
  # download quarantine Gatekeeper lets it open.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/TablePeek.app"],
        must_succeed: false
  end

  uninstall quit: "io.github.extransload.tablepeek"

  # ~/.tablepeek stays: the command-line tablepeek shares its connections
  # and history.
  zap trash: [
    "~/Library/Caches/io.github.extransload.tablepeek",
    "~/Library/WebKit/io.github.extransload.tablepeek",
  ]
end
