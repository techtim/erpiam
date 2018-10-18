LEDMAPPER_LISTEN_SITE_METHOD = git
LEDMAPPER_LISTEN_VERSION = master
LEDMAPPER_LISTEN_SITE = https://github.com/techtim/lmListener.git
LEDMAPPER_LISTEN_DEPENDENCIES = libwiringPi

ifeq ($(BR2_i386),y)
	LEDMAPPER_LISTEN_TARGET_ARCH = x86
else ifeq ($(BR2_x86_64),y)
	LEDMAPPER_LISTEN_TARGET_ARCH = x64
else ifeq ($(BR2_powerpc),y)
	LEDMAPPER_LISTEN_TARGET_ARCH = ppc
else ifeq ($(BR2_arm)$(BR2_armeb),y)
	LEDMAPPER_LISTEN_TARGET_ARCH = armv7-a
else ifeq ($(BR2_mips),y)
	LEDMAPPER_LISTEN_TARGET_ARCH = mips
else ifeq ($(BR2_mipsel),y)
	LEDMAPPER_LISTEN_TARGET_ARCH = mipsel
else
	LEDMAPPER_LISTEN_TARGET_ARCH = $(BR2_ARCH)
endif

define LEDMAPPER_LISTEN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) CONFIG=Release TARGET_ARCH=-march=$(LEDMAPPER_LISTEN_TARGET_ARCH) -C $(@D)
endef

define LEDMAPPER_LISTEN_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/lmListener $(TARGET_DIR)/usr/bin/lmListener
endef

$(eval $(generic-package))
