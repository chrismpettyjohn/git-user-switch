# gh-user-switch
Effortless switching through SSH keys.  gh-user-switch will automatically determine the username and email authenticating.

## Install
```bash
git clone https://github.com/chrismpettyjohn/gh-user-switch.git
cd gh-user-switch
./install.sh
```

That copies the script to `~/.local/share/gh-switch/` and adds a `source` line to
your `~/.zshrc`, so `gh` is available in every new shell. To use it right away in
the shell you're in:

```bash
source ~/.zshrc
```

Prefer somewhere else? `GH_SWITCH_PREFIX=/opt/gh-switch ./install.sh`.
To remove it: `./install.sh --uninstall` (your saved accounts stay in
`~/.config/gh-switch` until you delete that directory).

## Usage
Just run `gh`:

```bash
gh
```

Example Result
```bash
ssh keys in ~/.ssh:
  1) first-user              ed25519  github.com/first-user  *
  2) second-user             ed25519  github.com/second-user
  o) other path…
```

Picking a key
```bash
pick a key [1-2, o]: 1
✓ github identity: first-user  (John Doe <123456+john-doe@users.noreply.github.com>)
```

Once an account is known you can jump straight to it, and tab completion knows
the names:

```bash
gh first-user
```

### Other commands
```bash
gh --keys              list the ssh keys in ~/.ssh and who each one is
gh --list              list known accounts
gh --status            who this shell is right now
gh --add <key-path>    register a key without the picker
gh --refresh           re-fetch name/email for the current account
gh --forget <account>  drop an account
gh --off               back to the default ssh key
```

If the real GitHub CLI is installed, its own subcommands (`gh pr`, `gh repo`, …)
still pass through untouched.

## Notes
`gh-switch.zsh` defines a shell function and must be **sourced**, not executed —
it exports `GIT_SSH_COMMAND` and the `GIT_AUTHOR_*` variables into your current
shell. `install.sh` wires that up for you.

## Compatibility
Mac only, zsh.
