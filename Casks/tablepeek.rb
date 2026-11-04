# Written by scripts/homebrew-cask.mjs in https://github.com/Extransload/TablePeek on each
# stable release; edits here are replaced by the next one.
cask "tablepeek" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.0"
  sha256 arm:   "e2983f6e6bd688eee0ac92ee367b17187c7c7f111f7955fcba027c529ef2cf2e",
         intel: "ce5e8c02b902fca25b75d6199afbd56dda1c289be049a25c4ac9ce171ef5f4f3"

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
