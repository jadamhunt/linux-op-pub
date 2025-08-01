# Bash Quickies

## Utilities
### Cut 
Get the last field with cut
echo 'maps.google.com' | rev | cut -d'.' -f 1 | rev 

*Explanation*
  - ```rev``` reverses "maps.google.com" to be ```moc.elgoog.spam``` 
  - ```cut``` uses dot (ie '.') as the delimeter, and chooses the first field, whic is moc
  - lastly, we reverse it again to get ```com```

### venv Creation
#!/bin/bash

PWD=$(pwd |rev | cut -d'/' -f 1 | rev)
echo $PWD

virtualenv $PWD

### Check if Directory exists
```if test -d /path/to/directory; then
  echo "Directory exists."
fi
```  
 or\
```if [ -d /path/to/directory ]; then
  echo "Directory exists."
fi```

### Create directories from file
cat {filename}| xargs -L 1 mkdir

### Do something to many files (recursively)
 ``` find -type f -name "FILENAME/TYPE" -exec COMMAND {} \; ```

For example, in a dir with 20 .zip files to unzip

```find -type f -name "*.zip" -exec unzip {} \;``` 

  - find, 
  - ```-type f``` 
    - target items of type file 
  - ```-name``` 
    - search for by filename, 
  - ```*.zip``` 
    - target extension ".zip"  
  - ```exec ``` 
    -  execute a command 
  - ```{}``` 
    - placeholder for each return from find
  - ```\;``` 
    - closing string

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

