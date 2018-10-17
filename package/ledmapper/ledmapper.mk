LEDMAPPER_DEPENDENCIES += rpi-firmware
LEDMAPPER_INSTALL_IMAGES = YES
LEDMAPPER_LOGO_LINES = `wc -l ${BR2_PACKAGE_LEDMAPPER_BOOT_SPLASH} | awk '{print $$1}'`

ifeq ($(BR2_PACKAGE_LEDMAPPER_X11_NOCURSOR),y)
define LEDMAPPER_INSTALL_X11_ARGS
	echo -n "-nocursor" > $(TARGET_DIR)/etc/x11args
endef
else
define LEDMAPPER_INSTALL_X11_ARGS
	echo -n "" > $(TARGET_DIR)/etc/x11args
endef
endif

define LEDMAPPER_INSTALL_DTOVERLAY
	echo "dtoverlay=${BR2_PACKAGE_LEDMAPPER_CONFIG_DTOVERLAY}" >> $(BINARIES_DIR)/rpi-firmware/config.txt
endef

define LEDMAPPER_INSTALL_DTPARAM
	echo "dtparam=${BR2_PACKAGE_LEDMAPPER_CONFIG_DTPARAM}" >> $(BINARIES_DIR)/rpi-firmware/config.txt
endef

define LEDMAPPER_INSTALL_BOOT_SPLASH
	sed -e "s/+1,@@/+1,$(LEDMAPPER_LOGO_LINES) @@/" package/ledmapper/kernel.patch_header > ${BUILD_DIR}/ledmapper_kernel.patch
	sed -e 's/^/+/' ${BR2_PACKAGE_LEDMAPPER_BOOT_SPLASH} >> ${BUILD_DIR}/ledmapper_kernel.patch
endef

define LEDMAPPER_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 package/ledmapper/config.txt $(BINARIES_DIR)/rpi-firmware/config.txt
	$(INSTALL) -D -m 0644 package/ledmapper/cmdline.txt $(BINARIES_DIR)/rpi-firmware/cmdline.txt
	$(LEDMAPPER_INSTALL_X11_ARGS)
	$(LEDMAPPER_INSTALL_DTOVERLAY)
	$(LEDMAPPER_INSTALL_DTPARAM)
	$(LEDMAPPER_INSTALL_BOOT_SPLASH)
endef

$(eval $(generic-package))
