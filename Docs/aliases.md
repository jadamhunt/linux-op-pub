# Aliases & Shortcuts

## drop-in `ls` replacements with `exa`
```bash
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"                                     # show only dotfiles

```

## Alias a short bat command to replace cat (debian-only): 
``` alias bat="batcat" ```

## Alias for quick Python virtual environments
`alias venv="PWD=$(pwd | rev | cut -d'/' -f 1 | rev) | virtualenv $PWD"`

## Create and bring up Bridge Device (`br0`)
`alias brup='sudo ip link add name br0 type bridge && sudo ip link set br0 up'`

---

