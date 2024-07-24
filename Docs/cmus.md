# CMUS guide 
---

## Adding playlists
> `:add <Path-to-Music-directory>` 
 > 
*example:*  
> `:add /home/jhunt/Music`

## Update playlist 
> `:update` 

## Key Bindings - Navigation
Vim keys are honored: 

|key|action|
|--|--|
|h|left|
|j|down|
|k|up|
|l|right|

## Key bindings - Hotkeys
|key| description | Notes |
|--|------|----|
| v | stop playback | |
| b | next track ||
| z | previous track ||
| c | pause playback ||
| s | toggle shuffle ||
| m | toggles "aaa mode." |aaa stands for artist, album, or all. Controls whether cmus shuffles between songs from an artist, album, or from all your songs. |
| x | restart track ||
| i | focus selection | handy when in shuffle mode and follow is off) |
| f |toggle follow | When follow is on, the selection bar will jump the track that is currently playing. For example, in shuffle mode, this controls whether the selection bar jumps between artists or not. You can manually focus on the playing track by pressing i, as noted above. If follow is on, an "f" appears in the bottom right, in the area where continue, repeat, and shuffle are displayed.|
| / | Search. | Type /, a string, and enter to find the first instance of that string in your current view. Press n to go to the next matching string, N to go to the previous.
| - | reduce volume by 10% ||
| + | increase volume by 10% ||

## Tutorials and Help
  * [The cmus man page](https://github.com/cmus/cmus/blob/master/Doc/cmus.txt) 

  * [Online cmus tutorial](https://github.com/cmus/cmus/blob/master/Doc/cmus-tutorial.txt) 

**or** 

  * ```:man cmus-tutorial``` 




