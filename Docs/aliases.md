# Aliases & Shortcuts

## drop-in `ls` replacements with `exa`
```bash
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"                                     # show only dotfiles

```

## Alias a short bat command to replace cat: 

``` alias bat="batcat" ```

Alias for quick Python virtual environments
*In Progress*
alias venv="PWD=$(pwd | rev | cut -d'/' -f 1 | rev) | virtualenv $PWD"


---
###  Base64 Encoding - Image to Base64
```test=$( base64 ImageName.JPG )```
  - For *HTML*
    - ```echo "data:image/jpeg;base64,$(base64 -w 0 DSC_0251.JPG)"```
  - As a file 
    - ```base64 -w 0 DSC_0251.JPG > DSC_0251.JPG.base64```
  - In a variable
    - ```IMAGE_BASE64="$(base64 -w 0 DSC_0251.JPG)"```
  - As a Shell Function 

```
base64() { 
 if [[ "${OSTYPE}" = darwin* ]]; then
    # OSX
    if [ -t 0 ]; then
      base64 "$@"
    else
      cat /dev/stdin | base64 "$@"
    fi
  else
    # Linux
    if [ -t 0 ]; then
      base64 -w 0 "$@"
    else
      cat /dev/stdin | base64 -w 0 "$@"
    fi
  fi
}
```
Usage: 
```
@base64 DSC_0251.JPG
cat DSC_0251.JPG | @base64
```
---
  - As a Shell Script 
```base64.sh```

```
#!/usr/bin/env bash
if [[ "${OSTYPE}" = darwin* ]]; then
  # OSX
  if [ -t 0 ]; then
    base64 "$@"
  else
    cat /dev/stdin | base64 "$@"
  fi
else
  # Linux
  if [ -t 0 ]; then
    base64 -w 0 "$@"
  else
    cat /dev/stdin | base64 -w 0 "$@"
  fi
fi
```
Usage: 
```
./base64.sh DSC_0251.JPG
cat DSC_0251.JPG | ./base64.sh
```
---
### Decode 


Get you readable data back:\
```base64 -d DSC_0251.base64 > DSC_0251.JPG ```

