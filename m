Return-Path: <linux-can+bounces-2355-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E79089E9BE2
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 17:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68664282DDE
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4D135A63;
	Mon,  9 Dec 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi3BzaE2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09B13D518
	for <linux-can@vger.kernel.org>; Mon,  9 Dec 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762207; cv=none; b=L66/3zffUBWoSoDZx/oE9nt+Xpith9/7h+YgMJk749u8BHh6DsZ2D21hzR1hf+lx3uncFP9LDX2kVAduYWodE/MvgvT+ghibn9OyPCSYxFXdXSnS7gIE/gMoyAWSnL+5tQXb0pJXA5F+/Dt7QW3X9nqtqDf3mlWopHlh4/3acSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762207; c=relaxed/simple;
	bh=VYgl92j6q2tpBhJNNBqCqYIowhosts2LbX00ohmUrXI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AUeD3ZvAUKaW8OsTEq+VAATNbBJQy7focVKE621zWmYz2IqGdFAbyBq9/XvoAh0N0AoNOZewoy5MklfExgsgZqlb3cLE6OlmNN0gWvPEfDpqP309ku7fl68nmffQ8msNETjcDIOhBuN2tziG4CEqSVCQM8YfCxILNKQjyO/liTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi3BzaE2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30227ccf803so8324051fa.2
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2024 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733762202; x=1734367002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KrEw+5gj7e6LivjcqVsDkh1er0c5rtFuHK0e1J/cVmg=;
        b=fi3BzaE2MMk3gn+mcFi7lVT66/xAbWcrNE3fRFfjAEQkbsdt2ZwHC/DGkSi9BGnvW3
         BRFHQEr8uN5xiFiJyVgw8b1hJTfGOFdi9g3OhSwsILpfGLpFHig7NPLKBlXq7mJgnDE5
         UeGxRJaYDSejTmK9li1CetSMOmeFIhTP++z7W1S6rbB7c8kjqMJH1iQqVTkkRub5Wg27
         Wm1slKNqhEFF0EkDEHnc7TBqRyqnh8Gf0StrIZZopIiWyKzmGNQfDM4dTSL18+F12AJY
         hUtq2nzV96FPUjKsdrRtfcE9vaKNBOFiKYX5D9vf7O2OsO7ba+CHamWdRl6t0pNs8jN7
         dV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733762202; x=1734367002;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrEw+5gj7e6LivjcqVsDkh1er0c5rtFuHK0e1J/cVmg=;
        b=FavSZQVEEPXxGNXMUOE5JTt2imQ9pE3/QUOkcZB7zpeDPx3T9AJSWdZSa/JQvviGsU
         fEx+nSQEg1I2+xJw18bS9Ttw/w46TCc1W7uha4VXaq3iM+dNDFPxkQdmDzq5sKyFmfNv
         cMYHHIiZ+gtnSsSoDTo7MGU01W5Tn/IBRMfreBsoaHLmGU2NQwf08AVp7QuEs0hzyvLD
         Nnfxty3xjQaJVIoDV5njDXWLMnnwdSq8CEyYKP9NDPfg3FIXbIdDJK9s+paEwhbrsfPm
         tvH7r82k51i46yumUIxM5cadbXWJixcSiBqJhsjtVjAlKy3DkEjBhEt5ZSRsekHZURic
         ckAQ==
X-Gm-Message-State: AOJu0Yx00cx7LWHe80lZXCl7dG1079LoIcdoMBRgs4kydcJ/knqBaxGZ
	AWroGBkJgxlcHZWa5Nh/yNwtfPJfqNdre95wS8WTTy5Ok6SeA7yJC5wkBMs+/uQ5gCusr/yJSL8
	7/UsXkwvtbCNOxeDO0/wilHYhhH1+d6kB
