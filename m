Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4C3234EC
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 02:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhBXBHx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 20:07:53 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:40332 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbhBXAfW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 19:35:22 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d12 with ME
        id YoPH240063PnFJp03oPPhm; Wed, 24 Feb 2021 01:23:25 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Feb 2021 01:23:25 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 4/5] can: add netlink interface for CAN-FD Transmitter Delay Compensation (TDC)
Date:   Wed, 24 Feb 2021 09:20:07 +0900
Message-Id: <20210224002008.4158-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add the netlink interface for TDC parameters of struct can_tdc and
can_tdc_const.

Contrary to the can_bittiming(_const) structures for which there is
just a single IFLA_CAN(_DATA)_BITTMING(_CONST) entry per structure,
here, an IFLA_CAN_TDC* entry is added for each of the TDC parameters
of the newly introduced struct can_tdc and struct can_tdc_const.

For struct can_tdc, these are:
	IFLA_CAN_TDCV
	IFLA_CAN_TDCO
	IFLA_CAN_TDCF

For struct can_tdc_const, these are:
	IFLA_CAN_TDCV_MAX_CONST
	IFLA_CAN_TDCO_MAX_CONST
	IFLA_CAN_TDCF_MAX_CONST

This is done so that changes can be applied in the future to the
structures without breaking the netlink interface.

All the new parameters are defined as u32. This arbitrary choice is
done to mimic the other bittiming values with are also all of type
u32. An u16 would have been sufficient to hold the TDC values.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c    | 74 +++++++++++++++++++++++++++++++-
 include/uapi/linux/can/netlink.h |  6 +++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index c19eef775ec8..c3f75c09d6c8 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -19,6 +19,12 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
+	[IFLA_CAN_TDCV] = { .type = NLA_U32 },
+	[IFLA_CAN_TDCV_MAX_CONST] = { .type = NLA_U32 },
+	[IFLA_CAN_TDCO] = { .type = NLA_U32 },
+	[IFLA_CAN_TDCO_MAX_CONST] = { .type = NLA_U32 },
+	[IFLA_CAN_TDCF] = { .type = NLA_U32 },
+	[IFLA_CAN_TDCF_MAX_CONST] = { .type = NLA_U32 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -218,6 +224,51 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		priv->termination = termval;
 	}
 
+	if (data[IFLA_CAN_TDCV]) {
+		u32 tdcv = nla_get_u32(data[IFLA_CAN_TDCV]);
+
+		if (!priv->tdc_const || !priv->tdc_const->tdcv_max)
+			return -EOPNOTSUPP;
+
+		if (tdcv > priv->tdc_const->tdcv_max)
+			return -EINVAL;
+
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		priv->tdc.tdcv = tdcv;
+	}
+
+	if (data[IFLA_CAN_TDCO]) {
+		u32 tdco = nla_get_u32(data[IFLA_CAN_TDCO]);
+
+		if (!priv->tdc_const || !priv->tdc_const->tdco_max)
+			return -EOPNOTSUPP;
+
+		if (tdco > priv->tdc_const->tdco_max)
+			return -EINVAL;
+
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		priv->tdc.tdco = tdco;
+	}
+
+	if (data[IFLA_CAN_TDCF]) {
+		u32 tdcf = nla_get_u32(data[IFLA_CAN_TDCF]);
+
+		if (!priv->tdc_const || !priv->tdc_const->tdcf_max)
+			return -EOPNOTSUPP;
+
+		if (tdcf > priv->tdc_const->tdcf_max)
+			return -EINVAL;
+
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		priv->tdc.tdcf = tdcf;
+	}
+
 	return 0;
 }
 
@@ -252,6 +303,16 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(*priv->data_bitrate_const) *
 				       priv->data_bitrate_const_cnt);
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
+	if (priv->tdc.tdco) {
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCO */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF */
+	}
+	if (priv->tdc_const) {
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MAX_CONST */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCO_MAX_CONST */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MAX_CONST */
+	}
 
 	return size;
 }
@@ -313,7 +374,18 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),
-		     &priv->bitrate_max))
+		     &priv->bitrate_max)) ||
+
+	    (priv->tdc_const &&
+	     (nla_put_u32(skb, IFLA_CAN_TDCV, priv->tdc.tdcv) ||
+	      nla_put_u32(skb, IFLA_CAN_TDCO, priv->tdc.tdco) ||
+	      nla_put_u32(skb, IFLA_CAN_TDCF, priv->tdc.tdcf) ||
+	      nla_put_u32(skb, IFLA_CAN_TDCV_MAX_CONST,
+			  priv->tdc_const->tdcv_max) ||
+	      nla_put_u32(skb, IFLA_CAN_TDCO_MAX_CONST,
+			  priv->tdc_const->tdco_max) ||
+	      nla_put_u32(skb, IFLA_CAN_TDCF_MAX_CONST,
+			  priv->tdc_const->tdcf_max)))
 	    )
 
 		return -EMSGSIZE;
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index f730d443b918..e69c4b330ae6 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -134,6 +134,12 @@ enum {
 	IFLA_CAN_BITRATE_CONST,
 	IFLA_CAN_DATA_BITRATE_CONST,
 	IFLA_CAN_BITRATE_MAX,
+	IFLA_CAN_TDCV,
+	IFLA_CAN_TDCO,
+	IFLA_CAN_TDCF,
+	IFLA_CAN_TDCV_MAX_CONST,
+	IFLA_CAN_TDCO_MAX_CONST,
+	IFLA_CAN_TDCF_MAX_CONST,
 	__IFLA_CAN_MAX
 };
 
-- 
2.26.2

