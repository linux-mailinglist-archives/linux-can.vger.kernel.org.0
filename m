Return-Path: <linux-can+bounces-2357-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C88F9EAA15
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 08:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185C32834EE
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 07:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FCD1D5CCF;
	Tue, 10 Dec 2024 07:57:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E940233123
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817446; cv=none; b=OOylg9WVyL6rDPLROENuqzFn9UxPMYo4u/rpHw2Onopu2V4AlvuZxIz0DuBWq2ZmK3seAvGfbBpdICrOQDVul9MmQ3LHwvr0lmQALtbTWYJsxWjF4iQaNX4/uB5kDwvJV16XcmjaW3Yl0ofrGrSHN0BB18+5sCqBKhd4aBcepg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817446; c=relaxed/simple;
	bh=yGlCA7wKCLuZiusubto9z5glNITuVYeq69H4lC6P8o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=odUvj3PZ68ME76dh7Fr5Cs7RcUCj6Mx5wZjB7aw3XTH09GqIUh4wS05r+2aW3wqkPGx6rcEi2jAIBg9DKSQ8SEIkdtlNRgXd10ACANgixoVgH74+sOglsLgrm0DnSrlD5EAHdXngTENwN+258v9fiZwW/vyX3HCulfc/CF8+ZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKv7P-0006W4-SC
	for linux-can@vger.kernel.org; Tue, 10 Dec 2024 08:57:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKv7O-002eUk-2q
	for linux-can@vger.kernel.org;
	Tue, 10 Dec 2024 08:57:19 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5248238A41B
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 07:57:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E997F38A413;
	Tue, 10 Dec 2024 07:57:17 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5f1526b5;
	Tue, 10 Dec 2024 07:57:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 10 Dec 2024 08:57:14 +0100
Subject: [PATCH can-next v2] can: mcp251xfd: ACPI support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAFn0V2cC/x2MwQqCQBRFfyXetl6Mg2a2SqNsE1FGlNFimp460
 aiNEgPhvyduLhwu5/ygIaOogcXoB4a+qlFV2QOfjEAWoswJ1bNn4Iy7DmcBallzz7HZE4WsFfr
 Bw/PZ3PUcnkEv1YYyZYfgDaQosSTbwr1/MlNpbAtDYgiuwv13tl2HUTxHJ2lfJiWdR+2LsGZxs
 jvPTrGNPtcdjo2/OZogvRyWWqj3NB9WVhq67g9d2WvivwAAAA==
X-Change-ID: 20241209-mcp251xfd-acpi-79b57084512f
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Stefano Offredi <stefano.offredi@gmail.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5149; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=i4cOC0U+oKZAN+P6jQjp4ieLpT+I5eVw7fcNFfPPSgU=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnV/RaCdl65fMGG3ONwwreRTHqwKdA1lixyLv1z
 B6GRyTe3VqJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZ1f0WgAKCRAoOKI+ei28
 bwr8CACCfjteUOKpx+yXVHt0WKJTTqmdwhaN+Q0Shf+LThkrWaSCSoLxqsZzQJ5RoDMLwcKTL5/
 HPgvVc2E86fpphxFmXRJBCN1Tld5BcN54NmCEHNS+eydK47FHO0BaOdbp31c7EFRtYhLiI51Yoy
 uvHFUMmrSm1grgXgqF4R1e1tHtXB3NIBANcD6en5DTIY35Do88z1a78tkUhhbTZEqKvLpUu5OIm
 bXf+EqYcwBwHFN6GEbGwjfmzT3fM4ezEcs+frNU4doFsJaDfPPYNWklagJjL/hf7tvwpxZKYOUs
 JGEmgR8vMSmM9duP3pJq9+rWaM4uSJdze2CPqOq/5yHMKgEX
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Stefano Offredi <stefano.offredi@gmail.com>

This patch makes the Microchip MCP251xFD driver compatible with
hardware parameters loading from ACPI tables.

It's a patch for the 5.15 kernel version for which I could do tests on.

The ACPI driver hardware description table I used is the following:

DefinitionBlock ("can.aml", "SSDT", 1, "mcp2518fd", "Intel", 0x00000003)
{
    External (\_SB.PC00.SPI0, DeviceObj)
    Scope (\_SB.PC00.SPI0)
    {
        Device (CAN0) {
            Name (_HID, "MCP2518")
            Name (_CID, "mcp2518fd")
            Name (_DDN, "CAN SPI device connected to CS0")
            Name (_CRS, ResourceTemplate () {
                SpiSerialBus (
                    0,                             // Chip select
                    PolarityLow,             // Chip select is active low
                    FourWireMode,        // Full duplex
                    8,                              // Bits per word is 8 (byte)
                    ControllerInitiated,    // Don't care
                    20000000,                // 20 MHz
                    ClockPolarityLow,     // SPI mode 0
                    ClockPhaseFirst,      // SPI mode 0
                    "\\_SB.PC00.SPI0",  // SPI host controller
                    0                               // Must be 0
                )
                GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault, 0,
                    "\\_SB.GPI0", 0, ResourceConsumer, ,
                    )
                    {
                       2
                    }
            })
            Name (_DSD, Package ()
            {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package ()
                {
                    Package () {"rxint-gpios", Package () { ^CAN0, 0, 0, 0 } },
                    Package (2) {"clock-frequency",  40000000 }
                }
            })
         }
     }
 }

Signed-off-by: Stefano Offredi <stefano.offredi@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
This is a continuation of Stefano Offredi's work. For easier review
I've rebased the patch to current net-next/main and fixed the
indention.
---
Changes in v2:
- rebased to net-next/main
- fix indention
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3bc56517fe7a99d96dd43750a8ddd21961138e41..ee066dc2fdaa97ebadb5dc975957426c563adc9e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -12,6 +12,9 @@
 // Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
 //
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 #include <linux/unaligned.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
@@ -2002,6 +2005,23 @@ static const struct spi_device_id mcp251xfd_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id  mcp251xfd_acpi_id_table[] = {
+	{ "MCP2517", .driver_data = (kernel_ulong_t)&mcp251xfd_devtype_data_mcp2517fd, },
+	{ "MCP2518", .driver_data = (kernel_ulong_t)&mcp251xfd_devtype_data_mcp2518fd, },
+	{ "MCP251X", .driver_data = (kernel_ulong_t)&mcp251xfd_devtype_data_mcp251xfd, },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_id_table);
+
+static const struct acpi_gpio_params rx_int_gpios = { 1, 0, false };
+
+static const struct acpi_gpio_mapping acpi_mcp251xfd_gpios[] = {
+	{ "rx-int-gpios", &rx_int_gpios, 1 },
+	{},
+};
+#endif
+
 static int mcp251xfd_probe(struct spi_device *spi)
 {
 	struct net_device *ndev;
@@ -2012,11 +2032,20 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	bool pll_enable = false;
 	u32 freq = 0;
 	int err;
+	int ret;
 
 	if (!spi->irq)
 		return dev_err_probe(&spi->dev, -ENXIO,
 				     "No IRQ specified (maybe node \"interrupts-extended\" in DT missing)!\n");
 
+#ifdef CONFIG_ACPI
+	ret = devm_acpi_dev_add_driver_gpios(&spi->dev, acpi_mcp251xfd_gpios);
+	if (ret) {
+		dev_dbg(&spi->dev, "failed to add gpios mapping table\n");
+		return ret;
+	}
+#endif
+
 	rx_int = devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
 					 GPIOD_IN);
 	if (IS_ERR(rx_int))
@@ -2049,6 +2078,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
 		if (err)
 			return dev_err_probe(&spi->dev, err,
 					     "Failed to get clock-frequency!\n");
+
+		dev_dbg(&spi->dev, "using clock-frequency %d Hz\n", freq);
 	}
 
 	/* Sanity check */
@@ -2204,6 +2235,9 @@ static struct spi_driver mcp251xfd_driver = {
 		.name = DEVICE_NAME,
 		.pm = &mcp251xfd_pm_ops,
 		.of_match_table = mcp251xfd_of_match,
+#ifdef CONFIG_ACPI
+		.acpi_match_table = ACPI_PTR(mcp251xfd_acpi_id_table),
+#endif
 	},
 	.probe = mcp251xfd_probe,
 	.remove = mcp251xfd_remove,

---
base-commit: a0e1fc921cb0651cd11469bf5378ec342bf7094d
change-id: 20241209-mcp251xfd-acpi-79b57084512f

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



