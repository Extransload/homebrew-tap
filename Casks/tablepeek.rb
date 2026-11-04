# Written by scripts/homebrew-cask.mjs in https://github.com/Extransload/TablePeek on each
# stable release; edits here are replaced by the next one.
cask "tablepeek" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.3.3"
  sha256 arm:   "5c5fd41fec567bab375bb45a792c6f67564c5422d01d7a6aa9fe679bac45dfa9",
         intel: "09adc3067277fcf0564efe04e2776143619914a51d7a31b01cb89c1522baec04"

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
