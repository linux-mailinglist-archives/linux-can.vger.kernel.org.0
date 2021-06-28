Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC26B3B64E6
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhF1PRd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:17:33 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:27763 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhF1PPc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:15:32 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id NfCP250070zjR6y03fD3mh; Mon, 28 Jun 2021 17:13:05 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:13:05 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 4/4] can: netlink: add interface for CAN-FD Transmitter Delay Compensation (TDC)
Date:   Tue, 29 Jun 2021 00:06:07 +0900
Message-Id: <20210628150607.1128574-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628150607.1128574-1-mailhol.vincent@wanadoo.fr>
References: <20210628150607.1128574-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add the netlink interface for TDC parameters of struct can_tdc_const
and can_tdc.

Contrary to the can_bittiming(_const) structures for which there is
just a single IFLA_CAN(_DATA)_BITTMING(_CONST) entry per structure,
here, we create a nested entry IFLA_CAN_TDC. Within this nested entry,
additional IFLA_CAN_TDC_TDC* entries are added for each of the TDC
parameters of the newly introduced struct can_tdc_const and struct
can_tdc.

For struct can_tdc_const, these are:
        IFLA_CAN_TDC_TDCV_MIN
        IFLA_CAN_TDC_TDCV_MAX
        IFLA_CAN_TDC_TDCO_MIN
        IFLA_CAN_TDC_TDCO_MAX
        IFLA_CAN_TDC_TDCF_MIN
        IFLA_CAN_TDC_TDCF_MAX

For struct can_tdc, these are:
        IFLA_CAN_TDC_TDCV
        IFLA_CAN_TDC_TDCO
        IFLA_CAN_TDC_TDCF

This is done so that changes can be applied in the future to the
structures without breaking the netlink interface.

All the new parameters are defined as u32. This arbitrary choice is
done to mimic the other bittiming values with are also all of type
u32. An u16 would have been sufficient to hold the TDC values.

