Return-Path: <linux-can+bounces-5580-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DBAC7B89E
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6B93A475F
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA946301039;
	Fri, 21 Nov 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SxkSXIsb";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cCXg4cEA"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13662F12B6
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753746; cv=pass; b=DyCF6P6sIUDIpM4dhB3BFPK9rJGxOe/RzhKOGcohWT546IppkNMuPnE5xh7HB44mxVhb1p4uOFKMM9tjIovR//VVWve2laRa40b79YhXjbBy3ZghxTBthDd/wWWZPQDaApzL+LWFBykhUHdlzGM1op2IXHJfBqzXwt0OQDbmz/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753746; c=relaxed/simple;
	bh=ghxRWBFxKY2bRYxxxgWUBrRR3zijl8/9vgkJ+H9GwBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNmcz6hS+nLoSaEOEsxHtgYT8O/d9BU3Kk+nnhss6IE58ONSGL2+H6TlMjRrLPsL8X/gkr/nx8qv7pQuqEm8B5LQSbKrg7NyC0gwrme4J8Bc0zbpnhBLxN2ekqKe5iPlA8+TO8qEkIPhiGzK8GzYK3C+iB39jBLXhYil4NPv/6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SxkSXIsb; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cCXg4cEA; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753727; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=S4dufMx+LB8P8FVt3XQbKO2kbgNKmXqkzcURKSbX+GCYv2+Mp7+EilMlCOoZMnC2jM
    KVfg58PPvtigCO+SoF1q2oaGBTr4XwOS5p5YNA2jXqFXkfSlmRSbXi2udL+sBuf+jqIJ
    /CEdg16GZ60WVfj4iORFOL3U6y/kSlwZKurXgYWZRJMRCt4x9mzk3qwMnjlzwIyvtmHI
    uwTqbsRyqzTtJOJBAA0gjZ4+Mr7PwB5dIcnLi6egC5uWRZUhj+pzQFhiaId8xDtjSvDz
    D6FaTHDVD45v9EOC6g5KmKn0H7gVg/68aul4JrCQDGg2niqT4jQZSB/fmhRT3ulbQPiy
    yYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7EX5Gsm9RJpiqku2bbQXHYhKAolW4ebdYYaVHUHDP9c=;
    b=d/31cGDZw8/fW7cAFgdsrRe36r3C6o0Lq6SHW2IN8zq7vTJzO/dBbhuQIp5Pyaz635
    /4IRB8+1BsTSrm1RmCCfYRKQYwWxnxdH4hpt//KD567+myhNt7hhXirvbSF7urbXPruA
    BRFDEg74+mi5+t1pA5XEVJcwb/hNkI/H74UJbfyreyHaZov+GzVKhvHsLdAkwCp34aSq
    b1OGNHrcOfq0ES5cdxzGwpZ70YzAoSkkv8rXodNoTZO7bWn6NYwtvBLkzR/wCrbRb73p
    AvP/gsUQ10/cOIWv93AYiAuEDEy0c8cbBcUfWB10/5DlCOp4f0hgR30svF7pJY9PNbuG
    mBZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7EX5Gsm9RJpiqku2bbQXHYhKAolW4ebdYYaVHUHDP9c=;
    b=SxkSXIsba5mIvTovsjIor1S+u3cGdhOO1Xfg6ii1JR/O9LqcK0/V6mjW50Pg20o7xl
    jOlFpju7UBZ5JKgrJvMOhtgVvoRC9bYn7NZEQif3MQA1Jpdz0pCpZDqb2aaiyAbksd6s
    W/hIIVt4Hi2pRJ9e4yernt4IxWjpu703k7z9E20PWS106vmpAOU8zguZu9LRduZ2BfUa
    qQVjXdVlz3PvnDeiN7kEXCj+eRUiI/z0zu2EZjzYvHFpOrRZWyIfkgs/ZHPbu/6uK8ge
    MfG0ZrIHLTG6IQPIv83HGJxQzqAfv7Ar0p2m9ka1kFqneXNGHjFIO05d3LzuSlHx+oYN
    zLww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7EX5Gsm9RJpiqku2bbQXHYhKAolW4ebdYYaVHUHDP9c=;
    b=cCXg4cEAWsBK++40vA3KVGnUy/vvU3hGdSPhUevlk5JQFLVXwD5Wp2Ow1Wekx6WHxw
    SkMT0okyznKYV5Jx0BDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZREn5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:27 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 04/17] can: netlink: add CAN_CTRLMODE_RESTRICTED
