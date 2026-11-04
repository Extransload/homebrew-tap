# Written by scripts/homebrew-cask.mjs in https://github.com/Extransload/TablePeek on each
# stable release; edits here are replaced by the next one.
cask "tablepeek" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.3.0"
  sha256 arm:   "082cceda0e5f3a873bf142be5ff94ca3ab3a2ff613b88c938d0aac9cbea9a42e",
         intel: "e2430f944cc66f69e6d838052417fc25b7af90f214a8cf55c7b1a3074d91cb23"

  url "https://github.com/Extransload/TablePeek/releases/download/v#{version}/TablePeek-v#{version}-#{arch}-apple-darwin.dmg"
  name "TablePeek"
  desc "Local-first database client"
  homepage "https://github.com/Extransload/TablePeek"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app installs its own updates (Settings > General).
  auto_updates true
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
