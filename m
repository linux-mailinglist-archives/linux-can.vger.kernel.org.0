Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418133234ED
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 02:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhBXBHz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 20:07:55 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:45943 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBXAgb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 19:36:31 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d12 with ME
        id YoQ2240083PnFJp03oQ7nU; Wed, 24 Feb 2021 01:24:09 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Feb 2021 01:24:09 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 5/5] can: bittiming: add calculation for CAN FD Transmitter Delay Compensation (TDC)
Date:   Wed, 24 Feb 2021 09:20:08 +0900
Message-Id: <20210224002008.4158-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The logic for the tdco calculation is to just reuse the normal sample
point: tdco = sp. Because the sample point is expressed in tenth of
percent and the tdco is expressed in time quanta, a conversion is
needed.

At the end,
     ssp = tdcv + tdco
         = tdcv + sp.

Another popular method is to set tdco to the middle of the bit:
     tdc->tdco = can_bit_time(dbt) / 2
During benchmark tests, we could not find a clear advantages for one
of the two methods.

The tdco calculation is triggered each time the data_bittiming is
changed so that users relying on automated calculation can use the
netlink interface the exact same way without need of new parameters.
For example, a command such as:
	ip link set canX type can bitrate 500000 dbitrate 4000000 fd on
would trigger the calculation.

The user using CONFIG_CAN_CALC_BITTIMING who does not want automated
calculation needs to manually set tdco to zero.
For example with:
	ip link set canX type can tdco 0 bitrate 500000 dbitrate 4000000 fd on
(if the tdco parameter is provided in a previous command, it will be
overwritten).

If tdcv is set to zero (default), it is automatically calculated by
the transiver for each frame. As such, there is no code in the kernel
to calculate it.

tdcf has no automated calculation functions because we could not
figure out a formula for this parameter.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/bittiming.c | 23 +++++++++++++++++++++++
 drivers/net/can/dev/netlink.c   |  1 +
 include/linux/can/bittiming.h   |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index f7fe226bb395..5d6c2f217210 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -174,6 +174,29 @@ int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
 
 	return 0;
 }
+
+void can_calc_tdco(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	const struct can_bittiming *dbt = &priv->data_bittiming;
+	struct can_tdc *tdc = &priv->tdc;
+	const struct can_tdc_const *tdc_const = priv->tdc_const;
+
+	if (!tdc_const)
+		return;
+
+	/* As specified in ISO 11898-1 section 11.3.3 "Transmitter
+	 * delay compensation" (TDC) is only applicable if data BRP is
+	 * one or two.
+	 */
+	if (dbt->brp == 1 || dbt->brp == 2) {
+		/* Reuse "normal" sample point and convert it to time quanta */
+		tdc->tdco = min(can_bit_time(dbt) * dbt->sample_point / 1000,
+				tdc_const->tdco_max);
+	} else {
+		tdc->tdco = 0;
+	}
+}
 #endif /* CONFIG_CAN_CALC_BITTIMING */
 
 /* Checks the validity of the specified bit-timing parameters prop_seg,
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index c3f75c09d6c8..a3b71465849c 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -183,6 +183,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 					priv->data_bitrate_const_cnt);
 		if (err)
 			return err;
+		can_calc_tdco(dev);
 
 		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
 			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 91bf9f8926a7..8c042a025a7f 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -78,6 +78,8 @@ struct can_tdc_const {
 #ifdef CONFIG_CAN_CALC_BITTIMING
 int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
 		       const struct can_bittiming_const *btc);
+
+void can_calc_tdco(struct net_device *dev);
 #else /* !CONFIG_CAN_CALC_BITTIMING */
 static inline int
 can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
@@ -86,6 +88,10 @@ can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
 	netdev_err(dev, "bit-timing calculation not available\n");
 	return -EINVAL;
 }
+
+static inline void can_calc_tdco(struct net_device *dev)
+{
+}
 #endif /* CONFIG_CAN_CALC_BITTIMING */
 
 int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
-- 
2.26.2

