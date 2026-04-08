Return-Path: <linux-can+bounces-7347-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGIvA4no1WnN/AcAu9opvQ
	(envelope-from <linux-can+bounces-7347-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 07:32:57 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF13B7362
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 07:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1579230488EC
	for <lists+linux-can@lfdr.de>; Wed,  8 Apr 2026 05:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193A3148A8;
	Wed,  8 Apr 2026 05:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUjJ2WAl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092935C1BC
	for <linux-can@vger.kernel.org>; Wed,  8 Apr 2026 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775626265; cv=none; b=Rh+OM9V0cY3Szgt+y2ECTj/nRaUhBsbhYy0lbGM0GYbapk5lRTJDIxMYuRoetRloH7TBTQcoK9XZWBJsFSGHMNx9IXL3ptbxPdWc1PM4RNE0/kw1mUioMXpMILQnOJWfwRYc9W5Y3ZAva7Zp0kLf3t3Z/whYMQmSZYFFs+pqLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775626265; c=relaxed/simple;
	bh=NVGcsfxpcPGaKzQNC6EolkdR6mRAYKh8ZJoWeZ1/LUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki4YmcjKJPNaQgPRNiTnqKWqRuGuD6h19hIuwvp1rUn8Fo6SxI4xK0c4EBIxlyXlLodyVxXvaBc7jYBK3wBQ7GteTIRepzejy8IPi+yfsubYYgfNNbUH4+hkKW1iELU+tiEvsA8XVYlt13b8ZCyHXV7fXIzCiF+mGNPJfjbdDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUjJ2WAl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a8fba3f769so23276835ad.2
        for <linux-can@vger.kernel.org>; Tue, 07 Apr 2026 22:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775626262; x=1776231062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsOLJpi4r6A+gB3wsl2Y2ruPMS5OAuWNDd0rp3nWquk=;
        b=LUjJ2WAltrOOR9U9dzMZqwFm5Ac42mV172D1ZCjAa/gpnlPoxiCmH9a/j/3WPyUVAY
         2SonyFnrSCM7gpkWXa9ZPR2vIAt5Nc/ZW4dPXnN3LENcGQ8u80cjmWcmJSHf0qMioyW1
         LVW1j9TYnSEdvDZ+dOOQY54Qe7tVUtvk0mlUOFW2QfEu01M6i2zN4wW5aJZgqq1+xvP3
         5daFFEBVxAjfcIhSs4Ylo9AntzAATjcOsudLtaZZ+8HbwdQ0UDzL3cL6mGGLo6V4lhJ5
         Yszb2hLL1qmjQuUc9+EJyq/py6MGUSVq0M22saieBFHYiN2vKdnWRId00QGW575shJht
         4/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775626262; x=1776231062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BsOLJpi4r6A+gB3wsl2Y2ruPMS5OAuWNDd0rp3nWquk=;
        b=tX2Gv8c4i2oUa1UBXxUZNDCBfQZUPZEhz8mJX4ESFgCu3UyaTFoHDzO/PkbtDZAZ1o
         7DGc0eoB1kMdJEExRNzLzSno1RDrT3x2y3PSjiqyPW/aOKVpx3UeHSwvq6WYs3EPsiYE
         QV9LJfThxWu8X5fnGUB70TUdAiRWYXia5cC+FZcYgIe1n+T5+LoNu7H210IEYuezhRmD
         Nfk4puPg4lQMeId3GOPD4L7gIK76M8ocC2TIglIHj3KmyOA0WhM8NvoOeBOo0H3MWikn
         I2uDcFGFn0c3TbtJmWT3MQwr9h8Lhnk4S2VM5Js/KJJFhvhrSFcU5o/TdZuUF1Vf2QVW
         y9bA==
X-Forwarded-Encrypted: i=1; AJvYcCWAx6aTppordySldcC6JQJ0so0QiRgXvkadeEMyGM+cfH+yi8Jja/c0+PS0XJsF9aQRbVemIV4ooXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysrFEB/jSluQnxGQZTM+dvf7S0GWS/x2e64eOGNs1hQYgpWG3y
	kvi7uSRmEYp6mAwR09MD1l0+zesNVzBrBs7hidtuFHHgnHYCttYUFsbQ
X-Gm-Gg: AeBDietTAfVEuGM7KFQkCcDTIfs0wkf4OLtLDOJk9da1MMjACelwHMIa8dn54o4NE49
	HuY4Y2y3mrbiyhoItyRewa78+9FIowF9rPBLU3AemzNyE8S2cDyMPDS4iY2s0w/OCwg4gNDAPnq
	3mFzECrUJEHlts0ER75QAWU6Qo+EKIFqi6c7GhsN+sVv5K47kdv4zLZorNQQDqWgWd372nSeDAI
	WtwDtnt4Mt1G26/ws9IU7sQ1PjqzGRqarIy75Dc2q5x2OR75JCUS0qt9RuVG2T8oaLOcXIy+HiM
	qbHQ4wmOkypr/0htV8mPv+7Tb+RH10oaMWRcm9Sz1zjGyuoGL8QxSAQecY77An2HL7ux5tiuB+c
	CZZlFxw7JgJ5VVTKLQojw77go032UMyF+iaaKhNwwEpfhjRKxuYCgH7AFRiqkjt4hmxSdEPsT7r
	/8qfslN7i4FtY/NtSoSNsk2dsLbCZ5kl585KMCdE/mRAwu5BX+qeFILieZD+eVQepqKw==
X-Received: by 2002:a17:903:4b2d:b0:2b2:4e5c:69a9 with SMTP id d9443c01a7336-2b281715f1amr209460845ad.5.1775626261941;
        Tue, 07 Apr 2026 22:31:01 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d098sm181673475ad.13.2026.04.07.22.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 22:31:01 -0700 (PDT)
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
Subject: [PATCH v2 2/2] mfd: Add Host Interface (HIF) support for Nuvoton NCT6694
Date: Wed,  8 Apr 2026 13:30:37 +0800
Message-Id: <20260408053037.1867092-3-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408053037.1867092-1-a0282524688@gmail.com>
References: <20260408053037.1867092-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-7347-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nuvoton.com:email]
X-Rspamd-Queue-Id: 60AF13B7362
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes since version 1:
- Drop function pointers from Super-I/O access and use static inline
  helpers with proper types.

 MAINTAINERS                         |   1 +
 drivers/gpio/gpio-nct6694.c         |   7 -
 drivers/hwmon/nct6694-hwmon.c       |  21 -
 drivers/i2c/busses/i2c-nct6694.c    |   7 -
 drivers/mfd/Kconfig                 |  47 ++-
 drivers/mfd/Makefile                |   3 +-
 drivers/mfd/nct6694-hif.c           | 634 ++++++++++++++++++++++++++++
 drivers/mfd/nct6694.c               |  97 +++--
 drivers/net/can/usb/nct6694_canfd.c |   6 -
 drivers/rtc/rtc-nct6694.c           |   7 -
 drivers/watchdog/nct6694_wdt.c      |   7 -
 include/linux/mfd/nct6694.h         |  51 ++-
 12 files changed, 772 insertions(+), 116 deletions(-)
 create mode 100644 drivers/mfd/nct6694-hif.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..7b6241faa6df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18899,6 +18899,7 @@ S:	Supported
 F:	drivers/gpio/gpio-nct6694.c
 F:	drivers/hwmon/nct6694-hwmon.c
 F:	drivers/i2c/busses/i2c-nct6694.c
