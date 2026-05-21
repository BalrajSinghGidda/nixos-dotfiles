{
  config,
  pkgs,
  lib,
  ...
}: let
  driverVersion = "ca3ff74436029a960d85018459e79dd97e08dfbe";
  snd-hda-cirrus = pkgs.stdenv.mkDerivation {
    pname = "snd-hda-cirrus";
    name = "sna-hda-codec-cirrus-${driverVersion}-module-${config.boot.kernelPackages.kernel.modDirVersion}";
    version = driverVersion;

    src = pkgs.fetchgit {
      url = "https://github.com/davidjo/snd_hda_macbookpro";
      rev = driverVersion;
      sha256 = "sha256-NKOkK9oQBJEwsfpG5fF/373qK8VSJa1XDIb6jrg/IWI=";
    };

    hardeningDisable = ["pic"];
    nativeBuildInputs = config.boot.kernelPackages.kernel.moduleBuildDependencies;
    NIX_CFLAGS_COMPILE = ["-g" "-Wall" "-Wno-unused-variable" "-Wno-unused-function"];
    makeFlags =
      # Patching out broken flags
      (
        lib.filter (
          f:
            !(lib.hasPrefix "O=" f)
            && !(lib.hasPrefix "--eval=" f)
        )
        config.boot.kernelPackages.kernel.makeFlags
      )
      ++ [
        "INSTALL_MOD_PATH=${placeholder "out"}"
        "KERNELRELEASE=${config.boot.kernelPackages.kernel.modDirVersion}"
        "KERNELBUILD=${config.boot.kernelPackages.kernel.dev}/lib/modules/${config.boot.kernelPackages.kernel.modDirVersion}/build"
      ];

    postPatch = ''
      # unpack kernel src
      mkdir -p build
      tar -xf ${config.boot.kernelPackages.kernel.src} \
      -C build \
      --strip-components=2 \
      "linux-${config.boot.kernelPackages.kernel.modDirVersion}/sound/hda"

      # copy files
      # <https://github.com/davidjo/snd_hda_macbookpro/blob/master/install.cirrus.driver.sh#L206>
      hda_dir="build/hda"
      makefiles_dir="makefiles"
      patch_dir="patch_cirrus"

      mv $hda_dir/Makefile $hda_dir/Makefile.orig
      mv $hda_dir/common/Makefile $hda_dir/common//Makefile.orig
      mv $hda_dir/codecs/Makefile $hda_dir/codecs//Makefile.orig
      mv $hda_dir/codecs/cirrus/Makefile $hda_dir/codecs/cirrus//Makefile.orig

      cp $makefiles_dir/Makefile $hda_dir
      cp $makefiles_dir/Makefile_common $hda_dir/common/Makefile
      cp $makefiles_dir/Makefile_codecs $hda_dir/codecs/Makefile
      cp $makefiles_dir/Makefile_cirrus $hda_dir/codecs/cirrus/Makefile

      cp $patch_dir/cirrus_apple.h $hda_dir/codecs/cirrus
      cp $patch_dir/patch_cirrus_boot84.h $hda_dir/codecs/cirrus
      cp $patch_dir/patch_cirrus_new84.h $hda_dir/codecs/cirrus
      cp $patch_dir/patch_cirrus_real84.h $hda_dir/codecs/cirrus
      cp $patch_dir/patch_cirrus_hda_generic_copy.h $hda_dir/codecs/cirrus
      cp $patch_dir/patch_cirrus_real84_i2c.h $hda_dir/codecs/cirrus

      # apply patches
      cd build/hda
      patch -b -p1 < ../../patch_cs8409.c.diff
      patch -b -p1 < ../../patch_cs8409.h.diff
      cd -

      # create makefile
      printf '
      subdir-ccflags-y += -I$(shell pwd)/common
      snd-hda-codec-cs8409-objs := patch_cs8409.o patch_cs8409-tables.o
      obj-$(CONFIG_SND_HDA_CODEC_CS8409) += snd-hda-codec-cs8409.o

      KBUILD_EXTRA_CFLAGS = "-DAPPLE_PINSENSE_FIXUP -DAPPLE_CODECS -DCONFIG_SND_HDA_RECONFIG=1"

      all:
      \tmake -C $(KERNELBUILD) CFLAGS_MODULE=$(KBUILD_EXTRA_CFLAGS) M=$(shell pwd)/build/hda modules

      clean:
      \tmake -C $(KERNELBUILD) M=$(shell pwd)/build/hda clean

      install:
      \tmake -C $(KERNELBUILD) M=$(shell pwd)/build/hda INSTALL_MOD_PATH=$(INSTALL_MOD_PATH) modules_install
      ' > Makefile
    '';

    meta = {platforms = lib.platforms.linux;};
  };
in {
  boot.extraModulePackages = [snd-hda-cirrus];
}
