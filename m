Return-Path: <linux-can+bounces-5534-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6DC77ED6
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 26F61293C1
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33746330D54;
	Fri, 21 Nov 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MGGl4hEc";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="2+LtkUAq"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259B82E041D
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714081; cv=pass; b=WSKcHW1dIqsPDwDdhBZEW9ombYUaCPK3VumOzMlTcMSec9WKLKirX/gLzZtWelAo/KvNmJjYACUNcuFjSH0Nf4F+MRwTLE/awpoRy3bspYXzJEqgIhW4qKzLdPr7NZuMOI6kEVILl+dUcuU4vwoFLAvO+DuwYRXbO1MkwP7SpMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714081; c=relaxed/simple;
	bh=vEdKl2mkXYwP6udJd6dRXjFYS6s2ZGEDcZtll5XU0cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqSC464pKePtjQPhN13UZG40swVpUi4CkCa4qB4WQa97UZthbA2CynVfNyDY7H/S2r6fgnqqXvYxwyR4jPBNS5CJoPkO1eyjkYsYPBlhEKBCcUAEwN4KmTxpS+x6YrbHrhdI2BpWrN5J7OafTjsLLpUecG0LMDuJT40MfinYGpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MGGl4hEc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=2+LtkUAq; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714068; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=h/nqN/0TFlP5XiTw+PNldBP+aD6LokK00OuQ3GyirharqL8TUGhuK8GYnr6WugpcvG
    h0VJvoBNLysCyg1BtYJpsTa65vf0GEXdZz29MGdY74CLFVknbYrOgdmHccuBjYc1UeQ5
    DEqd3WEYzU6C/ZRYG+136w1WmlnDnCLKVFhnogdAOSPRZ3AK4AlFChlZQCrMfck//T8t
    HMPE6mLlP1JqzK9mV7xv6qWbdweqJ5IP0ATCdhlc8+7+o4J4rqG8knAtn0Rd1R67D/yM
    v9gm2ZqOVzi9sEX/V1URV88XUfjxsJFjD9QMNhM32EBFunyEmviA3OR2Z9Y41v4kui8V
    vAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714068;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=G1xSU719UXDD5PVmX58aVpDXl0eVnmqAyLySG0oFUDQ=;
    b=hAGkcFnf2AVqovmfmu+9IjCIdv72T4FGm+9D/szzHpOZk6TmLTMiVv4rbv7FfxVtBm
    iisZAu1/423Os6Nx87nA/Ok+tAdGUPb+0v/yk9pzhru+GWOE+Wisp6DkAvwxNRYQL069
    f2YBA8hKC4MtsUeRasBADgKbYT6BJzOEs58uITeRmwHw38GTcKtltA2x4VS8JjHYE8Q7
    PJHX37UH8J64QRbyk8x/7zSFc2AEdtf/vRrTN2oq76Ot28oKQq/tCNsQsitrODZGGiiL
    NqRhOMvuXkXInW+q6VsnUABw7Z4L8dt6rOgd47ZwZMNn0948/oXuGbLq/RB+jTqDTL0q
    C0EA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714068;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=G1xSU719UXDD5PVmX58aVpDXl0eVnmqAyLySG0oFUDQ=;
    b=MGGl4hEcUUTP+3WA9abbwEW+PtD/RfZA1pUkKOi11MSv5RsyIOXEKQuHry9Ja1XboW
    YHZq6MKPq1QEyEWY3+o2JilxLySeIwGOFG7ae8l5eQMj0/JYc1rB8RT+d6mYCEW3ocLw
    gR9AcZ2ZNtqc/y1Vjik5Q4s8hYUQJbJzMuRkKXzFA7dyP/9fhHJiQKJ2Kn9f/T5VTO2k
    0egAZs9W8Gvj1KO83+VtwDRRUbP+aFQ0Pt8qr2Jl2nquk9P/WJvK5dWTtmyILnyALQx3
    zUHcNKiLdwgWxUL8VRuS/yp4N/xPGlXhmkBSV6tlAC7WLiPT12y1c5Ogz6asj2X4JE7J
    mzZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714068;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=G1xSU719UXDD5PVmX58aVpDXl0eVnmqAyLySG0oFUDQ=;
    b=2+LtkUAq/a8qO755CREjAh/pa4XWEdC6PrUNcIC84Hu301PsOb/WT7d+ltXNyJGouo
    zyk2Cs/xTP7C2iyUjyDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YRAfq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:27 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 03/17] can: netlink: add CAN_CTRLMODE_RESTRICTED
Date: Fri, 21 Nov 2025 09:34:00 +0100
Message-ID: <20251121083414.3642-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121083414.3642-1-socketcan@hartkopp.net>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
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
index 0cc3d008adb3..3377afb6f1c4 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -113,10 +113,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "cc-len8-dlc";
 	case CAN_CTRLMODE_TDC_AUTO:
 		return "fd-tdc-auto";
 	case CAN_CTRLMODE_TDC_MANUAL:
 		return "fd-tdc-manual";
+	case CAN_CTRLMODE_RESTRICTED:
+		return "restricted-operation";
 	default:
 		return "<unknown>";
 	}
 }
 EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 6f83b87d54fc..7cb57b0df726 100644
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
+				       "Listen-only and restricted modes are mutually exclusive");
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


