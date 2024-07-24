# Random how-tos 
yet to be converted to scripts
---

## Adding Right-click context to Gnome

  * Create a script in: ```~/.local/share/nautilus/scripts/```

** example: Creating a VScode context ##
``` #!/bin/bash
    #OpenByVScode.sh
    code -n ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}
```
  * Set executable permissions
    * chmod 744 OpenByVScode.sh
    * **or**
    * u+x OpenByVScode.sh 

---

## Code Explanation 

Second line: ```code -n ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}``` 

```code``` is the VSCode default command, option ```-n``` means force to open in **new window**, on the contrary, it also has other option like ```-r```, reuse the current windows, if the software is not open, this option will be the same like ```-n```. For more, please check by code --help. 

The variable ```NAUTILUS_SCRIPT_SELECTED_FILE_PATHS``` is defined by nautilus, like its name meaning, the path for the selected file or folder. It also has other three type of variables: 

```
  1. NAUTILUS_SCRIPT_SELECTED_URIS   : newline-delimited URIs for selected files
  2. NAUTILUS_SCRIPT_CURRENT_URI     : current location
  3. NAUTILUS_SCRIPT_WINDOW_GEOMETRY : position and size of current window
```
