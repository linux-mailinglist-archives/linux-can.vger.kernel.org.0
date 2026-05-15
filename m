Return-Path: <linux-can+bounces-7631-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJHHGIvgBmrLogIAu9opvQ
	(envelope-from <linux-can+bounces-7631-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 10:59:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921854BDE5
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C7153045CFA
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60196426686;
	Fri, 15 May 2026 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRLtfxIF"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7A4279F5
	for <linux-can@vger.kernel.org>; Fri, 15 May 2026 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835491; cv=none; b=NMXsv7NedEu+fp3XZ2rIQZM4JebHPzsrSGpGnfKHgl+YPuLhX9iLeQg9YM5EhDNGhRbRVCyXeeh1WyejNMEhNuamnWETxQ8HvV83qLMnBsSJkHsBM2VHNI6AXKn0TXorplObQAOpBDMYW8CfXmSF5XfGOcLSUbvYmHuNQt+zi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835491; c=relaxed/simple;
	bh=w8ud8CNOeOEGPJ+YlCz3w83bibyymRSZ88Ef09Xu764=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md0GPMlTRr7//h7axKXh1pyqK+xNuaJpW0jln4I6Yu5BPr9PI+BkRS9n5WRaXnSwt71zrVkSaa1OTLpzCpxb9p7QnWRmqiTld/Du+IVvkum7IBYSULJsSKO0nkEHhRsGDlh0oF9feunYPfq0KoMvhGF1G/bDVVZpoyitLSTJqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRLtfxIF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bc7b311e77so3247005ad.0
        for <linux-can@vger.kernel.org>; Fri, 15 May 2026 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835487; x=1779440287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gEUeNfn6NhxfIvT+S4NO5SvvBLx8VhZKVg8WD051+M=;
        b=WRLtfxIFBUngviQSaxWrS1egVTyzsGtUWo18pxabbDF+ewHwD3KrOVWQhoEtvVUmJq
         7ktReApjqG7RCR9baB9Ls1+MIEhB/Zd+n1yQItIPW+k/ZoxSAWqhkTwbcC83Z9yAXDI2
         QbjSYbU0zabr/IaxpON6D6YIoSt7xHgjHoH+9TS1aSU4SRDF3HIl8jP/psFE0SocvLsp
         DnnctZ2Th1/JZ4BvXLsdLhXwmWSv7mW7aN6x+xFCZN9ybwbZd+59swQCoGeFs90HTDMq
         VEeccXd8piMpoKg4tSwTzJzy7FD1ejfMbgBgQQ9o7OuD/j4FwNQdQ9/NKSmbNkIHUyt7
         o56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835487; x=1779440287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6gEUeNfn6NhxfIvT+S4NO5SvvBLx8VhZKVg8WD051+M=;
        b=gd8wjEHIzyEShNE7Zv/oYJ5UbYVYUAWRl8pRcmZRfsyZlyvqI+JoMvi6yvv4N4GEOu
         QM8hTctnsjABDyESz+PSBICW0+CdvLYww0SNk/Mk4eb13BQiwBHL+em30+ELS7q1SJ3Y
         //ItUw1R9fdb4jhGDFiDDrB6Po7tkzXLXYCiUh0IHnQojrShVy/uu2J0mgIyArWjaEc0
         vwFgoYMuQHVqgKLJ1jqXUZYNj1RRcLkUuzSXeQ70o/Usni/PUm+uVSmQuTgbAiSaCXJU
         T06Y6uVgwtG4czGQ14o1R7e3Mt12egDk69NvISEG4Z2owxfQckbhBrm17Dfd0F2PWTVw
         R5CA==
X-Forwarded-Encrypted: i=1; AFNElJ9UA/Rj+mlA1hFIuzC4+LXFn0ttbIfpHgvWJUIK7l0WZoDtMbgnXT5hBwaKqOtlxx36t4Gq8/udFx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCO8kqsVI2IBv1FDpsjlI5hSnvtOy7eKlaEcgaFbSnHelaf7zC
	1S0GYaSnOvi3Y8/AtIhJPROcnmQO2sgKcu/OQCeIWKwgy4PqWGI8tfbH
X-Gm-Gg: Acq92OGO7JP27MZBXpXgkYVP2BoZoqnhNfYSVfP7XRJYBDGICRI/xnGhZqNc9M9Gbht
	25hxeeuHvpulDzA9z9jtU36U9fW/Bol9G/Mi2gIFGmmdLxbfX/Lioqb8V3pt24ZXr9McA8MB1V0
	77s4VwWC+weHRyYUof0FtTSp+nQJktKw301ZLZ7zMcP7U1qBa02UYArb9wUa/CiqEVy2lHKfA32
	pDyVIX86/vnggYR3IZY2e0Gqm/QRoy5+zzfcxY15GWDw9aZDqOdbXvD+w6dXDt/MCRvZhTDE0/2
	KTUvJeDIsKCRYSrOdgiBYkb5dtXxwTPcB4z2FuzrOirrkH9IeKDnlR78RN1w9cM2VBnf1AdbRoQ
	Vj2fO73hf5tg3suM0I7uPpKgz4HWgi6OojGPmwUkzhTiW3mP+ueZgeGFwEhELjopil5U2CDiVdn
	iVbePCfmfl52kYSRRh6MOGB4DrnRO4nucvZhsXjZghJ5q+BxGkE7gpllYbkAE82iCn/448miylq
	rn5
X-Received: by 2002:a17:902:f78a:b0:2bc:cf06:221c with SMTP id d9443c01a7336-2bd527d773dmr61777785ad.21.1778835486394;
        Fri, 15 May 2026 01:58:06 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6512sm52249325ad.52.2026.05.15.01.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:05 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	linusw@kernel.org,
	brgl@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>
Subject: [PATCH v4 1/1] mfd: Add Host Interface (HIF) support for Nuvoton NCT6694
Date: Fri, 15 May 2026 16:57:46 +0800
Message-Id: <20260515085746.114361-2-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515085746.114361-1-a0282524688@gmail.com>
References: <20260515085746.114361-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3921854BDE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7631-lists,linux-can=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Ming Yu <a0282524688@gmail.com>

The Nuvoton NCT6694 also provides a Host Interface (HIF) via eSPI
to the host to access its features.

Sub-devices can use the common functions nct6694_read_msg() and
nct6694_write_msg() to issue a command. They can also request
interrupts that will be called when the HIF device triggers a
shared memory interrupt.

To support multiple transports, the driver configuration is
updated to allow selecting between the USB and HIF interfaces.

Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes since version 3:
- Remove redundant module type macro definitions from sub-device drivers
  that are now provided by the shared header <linux/mfd/nct6694.h>,
  fixing -Wmacro-redefined warnings.

Changes since version 2:
- Restore per-device IDA and mfd_add_hotplug_devices()/PLATFORM_DEVID_AUTO
  to avoid child device ID conflicts with multiple NCT6694 chips.
- Validate irq_find_mapping() return value before dispatching IRQs.
- Check superio_enter() return value in nct6694_irq_init().

Changes since version 1:
- Drop function pointers from Super-I/O access and use static inline
  helpers with proper types.

 MAINTAINERS                         |   1 +
 drivers/gpio/gpio-nct6694.c         |   7 -
 drivers/hwmon/nct6694-hwmon.c       |  21 -
 drivers/i2c/busses/i2c-nct6694.c    |   7 -
 drivers/mfd/Kconfig                 |  47 +-
 drivers/mfd/Makefile                |   3 +-
 drivers/mfd/nct6694-hif.c           | 663 ++++++++++++++++++++++++++++
 drivers/mfd/nct6694.c               | 111 +++--
 drivers/net/can/usb/nct6694_canfd.c |   6 -
 drivers/rtc/rtc-nct6694.c           |   7 -
 drivers/watchdog/nct6694_wdt.c      |   7 -
 include/linux/mfd/nct6694.h         |  54 ++-
 12 files changed, 813 insertions(+), 121 deletions(-)
 create mode 100644 drivers/mfd/nct6694-hif.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6aa3fe2ee1bb..e39aad82132e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19091,6 +19091,7 @@ S:	Supported
 F:	drivers/gpio/gpio-nct6694.c
 F:	drivers/hwmon/nct6694-hwmon.c
 F:	drivers/i2c/busses/i2c-nct6694.c
+F:	drivers/mfd/nct6694-hif.c
 F:	drivers/mfd/nct6694.c
 F:	drivers/net/can/usb/nct6694_canfd.c
 F:	drivers/rtc/rtc-nct6694.c
diff --git a/drivers/gpio/gpio-nct6694.c b/drivers/gpio/gpio-nct6694.c
index a8607f0d9915..53bfc5983648 100644
--- a/drivers/gpio/gpio-nct6694.c
+++ b/drivers/gpio/gpio-nct6694.c
@@ -13,13 +13,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-/*
- * USB command module type for NCT6694 GPIO controller.
- * This defines the module type used for communication with the NCT6694
- * GPIO controller over the USB interface.
- */
-#define NCT6694_GPIO_MOD	0xFF
-
 #define NCT6694_GPIO_VER	0x90
 #define NCT6694_GPIO_VALID	0x110
 #define NCT6694_GPI_DATA	0x120
diff --git a/drivers/hwmon/nct6694-hwmon.c b/drivers/hwmon/nct6694-hwmon.c
index 6dcf22ca5018..581451875f2c 100644
--- a/drivers/hwmon/nct6694-hwmon.c
+++ b/drivers/hwmon/nct6694-hwmon.c
@@ -15,13 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-/*
- * USB command module type for NCT6694 report channel
- * This defines the module type used for communication with the NCT6694
- * report channel over the USB interface.
- */
-#define NCT6694_RPT_MOD			0xFF
-
 /* Report channel */
 /*
  * The report channel is used to report the status of the hardware monitor
@@ -38,13 +31,6 @@
 #define NCT6694_TIN_STS(x)		(0x6A + (x))
 #define NCT6694_FIN_STS(x)		(0x6E + (x))
 
-/*
- * USB command module type for NCT6694 HWMON controller.
- * This defines the module type used for communication with the NCT6694
- * HWMON controller over the USB interface.
- */
-#define NCT6694_HWMON_MOD		0x00
-
 /* Command 00h - Hardware Monitor Control */
 #define NCT6694_HWMON_CONTROL		0x00
 #define NCT6694_HWMON_CONTROL_SEL	0x00
@@ -53,13 +39,6 @@
 #define NCT6694_HWMON_ALARM		0x02
 #define NCT6694_HWMON_ALARM_SEL		0x00
 
-/*
- * USB command module type for NCT6694 PWM controller.
- * This defines the module type used for communication with the NCT6694
- * PWM controller over the USB interface.
- */
-#define NCT6694_PWM_MOD			0x01
-
 /* PWM Command - Manual Control */
 #define NCT6694_PWM_CONTROL		0x01
 #define NCT6694_PWM_CONTROL_SEL		0x00
diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nct6694.c
index 1413ab6f9462..ef3329f34246 100644
--- a/drivers/i2c/busses/i2c-nct6694.c
+++ b/drivers/i2c/busses/i2c-nct6694.c
@@ -12,13 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-/*
- * USB command module type for NCT6694 I2C controller.
- * This defines the module type used for communication with the NCT6694
- * I2C controller over the USB interface.
- */
-#define NCT6694_I2C_MOD			0x03
-
 /* Command 00h - I2C Deliver */
 #define NCT6694_I2C_DELIVER		0x00
 #define NCT6694_I2C_DELIVER_SEL		0x00
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7192c9d1d268..8a715ec2f79f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1164,19 +1164,46 @@ config MFD_MENF21BMC
 	  will be called menf21bmc.
 
 config MFD_NCT6694
-	tristate "Nuvoton NCT6694 support"
+	tristate
 	select MFD_CORE
+	help
+	  Core MFD support for the Nuvoton NCT6694 peripheral expander.
+	  This provides the common APIs and shared structures used by all
+	  interfaces (USB, HIF) to access the NCT6694 hardware features
+	  such as GPIO, I2C, CAN-FD, Watchdog, ADC, PWM, and RTC.
+
+	  It is selected automatically by the transport interface drivers.
+
+config MFD_NCT6694_HIF
+	tristate "Nuvoton NCT6694 HIF (eSPI) interface support"
+	depends on HAS_IOPORT && ACPI
+	select MFD_NCT6694
+	select REGMAP_MMIO
+	help
+	  This enables support for the Nuvoton NCT6694 peripheral expander
+	  connected via the Host Interface (HIF) using eSPI transport.
+
+	  The transport driver uses Super-I/O mapping and shared memory to
+	  communicate with the NCT6694 firmware. Enable this option if you
+	  are using the NCT6694 over an eSPI interface on an ACPI platform.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called nct6694-hif.
+
+config MFD_NCT6694_USB
+	tristate "Nuvoton NCT6694 USB interface support"
+	select MFD_NCT6694
 	depends on USB
 	help
-	  This enables support for the Nuvoton USB device NCT6694, which shares
-	  peripherals.
-	  The Nuvoton NCT6694 is a peripheral expander with 16 GPIO chips,
-	  6 I2C controllers, 2 CANfd controllers, 2 Watchdog timers, ADC,
-	  PWM, and RTC.
-	  This driver provides core APIs to access the NCT6694 hardware
-	  monitoring and control features.
-	  Additional drivers must be enabled to utilize the specific
-	  functionalities of the device.
+	  This enables support for the Nuvoton NCT6694 peripheral expander
+	  connected via the USB interface.
+
+	  The transport driver uses USB bulk and interrupt transfers to
+	  communicate with the NCT6694 firmware. Enable this option if you
+	  are using the NCT6694 via a USB connection.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called nct6694.
 
 config MFD_OCELOT
 	tristate "Microsemi Ocelot External Control Support"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e75e8045c28a..4cee9b74978c 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -124,7 +124,8 @@ obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
 obj-$(CONFIG_MFD_PF1550)	+= pf1550.o
 
-obj-$(CONFIG_MFD_NCT6694)	+= nct6694.o
+obj-$(CONFIG_MFD_NCT6694_HIF)	+= nct6694-hif.o
+obj-$(CONFIG_MFD_NCT6694_USB)	+= nct6694.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
diff --git a/drivers/mfd/nct6694-hif.c b/drivers/mfd/nct6694-hif.c
new file mode 100644
index 000000000000..ca8c08b0d2e3
--- /dev/null
+++ b/drivers/mfd/nct6694-hif.c
@@ -0,0 +1,663 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Nuvoton Technology Corp.
+ *
+ * Nuvoton NCT6694 host-interface (eSPI) transport driver.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/nct6694.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/unaligned.h>
+
+#define DRVNAME "nct6694-hif"
+
+#define NCT6694_POLL_INTERVAL_US	10
+#define NCT6694_POLL_TIMEOUT_US		10000
+
+/*
+ * Super-I/O registers
+ */
+#define SIO_REG_LDSEL		0x07	/* Logical device select */
+#define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
+#define SIO_REG_LD_SHM		0x0F	/* Logical device shared memory control */
+
+#define SIO_REG_SHM_ENABLE	0x30	/* Enable shared memory */
+#define SIO_REG_SHM_BASE_ADDR	0x60	/* Shared memory base address (2 bytes) */
+#define SIO_REG_SHM_IRQ_NR	0x70	/* Shared memory interrupt number */
+
+#define SIO_REG_UNLOCK_KEY	0x87	/* Key to enable Super-I/O */
+#define SIO_REG_LOCK_KEY	0xAA	/* Key to disable Super-I/O */
+
+#define SIO_NCT6694B_ID		0xD029
+#define SIO_NCT6694D_ID		0x5832
+
+/*
+ * Super-I/O Shared Memory Logical Device registers
+ */
+#define NCT6694_SHM_COFS_STS			0x2E
+#define NCT6694_SHM_COFS_STS_COFS4W		BIT(7)
+
+#define NCT6694_SHM_COFS_CTL2			0x3B
+#define NCT6694_SHM_COFS_CTL2_COFS4W_IE		BIT(3)
+
+#define NCT6694_SHM_INTR_STATUS			0x9C	/* Interrupt status register (4 bytes) */
+
+enum nct6694_chips {
+	NCT6694B = 0,
+	NCT6694D,
+};
+
+enum nct6694_module_id {
+	NCT6694_GPIO0 = 0,
+	NCT6694_GPIO1,
+	NCT6694_GPIO2,
+	NCT6694_GPIO3,
+	NCT6694_GPIO4,
+	NCT6694_GPIO5,
+	NCT6694_GPIO6,
+	NCT6694_GPIO7,
+	NCT6694_GPIO8,
+	NCT6694_GPIO9,
+	NCT6694_GPIOA,
+	NCT6694_GPIOB,
+	NCT6694_GPIOC,
+	NCT6694_GPIOD,
+	NCT6694_GPIOE,
+	NCT6694_GPIOF,
+	NCT6694_I2C0,
+	NCT6694_I2C1,
+	NCT6694_I2C2,
+	NCT6694_I2C3,
+	NCT6694_I2C4,
+	NCT6694_I2C5,
+	NCT6694_CAN0,
+	NCT6694_CAN1,
+};
+
+struct __packed nct6694_msg {
+	struct nct6694_cmd_header cmd_header;
+	struct nct6694_response_header response_header;
+	unsigned char *data;
+};
+
+struct nct6694_sio_data {
+	enum nct6694_chips chip;
+	int sioreg;	/* Super-I/O index port */
+};
+
+struct nct6694_hif_data {
+	struct regmap *regmap;
+	struct mutex msg_lock;
+	struct nct6694_sio_data *sio_data;
+	void __iomem *msg_base;
+	unsigned int shm_base;
+};
+
+static const char * const nct6694_chip_names[] = {
+	"NCT6694D",
+	"NCT6694B"
+};
+
+/*
+ * Super-I/O functions.
+ */
+static inline int superio_enter(struct nct6694_sio_data *sio_data)
+{
+	int ioreg = sio_data->sioreg;
+
+	/*
+	 * Try to reserve <ioreg> and <ioreg + 1> for exclusive access.
+	 */
+	if (!request_muxed_region(ioreg, 2, DRVNAME))
+		return -EBUSY;
+
+	outb(SIO_REG_UNLOCK_KEY, ioreg);
+	outb(SIO_REG_UNLOCK_KEY, ioreg);
+
+	return 0;
+}
+
+static inline void superio_exit(struct nct6694_sio_data *sio_data)
+{
+	int ioreg = sio_data->sioreg;
+
+	outb(SIO_REG_LOCK_KEY, ioreg);
+
+	release_region(ioreg, 2);
+}
+
+static inline void superio_select(struct nct6694_sio_data *sio_data, int ld)
+{
+	int ioreg = sio_data->sioreg;
+
+	outb(SIO_REG_LDSEL, ioreg);
+	outb(ld, ioreg + 1);
+}
+
+static inline int superio_inb(struct nct6694_sio_data *sio_data, int reg)
+{
+	int ioreg = sio_data->sioreg;
+
+	outb(reg, ioreg);
+	return inb(ioreg + 1);
+}
+
+static inline int superio_inw(struct nct6694_sio_data *sio_data, int reg)
+{
+	int ioreg = sio_data->sioreg;
+	int val;
+
+	outb(reg++, ioreg);
+	val = inb(ioreg + 1) << 8;
+	outb(reg, ioreg);
+	val |= inb(ioreg + 1);
+
+	return val;
+}
+
+static inline void superio_outb(struct nct6694_sio_data *sio_data, int reg, u8 val)
+{
+	int ioreg = sio_data->sioreg;
+
+	outb(reg, ioreg);
+	outb(val, ioreg + 1);
+}
+
+static int nct6694_sio_find(struct nct6694_sio_data *sio_data, u8 sioreg)
+{
+	int ret;
+	u16 devid;
+
+	sio_data->sioreg = sioreg;
+
+	ret = superio_enter(sio_data);
+	if (ret)
+		return ret;
+
+	/* Check Chip ID */
+	devid = superio_inw(sio_data, SIO_REG_DEVID);
+	switch (devid) {
+	case SIO_NCT6694B_ID:
+		sio_data->chip = NCT6694B;
+		break;
+	case SIO_NCT6694D_ID:
+		sio_data->chip = NCT6694D;
+		break;
+	default:
+		pr_err("Unsupported device 0x%04x\n", devid);
+		goto err;
+	}
+
+	pr_info("Found %s at %#x\n", nct6694_chip_names[sio_data->chip], sio_data->sioreg);
+
+	superio_exit(sio_data);
+
+	return 0;
+
+err:
+	superio_exit(sio_data);
+	return -ENODEV;
+}
+
+static const struct mfd_cell_acpi_match nct6694_acpi_match_gpio[] = {
+	{ .adr = NCT6694_GPIO0 },
+	{ .adr = NCT6694_GPIO1 },
+	{ .adr = NCT6694_GPIO2 },
+	{ .adr = NCT6694_GPIO3 },
+	{ .adr = NCT6694_GPIO4 },
+	{ .adr = NCT6694_GPIO5 },
+	{ .adr = NCT6694_GPIO6 },
+	{ .adr = NCT6694_GPIO7 },
+	{ .adr = NCT6694_GPIO8 },
+	{ .adr = NCT6694_GPIO9 },
+	{ .adr = NCT6694_GPIOA },
+	{ .adr = NCT6694_GPIOB },
+	{ .adr = NCT6694_GPIOC },
+	{ .adr = NCT6694_GPIOD },
+	{ .adr = NCT6694_GPIOE },
+	{ .adr = NCT6694_GPIOF },
+};
+
+static const struct mfd_cell_acpi_match nct6694_acpi_match_i2c[] = {
+	{ .adr = NCT6694_I2C0 },
+	{ .adr = NCT6694_I2C1 },
+	{ .adr = NCT6694_I2C2 },
+	{ .adr = NCT6694_I2C3 },
+	{ .adr = NCT6694_I2C4 },
+	{ .adr = NCT6694_I2C5 },
+};
+
+static const struct mfd_cell_acpi_match nct6694_acpi_match_can[] = {
+	{ .adr = NCT6694_CAN0 },
+	{ .adr = NCT6694_CAN1 },
+};
+
+static const struct mfd_cell nct6694_devs[] = {
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[0]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[1]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[2]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[3]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[4]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[5]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[6]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[7]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[8]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[9]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[10]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[11]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[12]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[13]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[14]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 0, &nct6694_acpi_match_gpio[15]),
+
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 0, &nct6694_acpi_match_i2c[0]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 0, &nct6694_acpi_match_i2c[1]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 0, &nct6694_acpi_match_i2c[2]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 0, &nct6694_acpi_match_i2c[3]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 0, &nct6694_acpi_match_i2c[4]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 0, &nct6694_acpi_match_i2c[5]),
+
+	MFD_CELL_ACPI("nct6694-canfd", NULL, NULL, 0, 0, &nct6694_acpi_match_can[0]),
+	MFD_CELL_ACPI("nct6694-canfd", NULL, NULL, 0, 0, &nct6694_acpi_match_can[1]),
+};
+
+static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char err_status)
+{
+	switch (err_status) {
+	case NCT6694_NO_ERROR:
+		return 0;
+	case NCT6694_NOT_SUPPORT_ERROR:
+		dev_err(nct6694->dev, "Command is not supported!\n");
+		break;
+	case NCT6694_NO_RESPONSE_ERROR:
+		dev_warn(nct6694->dev, "Command received no response!\n");
+		break;
+	case NCT6694_TIMEOUT_ERROR:
+		dev_warn(nct6694->dev, "Command timed out!\n");
+		break;
+	case NCT6694_PENDING:
+		dev_err(nct6694->dev, "Command is pending!\n");
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return -EIO;
+}
+
+static int nct6694_xfer_msg(struct nct6694 *nct6694,
+			    const struct nct6694_cmd_header *cmd_hd,
+			    u8 hctrl, void *buf)
+{
+	struct nct6694_hif_data *hdata = nct6694->priv;
+	void __iomem *hdr = hdata->msg_base + offsetof(struct nct6694_msg, cmd_header);
+	struct nct6694_cmd_header cmd = *cmd_hd;
+	struct nct6694_response_header resp;
+	u16 len = le16_to_cpu(cmd.len);
+	u8 status;
+	int ret;
+
+	guard(mutex)(&hdata->msg_lock);
+
+	/* Wait until the previous command is completed */
+	ret = readb_poll_timeout(hdr + offsetof(struct nct6694_cmd_header, hctrl),
+				 status, status == 0, NCT6694_POLL_INTERVAL_US,
+				 NCT6694_POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/*
+	 * Write cmd header fields, but skip hctrl — writing to it triggers
+	 * firmware command processing and must be deferred until data is ready.
+	 */
+	memcpy_toio(hdr, &cmd, offsetof(struct nct6694_cmd_header, hctrl));
+	memcpy_toio(hdr + offsetof(struct nct6694_cmd_header, rsv2), &cmd.rsv2,
+		    sizeof(cmd) - offsetof(struct nct6694_cmd_header, rsv2));
+
+	if (hctrl == NCT6694_HCTRL_SET && len)
+		memcpy_toio(hdata->msg_base + offsetof(struct nct6694_msg, data),
+			    buf, len);
+
+	/* Write hctrl last to trigger command processing */
+	writeb(hctrl, hdr + offsetof(struct nct6694_cmd_header, hctrl));
+
+	ret = readb_poll_timeout(hdr + offsetof(struct nct6694_cmd_header, hctrl),
+				 status, status == 0, NCT6694_POLL_INTERVAL_US,
+				 NCT6694_POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	memcpy_fromio(&resp, hdata->msg_base + offsetof(struct nct6694_msg, response_header),
+		      sizeof(resp));
+
+	ret = nct6694_response_err_handling(nct6694, resp.sts);
+	if (ret)
+		return ret;
+
+	if (le16_to_cpu(resp.len))
+		memcpy_fromio(buf, hdata->msg_base + offsetof(struct nct6694_msg, data),
+			      min(len, le16_to_cpu(resp.len)));
+
+	return 0;
+}
+
+/**
+ * nct6694_hif_read_msg() - Send a command and read response data via HIF
+ * @nct6694: NCT6694 device data
+ * @cmd_hd: command header
+ * @buf: buffer to store response data
+ *
+ * Return: 0 on success or negative errno on failure.
+ */
+static int nct6694_hif_read_msg(struct nct6694 *nct6694,
+				const struct nct6694_cmd_header *cmd_hd,
+				void *buf)
+{
+	struct nct6694_hif_data *hdata = nct6694->priv;
+
+	if (cmd_hd->mod == NCT6694_RPT_MOD)
+		return regmap_bulk_read(hdata->regmap,
+					le16_to_cpu(cmd_hd->offset),
+					buf, le16_to_cpu(cmd_hd->len));
+	return nct6694_xfer_msg(nct6694, cmd_hd, NCT6694_HCTRL_GET, buf);
+}
+
+/**
+ * nct6694_hif_write_msg() - Send a command with data payload via HIF
+ * @nct6694: NCT6694 device data
+ * @cmd_hd: command header
+ * @buf: buffer containing data to send
+ *
+ * Return: 0 on success or negative errno on failure.
+ */
+static int nct6694_hif_write_msg(struct nct6694 *nct6694,
+				 const struct nct6694_cmd_header *cmd_hd,
+				 void *buf)
+{
+	struct nct6694_hif_data *hdata = nct6694->priv;
+
+	if (cmd_hd->mod == NCT6694_RPT_MOD)
+		return regmap_bulk_write(hdata->regmap,
+					 le16_to_cpu(cmd_hd->offset),
+					 buf, le16_to_cpu(cmd_hd->len));
+	return nct6694_xfer_msg(nct6694, cmd_hd, NCT6694_HCTRL_SET, buf);
+}
+
+static const struct regmap_config nct6694_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_stride = 1,
+};
+
+static irqreturn_t nct6694_irq_handler(int irq, void *data)
+{
+	struct nct6694 *nct6694 = data;
+	struct nct6694_hif_data *hdata = nct6694->priv;
+	u8 reg_data[4];
+	u32 intr_status;
+	int ret;
+
+	/* Check interrupt status is set */
+	if (!(inb(hdata->shm_base + NCT6694_SHM_COFS_STS) & NCT6694_SHM_COFS_STS_COFS4W))
+		return IRQ_NONE;
+
+	/* Clear interrupt status */
+	outb(NCT6694_SHM_COFS_STS_COFS4W, hdata->shm_base + NCT6694_SHM_COFS_STS);
+
+	ret = regmap_bulk_read(hdata->regmap, NCT6694_SHM_INTR_STATUS,
+			       reg_data, ARRAY_SIZE(reg_data));
+	if (ret)
+		return IRQ_NONE;
+
+	intr_status = get_unaligned_le32(reg_data);
+
+	while (intr_status) {
+		int hwirq = __ffs(intr_status);
+		unsigned int virq = irq_find_mapping(nct6694->domain, hwirq);
+
+		if (virq)
+			generic_handle_irq_safe(virq);
+		intr_status &= ~BIT(hwirq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void nct6694_irq_release(void *data)
+{
+	struct nct6694 *nct6694 = data;
+	struct nct6694_hif_data *hdata = nct6694->priv;
+	unsigned char cofs_ctl2;
+
+	/* Disable SIRQ interrupt */
+	cofs_ctl2 = inb(hdata->shm_base + NCT6694_SHM_COFS_CTL2);
+	cofs_ctl2 &= ~NCT6694_SHM_COFS_CTL2_COFS4W_IE;
+	outb(cofs_ctl2, hdata->shm_base + NCT6694_SHM_COFS_CTL2);
+}
+
+static int nct6694_irq_init(struct nct6694 *nct6694, int irq)
+{
+	struct nct6694_hif_data *hdata = nct6694->priv;
+	struct nct6694_sio_data *sio_data = hdata->sio_data;
+	unsigned char cofs_ctl2;
+	int ret;
+
+	/* Set SIRQ number */
+	ret = superio_enter(sio_data);
+	if (ret)
+		return ret;
+
+	superio_select(sio_data, SIO_REG_LD_SHM);
+
+	if (!superio_inb(sio_data, SIO_REG_SHM_ENABLE)) {
+		superio_exit(sio_data);
+		return -EIO;
+	}
+
+	hdata->shm_base = superio_inw(sio_data, SIO_REG_SHM_BASE_ADDR);
+
+	superio_outb(sio_data, SIO_REG_SHM_IRQ_NR, irq);
+
+	superio_exit(sio_data);
+
+	/* Enable SIRQ interrupt */
+	cofs_ctl2 = inb(hdata->shm_base + NCT6694_SHM_COFS_CTL2);
+	cofs_ctl2 |= NCT6694_SHM_COFS_CTL2_COFS4W_IE;
+	outb(cofs_ctl2, hdata->shm_base + NCT6694_SHM_COFS_CTL2);
+
+	return 0;
+}
+
+static void nct6694_irq_enable(struct irq_data *data)
+{
+	struct nct6694 *nct6694 = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+
+	guard(spinlock_irqsave)(&nct6694->irq_lock);
+
+	nct6694->irq_enable |= BIT(hwirq);
+}
+
+static void nct6694_irq_disable(struct irq_data *data)
+{
+	struct nct6694 *nct6694 = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+
+	guard(spinlock_irqsave)(&nct6694->irq_lock);
+
+	nct6694->irq_enable &= ~BIT(hwirq);
+}
+
+static const struct irq_chip nct6694_irq_chip = {
+	.name = "nct6694-irq",
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.irq_enable = nct6694_irq_enable,
+	.irq_disable = nct6694_irq_disable,
+};
+
+static void nct6694_irq_domain_remove(void *data)
+{
+	struct nct6694 *nct6694 = data;
+
+	irq_domain_remove(nct6694->domain);
+}
+
+static int nct6694_irq_domain_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	struct nct6694 *nct6694 = d->host_data;
+
+	irq_set_chip_data(irq, nct6694);
+	irq_set_chip_and_handler(irq, &nct6694_irq_chip, handle_simple_irq);
+
+	return 0;
+}
+
+static void nct6694_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
+{
+	irq_set_chip_and_handler(irq, NULL, NULL);
+	irq_set_chip_data(irq, NULL);
+}
+
+static const struct irq_domain_ops nct6694_irq_domain_ops = {
+	.map	= nct6694_irq_domain_map,
+	.unmap	= nct6694_irq_domain_unmap,
+};
+
+static void nct6694_ida_destroy(void *data)
+{
+	struct nct6694 *nct6694 = data;
+
+	ida_destroy(&nct6694->wdt_ida);
+	ida_destroy(&nct6694->canfd_ida);
+	ida_destroy(&nct6694->i2c_ida);
+	ida_destroy(&nct6694->gpio_ida);
+}
+
+static const u8 sio_addrs[] = { 0x2e, 0x4e };
+
+static int nct6694_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nct6694_sio_data *sio_data;
+	struct nct6694_hif_data *hdata;
+	struct nct6694 *data;
+	void __iomem *rpt_base, *msg_base;
+	int ret, i, irq;
+
+	sio_data = devm_kzalloc(dev, sizeof(*sio_data), GFP_KERNEL);
+	if (!sio_data)
+		return -ENOMEM;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	hdata = devm_kzalloc(dev, sizeof(*hdata), GFP_KERNEL);
+	if (!hdata)
+		return -ENOMEM;
+
+	rpt_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rpt_base))
+		return PTR_ERR(rpt_base);
+	msg_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(msg_base))
+		return PTR_ERR(msg_base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	for (i = 0; i < ARRAY_SIZE(sio_addrs); i++) {
+		ret = nct6694_sio_find(sio_data, sio_addrs[i]);
+		if (!ret)
+			break;
+	}
+	if (ret)
+		return ret;
+
+	hdata->sio_data = sio_data;
+	hdata->msg_base = msg_base;
+	hdata->regmap = devm_regmap_init_mmio(dev, rpt_base,
+					      &nct6694_regmap_config);
+	if (IS_ERR(hdata->regmap))
+		return PTR_ERR(hdata->regmap);
+
+	data->dev = dev;
+	data->priv = hdata;
+	data->read_msg = nct6694_hif_read_msg;
+	data->write_msg = nct6694_hif_write_msg;
+
+	spin_lock_init(&data->irq_lock);
+
+	ida_init(&data->gpio_ida);
+	ida_init(&data->i2c_ida);
+	ida_init(&data->canfd_ida);
+	ida_init(&data->wdt_ida);
+
+	ret = devm_add_action_or_reset(dev, nct6694_ida_destroy, data);
+	if (ret)
+		return ret;
+
+	data->domain = irq_domain_create_simple(NULL, NCT6694_NR_IRQS, 0,
+						&nct6694_irq_domain_ops,
+						data);
+	if (!data->domain)
+		return -ENODEV;
+
+	ret = devm_add_action_or_reset(dev, nct6694_irq_domain_remove, data);
+	if (ret)
+		return ret;
+
+	ret = nct6694_irq_init(data, irq);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, nct6694_irq_release, data);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, nct6694_irq_handler,
+					IRQF_ONESHOT | IRQF_SHARED,
+					dev_name(dev), data);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &hdata->msg_lock);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, data);
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, nct6694_devs,
+				    ARRAY_SIZE(nct6694_devs), NULL, 0, NULL);
+}
+
+static const struct acpi_device_id nct6694_acpi_ids[] = {
+	{ "NTN0538", 0 },
+	{}
+};
+
+static struct platform_driver nct6694_driver = {
+	.driver = {
+		.name = DRVNAME,
+		.acpi_match_table = nct6694_acpi_ids,
+	},
+	.probe	= nct6694_probe,
+};
+module_platform_driver(nct6694_driver);
+
+MODULE_DESCRIPTION("Nuvoton NCT6694 host-interface transport driver");
+MODULE_AUTHOR("Ming Yu <tmyu0@nuvoton.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/nct6694.c b/drivers/mfd/nct6694.c
index 308b2fda3055..cf3457c2b3ed 100644
--- a/drivers/mfd/nct6694.c
+++ b/drivers/mfd/nct6694.c
@@ -10,8 +10,8 @@
  */
 
 #include <linux/bits.h>
-#include <linux/interrupt.h>
 #include <linux/idr.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -22,6 +22,27 @@
 #include <linux/spinlock.h>
 #include <linux/usb.h>
 
+#define NCT6694_VENDOR_ID	0x0416
+#define NCT6694_PRODUCT_ID	0x200B
+#define NCT6694_INT_IN_EP	0x81
+#define NCT6694_BULK_IN_EP	0x02
+#define NCT6694_BULK_OUT_EP	0x03
+
+#define NCT6694_URB_TIMEOUT	1000
+
+union __packed nct6694_usb_msg {
+	struct nct6694_cmd_header cmd_header;
+	struct nct6694_response_header response_header;
+};
+
+struct nct6694_usb_data {
+	struct mutex access_lock;
+	struct urb *int_in_urb;
+	struct usb_device *udev;
+	union nct6694_usb_msg *usb_msg;
+	__le32 *int_buffer;
+};
+
 static const struct mfd_cell nct6694_devs[] = {
 	MFD_CELL_NAME("nct6694-gpio"),
 	MFD_CELL_NAME("nct6694-gpio"),
@@ -58,7 +79,8 @@ static const struct mfd_cell nct6694_devs[] = {
 	MFD_CELL_NAME("nct6694-rtc"),
 };
 
-static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char err_status)
+static int nct6694_usb_err_handling(struct nct6694 *nct6694,
+				    unsigned char err_status)
 {
 	switch (err_status) {
 	case NCT6694_NO_ERROR:
@@ -83,7 +105,7 @@ static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char
 }
 
 /**
- * nct6694_read_msg() - Read message from NCT6694 device
+ * nct6694_usb_read_msg() - Read message from NCT6694 device via USB
  * @nct6694: NCT6694 device pointer
  * @cmd_hd: command header structure
  * @buf: buffer to store the response data
@@ -94,13 +116,16 @@ static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char
  *
  * Return: Negative value on error or 0 on success.
  */
-int nct6694_read_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *cmd_hd, void *buf)
+static int nct6694_usb_read_msg(struct nct6694 *nct6694,
+				const struct nct6694_cmd_header *cmd_hd,
+				void *buf)
 {
-	union nct6694_usb_msg *msg = nct6694->usb_msg;
-	struct usb_device *udev = nct6694->udev;
+	struct nct6694_usb_data *udata = nct6694->priv;
+	union nct6694_usb_msg *msg = udata->usb_msg;
+	struct usb_device *udev = udata->udev;
 	int tx_len, rx_len, ret;
 
-	guard(mutex)(&nct6694->access_lock);
+	guard(mutex)(&udata->access_lock);
 
 	memcpy(&msg->cmd_header, cmd_hd, sizeof(*cmd_hd));
 	msg->cmd_header.hctrl = NCT6694_HCTRL_GET;
@@ -129,12 +154,11 @@ int nct6694_read_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *c
 		return -EIO;
 	}
 
-	return nct6694_response_err_handling(nct6694, msg->response_header.sts);
+	return nct6694_usb_err_handling(nct6694, msg->response_header.sts);
 }
