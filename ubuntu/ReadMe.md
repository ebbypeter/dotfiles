#### Install Zsh
``` sh
sudo apt install zsh
```

#### Install oh-my-zsh
``` sh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

#### Install PowerLevel10K Theme
``` sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10kclear

```

### Run the Script
``` sh
./ubuntu-backup.sh
```
