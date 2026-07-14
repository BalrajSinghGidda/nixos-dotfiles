# nix-ld.nix
{ pkgs, ... }: {
  programs.nix-ld = {
    enable = true;

    # Libraries exposed to non-NixOS binaries through nix-ld
    libraries = with pkgs; [
      # C/C++ runtime
      stdenv.cc.cc.lib
      glibc
      gtk3

      # Compression / archive libs
      zlib
      zstd
      xz
      bzip2

      # SSL/TLS
      openssl

      # Wayland + graphics
      wayland
      libxkbcommon

      # XWayland compatibility (many apps still need these)
      libx11
      libxcursor
      libxi
      libxext
      libxrandr
      libxrender
      libxcb

      # OpenGL / Vulkan
      libglvnd
      mesa

      # Audio
      alsa-lib
      pipewire
      libpulseaudio

      # Fonts / UI
      fontconfig
      freetype

      # IPC / system
      dbus
      systemd
      util-linux

      # Common runtime deps
      glib
      nspr
      nss
      expat
      libxml2
      curl

      # Permissions / filesystem
      libcap
      attr
      acl
    ];
  };
}
