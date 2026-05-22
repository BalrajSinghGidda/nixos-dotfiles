# Progress Log

## 2026-05-22T02:02:36.562+05:30

- **Did:** Listed repository root files with `ls`.
- **Next:** Inspect configuration directories (mac-btw, hosts, modules, flake).
- **How:** Use `ls`/`find` to locate Nix configuration files, then open them with `sed -n '1,200p <file>'` or `rg` for references.

- **Did:** Listed directories up to depth 3 to locate `hosts/mac-btw`.
- **Next:** Enumerate files under `hosts/mac-btw` and `hosts/nixos-btw`, then open key Nix configs.
- **How:** Run `find hosts -type f` and open files with `sed -n '1,200p <file>'` or `rg` for imports and hardware modules.

- **Did:** Listed all files under `hosts/` to identify host-specific configs.
- **Next:** Read `hosts/*/default.nix`, `hardware-configuration.nix`, and `home.nix`.
- **How:** Open each file with `sed -n '1,200p <file>'` to inspect imports and hardware settings.

- **Did:** Read all host configs under `hosts/mac-btw` and `hosts/nixos-btw` (default, hardware-configuration, home).
- **Next:** Inspect `flake.nix`, `modules/nixos`, and other Nix modules to see how hardware presets should be wired.
- **How:** Open `flake.nix` and `modules/nixos` with `sed -n '1,240p <file>'`, and scan for `imports`/hardware references using `rg "hardware|nixos-hardware"`.

- **Did:** Listed all files under `modules/` to identify NixOS and Home Manager modules.
- **Next:** Read `flake.nix` and `modules/nixos/default.nix` (plus any hardware-related modules).
- **How:** Open the files with `sed -n '1,240p <file>'` and search for hardware/module imports using `rg`.

- **Did:** Read `flake.nix`, `modules/nixos/default.nix`, `modules/nixos/core.nix`, and Apple-specific modules.
- **Next:** Locate any existing hardware tweaks and plan how to add `nixos-hardware` presets per host.
- **How:** Search for `hardware`/`nixos-hardware` in the repo with `rg "nixos-hardware|hardware"`.

- **Did:** Searched the repo for `hardware`/`nixos-hardware` references with `rg`.
- **Next:** Add `nixos-hardware` flake input and host-specific module imports.
- **How:** Use the nixos-hardware repo to find the correct module paths for MacBookPro14,1 and Dell Latitude 7490, then wire them into `hosts/*/default.nix` or `flake.nix`.

- **Did:** Read nixos-hardware modules for Apple MacBookPro 14,1 and Dell Latitude 7490.
- **Next:** Add nixos-hardware flake input and import `apple-macbook-pro-14-1`/`dell-latitude-7490` in host modules.
- **How:** Update `flake.nix` inputs and `modules` lists, then remove any duplicate settings already covered by those modules (e.g., microcode or B43 firmware).

- **Did:** Read the repository `Makefile` to confirm existing check/build commands.
- **Next:** Run `nix flake check` before and after changes (no sudo), and update `flake.lock` after adding nixos-hardware.
- **How:** Use `nix flake check` for validation and `nix flake lock --update-input nixos-hardware` after editing `flake.nix`.

- **Did:** Ran `nix flake check` to capture the current baseline.
- **Next:** Update `flake.nix` to add `nixos-hardware` and import the MacBook/Dell presets, then update `flake.lock`.
- **How:** Edit `flake.nix` with `apply_patch`, then run `nix flake lock --update-input nixos-hardware`.

- **Did:** Added `nixos-hardware` flake input and imported `dell-latitude-7490` and `apple-macbook-pro-14-1` modules in `flake.nix`.
- **Next:** Update `flake.lock` to pin the new input.
- **How:** Run `nix flake lock --update-input nixos-hardware` in the repo root.

- **Did:** Updated `flake.lock` to include the `nixos-hardware` input.
- **Next:** Re-run `nix flake check` to validate the updated configuration.
- **How:** Execute `nix flake check` in the repo root.

- **Did:** Ran `nix flake check` after adding nixos-hardware.
- **Next:** Review git diff and provide the user with any non-sudo commands to apply.
- **How:** Use `git status -sb` and `git diff` for a quick summary.

