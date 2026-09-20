# gh-user-switch
Effortless switching through SSH keys.  gh-user-switch will automatically determine the username and email authenticating.

## Usage
Running gh-user-switch is easy.  
```bash
/.gh-switch.zsh
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

## Compatibility
Mac only
