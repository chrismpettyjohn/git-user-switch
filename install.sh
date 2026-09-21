#!/bin/zsh
# Installs gh-switch so the `gh` function exists in every new shell.
#
#   ./install.sh              install to ~/.local/share/gh-switch, hook ~/.zshrc
#   ./install.sh --uninstall  undo it
#
# Override the destination with GH_SWITCH_PREFIX=/somewhere ./install.sh

emulate -L zsh
setopt err_exit no_unset pipe_fail

src=${0:A:h}/gh-switch.zsh
prefix=${GH_SWITCH_PREFIX:-$HOME/.local/share/gh-switch}
dest=$prefix/gh-switch.zsh
rc=${ZDOTDIR:-$HOME}/.zshrc
begin='# >>> gh-switch >>>'
end='# <<< gh-switch <<<'

strip_block() {
  # drop any existing gh-switch block from ~/.zshrc
  [[ -r $rc ]] || return 0
  local tmp=$rc.gh-switch.$$
  awk -v b="$begin" -v e="$end" '
    $0 == b { skip = 1 } !skip { print } $0 == e { skip = 0 }
  ' "$rc" > "$tmp"
  mv -f "$tmp" "$rc"
}

if [[ ${1:-} == (-u|--uninstall) ]]; then
  strip_block
  rm -f "$dest"
  rmdir "$prefix" 2>/dev/null || true
  print -r -- "removed gh-switch from $rc (open a new shell to finish)"
  print -r -- "your accounts are still in ~/.config/gh-switch — delete that to forget them"
  exit 0
fi

[[ -r $src ]] || { print -u2 -- "install.sh: can't find $src"; exit 1 }

mkdir -p "$prefix"
cp -f "$src" "$dest"
chmod 644 "$dest"

strip_block
print -r -- "$begin"        >> "$rc"
print -r -- "[[ -r ${(q)dest} ]] && source ${(q)dest}" >> "$rc"
print -r -- "$end"          >> "$rc"

print -r -- "✓ installed to ${dest/#$HOME/~}"
print -r -- "  sourced from ${rc/#$HOME/~}"
print -r -- ""
print -r -- "start using it now with:"
print -r -- "  source ${rc/#$HOME/~}"
