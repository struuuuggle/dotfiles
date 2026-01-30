---
name: emacs-compile-check
description: Use when editing files under .emacs.d in this repo; run make compile-emacs and ensure it succeeds.
---

When this task changes any file under `.emacs.d/`:
1) Run `make compile-emacs` from the repo root after edits.
2) If it fails, fix the errors and rerun until it succeeds.
3) Report the command result in the final response.