This patch completes below series:
  - commit 289ea9e4ae59 ("can: add new CAN FD bittiming parameters:
    Transmitter Delay Compensation (TDC)")
  - commit c25cc7993243 ("can: bittiming: add calculation for CAN FD
    Transmitter Delay Compensation (TDC)")

Reference: https://lore.kernel.org/linux-can/20210224002008.4158-1-mailhol.vincent@wanadoo.fr/T/#t

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c    | 180 ++++++++++++++++++++++++++++++-
 include/uapi/linux/can/netlink.h |  29 ++++-
 2 files changed, 203 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 80425636049d..db8a6e4777a1 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -19,6 +19,19 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
+	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
+	[IFLA_CAN_TDC_TDCV_MIN] = { .type = NLA_U32 },
+	[IFLA_CAN_TDC_TDCV_MAX] = { .type = NLA_U32 },
+	[IFLA_CAN_TDC_TDCO_MIN] = { .type = NLA_U32 },
+	[IFLA_CAN_TDC_TDCO_MAX] = { .type = NLA_U32 },
+	[IFLA_CAN_TDC_TDCF_MIN] = { .type = NLA_U32 },
+	[IFLA_CAN_TDC_TDCF_MAX] = { .type = NLA_U32 },
+	[IFLA_CAN_TDC_TDCV] = { .type = NLA_U32 },
+	[IFLA_CAN_TDC_TDCO] = { .type = NLA_U32 },
+	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -46,7 +59,7 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			return -EOPNOTSUPP;
 	}
 
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
+	if (data[IFLA_CAN_DATA_BITTIMING] || data[IFLA_CAN_TDC]) {
 		if (!is_can_fd)
 			return -EOPNOTSUPP;
 	}
@@ -54,11 +67,69 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
+static int can_tdc_changelink(struct net_device *dev, const struct nlattr *nla,
+			      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[IFLA_CAN_TDC_MAX + 1];
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_tdc *tdc = &priv->tdc;
+	const struct can_tdc_const *tdc_const = priv->tdc_const;
+	int err;
+
+	if (!tdc_const || !can_tdc_is_enabled(priv))
+		return -EOPNOTSUPP;
+
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	err = nla_parse_nested(tb, IFLA_CAN_TDC_MAX, nla,
+			       can_tdc_policy, extack);
+	if (err)
+		return err;
+
+	if (tb[IFLA_CAN_TDC_TDCV]) {
+		u32 tdcv = nla_get_u32(tb[IFLA_CAN_TDC_TDCV]);
+
+		if (priv->ctrlmode & CAN_CTRLMODE_TDC_AUTO)
+			return -EOPNOTSUPP;
+
+		if (tdcv < tdc_const->tdcv_min || tdcv > tdc_const->tdcv_max)
+			return -EINVAL;
+
+		tdc->tdcv = tdcv;
+	} else if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		return -EOPNOTSUPP;
+	}
+
+	if (tb[IFLA_CAN_TDC_TDCO]) {
+		u32 tdco = nla_get_u32(tb[IFLA_CAN_TDC_TDCO]);
+
+		if (tdco < tdc_const->tdco_min || tdco > tdc_const->tdco_max)
+			return -EINVAL;
+
+		tdc->tdco = tdco;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	if (tb[IFLA_CAN_TDC_TDCF]) {
+		u32 tdcf = nla_get_u32(tb[IFLA_CAN_TDC_TDCF]);
+
+		if (tdcf < tdc_const->tdcf_min || tdcf > tdc_const->tdcf_max)
+			return -EINVAL;
+
+		tdc->tdcf = tdcf;
+	}
+
+	return 0;
+}
+
 static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
+	u32 tdc_mask = 0;
 	int err;
 
 	/* We need synchronization with dev->stop() */
@@ -107,6 +178,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		struct can_ctrlmode *cm;
 		u32 ctrlstatic;
 		u32 maskedflags;
+		u32 tdc_flags;
 
 		/* Do not allow changing controller mode while running */
 		if (dev->flags & IFF_UP)
@@ -138,7 +210,18 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			dev->mtu = CAN_MTU;
 			memset(&priv->data_bittiming, 0,
 			       sizeof(priv->data_bittiming));
+			memset(&priv->tdc, 0, sizeof(priv->tdc));
+			priv->ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
 		}
+
+		tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
+		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
+		if (tdc_flags == CAN_CTRLMODE_TDC_MASK)
+			return -EOPNOTSUPP;
+		/* If one of CAN_CTRLMODE_TDC_* is set then TDC must be set */
+		if (tdc_flags && !data[IFLA_CAN_TDC])
+			return -EOPNOTSUPP;
+		tdc_mask = cm->mask & CAN_CTRLMODE_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
@@ -189,8 +272,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 
 		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
 
-		can_calc_tdco(dev);
-
 		if (priv->do_set_data_bittiming) {
 			/* Finally, set the bit-timing registers */
 			err = priv->do_set_data_bittiming(dev);
@@ -223,9 +304,52 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		priv->termination = termval;
 	}
 
+	if (data[IFLA_CAN_TDC]) {
+		/* Use the provided TDC parameters */
+		err = can_tdc_changelink(dev, data[IFLA_CAN_TDC], extack);
+		if (err)
+			return err;
+	} else if (!tdc_mask) {
+		/* both TDC parameters and flags not provided: do calculation */
+		can_calc_tdco(dev);
+	} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
+	   * turned off. TDC is disabled
+	   */
+
 	return 0;
 }
 
+static size_t can_tdc_get_size(const struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	size_t size;
+
+	if (!priv->tdc_const)
+		return 0;
+
+	size = nla_total_size(0);			/* nest IFLA_CAN_TDC */
+	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL) {
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MIN */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MAX */
+	}
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MIN */
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MAX */
+	if (priv->tdc_const->tdcf_max) {
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MIN */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MAX */
+	}
+
+	if (can_tdc_is_enabled(priv)) {
+		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
+			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
+		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
+		if (priv->tdc_const->tdcf_max)
+			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF */
+	}
+
+	return size;
+}
+
 static size_t can_get_size(const struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
@@ -257,10 +381,56 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(*priv->data_bitrate_const) *
 				       priv->data_bitrate_const_cnt);
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
+	size += can_tdc_get_size(dev);				/* IFLA_CAN_TDC */
 
 	return size;
 }
 