Date: Fri, 21 Nov 2025 20:35:00 +0100
Message-ID: <20251121193513.2097-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121193513.2097-1-socketcan@hartkopp.net>
References: <20251121193513.2097-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

ISO 11898-1:2024 adds a new restricted operation mode. This mode is
added as a mandatory feature for nodes which support CAN XL and is
retrofitted as optional for legacy nodes (i.e. the ones which only
support Classical CAN and CAN FD).

The restricted operation mode is nearly the same as the listen only
mode: the node can not send data frames or remote frames and can not
send dominant bits if an error occurs. The only exception is that the
node shall still send the acknowledgment bit. A second niche exception
is that the node may still send a data frame containing a time
reference message if the node is a primary time provider, but because
the time provider feature is not yet implemented in the kernel, this
second exception is not relevant to us at the moment.

Add the CAN_CTRLMODE_RESTRICTED control mode flag and update the
can_dev_dropped_skb() helper function accordingly.

Finally, bail out if both CAN_CTRLMODE_LISTENONLY and
CAN_CTRLMODE_RESTRICTED are provided.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/dev.c        |  2 ++
 drivers/net/can/dev/netlink.c    |  7 +++++
 include/linux/can/dev.h          | 50 +++++++++++++++++---------------
 include/uapi/linux/can/netlink.h |  1 +
 4 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 735faa888886..7973674402d1 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -113,10 +113,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "CC-LEN8-DLC";
 	case CAN_CTRLMODE_TDC_AUTO:
 		return "TDC-AUTO";
 	case CAN_CTRLMODE_TDC_MANUAL:
 		return "TDC-MANUAL";
+	case CAN_CTRLMODE_RESTRICTED:
+		return "RESTRICTED";
 	default:
 		return "<unknown>";
 	}
 }
 EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 6f83b87d54fc..87e731527dd7 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -186,10 +186,17 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
 		flags = cm->flags & cm->mask;
+
+		if ((flags & CAN_CTRLMODE_LISTENONLY) &&
+		    (flags & CAN_CTRLMODE_RESTRICTED)) {
+			NL_SET_ERR_MSG(extack,
+				       "LISTEN-ONLY and RESTRICTED modes are mutually exclusive");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
 	if (err)
 		return err;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index d59b283c981a..9de8fde3ec9d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -93,34 +93,10 @@ static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
 static inline bool can_is_canxl_dev_mtu(unsigned int mtu)
 {
 	return (mtu >= CANXL_MIN_MTU && mtu <= CANXL_MAX_MTU);
 }
 
-/* drop skb if it does not contain a valid CAN frame for sending */
-static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
-		netdev_info_once(dev,
-				 "interface in listen only mode, dropping skb\n");
-		goto invalid_skb;
-	}
-
-	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
-		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
-		goto invalid_skb;
-	}
-
-	return can_dropped_invalid_skb(dev, skb);
-
-invalid_skb:
-	kfree_skb(skb);
-	dev->stats.tx_dropped++;
-	return true;
-}
-
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 				    unsigned int txqs, unsigned int rxqs);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
@@ -148,10 +124,36 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
 const char *can_get_ctrlmode_str(u32 ctrlmode);
 
+/* drop skb if it does not contain a valid CAN frame for sending */
+static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
+					    CAN_CTRLMODE_RESTRICTED);
+
+	if (silent_mode) {
+		netdev_info_once(dev, "interface in %s mode, dropping skb\n",
+				 can_get_ctrlmode_str(silent_mode));
+		goto invalid_skb;
+	}
+
+	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
+		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
+		goto invalid_skb;
+	}
+
+	return can_dropped_invalid_skb(dev, skb);
+
+invalid_skb:
+	kfree_skb(skb);
+	dev->stats.tx_dropped++;
+	return true;
+}
+
 void can_state_get_by_berr_counter(const struct net_device *dev,
 				   const struct can_berr_counter *bec,
 				   enum can_state *tx_state,
 				   enum can_state *rx_state);
 void can_change_state(struct net_device *dev, struct can_frame *cf,
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index ef62f56eaaef..fafd1cce4798 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -101,10 +101,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
+#define CAN_CTRLMODE_RESTRICTED		0x800	/* Restricted operation mode */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
-- 
2.47.3