+F:	drivers/mfd/nct6694-hif.c
 F:	drivers/mfd/nct6694.c
 F:	drivers/net/can/usb/nct6694_canfd.c
 F:	drivers/rtc/rtc-nct6694.c
diff --git a/drivers/gpio/gpio-nct6694.c b/drivers/gpio/gpio-nct6694.c
index 3703a61209e6..a279510ece89 100644
--- a/drivers/gpio/gpio-nct6694.c
+++ b/drivers/gpio/gpio-nct6694.c
@@ -12,13 +12,6 @@
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
index 7d8ad997f6d2..7ee209a04d16 100644
--- a/drivers/i2c/busses/i2c-nct6694.c
+++ b/drivers/i2c/busses/i2c-nct6694.c
@@ -11,13 +11,6 @@
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
index 000000000000..7560754e7481
--- /dev/null
+++ b/drivers/mfd/nct6694-hif.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Nuvoton Technology Corp.
+ *
+ * Nuvoton NCT6694 host-interface (eSPI) transport driver.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
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
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 1, &nct6694_acpi_match_gpio[1]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 2, &nct6694_acpi_match_gpio[2]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 3, &nct6694_acpi_match_gpio[3]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 4, &nct6694_acpi_match_gpio[4]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 5, &nct6694_acpi_match_gpio[5]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 6, &nct6694_acpi_match_gpio[6]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 7, &nct6694_acpi_match_gpio[7]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 8, &nct6694_acpi_match_gpio[8]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 9, &nct6694_acpi_match_gpio[9]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 10, &nct6694_acpi_match_gpio[10]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 11, &nct6694_acpi_match_gpio[11]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 12, &nct6694_acpi_match_gpio[12]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 13, &nct6694_acpi_match_gpio[13]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 14, &nct6694_acpi_match_gpio[14]),
+	MFD_CELL_ACPI("nct6694-gpio", NULL, NULL, 0, 15, &nct6694_acpi_match_gpio[15]),
+
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 0, &nct6694_acpi_match_i2c[0]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 1, &nct6694_acpi_match_i2c[1]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 2, &nct6694_acpi_match_i2c[2]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 3, &nct6694_acpi_match_i2c[3]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 4, &nct6694_acpi_match_i2c[4]),
+	MFD_CELL_ACPI("nct6694-i2c", NULL, NULL, 0, 5, &nct6694_acpi_match_i2c[5]),
+
+	MFD_CELL_ACPI("nct6694-canfd", NULL, NULL, 0, 0, &nct6694_acpi_match_can[0]),
+	MFD_CELL_ACPI("nct6694-canfd", NULL, NULL, 0, 1, &nct6694_acpi_match_can[1]),
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
+		int irq = __ffs(intr_status);
+
+		generic_handle_irq_safe(irq_find_mapping(nct6694->domain, irq));
+		intr_status &= ~BIT(irq);
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
+
+	/* Set SIRQ number */
+	superio_enter(sio_data);
+	superio_select(sio_data, SIO_REG_LD_SHM);
+	if (!superio_inb(sio_data, SIO_REG_SHM_ENABLE)) {
+		superio_exit(sio_data);
+		return -EIO;
+	}
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
+	return devm_mfd_add_devices(dev, 0, nct6694_devs, ARRAY_SIZE(nct6694_devs), NULL, 0, NULL);
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
index 8ce2c4985aab..903a0a7f0694 100644
--- a/drivers/mfd/nct6694.c
+++ b/drivers/mfd/nct6694.c
@@ -21,6 +21,27 @@
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
 	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 0),
 	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 1),
