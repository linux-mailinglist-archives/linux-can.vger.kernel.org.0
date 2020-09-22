Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760AD274495
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgIVOor (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgIVOom (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D9C0613CF
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:42 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjX6-0001FU-5t; Tue, 22 Sep 2020 16:44:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 18/20] can: flexcan: add Transceiver Delay Compensation support
Date:   Tue, 22 Sep 2020 16:44:27 +0200
Message-Id: <20200922144429.2613631-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922144429.2613631-1-mkl@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

The CAN-FD protocol allows the transmission and reception of data at a
higher bit rate than the nominal rate used in the arbitration phase when
the message's BRS bit is set.

The TDC mechanism is effective only during the data phase of FD frames
having BRS bit set. It has no effect either on non-FD frames, or on FD
frames transmitted at normal bit rate.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Link: https://lore.kernel.org/r/20190712075926.7357-7-qiangqing.zhang@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index fc0e9d5fd02b..fc98b5d521f2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -156,6 +156,10 @@
 #define FLEXCAN_FDCTRL_MBDSR_12		0x1
 #define FLEXCAN_FDCTRL_MBDSR_32		0x2
 #define FLEXCAN_FDCTRL_MBDSR_64		0x3
+#define FLEXCAN_FDCTRL_TDCEN		BIT(15)
+#define FLEXCAN_FDCTRL_TDCFAIL		BIT(14)
+#define FLEXCAN_FDCTRL_TDCOFF		GENMASK(12, 8)
+#define FLEXCAN_FDCTRL_TDCVAL		GENMASK(5, 0)
 
 /* FLEXCAN FD Bit Timing register (FDCBT) bits */
 #define FLEXCAN_FDCBT_FPRESDIV_MASK	GENMASK(29, 20)
@@ -1220,11 +1224,24 @@ static void flexcan_set_bittiming_cbt(const struct net_device *dev)
 
 	/* FDCTRL */
 	reg_fdctrl = priv->read(&regs->fdctrl);
-	reg_fdctrl &= ~FLEXCAN_FDCTRL_FDRATE;
+	reg_fdctrl &= ~(FLEXCAN_FDCTRL_FDRATE |
+			FIELD_PREP(FLEXCAN_FDCTRL_TDCOFF, 0x1f));
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		reg_fdctrl |= FLEXCAN_FDCTRL_FDRATE;
 
+		if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
+			/* TDC must be disabled for Loop Back mode */
+			reg_fdctrl &= ~FLEXCAN_FDCTRL_TDCEN;
+		} else {
+			reg_fdctrl |= FLEXCAN_FDCTRL_TDCEN |
+				FIELD_PREP(FLEXCAN_FDCTRL_TDCOFF,
+					   ((dbt->phase_seg1 - 1) +
+					    dbt->prop_seg + 2) *
+					   ((dbt->brp - 1 ) + 1));
+		}
+	}
+
 	netdev_dbg(dev, "writing fdctrl=0x%08x\n", reg_fdctrl);
 	priv->write(reg_fdctrl, &regs->fdctrl);
 
-- 
2.28.0

