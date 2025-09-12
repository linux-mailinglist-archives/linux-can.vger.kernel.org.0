Return-Path: <linux-can+bounces-4678-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9548B54737
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D211586F0D
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202D028A705;
	Fri, 12 Sep 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI0jyQ7I"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A9289E2D
	for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668830; cv=none; b=lWkvIO1hLZT3f5qteTmfhJFCMCZCebG1ZlZXEgVo5IrQ3xsZjPS1/+urfil8rF3+d4uZYjYPnKbwLlM+NCH/AqUmEKQ5vCt8p1WfmAicSzpBSAeTnWIoU+Fa0QUwfwWje5/CknkTgiPTOvZ576D3IZ84ZpxSn0xIjNhn37O4R/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668830; c=relaxed/simple;
	bh=/gjiOvtQeC8MWi0aqWNM7oYCQpBdtUwq1g79qJU3mJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rK516sy0kj/YVmiTKhicDVtHa8PwXZWKEoXPtoAaViX33Vk7kwL5yxL+bWAyKwIIEvju7nMi0WxLbP/BsZX44j4m2lYTPTXCVSe64W7Ue+HNConsIblRaWzDEmZtdx7DGcXqMEkGemMhHFXsxnie5BsOX9MDqrQeeg2BPdEE5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI0jyQ7I; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-772481b2329so1954266b3a.2
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757668826; x=1758273626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPdU6LK77EYO3iP5ZobJ/AY/W1Pzf56x6nwabe4cYsE=;
        b=jI0jyQ7I/IdK/QmdD9IiJp+L5HJ0oJqLR/28ERb8uhp+bxZPR3hbT8MknbijP8fGQ/
         2bSO5NfiHHwvc9jvh86Cjz6LhZ/FJX8Cpxv4XDo/A9ASV+zci9lYUHOVKuhLfPfK4Adv
         0613GaK2lGwsRHz++aH7qfba3JmupaDrlolWvkbGAdHFjg1N0x+l53sUm0ZXagUtbh6C
         cZqosPDcl0erJMUAgDayxfnSvtBCIF1pj9ysFdIMyBEnamD+bv6xzCc8NOEelyhU7pKB
         4lEp2lTk8zkerMVla+huJiRmLZW9jBtmBiXzyKcHEFOnlii8IC3WOyyLbzrW/VIQONz8
         q7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668826; x=1758273626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPdU6LK77EYO3iP5ZobJ/AY/W1Pzf56x6nwabe4cYsE=;
        b=Wz2kR/KG+qzqk289Vg3qTuJ1652pE3+BLcIB5hv7f39C+WYVXcMXImiQ+CKEG4gpHH
         r9UOkfxKQEmLv87FyNuTVQqusecq03j9BW5cvBZkMClpKDua+VJ47HSIo7ZlFR2OW8U2
         kDxeETkppbFpPFXW4UcF1czmwQyf106bRzNQjHTCP8PjnVCBNUDeS2aXaei3nka3S3Rk
         srlEhhYyzfeCFw/DFsETK/mkiivngmLyx4MHwq0/Q8cpK0FfNYkPIzldw+qaL1zTtdLA
         jwrjqaHVWCMqYtbGlfo+NRIPqTjxgxDtYllcF7tSr4v0CXsjQPLGW4SOOSQprrHkwveT
         6BRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYNfLeIowHjKsgMnD10H7ldzt+GrVIg9jDE5y7Id+J9rzt9J0dE2OhcdfRAZ72Ay3hsAEk1MO1RIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9MLSFj2hWtCmotX5Rz4FspsNkEweNKPDujwmHlcRcbpqsREf
	jp7XZ/2+t88D16FLOwkYqpKFgTs0uEdzf4TQHe7yvUxjSGkYIhzHQxjR
X-Gm-Gg: ASbGncuvqDv6/zMPy9+br09LBOmUq6keLHfbCpnZqSQsIKHrVIFN2DrMpIW0W62Jolo
	+EmnOz0lvmIsJITjbRh9mGDu53LAunLDnTTVnvtJ7on2kXeu0OlDHT4n547jfrXtirY4PK2tPKX
	vpJp78C7FLQPvzQInBfs3hn79b27ZbY5UMEdKy4sc44ceT7z//p8Z2xLAPGM5Lj/ZukZ2d8o04j
	uR2TB1csUOxvq+fdru0MLI2WUFFARfIUvVXCyKiuVOm3gVUXhytppQBKXponpeFpzPdgUZKIW+5
	mmEjvSDTkedw0euE7tv+2+kyjiE+EuoBOpu95cemlXBP6AZG6ZWsv+dH7COMu+XSRW9IuMo++U1
	zoawFK3tyLZ/ICZPjzbHmPHyjVq+Jv6CLWnUe6aeLq+3f1AMoaVcYG00bMz2bx1kCjQ==