-EXPORT_SYMBOL_GPL(nct6694_read_msg);
 
 /**
- * nct6694_write_msg() - Write message to NCT6694 device
+ * nct6694_usb_write_msg() - Write message to NCT6694 device via USB
  * @nct6694: NCT6694 device pointer
  * @cmd_hd: command header structure
  * @buf: buffer containing the data to be sent
@@ -144,13 +168,16 @@ EXPORT_SYMBOL_GPL(nct6694_read_msg);
  *
  * Return: Negative value on error or 0 on success.
  */
-int nct6694_write_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *cmd_hd, void *buf)
+static int nct6694_usb_write_msg(struct nct6694 *nct6694,
+				 const struct nct6694_cmd_header *cmd_hd,
+				 void *buf)
 {
-	union nct6694_usb_msg *msg = nct6694->usb_msg;
-	struct usb_device *udev = nct6694->udev;
+	struct nct6694_usb_data *udata = nct6694->priv;
+	union nct6694_usb_msg *msg = udata->usb_msg;
+	struct usb_device *udev = udata->udev;
 	int tx_len, rx_len, ret;
 
-	guard(mutex)(&nct6694->access_lock);
+	guard(mutex)(&udata->access_lock);
 
 	memcpy(&msg->cmd_header, cmd_hd, sizeof(*cmd_hd));
 	msg->cmd_header.hctrl = NCT6694_HCTRL_SET;
@@ -185,9 +212,8 @@ int nct6694_write_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *
 		return -EIO;
 	}
 
