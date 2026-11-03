# Extransload Homebrew Tap

```sh
brew install --cask extransload/tap/usagi
brew install --cask extransload/tap/tablepeek
```

| Cask | Description |
|---|---|
| [usagi](https://github.com/Extransload/usagi) | macOS menu bar app that shows Claude Code and Codex usage limits for each of your accounts |
| [tablepeek](https://github.com/Extransload/TablePeek) | Local-first database client (SQL, MongoDB, Elasticsearch, and more) as a desktop app |

Usagi is not signed or notarized by Apple, so the cask removes the macOS quarantine flag on install to let it open right away.
From 1.0.3 on, release zips are built by GitHub Actions with a build provenance attestation; see [Usagi's SECURITY.md](https://github.com/Extransload/usagi/blob/main/SECURITY.md) for how to verify one.

TablePeek's app carries an ad-hoc signature only (no Developer ID), so its cask removes the quarantine flag the same way. TablePeek's release workflow writes `Casks/tablepeek.rb` after each stable release; the first one with the desktop app adds the cask here.
