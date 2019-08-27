Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52779EC1C
	for <lists+linux-can@lfdr.de>; Tue, 27 Aug 2019 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfH0PNn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Aug 2019 11:13:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41826 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0PNn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Aug 2019 11:13:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id j4so4599875lfh.8
        for <linux-can@vger.kernel.org>; Tue, 27 Aug 2019 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/Blie0wpP4EiuUZwaCHvcaf60dLPg8W0PISUOC7zg+0=;
        b=bh5r662HFC/4RlxdLJThBDXZksm4vED7XBxdCX368MUVWNMJXeL1lN5Fki2cJEkmr8
         rhIeTxuiWoiDjkmQRWDX0YZ9lDnUT0gPfRdG/HepT96lQLxJQisevoJpdXuU5yeXuDOJ
         aPxFS34tjsrFzDVROgiRg22rM3OYdKZpDnc9uhCZ/gwn/B79RQcimUtbV07TOa8pLYO9
         fCf6OJ6A6/jTZYyia0eNnanvgl67rsJRkW1stHi+BjcQ5YjYHO9mIrA3jBmzN4VBDki/
         SfU5GRPMixPZ9GeiTvjrC4EZ4mDLpA+c2UwXAUkE/3zTFPeTYR+DgxbNIg+zdLkZB7KT
         gqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Blie0wpP4EiuUZwaCHvcaf60dLPg8W0PISUOC7zg+0=;
        b=YzABD3Qh1XRGozsFil/PzGxzfJV8YSCmw8LU5UwX77uqcFNuImHwr0aZAfHQAxe+Jc
         YOOP+QE6N3QiQh7RzzWPFtG28ZC9QRuIEJWMBS2EWLR8SRMHGL+q+CL3QV1demrmsY2T
         +d76DS/PreIveY4iuK/bpp5N6Hr5R1UqKHkAwytIV//Tb8WleOfMK2hp0caIIJS4+sXr
         AcJYg7V2C5736U57P7hZjohPj/ej021jAYBATipocxDFhre61iErCir+fpklbGuyTDDV
         SCozTxDFjH8sm7OAKuf6WH1MlLlNT9NeV3XGMH2folPtXdMiKcgAJcIbbioIEGB+BNnO
         Os7g==
X-Gm-Message-State: APjAAAVRhtgkK55VnLAHX47Pd7F5Y3BH7h2Y4nSjalh8QrfO1XnKmoEg
        QqP/3SCOO1qoPhsbpZHTpctS8EzA9EM=
X-Google-Smtp-Source: APXvYqzFI0ACZjd2ed1YzJgH0Zgr+FHViEZYimEIgdaXEl+kQidG0j9/MLbag3DkhB3D6CUaH89Hxg==
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr13415670lfq.152.1566918820985;
        Tue, 27 Aug 2019 08:13:40 -0700 (PDT)
Received: from ubuntu-loke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id m21sm2547025ljj.48.2019.08.27.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:13:39 -0700 (PDT)
From:   Christer Beskow <chbe@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Christer Beskow <chbe@kvaser.com>
Subject: [PATCH][next] can: kvaser_pciefd: the PWM generator is running at the bus frequency of the system.
Date:   Tue, 27 Aug 2019 17:13:26 +0200
Message-Id: <20190827151326.7029-1-chbe@kvaser.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The system clock frequency for the bus connected to the PCIe controller
shall be used when calculating the frequency of the PWM, not the
CAN system clock frequency.

Signed-off-by: Christer Beskow <chbe@kvaser.com>

---
 drivers/net/can/kvaser_pciefd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index f9815fda8840..6f766918211a 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -65,6 +65,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SYSID_BASE 0x1f020
 #define KVASER_PCIEFD_SYSID_VERSION_REG (KVASER_PCIEFD_SYSID_BASE + 0x8)
 #define KVASER_PCIEFD_SYSID_CANFREQ_REG (KVASER_PCIEFD_SYSID_BASE + 0xc)
+#define KVASER_PCIEFD_SYSID_BUSFREQ_REG (KVASER_PCIEFD_SYSID_BASE + 0x10)
 #define KVASER_PCIEFD_SYSID_BUILD_REG (KVASER_PCIEFD_SYSID_BASE + 0x14)
 /* Shared receive buffer registers */
 #define KVASER_PCIEFD_SRB_BASE 0x1f200
@@ -268,6 +269,7 @@ struct kvaser_pciefd {
 	struct kvaser_pciefd_can *can[KVASER_PCIEFD_MAX_CAN_CHANNELS];
 	void *dma_data[KVASER_PCIEFD_DMA_COUNT];
 	u8 nr_channels;
+	u32 bus_freq;
 	u32 freq;
 	u32 freq_to_ticks_div;
 };
@@ -666,7 +668,7 @@ static void kvaser_pciefd_pwm_start(struct kvaser_pciefd_can *can)
 	spin_lock_irqsave(&can->lock, irq);
 
 	/* Set frequency to 500 KHz*/
-	top = can->can.clock.freq / (2 * 500000) - 1;
+	top = can->kv_pcie->bus_freq / (2 * 500000) - 1;
 
 	pwm_ctrl = top & 0xff;
 	pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
@@ -1119,6 +1121,8 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 		return -ENODEV;
 	}
 
+	pcie->bus_freq = ioread32(pcie->reg_base +
+				  KVASER_PCIEFD_SYSID_BUSFREQ_REG);
 	pcie->freq = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_CANFREQ_REG);
 	pcie->freq_to_ticks_div = pcie->freq / 1000000;
 	if (pcie->freq_to_ticks_div == 0)
-- 
2.17.1