@@ -57,7 +78,8 @@ static const struct mfd_cell nct6694_devs[] = {
 	MFD_CELL_NAME("nct6694-rtc"),
 };
 
-static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char err_status)
+static int nct6694_usb_err_handling(struct nct6694 *nct6694,
+				    unsigned char err_status)
 {
 	switch (err_status) {
 	case NCT6694_NO_ERROR:
@@ -82,7 +104,7 @@ static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char
 }
 
 /**
- * nct6694_read_msg() - Read message from NCT6694 device
+ * nct6694_usb_read_msg() - Read message from NCT6694 device via USB
  * @nct6694: NCT6694 device pointer
  * @cmd_hd: command header structure
  * @buf: buffer to store the response data
@@ -93,13 +115,16 @@ static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char
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
@@ -128,12 +153,11 @@ int nct6694_read_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *c
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
@@ -143,13 +167,16 @@ EXPORT_SYMBOL_GPL(nct6694_read_msg);
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
@@ -184,9 +211,8 @@ int nct6694_write_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *
 		return -EIO;
 	}
 
-	return nct6694_response_err_handling(nct6694, msg->response_header.sts);
+	return nct6694_usb_err_handling(nct6694, msg->response_header.sts);
 }
-EXPORT_SYMBOL_GPL(nct6694_write_msg);
 
 static void usb_int_callback(struct urb *urb)
 {
@@ -276,6 +302,7 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	struct usb_endpoint_descriptor *int_endpoint;
 	struct usb_host_interface *interface;
 	struct device *dev = &iface->dev;
+	struct nct6694_usb_data *udata;
 	struct nct6694 *nct6694;
 	int ret;
 
@@ -283,18 +310,28 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	if (!nct6694)
 		return -ENOMEM;
 
-	nct6694->usb_msg = devm_kzalloc(dev, sizeof(union nct6694_usb_msg), GFP_KERNEL);
-	if (!nct6694->usb_msg)
+	udata = devm_kzalloc(dev, sizeof(*udata), GFP_KERNEL);
+	if (!udata)
+		return -ENOMEM;
+
+	udata->usb_msg = devm_kzalloc(dev, sizeof(*udata->usb_msg), GFP_KERNEL);
+	if (!udata->usb_msg)
 		return -ENOMEM;
 
-	nct6694->int_buffer = devm_kzalloc(dev, sizeof(*nct6694->int_buffer), GFP_KERNEL);
-	if (!nct6694->int_buffer)
+	udata->int_buffer = devm_kzalloc(dev, sizeof(*udata->int_buffer), GFP_KERNEL);
+	if (!udata->int_buffer)
 		return -ENOMEM;
 
-	nct6694->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!nct6694->int_in_urb)
+	udata->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!udata->int_in_urb)
 		return -ENOMEM;
 
+	udata->udev = udev;
+
+	nct6694->priv = udata;
+	nct6694->read_msg = nct6694_usb_read_msg;
+	nct6694->write_msg = nct6694_usb_write_msg;
+
 	nct6694->domain = irq_domain_create_simple(NULL, NCT6694_NR_IRQS, 0,
 						   &nct6694_irq_domain_ops,
 						   nct6694);
@@ -304,11 +341,10 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	}
 
 	nct6694->dev = dev;
-	nct6694->udev = udev;
 
 	spin_lock_init(&nct6694->irq_lock);
 
-	ret = devm_mutex_init(dev, &nct6694->access_lock);
+	ret = devm_mutex_init(dev, &udata->access_lock);
 	if (ret)
 		goto err_irq_domain;
 
@@ -320,11 +356,11 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 		goto err_irq_domain;
 	}
 
-	usb_fill_int_urb(nct6694->int_in_urb, udev, usb_rcvintpipe(udev, NCT6694_INT_IN_EP),
-			 nct6694->int_buffer, sizeof(*nct6694->int_buffer), usb_int_callback,
+	usb_fill_int_urb(udata->int_in_urb, udev, usb_rcvintpipe(udev, NCT6694_INT_IN_EP),
+			 udata->int_buffer, sizeof(*udata->int_buffer), usb_int_callback,
 			 nct6694, int_endpoint->bInterval);
 
-	ret = usb_submit_urb(nct6694->int_in_urb, GFP_KERNEL);
+	ret = usb_submit_urb(udata->int_in_urb, GFP_KERNEL);
 	if (ret)
 		goto err_irq_domain;
 
@@ -337,21 +373,22 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	return 0;
 
 err_mfd:
-	usb_kill_urb(nct6694->int_in_urb);
+	usb_kill_urb(udata->int_in_urb);
 err_irq_domain:
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
 
-	usb_kill_urb(nct6694->int_in_urb);
+	usb_kill_urb(udata->int_in_urb);
 	irq_domain_remove(nct6694->domain);
-	usb_free_urb(nct6694->int_in_urb);
+	usb_free_urb(udata->int_in_urb);
 }
 
 static const struct usb_device_id nct6694_ids[] = {
diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nct6694_canfd.c
index 29282c56430f..05db00455f63 100644
--- a/drivers/net/can/usb/nct6694_canfd.c
+++ b/drivers/net/can/usb/nct6694_canfd.c
@@ -17,12 +17,6 @@
 
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
index 2b4b804a1739..847d8f1d1830 100644
--- a/drivers/watchdog/nct6694_wdt.c
+++ b/drivers/watchdog/nct6694_wdt.c
@@ -19,13 +19,6 @@
 
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
index 496da72949d9..ff0814dc82d4 100644
--- a/include/linux/mfd/nct6694.h
+++ b/include/linux/mfd/nct6694.h
@@ -2,7 +2,8 @@
 /*
  * Copyright (C) 2025 Nuvoton Technology Corp.
  *
- * Nuvoton NCT6694 USB transaction and data structure.
+ * Nuvoton NCT6694 core definitions shared by all transport drivers
+ * and sub-device drivers.
  */
 
 #ifndef __MFD_NCT6694_H
@@ -12,16 +13,17 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-#define NCT6694_VENDOR_ID	0x0416
-#define NCT6694_PRODUCT_ID	0x200B
-#define NCT6694_INT_IN_EP	0x81
-#define NCT6694_BULK_IN_EP	0x02
-#define NCT6694_BULK_OUT_EP	0x03
-
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
@@ -79,24 +81,33 @@ struct __packed nct6694_response_header {
 	__le16 len;
 };
 
-union __packed nct6694_usb_msg {
-	struct nct6694_cmd_header cmd_header;
-	struct nct6694_response_header response_header;
-};
-
 struct nct6694 {
 	struct device *dev;
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


