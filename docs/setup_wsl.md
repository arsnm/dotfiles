# Documentation for setting up a new machine using WSL

> [!NOTE]
> This setup assumes, just like [the setup for linux machine](./setup_linux.md) (non-WSL version) that the distro is Arch. (or just arch-based maybe, idk).

## Essential packages install

List of necessary packages:
- `git`
- `vim`
- `openssh`
- `socat` (notably for relaying bitwarden ssh-agent information)
 
## Bitwarden config + ssh-agent

This is probably the first step to be executed, as ssh keys are required for github auth, and thus cloning the `dotfiles` repo, necessary to do a lot when it comes to configurating my WSL workflow.

- First, INSTALL the Bitwarden (denoted BW in the rest of the instructions) Windows Client (available [here](https://bitwarden.com/download)).
- After connecting to your vault, don't forget to ENABLE the SSH agent in BW's setting.
- DISABLE the 'OpenSSH Authentication Agent' Windows service (Win + R; `services.msc`), and eventually STOP the running service.
- INSTALL [npiperelay.exe](https://github.com/jstarks/npiperelay) on Windows (see below), and INSTALL `socat` on the Linux side (`sudo pacman -S socat`).
- To install `npiperalay` and make sure its on the PATH (both on Windows and WSL), use `winget` : `winget install -e --id albertony.npiperelay`
- ADD the following to `.zshrc` (if raw config, if already using the zsh-config provided by `dotfiles`, no need):
```zsh
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0   ]; then
    rm -f $SSH_AUTH_SOCK
    ( setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
fi
```

> [!NOTE]
> In the `dotfiles` zsh config, the default path for npiperelay.exe is the following: `/mnt/c/tools/npiperaly_windows_386/npiperelay.exe`.

- Test that the configuration worked by typing `ssh-add -L`

### Configuring custom keys for different Hosts

