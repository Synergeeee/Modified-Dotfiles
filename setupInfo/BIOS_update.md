# Procedure post-bios update
- On aurorus motherboards, the following issues need to be addressed after a BIOS update
  1) memory needs to be overclocked again along with the timings tightened up
  2) fast boot needs to be turned on
  3) secure boot needs to be disabled
  4) the `efibootmgr` needs to recreate the `UEFI` boot entry
  5) Enable Secure Boot
  5) Previous TPM key becomes invalid and a new one must be enrolled

- We'll be going through all of these from the top to the bottom

---

# Memory
- For the memory, go into the BIOS and then use xmp profile under the memory setting
- Then we should also tighten up the memory timings as well under the same memory settings, look for somthing like "speed setting"

---

# Fast Boot
- This should be pretty easy, it's on the "easy mode" page just like the memory, note that there's two fast boot settings, one which is faster than the other, choose the slower one

---

# Disabling Secure Boot
1) Under the "advanced" tab inside of the BIOS
2) Select "boot"
3) You should then see "secure boot", double click it
4) There should be a setting for disabling secure boot, turn it off
5) exit saving changes, it should also give you a prompt that shows what has been changed, it should be enabled -> disabled

---

# Restoring the EFI
- When we update, due to aurorus' amazing software, it ends up nuking (removing) the `.efi` (Unified Kernel Image) file from the UEFI boot entries, restoring this is pretty easy though thankfully
1) use a USB drive with the arch `.iso` installed, 
2) run the following command: `sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Arch Linux" --loader /EFI/Linux/arch-linux.efi --unicode`
3) run `shutdown now` to exit out of the USB install
4) remove the USB drive and boot the computer on 
- Note that we don't need to mount anything, we just boot through the USB and then run the above command, because `/boot` is unencrypted, there's no need to unlock the encrypted partition

---

# Enabling Secure Boot
- Enable the secure boot using the same instructions under Disabling but toggle it to on instead of off
- In my experience, it automatically turns on after the EFI is restored but it should be checked because re-enrolling the TPM with secure boot OFF can lead to a security issue

---

# Re-enrolling the TPM 

1) on the computers boot, the TPM isn't going to work and instead of the TPM unlocking the drive automatically, you have to do it manually
    - Use the password or recovery key or anything else to unlock the drive so we can get to the desktop

2) Once we're at the desktop, we need to remove the old TPM key *FIRST* then enroll the new one

3) run `sudo sbctl status` and make sure that secure boot is active, if not:
    - go to the bios and make sure it's on 
    - run `sbctl enroll-keys -m`
    - make sure nessesary files are signed by running `sbctl verify`
    - Even if they are signed, resign them to be sure
    - re-install linux to regenerate mkinitcpio using `sudo pacman -S linux`

4) Run the following command to see the methods that currently work for unlocking the encrytped drive: `sudo systemd-cryptenroll /dev/nvme0n1p2`
    - It'll return a list, in it there may be password, passphrase, recovery code, TPM, ETC, each item on the list is a method that you have previously added to unlock the drive
    - For example, you may see `recovery-code`, this means that earlier during setup of the partition you made a recovery code that can also be used to unlock the encrypted drive, **multiple methods can be used at once to unlock the same partition, we can have 1 or 10 passphrases that all work**

5) Because our old TPM is no longer useful, we need to remove the old TPM key with the following: `sudo systemd-cryptenroll /dev/nvme0n1p2 --wipe-slot=<NUMBER_ON_LIST_OF_OLD_TPM>`
    - note the number next to `TPM` on the returned list from above is what's used for `<NUMBER_ON_LIST_OF_OLD_TPM`
    - EG:

```txt
SLOT TYPE
   0 recovery
   1 tpm2
// remove the old tpm2 by running:
sudo systemd-cryptenroll /dev/nvme0n1p2 --wipe-slot=1 
// if we used 0, it would wipe the recovery key and because the tpm2 is invalid, we'd be fucked SO BE CAREFUL TO ONLY DELETE THE OLD TPM2
```

6) now that the old key is deleted, we can enroll a fresh valid tpm key with: `sudo systemd-cryptenroll /dev/nvme0n1p2 --wipe-slot=empty --tpm2-device=auto --tpm2-pcrs=7+15:sha256=0000000000000000000000000000000000000000000000000000000000000000`

7) run the following: `sudo systemd-cryptenroll /dev/nvme0n1p2`, the output should now have a fresh `TPM` under `type`

8) restart the computer, everything has now been restored

---

# References:
- `https://wiki.archlinux.org/title/Systemd-cryptenroll` 
- `https://wiki.archlinux.org/title/Unified_kernel_image#Directly_from_UEFI` (3.5 only)
- `https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition_with_TPM2_and_Secure_Boot`
