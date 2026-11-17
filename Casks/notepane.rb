# Written by scripts/homebrew-cask.mjs in https://github.com/Extransload/NotePane on each
# stable release; edits here are replaced by the next one.
cask "notepane" do
  version "0.4.0"
  sha256 "ff4051d86dbc3d2e6d7c00b0a6092609221bd7a9155bf0de673a7ce173247782"

  url "https://github.com/Extransload/NotePane/releases/download/v#{version}/NotePane-#{version}-arm64.dmg"
  name "NotePane"
  desc "Local-first note pane with tabbed sessions and sticky windows"
  homepage "https://github.com/Extransload/NotePane"

  livecheck do
    url :url
    strategy :github_latest
  end

  # No auto_updates: an ad-hoc signed Mac build cannot replace itself, so the
  # app only links to the release and `brew upgrade` installs it.
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "NotePane.app"

  # The app carries an ad-hoc signature only, no Developer ID: without the
  # download quarantine Gatekeeper lets it open.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/NotePane.app"],
        must_succeed: false
  end

  uninstall quit: "com.gyu.notepane"

  # ~/Library/Application Support/NotePane stays: it holds the notes.
  zap trash: [
    "~/Library/Preferences/com.gyu.notepane.plist",
    "~/Library/Saved Application State/com.gyu.notepane.savedState",
  ]
end
