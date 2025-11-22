Return-Path: <linux-can+bounces-5603-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A114C7CBEB
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C178C3A8AA1
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16B2F5A2E;
	Sat, 22 Nov 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r8riVmhn";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yojfKliZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB62F068E
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804189; cv=pass; b=JTTaoMqpt7oTB1Dtb9o14N7ObED2v73fwTSMjSzqAcE1peiXbii5XTTdTURzeIVhUuhwkg2fGT2jX9NMWY6xVO8iLsC7IqzarqcduUhmUyMLxrDInrt+KqlvoMZkklZZWK8woamTu7wsj4UFiKIPn7+5RoSfQfmOAftEXMwI+iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804189; c=relaxed/simple;
	bh=ghxRWBFxKY2bRYxxxgWUBrRR3zijl8/9vgkJ+H9GwBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4jEb8Ei10ryXm2q9vvhGJUs+EwYP2e2RNpygjHqMu8v8rX3mhgD9rf00mfjOI2h843lEbDxIzlofmBxiqX5KH5oVx6/B1LXnWNKTfmrB4yarcq9Vot7hs3b8vPLO/EJ4rDFKfIApUGAMHmFhXoVQRo+dASdXexM96d7pTRce1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r8riVmhn; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yojfKliZ; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804169; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KH/XH0hePIWW65xyVq/jkpdMy8BVK52LD5zpEuipjR+w+uc1gUaAibJD4gZ60w0Bgw
    5OEpLL2fAGW9X2nPgP/6dqS4e3KQRxefuW70Pc62jjHzivnP89is5OMpq7PpqSVz4uYi
    rJs0xX9MMA0nNLYCxp0w5zDHT+NWf8MxIgdbttfCssS2G91My13809GO+8AY+5c7KWoN
    rnrx+lCv3OGmT9X9bPieaFq+Yic9dzXX2xbJhBUEb1q/Wx/Tjgu4J47+hrM+xNeUSoLw
    mBU2YSf5ywZ/3GdlCDATE8c7WjIOrPhedQCMQvUQa2SrIfRixtWvP4gJnjG46blkl+LW
    hEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7EX5Gsm9RJpiqku2bbQXHYhKAolW4ebdYYaVHUHDP9c=;
    b=PCCovUOjlgKBxGbofvLalDKa+aLVhUHjcDmo6/vDxagiNhTJKaOmj4jEDeDG9Z+FgY
    1cn/rWw++OFEvAAFT/nIMi9IihkaBlu3w5v01J48K+gN9o/U7v+DGfY0EgFtlB77z+Ak
    L0hZSZPj6qxkRsDmzYlimHtabWjFZ92VZzt9rfBUlIEWQ6/RDA+tleth7XnvUWAztZM7
    Xut/3Xy2XhjX7Lnn3UpUDb72PXE+RJaPDElYOlgqP3qaY4UrGqN0kGBxXoJ/NijeRElh
    t71f6jT5ZOgRp7hZAhwGrS7uOw/N0RoU5SwCE/iCyS9aBkNpZL76IaDjAHGBh0lTupxR
    DwiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7EX5Gsm9RJpiqku2bbQXHYhKAolW4ebdYYaVHUHDP9c=;
    b=r8riVmhnux488+OJMdPGLNsmO8RjDsIc4PNV/nWbSht2KRmKW3vxjgX3IIGiW5Mpod
    GkEu4D/QwZ7Sqk7xDT51rvGUk0yrEmgK1RcKW44bA3ytHPpNPE0XJydsyxt2M3TwwL7s
    GsdE04r+JLmfDlvLda/yEaDRiCnm988KX4aGn1Bou0I3IDUIeC63pLPQXbnRxvII+B3M
    Mx+H1tx0Q63PSx+R3/DXgQsQKzcoSJyKl/uo5ZXRBcF7g3nx49E2ohfBnVA69uvMSMX+
    +upCIe3SSVk+u2trmlrP4FYkabtlWoLR8yTpQY+PECILaMeb0ANHu/eFn7QhNIaSKxRc
    guzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7EX5Gsm9RJpiqku2bbQXHYhKAolW4ebdYYaVHUHDP9c=;
    b=yojfKliZzOWjdLlmAjE5FaIBztFJjEJgyEG9/th8htvdgxASoT4nv0g6i+4EEWjHhP
    cLoRUUrI6EibYQOZI2BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9a9Fdo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:09 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 04/17] can: netlink: add CAN_CTRLMODE_RESTRICTED
Date: Sat, 22 Nov 2025 10:35:48 +0100
Message-ID: <20251122093602.1660-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
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


