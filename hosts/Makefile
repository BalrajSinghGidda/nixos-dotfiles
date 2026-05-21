
      subdir-ccflags-y += -I$(shell pwd)/common
      snd-hda-codec-cs8409-objs := patch_cs8409.o patch_cs8409-tables.o
      obj-$(CONFIG_SND_HDA_CODEC_CS8409) += snd-hda-codec-cs8409.o

      KBUILD_EXTRA_CFLAGS = "-DAPPLE_PINSENSE_FIXUP -DAPPLE_CODECS -DCONFIG_SND_HDA_RECONFIG=1"

      all:
      	make -C $(KERNELBUILD) CFLAGS_MODULE=$(KBUILD_EXTRA_CFLAGS) M=$(shell pwd)/build/hda modules

      clean:
      	make -C $(KERNELBUILD) M=$(shell pwd)/build/hda clean

      install:
      	make -C $(KERNELBUILD) M=$(shell pwd)/build/hda INSTALL_MOD_PATH=$(INSTALL_MOD_PATH) modules_install
      