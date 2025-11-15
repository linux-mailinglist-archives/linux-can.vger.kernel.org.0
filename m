Return-Path: <linux-can+bounces-5431-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68312C608A7
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FED3A97A3
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37D2FF15E;
	Sat, 15 Nov 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QsfDsMiD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8KR/BSda"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5422FD68E
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224686; cv=pass; b=MV6rBQD4aA7YNduGdrOwydZv7eWf3NJa0UDI0jOmLnOnoOMGXA+xUneYapSCqI9ZRWglO1TokXYqUJxbzwp7ttdIKWs/30gjAHunxgNCiGJemahnYzxt3vcfq2aRcTQ2ASJE+27KQkqkI65cogE2BlbBT59lkedNXGWxAvtvtXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224686; c=relaxed/simple;
	bh=h1zodsCt8FnW/6LTnC1sNU3rH5Lvf1cJm4dQkShZS2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHxXdp/epP62qyAk/+GC31Mt32vIZhK+oumhminQXV8Icjb+DO8JcYTlB4+UgVVr01zVNuffoZdljGmTLkWceoc3VuhclYHj7J8PEanbMKnDaMujTuYUl6vxLiWJsCjEZoosVR7lnRBJUpeY/bOv5fwy37aMECRMWm+vgMtaGnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QsfDsMiD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8KR/BSda; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224673; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G9Q3zq5t3j5L/kS/7S3hYOSlX00FnO1UijhfNiprWJ63Q24zrt76ah9cHNZwBJefCn
    BKaeKHyV7UgjcVLIOxL7owt32OqqCChUe/39Rbxqn3xx5N0JlsMEWCauDKDTrn4ZZlCF
    iST2DJTsRYKZ3LnNd2+ilLDVoXCT5pK8h2WGCDcDvmyQ3Dh2L4KhK7KJlQRl33O+7Rn3
    XVTeWhE+TYjQT0eM3kw4xNdWEO5NH2z5vKkmuGZK2ME3XV1QSId34nf50LxqQ8FC1JGi
    e+fCNDeWySceoC8V9XmUlojJUdU08JzfTCm3QPMRFPCCZgieoGTU16XUGuqOqDoxCDnS
    xPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WyyPUWR80X0uNtfp8KrWRPR7nNaM0NFNRpxn5S9Yr6k=;
    b=Jbe7CoVGsEUP8jfnVuyO1/KFJC27yPxhl7gxIZSViQpPTnPaCCIr6qeWnNtUOKIGzp
    6VxqJSZg7kf6MVuEgxW6Ycg8mTf8r3d8Nt7JBwbzNsaW0IiP7gQEEz2/6+4npXHIhOcB
    WybEX4cMoNFrWhh20AiBywTEIt2U7fcDqj4e1ndaJif6GWUhyeNjV+LKw42X+hmKQ34Z
    NpfM5kEWOdjn9DjUWP9nx0Ec1hnOjo9C5NTbzGIuyopgXFVqPUsnApoJcNMNgqQJ8b4M
    kkufBeKYgviBYuGrBQ+ps53HDjuYHqBj/O5xRcf0u+KR9MO0HXaQDDh9LL3YCw9AcjQZ
    SPhg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WyyPUWR80X0uNtfp8KrWRPR7nNaM0NFNRpxn5S9Yr6k=;
    b=QsfDsMiD8gMzFWIpZfRyDRhLs4OVx4O2OaIxDLmVdBMLLlJweiiALcBydkbnIF8JNC
    HHPVmhZwZ6pkVy4rckmWc9gxxjsHuikljdauHdWkoSuZuffrWVT0FDK8RCBxnQb+HTYL
    fkYUUFM6YiZ7ZFc/fkAppCl/u++4aA5/stg+SEY4BjFoRFKTIJscgNAt0KfCMf16QVRb
    GIkQpF7t6rlBAxlc3DkAZZtg/cuXnMsg5nCSImPqP78Uexzsa5BX869aLpmkUXqL/0YN
    fR/225R6xsVG3kw+bIIJdCmwrGZFwvCzCM0iSm9vNlBjCYfuiuPLkBy9RT2U/tZ5XUBq
    Ywhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WyyPUWR80X0uNtfp8KrWRPR7nNaM0NFNRpxn5S9Yr6k=;
    b=8KR/BSdaTB2O71brefSKcMTP81YPPUfmGU13mcYK19hOu08hgzAdVeEvMLuymtCPdh
    4NuZW+Cjrys1lqRVfhCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbreQm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 03/15] can: netlink: add CAN_CTRLMODE_RESTRICTED
Date: Sat, 15 Nov 2025 17:37:28 +0100
Message-ID: <20251115163740.7875-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115163740.7875-1-socketcan@hartkopp.net>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
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