-	return nct6694_response_err_handling(nct6694, msg->response_header.sts);
+	return nct6694_usb_err_handling(nct6694, msg->response_header.sts);
 }
-EXPORT_SYMBOL_GPL(nct6694_write_msg);
 
 static void usb_int_callback(struct urb *urb)
 {
@@ -210,10 +236,12 @@ static void usb_int_callback(struct urb *urb)
 	int_status = le32_to_cpu(*status_le);
 
 	while (int_status) {
-		int irq = __ffs(int_status);
+		int hwirq = __ffs(int_status);
+		unsigned int virq = irq_find_mapping(nct6694->domain, hwirq);
 
-		generic_handle_irq_safe(irq_find_mapping(nct6694->domain, irq));
-		int_status &= ~BIT(irq);
+		if (virq)
+			generic_handle_irq_safe(virq);
+		int_status &= ~BIT(hwirq);
 	}
 
 resubmit:
@@ -277,6 +305,7 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	struct usb_endpoint_descriptor *int_endpoint;
 	struct usb_host_interface *interface;
 	struct device *dev = &iface->dev;
+	struct nct6694_usb_data *udata;
 	struct nct6694 *nct6694;
 	int ret;
 
@@ -284,18 +313,28 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	if (!nct6694)
 		return -ENOMEM;
 
-	nct6694->usb_msg = devm_kzalloc(dev, sizeof(union nct6694_usb_msg), GFP_KERNEL);
-	if (!nct6694->usb_msg)
+	udata = devm_kzalloc(dev, sizeof(*udata), GFP_KERNEL);
+	if (!udata)
 		return -ENOMEM;
 
-	nct6694->int_buffer = devm_kzalloc(dev, sizeof(*nct6694->int_buffer), GFP_KERNEL);
-	if (!nct6694->int_buffer)
+	udata->usb_msg = devm_kzalloc(dev, sizeof(*udata->usb_msg), GFP_KERNEL);
+	if (!udata->usb_msg)
 		return -ENOMEM;
 
-	nct6694->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!nct6694->int_in_urb)
+	udata->int_buffer = devm_kzalloc(dev, sizeof(*udata->int_buffer), GFP_KERNEL);
+	if (!udata->int_buffer)
 		return -ENOMEM;
 