X-Gm-Gg: ASbGnctpM046/p+3fyAXk8owjrXl2RZnIXaz2Pc5w4CsP0dDW/JGTV2atSnU0PAGj8b
	DRWihPaTxNUJrIDeZGymrKuOPoXYVpsg=
X-Google-Smtp-Source: AGHT+IFp76IER9Ky7jrxshYLKv2LdWXm4ZE4p4s3ZEv/Z5wxRVqb4ywoQi4NKXctGYKHYvodHWFa2T0kToQmBuNqtTc=
X-Received: by 2002:a2e:bcc6:0:b0:302:1d7a:dff with SMTP id
 38308e7fff4ca-3021d7a106dmr23874661fa.23.1733762202059; Mon, 09 Dec 2024
 08:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stefano Offredi <stefano.offredi@gmail.com>
Date: Mon, 9 Dec 2024 17:36:30 +0100
Message-ID: <CAOv6HEABG8-1StjrZemgBtje-p0GSMV6TGxBqYM-+r7FRr9ZXQ@mail.gmail.com>
Subject: [PATCH] can: mcp251xfd: ACPI support
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

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

Base: Linux 5.15

Signed-off-by: Stefano Offredi <stefano.offredi@gmail.com>
---
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 34
++++++++++++++++++++++++++++++++++
1 file changed, 34 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 673861ab665a..960995f6eeaf 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -12,6 +12,9 @@
 // Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
 //

+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -2853,6 +2856,23 @@ static const struct spi_device_id
mcp251xfd_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);

+#ifdef CONFIG_ACPI
+static const struct acpi_device_id  mcp251xfd_acpi_id_table[] = {
+    { "MCP2517", .driver_data =
(kernel_ulong_t)&mcp251xfd_devtype_data_mcp2517fd, },
+    { "MCP2518", .driver_data =
(kernel_ulong_t)&mcp251xfd_devtype_data_mcp2518fd, },
+    { "MCP251X", .driver_data =
(kernel_ulong_t)&mcp251xfd_devtype_data_mcp251xfd, },
+    {}
+};
+MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_id_table);
+
+static const struct acpi_gpio_params rx_int_gpios = { 1, 0, false };
+
+static const struct acpi_gpio_mapping acpi_mcp251xfd_gpios[] = {
+ { "rx-int-gpios", &rx_int_gpios, 1 },
+ {},
+};
+#endif
+
 static int mcp251xfd_probe(struct spi_device *spi)
 {
  const void *match;
@@ -2863,11 +2883,20 @@ static int mcp251xfd_probe(struct spi_device *spi)
  struct clk *clk;
  u32 freq = 0;
  int err;
+        int ret;

  if (!spi->irq)
  return dev_err_probe(&spi->dev, -ENXIO,
       "No IRQ specified (maybe node \"interrupts-extended\" in DT
missing)!\n");

+#ifdef CONFIG_ACPI
+ ret = devm_acpi_dev_add_driver_gpios(&spi->dev, acpi_mcp251xfd_gpios);
+        if (ret) {
+ dev_dbg(&spi->dev, "failed to add gpios mapping table\n");
+                return ret;
+        }
+#endif
+
  rx_int = devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
  GPIOD_IN);
  if (IS_ERR(rx_int))
@@ -2900,6 +2929,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
  if (err)
  return dev_err_probe(&spi->dev, err,
       "Failed to get clock-frequency!\n");
+
+                dev_dbg(&spi->dev, "using clock-frequency %d Hz\n", freq);
  }

  /* Sanity check */
@@ -3050,6 +3081,9 @@ static struct spi_driver mcp251xfd_driver = {
  .name = DEVICE_NAME,
  .pm = &mcp251xfd_pm_ops,
  .of_match_table = mcp251xfd_of_match,
+#ifdef CONFIG_ACPI
+                .acpi_match_table = ACPI_PTR(mcp251xfd_acpi_id_table),
+#endif
  },
  .probe = mcp251xfd_probe,
  .remove = mcp251xfd_remove,