- **Did:** Reviewed git status and diff to confirm `flake.nix`/`flake.lock` and `progress.md` changes.
- **Next:** Provide the non-sudo commands to rebuild/switch for each host.
- **How:** Use `nixos-rebuild` with `--flake .#<host>` under sudo (user-run) or `nix build`/`nix flake check` for validation.

- **Did:** Searched the repo for `dsearch/danksearch` and deprecated `xorg.lib*` references.
- **Next:** Update nix-ld xorg library names and address the `dsearch` fixed-output hash mismatch.
- **How:** Edit `modules/nixos/nix-ld.nix` to use `libx*` packages, and decide whether to update or override the `danksearch` input.

- **Did:** Replaced deprecated `xorg.lib*` references with `libx*` packages in `modules/nixos/nix-ld.nix`.
- **Next:** Override the `dsearch` package vendor hash via the Home Manager module.
- **How:** Set `programs.dsearch.package` to an overridden `inputs.danksearch` package with the new `vendorHash`.

- **Did:** Overrode `programs.dsearch.package` to use the corrected `vendorHash` for `dsearch`.
- **Next:** Re-run `nix flake check` or `nixos-rebuild` to verify the build succeeds.
- **How:** Run `nix flake check` in this repo (no sudo), then `sudo nixos-rebuild switch --flake .#mac-btw` on the Mac.

- **Did:** Ran `nix flake check` after the fixes; it passed.
- **Next:** Re-run `sudo nixos-rebuild switch --flake .#mac-btw` on the MacBook.
- **How:** From the repo root on the Mac, execute `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Read `config/hypr/hyprland.conf` and the DMS Lua fragments under `config/hypr/dms/`.
- **Next:** Create `hyprland.lua` that mirrors the current config and requires the DMS modules.
- **How:** Translate the conf blocks into `hl.monitor`, `hl.config`, `hl.curve`, `hl.animation`, and `hl.bind` calls, then add `require("dms.*")`.

- **Did:** Added `config/hypr/hyprland.lua` with a Lua port of the existing Hyprland config and required the DMS modules.
- **Next:** Decide whether to keep `hyprland.conf` as legacy or switch consumers to `hyprland.lua`.
- **How:** If using Hyprland Lua config, ensure Hyprland loads `hyprland.lua`; otherwise keep `hyprland.conf` for compatibility.

- **Did:** Ran `nix flake check` after adding the Lua config; it passed.
- **Next:** Switch Hyprland to Lua config on the target machine and reload.
- **How:** Rebuild (`nixos-rebuild` or `home-manager switch`) and restart Hyprland.

- **Did:** Reviewed the `snd_hda_macbookpro` driver module in `modules/nixos/apple-sound.nix` and the nixpkgs PR enabling `CONFIG_SND_HDA_CODEC_CS8409`.
- **Next:** Enable the Apple sound module only for `mac-btw`.
- **How:** Add `../../modules/nixos/apple-sound.nix` to `hosts/mac-btw/default.nix` imports.

- **Did:** Enabled the Apple sound module only for `mac-btw` by importing `modules/nixos/apple-sound.nix` in `hosts/mac-btw/default.nix`.
- **Next:** Re-run `nix flake check` to validate the configuration.
- **How:** Execute `nix flake check` in the repo root (no sudo).

- **Did:** Ran `nix flake check` after enabling the Apple sound module; it passed.
- **Next:** Rebuild the `mac-btw` system so the new kernel module is built and installed.
- **How:** Run `sudo nixos-rebuild switch --flake .#mac-btw` on the MacBook, then reboot if the module doesn’t load automatically.

- **Did:** Set `boot.kernelPackages = pkgs.linuxPackages_latest;` in `modules/nixos/core.nix` so both hosts track the latest kernel.
- **Next:** Re-run `nix flake check` and rebuild on target machines.
- **How:** Run `nix flake check`, then `sudo nixos-rebuild switch --flake .#nixos-btw` / `.#mac-btw`.

- **Did:** Ran `nix flake check` after pinning to `linuxPackages_latest`; it passed.
- **Next:** Rebuild each host to pick up the latest kernel.
- **How:** Run `sudo nixos-rebuild switch --flake .#nixos-btw` and `sudo nixos-rebuild switch --flake .#mac-btw` on their respective machines.

