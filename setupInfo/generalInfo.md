# mkinitcpio.conf
- This is the mkinitcpio with all the build hooks and everything for the nvidia drivers, the hyprland.conf is also setup for nvidia as well

- It's a decent reference but the wiki is still the better choice as it's more up to date incase things change/update

# Getting Started with an install:
- Install the following base packages:
```
gcc
clang 
cmake
base-devel
git
linux
linux-firmware
amd-ucode
networkmanager
nvidia 
nvidia-utils
nvidia-settings
sddm
hyprland
hyprpaper
hyprlock
hyprshot
apparmor(daemon)
```

# What to install when you're booted in:
```
pipewire (daemon)
pipewire-alsa (daemon)
python
python-pywal
python-pywalfox(yay)
nodejs
pyprland
firefox
spotify
discord
swaync (daemon)
telescope
mullvad-vpn-bin(yay)
----- FOR VM'S -------
libvirt(daemon)
firewalld(daemon)
iptables-nft(daemon)
swtpm 
dnsmasq
virt-manager
qemu-full
dmidecode
----------------------
```
# Other info 

## About the directory and it's contents:
- The locations of the folder match up to that of the system from the root directory

---

### mkinitcpio 
- There are two parts to this, the `mkinitcpio.conf` and the added command line components inside of `/etc/cmdline.d`

    - The added components are the kernel parameters we can pass using mkinitcpio, one is for apparomor (`security.conf`) and the other is for unlocking the luks encrypted partition (`root.conf`)

- The `mkinitcpio.conf` is where we put the modules for the nvidia drivers as well as setting the proper build hooks  

- `mkinitcpio.d` contains the `linux.preset` which is how we go from the default kernel `.img` boot file to the unified kernel image `.efi` file which makes signing the kernel much easier

- Refer to `https://wiki.archlinux.org/title/Unified_kernel_image#mkinitcpio` for more info (specifically under "unified kernel images")

---

### nvim
- The additional lua files needed for nvim can be found at `.config/nvim/lua/plugins/vim-test.lua` and `.config/nvim/lua/plugins/vim-tmux-navigator.lua`, 

- You'll notice there's also a bunch of other `.lua` files inside of the same `plugin` directory, those are by default, the custom ones we make are noted above

---

### tmux
- The files needed for tmux are at `.tmux.conf` normally located at `~/` simmilar to `.bashrc`

---

### waybar
- you'll find the waybar files under `/etc/xdg/waybar/` 

---

### keyd
- to rebind caps lock to ctrl, 

---

### `.bashrc` and Starship
- in order for startship to work properly, we need to add `` to the end of our `.bashrc` file located at our home directory

---

### wal
- dont forget to run `wal -i /path/to/wallpaper`

---

### git and git-credential-manager

- `git-credential-manager` isn't a package available on `pacman` or the AUR, we need to download the tarball on github and then use `gpg` and `pass` 

- refer to `https://github.com/git-ecosystem/git-credential-manager/tree/main` for the up-to-date instructions