X-Google-Smtp-Source: AGHT+IH/m+VR1DNePVcHWaQCojwRWvwxWRyQzo6LHek9BLXODlHrtK6Z/CgxSWdf3ZkUFzh0nnSbow==
X-Received: by 2002:a05:6a20:939e:b0:243:f86b:3868 with SMTP id adf61e73a8af0-2602c144613mr2945322637.48.1757668826456;
        Fri, 12 Sep 2025 02:20:26 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36dc461sm4066564a12.23.2025.09.12.02.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:20:26 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	lee@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andi.shyti@kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	jdelvare@suse.com,
	alexandre.belloni@bootlin.com
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RESEND v14 3/7] i2c: Add Nuvoton NCT6694 I2C support
Date: Fri, 12 Sep 2025 17:19:48 +0800
Message-Id: <20250912091952.1169369-4-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912091952.1169369-1-a0282524688@gmail.com>
References: <20250912091952.1169369-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

This driver supports I2C adapter functionality for NCT6694 MFD
device based on USB interface.

Each I2C controller uses the default baudrate of 100kHz, which
can be overridden via module parameters.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes since version 13:
- Add struct i2c_adapter_quirks in i2c-nct6694.c

Changes since version 12:
- Implement IDA in MFD driver to handle per-device IDs
- Use same email address in the signature

Changes since version 11:
- Use platform_device's id to replace IDA

Changes since version 10:
- Implement IDA to allocate id

Changes since version 9:

Changes since version 8:
- Modify the signed-off-by with my work address
- Add module parameters to configure I2C's baudrate

Changes since version 7:

Changes since version 6:

Changes since version 5:
- Modify the module name and the driver name consistently

Changes since version 4:
- Modify arguments in read/write function to a pointer to cmd_header
- Modify all callers that call the read/write function

Changes since version 3:
- Modify array buffer to structure
- Fix defines and comments

Changes since version 2:
- Add MODULE_ALIAS()

Changes since version 1:
- Add each driver's command structure
- Fix platform driver registration

 MAINTAINERS                      |   1 +
 drivers/i2c/busses/Kconfig       |  10 ++
 drivers/i2c/busses/Makefile      |   1 +
 drivers/i2c/busses/i2c-nct6694.c | 196 +++++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-nct6694.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e340d1934394..c8f912cb0b95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18086,6 +18086,7 @@ NUVOTON NCT6694 MFD DRIVER
 M:	Ming Yu <tmyu0@nuvoton.com>
 S:	Supported
 F:	drivers/gpio/gpio-nct6694.c
+F:	drivers/i2c/busses/i2c-nct6694.c
 F:	drivers/mfd/nct6694.c
 F:	include/linux/mfd/nct6694.h
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 070d014fdc5d..63a2b5a9abc3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1357,6 +1357,16 @@ config I2C_LJCA
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-ljca.
 
+config I2C_NCT6694
+	tristate "Nuvoton NCT6694 I2C adapter support"
+	depends on MFD_NCT6694
+	help
+	  If you say yes to this option, support will be included for Nuvoton
+	  NCT6694, a USB to I2C interface.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called i2c-nct6694.
+
 config I2C_CP2615
 	tristate "Silicon Labs CP2615 USB sound card and I2C adapter"
 	depends on USB
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 04db855fdfd6..fe8cf6325fc9 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -135,6 +135,7 @@ obj-$(CONFIG_I2C_GXP)		+= i2c-gxp.o
 obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
 obj-$(CONFIG_I2C_DLN2)		+= i2c-dln2.o
 obj-$(CONFIG_I2C_LJCA)		+= i2c-ljca.o
+obj-$(CONFIG_I2C_NCT6694)	+= i2c-nct6694.o
 obj-$(CONFIG_I2C_CP2615) += i2c-cp2615.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PCI1XXXX)	+= i2c-mchp-pci1xxxx.o
diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nct6694.c
new file mode 100644
index 000000000000..1413ab6f9462
--- /dev/null
+++ b/drivers/i2c/busses/i2c-nct6694.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton NCT6694 I2C adapter driver based on USB interface.
+ *
+ * Copyright (C) 2025 Nuvoton Technology Corp.
+ */
+
+#include <linux/i2c.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/mfd/nct6694.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/*
+ * USB command module type for NCT6694 I2C controller.
+ * This defines the module type used for communication with the NCT6694
+ * I2C controller over the USB interface.
+ */
+#define NCT6694_I2C_MOD			0x03
+
+/* Command 00h - I2C Deliver */
+#define NCT6694_I2C_DELIVER		0x00
+#define NCT6694_I2C_DELIVER_SEL		0x00
+
+#define NCT6694_I2C_MAX_XFER_SIZE	64
+#define NCT6694_I2C_MAX_DEVS		6
+
+static unsigned char br_reg[NCT6694_I2C_MAX_DEVS] = {[0 ... (NCT6694_I2C_MAX_DEVS - 1)] = 0xFF};
+
+module_param_array(br_reg, byte, NULL, 0644);
+MODULE_PARM_DESC(br_reg,
+		 "I2C Baudrate register per adapter: (0=25K, 1=50K, 2=100K, 3=200K, 4=400K, 5=800K, 6=1M), default=2");
+
+enum nct6694_i2c_baudrate {
+	NCT6694_I2C_BR_25K = 0,
+	NCT6694_I2C_BR_50K,
+	NCT6694_I2C_BR_100K,
+	NCT6694_I2C_BR_200K,
+	NCT6694_I2C_BR_400K,
+	NCT6694_I2C_BR_800K,
+	NCT6694_I2C_BR_1M
+};
+
+struct __packed nct6694_i2c_deliver {
+	u8 port;
+	u8 br;
+	u8 addr;
+	u8 w_cnt;
+	u8 r_cnt;
+	u8 rsv[11];
+	u8 write_data[NCT6694_I2C_MAX_XFER_SIZE];
+	u8 read_data[NCT6694_I2C_MAX_XFER_SIZE];
+};
+
+struct nct6694_i2c_data {
+	struct device *dev;
+	struct nct6694 *nct6694;
+	struct i2c_adapter adapter;
+	struct nct6694_i2c_deliver deliver;
+	unsigned char port;
+	unsigned char br;
+};
+
+static int nct6694_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct nct6694_i2c_data *data = adap->algo_data;
+	struct nct6694_i2c_deliver *deliver = &data->deliver;
+	static const struct nct6694_cmd_header cmd_hd = {
+		.mod = NCT6694_I2C_MOD,
+		.cmd = NCT6694_I2C_DELIVER,
+		.sel = NCT6694_I2C_DELIVER_SEL,
+		.len = cpu_to_le16(sizeof(*deliver))
+	};
+	int ret, i;
+
+	for (i = 0; i < num; i++) {
+		struct i2c_msg *msg_temp = &msgs[i];
+
+		memset(deliver, 0, sizeof(*deliver));
+
+		deliver->port = data->port;
+		deliver->br = data->br;
+		deliver->addr = i2c_8bit_addr_from_msg(msg_temp);
+		if (msg_temp->flags & I2C_M_RD) {
+			deliver->r_cnt = msg_temp->len;
+			ret = nct6694_write_msg(data->nct6694, &cmd_hd, deliver);
+			if (ret < 0)
+				return ret;
+
+			memcpy(msg_temp->buf, deliver->read_data, msg_temp->len);
+		} else {
+			deliver->w_cnt = msg_temp->len;
+			memcpy(deliver->write_data, msg_temp->buf, msg_temp->len);
+			ret = nct6694_write_msg(data->nct6694, &cmd_hd, deliver);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return num;
+}
+
+static u32 nct6694_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_adapter_quirks nct6694_i2c_quirks = {
+	.max_read_len = NCT6694_I2C_MAX_XFER_SIZE,
+	.max_write_len = NCT6694_I2C_MAX_XFER_SIZE,
+};
+
+static const struct i2c_algorithm nct6694_i2c_algo = {
+	.xfer = nct6694_i2c_xfer,
+	.functionality = nct6694_i2c_func,
+};
+
+static int nct6694_i2c_set_baudrate(struct nct6694_i2c_data *data)
+{
+	if (data->port >= NCT6694_I2C_MAX_DEVS) {
+		dev_err(data->dev, "Invalid I2C port index %d\n", data->port);
+		return -EINVAL;
+	}
+
+	if (br_reg[data->port] > NCT6694_I2C_BR_1M) {
+		dev_warn(data->dev, "Invalid baudrate %d for I2C%d, using 100K\n",
+			 br_reg[data->port], data->port);
+		br_reg[data->port] = NCT6694_I2C_BR_100K;
+	}
+
+	data->br = br_reg[data->port];
+
+	return 0;
+}
+
+static void nct6694_i2c_ida_free(void *d)
+{
+	struct nct6694_i2c_data *data = d;
+	struct nct6694 *nct6694 = data->nct6694;
+
+	ida_free(&nct6694->i2c_ida, data->port);
+}
+
+static int nct6694_i2c_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nct6694 *nct6694 = dev_get_drvdata(dev->parent);
+	struct nct6694_i2c_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	data->nct6694 = nct6694;
+
+	ret = ida_alloc(&nct6694->i2c_ida, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	data->port = ret;
+
+	ret = devm_add_action_or_reset(dev, nct6694_i2c_ida_free, data);
+	if (ret)
+		return ret;
+
+	ret = nct6694_i2c_set_baudrate(data);
+	if (ret)
+		return ret;
+
+	sprintf(data->adapter.name, "NCT6694 I2C Adapter %d", data->port);
+	data->adapter.owner = THIS_MODULE;
+	data->adapter.algo = &nct6694_i2c_algo;
+	data->adapter.quirks = &nct6694_i2c_quirks;
+	data->adapter.dev.parent = dev;
+	data->adapter.algo_data = data;
+
+	platform_set_drvdata(pdev, data);
+
+	return devm_i2c_add_adapter(dev, &data->adapter);
+}
+
+static struct platform_driver nct6694_i2c_driver = {
+	.driver = {
+		.name	= "nct6694-i2c",
+	},
+	.probe		= nct6694_i2c_probe,
+};
+
+module_platform_driver(nct6694_i2c_driver);
+
+MODULE_DESCRIPTION("USB-I2C adapter driver for NCT6694");
+MODULE_AUTHOR("Ming Yu <tmyu0@nuvoton.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:nct6694-i2c");
-- 
2.34.1


