################################################################################
#
# jack2
#
################################################################################

JACK2MOD_VERSION = ff1ed2c4524095055140370c1008a2d9cccc5645
JACK2MOD_SITE = $(call github,jackaudio,jack2,$(JACK2MOD_VERSION))
JACK2MOD_LICENSE = GPLv2+ (jack server), LGPLv2.1+ (jack library)
JACK2MOD_DEPENDENCIES = libsamplerate libsndfile alsa-lib host-python
JACK2MOD_INSTALL_STAGING = YES

JACK2MOD_WAF = $(HOST_DIR)/usr/bin/python2 ./waf

define JACK2MOD_CONFIGURE_CMDS
	(cd $(@D); \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -ffast-math -fprefetch-loop-arrays -funroll-loops -funsafe-loop-optimizations" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -ffast-math -fprefetch-loop-arrays -funroll-loops -funsafe-loop-optimizations" \
		$(JACK2MOD_WAF) configure \
		--alsa    \
		--classic \
		--prefix=/usr \
	)
endef

define JACK2MOD_BUILD_CMDS
	(cd $(@D); $(JACK2MOD_WAF) build -j $(PARALLEL_JOBS))
endef

define JACK2MOD_INSTALL_TARGET_CMDS
	(cd $(@D); $(JACK2MOD_WAF) install --destdir=$(TARGET_DIR))
endef

define JACK2MOD_INSTALL_STAGING_CMDS
	(cd $(@D); $(JACK2MOD_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