+static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct nlattr *nest;
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_tdc *tdc = &priv->tdc;
+	const struct can_tdc_const *tdc_const = priv->tdc_const;
+
+	if (!tdc_const)
+		return 0;
+
+	nest = nla_nest_start(skb, IFLA_CAN_TDC);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL &&
+	    (nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MIN, tdc_const->tdcv_min) ||
+	     nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MAX, tdc_const->tdcv_max)))
+		goto err_cancel;
+	if (nla_put_u32(skb, IFLA_CAN_TDC_TDCO_MIN, tdc_const->tdco_min) ||
+	    nla_put_u32(skb, IFLA_CAN_TDC_TDCO_MAX, tdc_const->tdco_max))
+		goto err_cancel;
+	if (tdc_const->tdcf_max &&
+	    (nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MIN, tdc_const->tdcf_min) ||
+	     nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MAX, tdc_const->tdcf_max)))
+		goto err_cancel;
+
+	if (can_tdc_is_enabled(priv)) {
+		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL &&
+		    nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdc->tdcv))
+			goto err_cancel;
+		if (nla_put_u32(skb, IFLA_CAN_TDC_TDCO, tdc->tdco))
+			goto err_cancel;
+		if (tdc_const->tdcf_max &&
+		    nla_put_u32(skb, IFLA_CAN_TDC_TDCF, tdc->tdcf))
+			goto err_cancel;
+	}
+
+	nla_nest_end(skb, nest);
+	return 0;
+
+err_cancel:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
 static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
@@ -318,7 +488,9 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),
-		     &priv->bitrate_max))
+		     &priv->bitrate_max)) ||
+
+	    (can_tdc_fill_info(skb, dev))
 	    )
 
 		return -EMSGSIZE;
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 004cd09a7d49..75b85c60efb2 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -136,10 +136,35 @@ enum {
 	IFLA_CAN_BITRATE_CONST,
 	IFLA_CAN_DATA_BITRATE_CONST,
 	IFLA_CAN_BITRATE_MAX,
-	__IFLA_CAN_MAX
+	IFLA_CAN_TDC,
+
+	/* add new constants above here */
+	__IFLA_CAN_MAX,
+	IFLA_CAN_MAX = __IFLA_CAN_MAX - 1
 };
 
-#define IFLA_CAN_MAX	(__IFLA_CAN_MAX - 1)
+/*
+ * CAN FD Transmitter Delay Compensation (TDC)
+ *
+ * Please refer to struct can_tdc_const and can_tdc in
+ * include/linux/can/bittiming.h for further details.
+ */
+enum {
+	IFLA_CAN_TDC_UNSPEC,
+	IFLA_CAN_TDC_TDCV_MIN,	/* u32 */
+	IFLA_CAN_TDC_TDCV_MAX,	/* u32 */
+	IFLA_CAN_TDC_TDCO_MIN,	/* u32 */
+	IFLA_CAN_TDC_TDCO_MAX,	/* u32 */
+	IFLA_CAN_TDC_TDCF_MIN,	/* u32 */
+	IFLA_CAN_TDC_TDCF_MAX,	/* u32 */
+	IFLA_CAN_TDC_TDCV,	/* u32 */
+	IFLA_CAN_TDC_TDCO,	/* u32 */
+	IFLA_CAN_TDC_TDCF,	/* u32 */
+
+	/* add new constants above here */
+	__IFLA_CAN_TDC,
+	IFLA_CAN_TDC_MAX = __IFLA_CAN_TDC - 1
+};
 
 /* u16 termination range: 1..65535 Ohms */
 #define CAN_TERMINATION_DISABLED 0
-- 
2.31.1

