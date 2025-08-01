
### Log in to Github 
[https://www.github.com](https://www.github.com)

### Install Git Credential Manager
  - Download GCM .deb package 
    - [https://github.com/git-ecosystem/git-credential-manager/releases/](https://github.com/git-ecosystem/git-credential-manager/releases/) 

  - Install latest .deb package
    - ```sudo dpkg -i {DEBFILE}```

### GCM configuration
```git-credential-manager configure```

### generate gpg key
```gpg --gen-key``` 

  - enter real name
  - enter email address
  - accept values
  - create key passcode
  - note uid (Real Name)
  - ```pass init {gpg-id}```
  - ``` git config --global credential.credentialStore gpg```

## clone down private repo
``` git clone https://www.github/{repo} ``` 

## Notes
Before git push, you will need to set global configs

``` git config --global user.email "EMAILADDRESS" ```
``` git config --global user.name "NAME" ```
