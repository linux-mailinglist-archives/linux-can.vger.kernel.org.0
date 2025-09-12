Return-Path: <linux-can+bounces-4684-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B39EB54A3A
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 12:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676841D60659
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ECF2FE062;
	Fri, 12 Sep 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2j8mVEe"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C292FDC2C
	for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674059; cv=none; b=FzuTASQINOuEF1bWZ2EDYUaYIGW8SXMIgFh45RHwIGmh/tLItFwml3OmBQ9iqXSchyOHH4S00hUCaryMKqeBu55x9t213ZJmc+P3btZrKIcPF5PFeOd577lGAHN3j5upqMu2tocMMPVglp8fRfpjUJ1btZ6g+9xrl4HluFkDOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674059; c=relaxed/simple;
	bh=QkZ3p1cNyITf5OPXOZZOeBTIKQ1JtBSjwxNWu+BfvUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lB4SOVsV8U8a/CAvwCR3o//wWvN/TbM2cDpFsgDzlBabw3/dPUPaa1iKbMvh81Syxt+aQ2gpHGzvgLyQIMbIT0U7r9yMW2Z6bikaEsxPHwpuEXzYBbgs3LJ79CHrj5AVGPT+Jgi0DqU40YFTK6EudZSasK9HwMUGSys/nJrh59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2j8mVEe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so12658745e9.1
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674055; x=1758278855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvhHPfMyVnRQHDE/Wsrr3mGdMtLEq8FfsaVlUqEDKgY=;
        b=W2j8mVEePNs57XKtw/a0jTHCuVb35LuyGNhQdwsYHGBayp8xyPK/9l6kPNrMNbpz1d
         XwXJ1aT9eYBeQWAVJX9jOAHd6+ObDY7H+gNZxQmXn9OrinbmA/ze+WJJIkTnIxNl9bfw
         8s/MhxmNCkvqGiA6ZWR3CZ6gKWCJ5+QlYRxDjy/Ms0p1aE0qy+mQ2PAVQF7RjK2WEmmW
         O+1yZtIo0HkMdZdyF+T6uWql0cQ4p/C+BpBTGYTSNpJPsC4B8uUOjsR9OplrKLTP6Vqo
         dniYILYtXYSGfb8t0FTJLXBayFR+cgxnf/r5WiD06lZvnqd/DLa6k+mf/Mp3RO4rJxd0
         Jigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674055; x=1758278855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvhHPfMyVnRQHDE/Wsrr3mGdMtLEq8FfsaVlUqEDKgY=;
        b=nG0w9RmWF4tPvfLQ/l9vDQon8aN9kavR9bQOD7dtc03tTOslz6SC8paRdJ+pbcu8pg
         e/UIoyEjW4TFYdvQYB6+NJg6YvPZHHimwKn5H7ZrtvFBPpIadg1WYrUdLQDOw4Mxuw4j
         fI8fRu9ho2zEGFs9CCKqAT2gQC/1hOZCj+bt5OVkXErg5LiU9AkSovwS02YHNc0PtrPD
         KZ2KF4uhpa7GbI08bbB9LizN+1WvxcPOsvi5qXweQMILeJwJtyFh1lt24MFGab8rKjJt
         phbPdUDXkEPzkmPkYFn+TYidAJKoC8+06K+FM1TyPnaUmjcsw3CxTCUrbTiAGsSwZ7Lx
         VPCg==
X-Forwarded-Encrypted: i=1; AJvYcCUa6gZ3bcOogoGRagjGHcBbeiJYwWSjc4W27+qXeROgWnveScApK2q1xlod3/cJqKthN1LtOWXB44g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5K0LsJHCfDWAYECbfilrOOtZsNJP0W15DK5uJ39fBwok67JU
	T6Zy0qlleKL0BEUk3f3R/TdUupeOpcwIZpR1HpOjzrmCPX6+SEi9wakG