+	udata->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!udata->int_in_urb)
+		return -ENOMEM;
+
+	udata->udev = udev;
+
+	nct6694->priv = udata;
+	nct6694->read_msg = nct6694_usb_read_msg;
+	nct6694->write_msg = nct6694_usb_write_msg;
+
 	nct6694->domain = irq_domain_create_simple(NULL, NCT6694_NR_IRQS, 0,
 						   &nct6694_irq_domain_ops,
 						   nct6694);
@@ -305,16 +344,15 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	}
 
 	nct6694->dev = dev;
-	nct6694->udev = udev;
+
+	spin_lock_init(&nct6694->irq_lock);
 
 	ida_init(&nct6694->gpio_ida);
 	ida_init(&nct6694->i2c_ida);
 	ida_init(&nct6694->canfd_ida);
 	ida_init(&nct6694->wdt_ida);
 
-	spin_lock_init(&nct6694->irq_lock);
-
-	ret = devm_mutex_init(dev, &nct6694->access_lock);
+	ret = devm_mutex_init(dev, &udata->access_lock);
 	if (ret)
 		goto err_ida;
 
@@ -326,11 +364,11 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 		goto err_ida;
 	}
 
-	usb_fill_int_urb(nct6694->int_in_urb, udev, usb_rcvintpipe(udev, NCT6694_INT_IN_EP),
-			 nct6694->int_buffer, sizeof(*nct6694->int_buffer), usb_int_callback,
+	usb_fill_int_urb(udata->int_in_urb, udev, usb_rcvintpipe(udev, NCT6694_INT_IN_EP),
+			 udata->int_buffer, sizeof(*udata->int_buffer), usb_int_callback,
 			 nct6694, int_endpoint->bInterval);
 
-	ret = usb_submit_urb(nct6694->int_in_urb, GFP_KERNEL);
+	ret = usb_submit_urb(udata->int_in_urb, GFP_KERNEL);
 	if (ret)
 		goto err_ida;
 
@@ -343,7 +381,7 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	return 0;
 
 err_mfd:
-	usb_kill_urb(nct6694->int_in_urb);
+	usb_kill_urb(udata->int_in_urb);
 err_ida:
 	ida_destroy(&nct6694->wdt_ida);
 	ida_destroy(&nct6694->canfd_ida);
@@ -351,22 +389,23 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	ida_destroy(&nct6694->gpio_ida);
 	irq_domain_remove(nct6694->domain);
 err_urb:
-	usb_free_urb(nct6694->int_in_urb);
+	usb_free_urb(udata->int_in_urb);
 	return ret;
 }
 
 static void nct6694_usb_disconnect(struct usb_interface *iface)
 {
 	struct nct6694 *nct6694 = usb_get_intfdata(iface);
+	struct nct6694_usb_data *udata = nct6694->priv;
 
 	mfd_remove_devices(nct6694->dev);
-	usb_kill_urb(nct6694->int_in_urb);
+	usb_kill_urb(udata->int_in_urb);
 	ida_destroy(&nct6694->wdt_ida);
 	ida_destroy(&nct6694->canfd_ida);
 	ida_destroy(&nct6694->i2c_ida);
 	ida_destroy(&nct6694->gpio_ida);
 	irq_domain_remove(nct6694->domain);
-	usb_free_urb(nct6694->int_in_urb);
+	usb_free_urb(udata->int_in_urb);
 }
 
 static const struct usb_device_id nct6694_ids[] = {
diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nct6694_canfd.c
index e5f7f8849a73..262b4c26c9d4 100644
--- a/drivers/net/can/usb/nct6694_canfd.c
+++ b/drivers/net/can/usb/nct6694_canfd.c
@@ -18,12 +18,6 @@
 
 #define DEVICE_NAME "nct6694-canfd"
 
-/* USB command module type for NCT6694 CANfd controller.
- * This defines the module type used for communication with the NCT6694
- * CANfd controller over the USB interface.
- */
-#define NCT6694_CANFD_MOD			0x05
-
 /* Command 00h - CAN Setting and Initialization */
 #define NCT6694_CANFD_SETTING			0x00
 #define NCT6694_CANFD_SETTING_ACTIVE_CTRL1	BIT(0)
diff --git a/drivers/rtc/rtc-nct6694.c b/drivers/rtc/rtc-nct6694.c
index 35401a0d9cf5..c06902f150c9 100644
--- a/drivers/rtc/rtc-nct6694.c
+++ b/drivers/rtc/rtc-nct6694.c
@@ -14,13 +14,6 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 
-/*
- * USB command module type for NCT6694 RTC controller.
- * This defines the module type used for communication with the NCT6694
- * RTC controller over the USB interface.
- */
-#define NCT6694_RTC_MOD		0x08
-
 /* Command 00h - RTC Time */
 #define NCT6694_RTC_TIME	0x0000
 #define NCT6694_RTC_TIME_SEL	0x00
diff --git a/drivers/watchdog/nct6694_wdt.c b/drivers/watchdog/nct6694_wdt.c
index bc3689bd4b6b..4c06ac105562 100644
--- a/drivers/watchdog/nct6694_wdt.c
+++ b/drivers/watchdog/nct6694_wdt.c
@@ -20,13 +20,6 @@
 
 #define NCT6694_WDT_MAX_DEVS		2
 
-/*
- * USB command module type for NCT6694 WDT controller.
- * This defines the module type used for communication with the NCT6694
- * WDT controller over the USB interface.
- */
-#define NCT6694_WDT_MOD			0x07
-
 /* Command 00h - WDT Setup */
 #define NCT6694_WDT_SETUP		0x00
 #define NCT6694_WDT_SETUP_SEL(idx)	(idx ? 0x01 : 0x00)
diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
index 6eb9be2cd4a0..fd645bf20fcd 100644
--- a/include/linux/mfd/nct6694.h
+++ b/include/linux/mfd/nct6694.h
@@ -2,22 +2,29 @@
 /*
  * Copyright (C) 2025 Nuvoton Technology Corp.
  *
- * Nuvoton NCT6694 USB transaction and data structure.
+ * Nuvoton NCT6694 core definitions shared by all transport drivers
+ * and sub-device drivers.
  */
 
 #ifndef __MFD_NCT6694_H
 #define __MFD_NCT6694_H
 
-#define NCT6694_VENDOR_ID	0x0416
-#define NCT6694_PRODUCT_ID	0x200B
-#define NCT6694_INT_IN_EP	0x81
-#define NCT6694_BULK_IN_EP	0x02
-#define NCT6694_BULK_OUT_EP	0x03
+#include <linux/idr.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define NCT6694_HCTRL_SET	0x40
 #define NCT6694_HCTRL_GET	0x80
 
-#define NCT6694_URB_TIMEOUT	1000
+#define NCT6694_HWMON_MOD	0x00
+#define NCT6694_PWM_MOD		0x01
+#define NCT6694_I2C_MOD		0x03
+#define NCT6694_CANFD_MOD	0x05
+#define NCT6694_WDT_MOD		0x07
+#define NCT6694_RTC_MOD		0x08
+#define NCT6694_RPT_MOD		0xFF
+#define NCT6694_GPIO_MOD	NCT6694_RPT_MOD
 
 enum nct6694_irq_id {
 	NCT6694_IRQ_GPIO0 = 0,
@@ -75,11 +82,6 @@ struct __packed nct6694_response_header {
 	__le16 len;
 };
 
-union __packed nct6694_usb_msg {
-	struct nct6694_cmd_header cmd_header;
-	struct nct6694_response_header response_header;
-};
-
 struct nct6694 {
 	struct device *dev;
 	struct ida gpio_ida;
@@ -87,16 +89,30 @@ struct nct6694 {
 	struct ida canfd_ida;
 	struct ida wdt_ida;
 	struct irq_domain *domain;
-	struct mutex access_lock;
 	spinlock_t irq_lock;
-	struct urb *int_in_urb;
-	struct usb_device *udev;
-	union nct6694_usb_msg *usb_msg;
-	__le32 *int_buffer;
 	unsigned int irq_enable;
+
+	void *priv;
+	int (*read_msg)(struct nct6694 *nct6694,
+			const struct nct6694_cmd_header *cmd_hd,
+			void *buf);
+	int (*write_msg)(struct nct6694 *nct6694,
+			 const struct nct6694_cmd_header *cmd_hd,
+			 void *buf);
 };
 
-int nct6694_read_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *cmd_hd, void *buf);
-int nct6694_write_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *cmd_hd, void *buf);
+static inline int nct6694_read_msg(struct nct6694 *nct6694,
+				   const struct nct6694_cmd_header *cmd_hd,
+				   void *buf)
+{
+	return nct6694->read_msg(nct6694, cmd_hd, buf);
+}
+
+static inline int nct6694_write_msg(struct nct6694 *nct6694,
+				    const struct nct6694_cmd_header *cmd_hd,
+				    void *buf)
+{
+	return nct6694->write_msg(nct6694, cmd_hd, buf);
+}
 
 #endif
-- 
2.34.1


