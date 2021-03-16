Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21C133CFA7
	for <lists+linux-can@lfdr.de>; Tue, 16 Mar 2021 09:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhCPIVi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Mar 2021 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhCPIVT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Mar 2021 04:21:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7EAC061765
        for <linux-can@vger.kernel.org>; Tue, 16 Mar 2021 01:21:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lM4x3-0003A7-NK
        for linux-can@vger.kernel.org; Tue, 16 Mar 2021 09:21:17 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1B3DE5F644E
        for <linux-can@vger.kernel.org>; Tue, 16 Mar 2021 08:21:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5FF8F5F641B;
        Tue, 16 Mar 2021 08:21:07 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e25d6c39;
        Tue, 16 Mar 2021 08:21:05 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 06/11] can: kvaser_pciefd: Always disable bus load reporting
Date:   Tue, 16 Mar 2021 09:20:59 +0100
Message-Id: <20210316082104.4027260-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210316082104.4027260-1-mkl@pengutronix.de>
References: <20210316082104.4027260-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Under certain circumstances, when switching from Kvaser's linuxcan driver
(kvpciefd) to the SocketCAN driver (kvaser_pciefd), the bus load reporting
is not disabled.
This is flooding the kernel log with prints like:
[3485.574677] kvaser_pciefd 0000:02:00.0: Received unexpected packet type 0x00000009

Always put the controller in the expected state, instead of assuming that
bus load reporting is inactive.

Note: If bus load reporting is enabled when the driver is loaded, you will
      still get a number of bus load packages (and printouts), before it is
      disabled.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Link: https://lore.kernel.org/r/20210309091724.31262-1-jimmyassarsson@gmail.com
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 37e05010ca91..74d9899fc904 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -57,6 +57,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_STAT_REG 0x418
 #define KVASER_PCIEFD_KCAN_MODE_REG 0x41c
 #define KVASER_PCIEFD_KCAN_BTRN_REG 0x420
+#define KVASER_PCIEFD_KCAN_BUS_LOAD_REG 0x424
 #define KVASER_PCIEFD_KCAN_BTRD_REG 0x428
 #define KVASER_PCIEFD_KCAN_PWM_REG 0x430
 /* Loopback control register */
@@ -949,6 +950,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		timer_setup(&can->bec_poll_timer, kvaser_pciefd_bec_poll_timer,
 			    0);
 
+		/* Disable Bus load reporting */
+		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
+
 		tx_npackets = ioread32(can->reg_base +
 				       KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
 		if (((tx_npackets >> KVASER_PCIEFD_KCAN_TX_NPACKETS_MAX_SHIFT) &
-- 
2.30.1


