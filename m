Return-Path: <linux-can+bounces-7323-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEvqBjlPzmmjmgYAu9opvQ
	(envelope-from <linux-can+bounces-7323-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 13:12:57 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F84238827E
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 13:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1583730BBCD6
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14FF3BF67E;
	Thu,  2 Apr 2026 11:06:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA73AC0CD
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127977; cv=none; b=f2gD5tjDLYVUoxiShjO5fSGDBOtQWihIqh48xo/cW1x5pPhzFWHJiX+WGBhBrviJ+ruAmYlP8KrOhi+szr33Jo331x5BgNxrvwlvvyTyhU1GWUidX8ejjrr1ig5Q3nXwJ8sw7yvsucbTck9eblaMT3FQsO0uJvtffh3CC3ES9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127977; c=relaxed/simple;
	bh=Yd/6Pc5loOp6q2Ae4swq/Wc1w/fliWxGIpt5pwIb6ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwAw0UMbNPkGZskOboZ2pTOl2UVMNzeE+zUw+J5ikqZrieLf1eOHPPvj35JNU5l6FPhg/oM0Cg791s1NE5/gvVKA4hD3y8fQqF8Hbw8vRUyBFN/DQRqh1wFnIJLmf++F4FZ26sc6NiiP7PC72M0VONY0qrmquxkQBhF3Vi2Sa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w8Fru-0004ZY-BZ; Thu, 02 Apr 2026 13:05:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w8Frs-003MQs-2L;
	Thu, 02 Apr 2026 13:05:44 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 57352514511;
	Thu, 02 Apr 2026 11:05:44 +0000 (UTC)
Date: Thu, 2 Apr 2026 13:05:43 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: a0282524688@gmail.com
Cc: tmyu0@nuvoton.com, linusw@kernel.org, brgl@kernel.org, 
	linux@roeck-us.net, andi.shyti@kernel.org, lee@kernel.org, mailhol@kernel.org, 
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mfd: Add Host Interface (HIF) support for Nuvoton
 NCT6694
Message-ID: <20260402-warping-chameleon-of-prowess-9df780-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260402051442.1426672-1-a0282524688@gmail.com>
 <20260402051442.1426672-3-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eduyjgnvxkh2zrsd"
Content-Disposition: inline
In-Reply-To: <20260402051442.1426672-3-a0282524688@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-7323-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_SPAM(0.00)[0.266];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 6F84238827E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--eduyjgnvxkh2zrsd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] mfd: Add Host Interface (HIF) support for Nuvoton
 NCT6694
MIME-Version: 1.0

