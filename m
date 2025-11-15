Return-Path: <linux-can+bounces-5407-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99AC60448
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED263A9980
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3254284B4F;
	Sat, 15 Nov 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="N9z49jvH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bu6GFO37"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412D2877CF
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207482; cv=pass; b=J+ecKvAIubgcRTwsTz3MFIfH2Q5hRMrfySuJdSllGFUbBGB3ZwnLBQgkUNS+sNyPgbGgj8TNSMH2zt2ydEbnYPvtwg2hv+wy/9DaMHchVL65ugQXYyOAxCUAiz6Hjy+CaQz3q6ad40i064b4zci2xNOvrQsLNWuB3LCKYA4bWpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207482; c=relaxed/simple;
	bh=h1zodsCt8FnW/6LTnC1sNU3rH5Lvf1cJm4dQkShZS2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBv7cXmmp/urqj7qb2S0nGR1oxNNKj3SoIIAOJEM9HJNN5hAF6Mrt4W4NPo9onJuQpXGT9o0gmcoNt7l99JAhyxvbPf8dA7uukb3l9B9VibZHkZ4+cNexBowFbiXSyBJywYlAuarLiBtI12s4lRrIh7s5wCmJdPIcFgzlTKvdms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=N9z49jvH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bu6GFO37; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207464; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P6KD9MIhmRwK7dsJofOdDKWrUkUTqEte0S0zmgDdhRqp0jLBm3mvb51wVhqEPAwZmV
    6mQOZibzsEd7edJpQh0AKAYOPmn7gmiIyQO1sKpSyR04RlgqmV4n7MrvPgd54WOHRmPh
    VjxooTmYAbm+wICq5lcMyOQr5L7Y5pGq59ZkmJVkPUBdrChKBZfrdp/oj0WgV/ObAE7c
    o1EOCHBOaylhU/hz5BvnGxLkY+tBpZAsaCv5kKPN2rqoDvrHOu9+J2/1TDsQN2WYUDBk
    d5NXAElBWTtp6vXln3B+pi30H6L1+XNbFUpfVEbqX7GcQYq+MvkjKfb3B9ug0gD0dzcn
    NEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WyyPUWR80X0uNtfp8KrWRPR7nNaM0NFNRpxn5S9Yr6k=;
    b=it+ObgTB1MXKexUUjSN1/qbLZ2ew7hMuPx62Cih0155AEBXhvvzHAdg/j4jPoCjYPq
    jftORfN7l+YKk1f8Uk36POhSZJlIT7NlrnnbzleTyXcAl6eaV9mQgRErPi8sWEi+nQoG
    Ud2Rq5941vphhMevo+Wyu2S/bIoQrik7p5v1KLrJQX8CuBKOfQca212ca3jyRhAX5yd8
    ycMhiptszMbTaUpsDImadcmGr56t2R10ITzeasFD6TK+2awlxJSI6pSLDIy8LbIAjHil
    /GHLM+YTSDyln6K8+1UC5kP8o/IarylpDrUsbhDC3I8sTGp+SdQXw8YzlMlUvvegkO18
    8ymA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WyyPUWR80X0uNtfp8KrWRPR7nNaM0NFNRpxn5S9Yr6k=;
    b=N9z49jvHlSCq6ousfStemBrgOtR8sTiCLZhwNSD9JH3v2ksUxSodzLjfMQ9WHJ6wuY
    Jkl/p6aTSBlUj6noOPTgS53pxSDSMXQ2SGOKdXlD4c2QEAC3EozMYDrSaVzJoycsww8U
    aRKI+YGLkJLosHtgFZBgoErkbabs3Wa9fVcuI1E3neiJRM7wJ/4r8VTwqWvzlAez1orw
    TLivBfLwOWwpAPhEJ8AbnJflw2bPyrNrN6W3ccLP9OH+XKxvpqrkGJCdnhPE8AShcluP
    1mB00qvLHmBB3Z5PnTSlWvHhSPGKcE3tRz2QA23cL5b0mP/nYgraQkinnZgH01gb5IJ7
    g/4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WyyPUWR80X0uNtfp8KrWRPR7nNaM0NFNRpxn5S9Yr6k=;
    b=bu6GFO37PzzLSBYGzKTAIwSSriY19UVDiMgeXPtmqGskAKv7Brrk64fzQ8uDnZPoMR
    Z5Kp16xn7utFeNOV1vCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBp4dZi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:51:04 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl 03/10] can: netlink: add CAN_CTRLMODE_RESTRICTED
Date: Sat, 15 Nov 2025 12:50:46 +0100
Message-ID: <20251115115053.72673-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115115053.72673-1-socketcan@hartkopp.net>
References: <20251115115053.72673-1-socketcan@hartkopp.net>
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
---
 drivers/net/can/dev/dev.c        |  2 ++
 drivers/net/can/dev/netlink.c    |  7 +++++
 include/linux/can/dev.h          | 50 +++++++++++++++++---------------
 include/uapi/linux/can/netlink.h |  1 +
 4 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 80e1ab18de87..5e24bc332a50 100644
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
index a7a39a6101d9..ab11c0e9111b 100644
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
@@ -152,10 +128,36 @@ int can_restart_now(struct net_device *dev);
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