X-Gm-Gg: ASbGncut+p03AeKAO7Utq7P2caL9tUCNES9qCBv+en287jN5NDDTNdGch7DnazaygZH
	kw5q2ek3VGvlqaEAvcDhS6iElEJ5Z2lVGt2/FTJ7bAPa6VNWx8De+C2QVvuwy5kE/N/q9AOqPTE
	eI0QTS7d5RyY5oDaxNb1I7QiyULxupDGFRZO5yCE1Lar7/SpYR/KR7x+zKQDeFxNAqrlQMIdqS0
	dEIPcj3AT2RfWg0ngN/3SlDKb4v1vDxtRCNRetaRRkoqvVjG77R8F/CbDpAgjt3uZXlwAywzxFz
	4dO5R/sOO9eFDUz6Ny9AI/ciUciEdeclq8LAzUk0aBN6+jXa/EKq6Pp2FmZBft4ibfpv1gbxGCZ
	QmJNc8UIVm8WUa+MDaY0VcNn1BhdpY2hMTuflnHkzvXUbmhxA80RwtGLAxMfZ94YXO1v8rWHWaS
	epGDM1PoS0vnW3
X-Google-Smtp-Source: AGHT+IGujmcN4fyQBQx1hNEHlQ9GX4FoUMI1IDvKHNbUiACXJBxa9v7K/dhtoyBnWCjhCazL+bwaCw==
X-Received: by 2002:a05:600c:138a:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-45f211e575dmr31091895e9.8.1757674055294;
        Fri, 12 Sep 2025 03:47:35 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:35 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/7] Add suspend/resume support
Date: Fri, 12 Sep 2025 11:47:18 +0100
Message-ID: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi all,

This patch series adds proper suspend/resume support to the Renesas
R-Car CAN-FD controller driver, after the customary cleanuops and fixes.
It aims to fix CAN-FD operation after resume from s2ram on systems where
PSCI powers down the SoC.

This patch series has been tested on RZ/G3E SMARC EVK, Ebisu-4D (R-Car E3)
and White Hawk (R-Car V4H).

v1->v2:
 * Added logs from RZ/G3E
 * Collected tags.
 * Moved enabling of RAM clk from probe().
 * Added RAM clk handling in rcar_canfd_global_{,de}init().
 * Fixed the typo in error path of rcar_canfd_resume().

Logs from RZ/G3E:
root@smarc-rzg3e:~# /canfd_t_003_all.sh
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
[  541.705921] can: controller area network core
[  541.710369] NET: Registered PF_CAN protocol family
[  541.753974] can: raw protocol
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 500000 and dbitrate 2000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 250000 and dbitrate 1000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer

EXIT|PASS|canfd_t_003.sh|[00:00:25] ||

bind/unbind
----------
[  566.821475] rcar_canfd 12440000.can: can_clk rate is 80000000
[  566.828076] rcar_canfd 12440000.can: device registered (channel 1)
[  566.834361] rcar_canfd 12440000.can: can_clk rate is 80000000
[  566.841842] rcar_canfd 12440000.can: device registered (channel 4)
[  566.848093] rcar_canfd 12440000.can: global operational state (canfd clk, fd mode)
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 500000 and dbitrate 2000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 250000 and dbitrate 1000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer

EXIT|PASS|canfd_t_003.sh|[00:00:25] ||

s2idle
-----
[  592.182479] PM: suspend entry (s2idle)
[  592.187031] Filesystems sync: 0.000 seconds
[  592.193221] Freezing user space processes
[  592.199425] Freezing user space processes completed (elapsed 0.002 seconds)
[  592.206450] OOM killer disabled.
[  592.209843] Freezing remaining freezable tasks
[  592.215775] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  592.223247] printk: Suspending console(s) (use no_console_suspend to debug)
[  592.260524] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  592.322759] renesas-gbeth 15c30000.ethernet end0: Link is Down
[  596.070955] dwmac4: Master AXI performs any burst length
[  596.072307] renesas-gbeth 15c30000.ethernet end0: No Safety Features support found
[  596.072376] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported
[  596.077470] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rgmii-id link mode
[  596.087503] dwmac4: Master AXI performs any burst length
[  596.088817] renesas-gbeth 15c40000.ethernet end1: No Safety Features support found
[  596.088881] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
[  596.093997] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rgmii-id link mode
[  596.141986] usb usb1: root hub lost power or was reset
[  596.142031] usb usb2: root hub lost power or was reset
[  598.304525] usb 2-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 using xhci-renesas-hcd
[  598.414846] OOM killer enabled.
[  598.418002] Restarting tasks: Starting
[  598.422518] Restarting tasks: Done
[  598.425999] random: crng reseeded on system resumption
[  598.431248] PM: suspend exit
[  598.661875] renesas-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 500000 and dbitrate 2000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 250000 and dbitrate 1000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer

EXIT|PASS|canfd_t_003.sh|[00:00:25] ||

str
---
[  624.898952] PM: suspend entry (deep)
[  624.903619] Filesystems sync: 0.000 seconds
[  624.908715] Freezing user space processes
[  624.914609] Freezing user space processes completed (elapsed 0.001 seconds)
[  624.921599] OOM killer disabled.
[  624.924862] Freezing remaining freezable tasks
[  624.930642] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  624.938059] printk: Suspending console(s) (use no_console_suspend to debug)
NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-169-g1410189b0
NOTICE:  BL2: Built : 12:53:12, Jul 15 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[  624.984425] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  625.036962] renesas-gbeth 15c30000.ethernet end0: Link is Down
[  625.050909] Disabling non-boot CPUs ...
[  625.055800] psci: CPU3 killed (polled 0 ms)
[  625.062476] psci: CPU2 killed (polled 0 ms)
[  625.068380] psci: CPU1 killed (polled 4 ms)
[  625.073342] Enabling non-boot CPUs ...
[  625.073551] Detected VIPT I-cache on CPU1
[  625.073598] GICv3: CPU1: found redistributor 100 region 0:0x0000000014960000
[  625.073635] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[  625.074465] CPU1 is up
[  625.074565] Detected VIPT I-cache on CPU2
[  625.074587] GICv3: CPU2: found redistributor 200 region 0:0x0000000014980000
[  625.074609] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[  625.075179] CPU2 is up
[  625.075276] Detected VIPT I-cache on CPU3
[  625.075299] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a0000
[  625.075320] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[  625.076021] CPU3 is up
[  625.092153] dwmac4: Master AXI performs any burst length
[  625.093058] renesas-gbeth 15c30000.ethernet end0: No Safety Features support found
[  625.093078] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported
[  625.096594] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rgmii-id link mode
[  625.114030] dwmac4: Master AXI performs any burst length
[  625.114926] renesas-gbeth 15c40000.ethernet end1: No Safety Features support found
[  625.114942] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
[  625.118528] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rgmii-id link mode
[  625.165208] usb usb1: root hub lost power or was reset
[  625.165216] usb usb2: root hub lost power or was reset
[  627.324220] usb 2-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 using xhci-renesas-hcd
[  627.511216] OOM killer enabled.
[  627.514354] Restarting tasks: Starting
[  627.518782] Restarting tasks: Done
[  627.522274] random: crng reseeded on system resumption
[  627.527525] PM: suspend exit
[  627.788377] renesas-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 500000 and dbitrate 2000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 250000 and dbitrate 1000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer

EXIT|PASS|canfd_t_003.sh|[00:00:25] ||

root@smarc-rzg3e:~#

Biju Das (1):
  can: rcar_canfd: Move enabling of RAM clk from probe()

Geert Uytterhoeven (6):
  can: rcar_canfd: Invert reset assert order
  can: rcar_canfd: Invert global vs. channel teardown
  can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
  can: rcar_canfd: Invert CAN clock and close_candev() order
  can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  can: rcar_canfd: Add suspend/resume support

 drivers/net/can/rcar/rcar_canfd.c | 246 ++++++++++++++++++++----------
 1 file changed, 168 insertions(+), 78 deletions(-)

-- 
2.43.0