On 02.04.2026 13:14:42, a0282524688@gmail.com wrote:
> From: Ming Yu <a0282524688@gmail.com>
>
> The Nuvoton NCT6694 also provides a Host Interface (HIF) via eSPI
> to the host to access its features.
>
> Sub-devices can use the common functions nct6694_read_msg() and
> nct6694_write_msg() to issue a command. They can also request
> interrupts that will be called when the HIF device triggers a
> shared memory interrupt.
>
> To support multiple transports, the driver configuration is
> updated to allow selecting between the USB and HIF interfaces.
>
> Signed-off-by: Ming Yu <a0282524688@gmail.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/gpio/gpio-nct6694.c         |   7 -
>  drivers/hwmon/nct6694-hwmon.c       |  21 -
>  drivers/i2c/busses/i2c-nct6694.c    |   7 -
>  drivers/mfd/Kconfig                 |  47 +-
>  drivers/mfd/Makefile                |   3 +-
>  drivers/mfd/nct6694-hif.c           | 649 ++++++++++++++++++++++++++++
>  drivers/mfd/nct6694.c               |  97 +++--
>  drivers/net/can/usb/nct6694_canfd.c |   6 -
>  drivers/rtc/rtc-nct6694.c           |   7 -
>  drivers/watchdog/nct6694_wdt.c      |   7 -
>  include/linux/mfd/nct6694.h         |  51 ++-
>  12 files changed, 787 insertions(+), 116 deletions(-)
>  create mode 100644 drivers/mfd/nct6694-hif.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3fe46d7c4bc..7b6241faa6df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18899,6 +18899,7 @@ S:	Supported
>  F:	drivers/gpio/gpio-nct6694.c
>  F:	drivers/hwmon/nct6694-hwmon.c
>  F:	drivers/i2c/busses/i2c-nct6694.c
> +F:	drivers/mfd/nct6694-hif.c
>  F:	drivers/mfd/nct6694.c
>  F:	drivers/net/can/usb/nct6694_canfd.c
>  F:	drivers/rtc/rtc-nct6694.c
> diff --git a/drivers/gpio/gpio-nct6694.c b/drivers/gpio/gpio-nct6694.c
> index 3703a61209e6..a279510ece89 100644
> --- a/drivers/gpio/gpio-nct6694.c
> +++ b/drivers/gpio/gpio-nct6694.c
> @@ -12,13 +12,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>
> -/*
> - * USB command module type for NCT6694 GPIO controller.
> - * This defines the module type used for communication with the NCT6694
> - * GPIO controller over the USB interface.
> - */
> -#define NCT6694_GPIO_MOD	0xFF
> -
>  #define NCT6694_GPIO_VER	0x90
>  #define NCT6694_GPIO_VALID	0x110
>  #define NCT6694_GPI_DATA	0x120
> diff --git a/drivers/hwmon/nct6694-hwmon.c b/drivers/hwmon/nct6694-hwmon.c
> index 6dcf22ca5018..581451875f2c 100644
> --- a/drivers/hwmon/nct6694-hwmon.c
> +++ b/drivers/hwmon/nct6694-hwmon.c
> @@ -15,13 +15,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -/*
> - * USB command module type for NCT6694 report channel
> - * This defines the module type used for communication with the NCT6694
> - * report channel over the USB interface.
> - */
> -#define NCT6694_RPT_MOD			0xFF
> -
>  /* Report channel */
>  /*
>   * The report channel is used to report the status of the hardware monit=
or
> @@ -38,13 +31,6 @@
>  #define NCT6694_TIN_STS(x)		(0x6A + (x))
>  #define NCT6694_FIN_STS(x)		(0x6E + (x))
>
> -/*
> - * USB command module type for NCT6694 HWMON controller.
> - * This defines the module type used for communication with the NCT6694
> - * HWMON controller over the USB interface.
> - */
> -#define NCT6694_HWMON_MOD		0x00
> -
>  /* Command 00h - Hardware Monitor Control */
>  #define NCT6694_HWMON_CONTROL		0x00
>  #define NCT6694_HWMON_CONTROL_SEL	0x00
> @@ -53,13 +39,6 @@
>  #define NCT6694_HWMON_ALARM		0x02
>  #define NCT6694_HWMON_ALARM_SEL		0x00
>
> -/*
> - * USB command module type for NCT6694 PWM controller.
> - * This defines the module type used for communication with the NCT6694
> - * PWM controller over the USB interface.
> - */
> -#define NCT6694_PWM_MOD			0x01
> -
>  /* PWM Command - Manual Control */
>  #define NCT6694_PWM_CONTROL		0x01
>  #define NCT6694_PWM_CONTROL_SEL		0x00
> diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nc=
t6694.c
> index 7d8ad997f6d2..7ee209a04d16 100644
> --- a/drivers/i2c/busses/i2c-nct6694.c
> +++ b/drivers/i2c/busses/i2c-nct6694.c
> @@ -11,13 +11,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>
> -/*
> - * USB command module type for NCT6694 I2C controller.
> - * This defines the module type used for communication with the NCT6694
> - * I2C controller over the USB interface.
> - */
> -#define NCT6694_I2C_MOD			0x03
> -
>  /* Command 00h - I2C Deliver */
>  #define NCT6694_I2C_DELIVER		0x00
>  #define NCT6694_I2C_DELIVER_SEL		0x00
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 7192c9d1d268..8a715ec2f79f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1164,19 +1164,46 @@ config MFD_MENF21BMC
>  	  will be called menf21bmc.
>
>  config MFD_NCT6694
> -	tristate "Nuvoton NCT6694 support"
> +	tristate
>  	select MFD_CORE
> +	help
> +	  Core MFD support for the Nuvoton NCT6694 peripheral expander.
> +	  This provides the common APIs and shared structures used by all
> +	  interfaces (USB, HIF) to access the NCT6694 hardware features
> +	  such as GPIO, I2C, CAN-FD, Watchdog, ADC, PWM, and RTC.
> +
> +	  It is selected automatically by the transport interface drivers.
> +
> +config MFD_NCT6694_HIF
> +	tristate "Nuvoton NCT6694 HIF (eSPI) interface support"
> +	depends on HAS_IOPORT && ACPI
> +	select MFD_NCT6694
> +	select REGMAP_MMIO
> +	help
> +	  This enables support for the Nuvoton NCT6694 peripheral expander
> +	  connected via the Host Interface (HIF) using eSPI transport.
> +
> +	  The transport driver uses Super-I/O mapping and shared memory to
> +	  communicate with the NCT6694 firmware. Enable this option if you
> +	  are using the NCT6694 over an eSPI interface on an ACPI platform.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called nct6694-hif.
> +
> +config MFD_NCT6694_USB
> +	tristate "Nuvoton NCT6694 USB interface support"
> +	select MFD_NCT6694
>  	depends on USB
>  	help
> -	  This enables support for the Nuvoton USB device NCT6694, which shares
> -	  peripherals.
> -	  The Nuvoton NCT6694 is a peripheral expander with 16 GPIO chips,
> -	  6 I2C controllers, 2 CANfd controllers, 2 Watchdog timers, ADC,
> -	  PWM, and RTC.
> -	  This driver provides core APIs to access the NCT6694 hardware
> -	  monitoring and control features.
> -	  Additional drivers must be enabled to utilize the specific
> -	  functionalities of the device.
> +	  This enables support for the Nuvoton NCT6694 peripheral expander
> +	  connected via the USB interface.
> +
> +	  The transport driver uses USB bulk and interrupt transfers to
> +	  communicate with the NCT6694 firmware. Enable this option if you
> +	  are using the NCT6694 via a USB connection.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called nct6694.
>
>  config MFD_OCELOT
>  	tristate "Microsemi Ocelot External Control Support"
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e75e8045c28a..4cee9b74978c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -124,7 +124,8 @@ obj-$(CONFIG_MFD_MC13XXX_I2C)	+=3D mc13xxx-i2c.o
>
>  obj-$(CONFIG_MFD_PF1550)	+=3D pf1550.o
>
> -obj-$(CONFIG_MFD_NCT6694)	+=3D nct6694.o
> +obj-$(CONFIG_MFD_NCT6694_HIF)	+=3D nct6694-hif.o
> +obj-$(CONFIG_MFD_NCT6694_USB)	+=3D nct6694.o
>
>  obj-$(CONFIG_MFD_CORE)		+=3D mfd-core.o
>
> diff --git a/drivers/mfd/nct6694-hif.c b/drivers/mfd/nct6694-hif.c
> new file mode 100644
> index 000000000000..a5953c951eb5
> --- /dev/null
> +++ b/drivers/mfd/nct6694-hif.c
> @@ -0,0 +1,649 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Nuvoton Technology Corp.
> + *
> + * Nuvoton NCT6694 host-interface (eSPI) transport driver.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/nct6694.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/unaligned.h>
> +
> +#define DRVNAME "nct6694-hif"
> +
> +#define NCT6694_POLL_INTERVAL_US	10
> +#define NCT6694_POLL_TIMEOUT_US		10000
> +
> +/*
> + * Super-I/O registers
> + */
> +#define SIO_REG_LDSEL		0x07	/* Logical device select */
> +#define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
> +#define SIO_REG_LD_SHM		0x0F	/* Logical device shared memory control */
> +
> +#define SIO_REG_SHM_ENABLE	0x30	/* Enable shared memory */
> +#define SIO_REG_SHM_BASE_ADDR	0x60	/* Shared memory base address (2 byte=
s) */
> +#define SIO_REG_SHM_IRQ_NR	0x70	/* Shared memory interrupt number */
> +
> +#define SIO_REG_UNLOCK_KEY	0x87	/* Key to enable Super-I/O */
> +#define SIO_REG_LOCK_KEY	0xAA	/* Key to disable Super-I/O */
> +
> +#define SIO_NCT6694B_ID		0xD029
> +#define SIO_NCT6694D_ID		0x5832
> +
> +/*
> + * Super-I/O Shared Memory Logical Device registers
> + */
> +#define NCT6694_SHM_COFS_STS			0x2E
> +#define NCT6694_SHM_COFS_STS_COFS4W		BIT(7)
> +
> +#define NCT6694_SHM_COFS_CTL2			0x3B
> +#define NCT6694_SHM_COFS_CTL2_COFS4W_IE		BIT(3)
> +
> +#define NCT6694_SHM_INTR_STATUS			0x9C	/* Interrupt status register (4 b=
ytes) */
> +
> +enum nct6694_chips {
> +	NCT6694B =3D 0,
> +	NCT6694D,
> +};
> +
> +enum nct6694_module_id {
> +	NCT6694_GPIO0 =3D 0,
> +	NCT6694_GPIO1,
> +	NCT6694_GPIO2,
> +	NCT6694_GPIO3,
> +	NCT6694_GPIO4,
> +	NCT6694_GPIO5,
> +	NCT6694_GPIO6,
> +	NCT6694_GPIO7,
> +	NCT6694_GPIO8,
> +	NCT6694_GPIO9,
> +	NCT6694_GPIOA,
> +	NCT6694_GPIOB,
> +	NCT6694_GPIOC,
> +	NCT6694_GPIOD,
> +	NCT6694_GPIOE,
> +	NCT6694_GPIOF,
> +	NCT6694_I2C0,
> +	NCT6694_I2C1,
> +	NCT6694_I2C2,
> +	NCT6694_I2C3,
> +	NCT6694_I2C4,
> +	NCT6694_I2C5,
> +	NCT6694_CAN0,
> +	NCT6694_CAN1,
> +};
> +
> +struct __packed nct6694_msg {
> +	struct nct6694_cmd_header cmd_header;
> +	struct nct6694_response_header response_header;
> +	unsigned char *data;
> +};
> +
> +struct nct6694_sio_data {
> +	enum nct6694_chips chip;
> +	int sioreg;	/* Super-I/O index port */
> +
> +	/* Super-I/O access functions */
> +	int (*sio_enter)(struct nct6694_sio_data *sio_data);
> +	void (*sio_exit)(struct nct6694_sio_data *sio_data);
> +	void (*sio_select)(struct nct6694_sio_data *sio_data, int ld);
> +	int (*sio_inb)(struct nct6694_sio_data *sio_data, int reg);
> +	int (*sio_inw)(struct nct6694_sio_data *sio_data, int reg);
> +	void (*sio_outb)(struct nct6694_sio_data *sio_data, int reg, int val);

The signatures of the function look a bit strange. I expect functions
reading/writing bytes use u8 not int, register offsets should probably
be an unsigned int.

Why do you have pointers to the access functions? Why not use them
directly?

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eduyjgnvxkh2zrsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCac5NhQAKCRDMOmT6rpmt
0iiOAQDPnaCTCz7cHPZcUdH6WW5DKZHAXFfgb03FMRkx/xPipgD/X+mA6FYqehlp
FMnxD26sUBwZidoKAtEpXxguwwLFGgo=
=+i7v
-----END PGP SIGNATURE-----

--eduyjgnvxkh2zrsd--