- **Did:** Disabled `hardware.facetimehd.enable` for `mac-btw` to avoid the FacetimeHD driver build failure on the latest kernel.
- **Next:** Re-run `nix flake check` and rebuild `mac-btw`.
- **How:** Run `nix flake check`, then `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Ran `nix flake check` after disabling FacetimeHD; it passed.
- **Next:** Rebuild `mac-btw` to apply the change.
- **How:** Run `sudo nixos-rebuild switch --flake .#mac-btw` on the MacBook.

- **Did:** Added a `disable-nvme-d3cold` systemd service for `mac-btw` using the nixos-hardware script to improve suspend/resume stability.
- **Next:** Re-run `nix flake check` and rebuild `mac-btw`.
- **How:** Run `nix flake check`, then `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Ran `nix flake check` after adding the NVMe resume workaround; it passed.
- **Next:** Rebuild `mac-btw` and test suspend/resume.
- **How:** Run `sudo nixos-rebuild switch --flake .#mac-btw`, then close/open the lid to verify wake stability.

- **Did:** Reviewed the provided `journalctl -b -1` output; it only shows boot logs and no suspend/resume events.
- **Next:** Collect suspend/resume logs from the current boot after reproducing the slow wake.
- **How:** Run `journalctl -b | rg -i "suspend|resume|pm:|freeze|thaw|lid|wakeup|nvme|applesmc|applespi|brcm|wlan|i915"` right after a slow wake and share the output.

- **Did:** Parsed the current-boot log blob; it still only contains boot messages and no suspend/resume markers.
- **Next:** Capture suspend/resume markers with monotonic timestamps right after a slow wake.
- **How:** Run `journalctl -b -o short-monotonic | rg -i "suspend|resume|pm:|freeze|thaw|lid|wakeup|i915|nvme|applesmc|applespi" | tail -n 200`.

- **Did:** The follow-up log still appears to be boot-only and lacks any suspend/resume markers.
- **Next:** Collect the last 200 journal lines immediately after a slow wake (before any reboot).
- **How:** Run `sudo journalctl -b -r | head -n 200` right after the slow wake and share the output.

- **Did:** User reports the slow wake issue is gone.
- **Next:** None.
- **How:** If it returns, capture `sudo journalctl -b -r | head -n 200` immediately after the slow wake.

- **Did:** Added a udev rule for `mac-btw` to disable runtime power management on xHCI (USB 3) controllers to prevent resume timeouts.
- **Next:** Rebuild `mac-btw` and verify resume latency.
- **How:** Run `sudo nixos-rebuild switch --flake .#mac-btw` and test lid close/open.

- **Did:** Ran `nix flake check` after the xHCI rule update; it passed.
- **Next:** Rebuild `mac-btw` and test lid close/open.
- **How:** Run `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Removed the xHCI resume workarounds and disabled sleep for `mac-btw`, while locking on lid close.
- **Next:** Re-run `nix flake check` and rebuild `mac-btw`.
- **How:** Run `nix flake check`, then `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Updated sleep/logind options to the new `settings` schema (replacing deprecated `extraConfig`).
- **Next:** Re-run `nix flake check` and rebuild `mac-btw`.
- **How:** Run `nix flake check`, then `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Moved lid-switch settings fully to `services.logind.settings.Login` to avoid rename warnings.
- **Next:** Re-run `nix flake check` and rebuild `mac-btw`.
- **How:** Run `nix flake check`, then `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Ran `nix flake check` after the lid/sleep changes; it passed.
- **Next:** Rebuild `mac-btw` to apply the new lid and sleep behavior.
- **How:** Run `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Added an acpid lid handler to lock the session and turn DPMS off/on via Hyprland when the lid closes/opens.
- **Next:** Re-run `nix flake check` and rebuild `mac-btw`.
- **How:** Run `nix flake check`, then `sudo nixos-rebuild switch --flake .#mac-btw`.

- **Did:** Ran `nix flake check` after adding the lid DPMS handler; it passed.
- **Next:** Rebuild `mac-btw` and test lid close/open behavior.
- **How:** Run `sudo nixos-rebuild switch --flake .#mac-btw`, then close/open the lid to verify lock + screen off/on.
