# Written by scripts/homebrew-cask.mjs in https://github.com/Extransload/NotePane on each
# stable release; edits here are replaced by the next one.
cask "notepane" do
  version "0.5.14"
  sha256 "fffc750ba3e0640188160c8f25015524265d2543a0e15e171d59c92fa0157f89"

  url "https://github.com/Extransload/NotePane/releases/download/v#{version}/NotePane-#{version}-arm64.dmg"
  name "NotePane"
  desc "Local-first note pane with tabbed sessions and sticky windows"
  homepage "https://github.com/Extransload/NotePane"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app downloads each release and swaps it in itself (electron/macSelfUpdate.cjs), so
  # `brew upgrade` leaves it alone unless asked with --greedy.
  auto_updates true
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
