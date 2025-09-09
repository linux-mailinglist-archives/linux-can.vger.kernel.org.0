Return-Path: <linux-can+bounces-4548-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27560B4A541
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 10:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F48165495
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E623C8C5;
	Tue,  9 Sep 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KKHVtZe0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nuIsxy9v"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D82405E3
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406475; cv=pass; b=JavOXljTbvkVBNCbr/qUY8n272oOeUdiM2fZnZGsygQX8RVq9wjXlOoG1aezNKgSnaMF4s5j37YzDCbJKOXFIRDSWi8XjJVYRWgAJV/Q3RCjkD3iHKQZN7IUCMCL7dJzY8OpX6XSvubJx8pHw+6SsnLT3W+286RUdYQX0rOwjfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406475; c=relaxed/simple;
	bh=RmuzQTi82vJwFu0qZxf+murmblq6z9ZpILovD6qKEgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDopVR4la90ftOvk7wB7Pn3/G/3APVdRCTsP39OeXo7+4vBkSg+KLiHFAysI5jai0zJ5LlktV2GxaElKOdbeMSF8CcgNyBHBVVgRYZgZOlJMbPONVM5qx+a1zuIWDdCZu9xNhKvvZ2LcU2pnos/dN6ayYp6iNxMOJIAsUjv+00Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KKHVtZe0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nuIsxy9v; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757406463; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I4jXwXznE4cWiL3p0YxauhiIXR+Y5wtf4RmRotKcou4p45FPU1KcomFoamVvvEypHh
    Mbw6qwDvzZq5QGKv9PGfmkgl8SAFvwmBmrXF8i0LlPjx4r+68lZUtKxpVO2lMJGDqxhL
    HHEcg1xHWpRb56Q/Nc5veLdpcXlbGEa1cVWBMRw8we/30AzsmfGTyQ6ER1KBjtJLZJKF
    oemJ8/OBV5zScDyS9+claRu+pFpkE2JG6WtSq8Ax+58nI9BfQT12KCSiIzkTTl0T7g61
    cjRgsPlFntQfFN0M5dL82ysYJOPUcO/RXdfRIdFWQ4RpnF9splo6KpK5HJcovASFMme7
    OX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757406463;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CfSZyIFJmLJDZoKKVomM79/4/aT26ysd/GI4rNeafao=;
    b=Rt2LWAlb/9AweAycwh599qDBvZIEdsaWh357OH/ZoOQ4v/P+wikUEGF8EDkT8HT8Af
    INVlFnfDP5+mWfei21MU7U113OHxcTpltrIH2Gu14UpHf2sMWsKWZbAB5h4Z/BbnKGbO
    sS/eqaox/bhuMMElPn/ZoQWm0uUGhOvW1ke1fvj69PK6Bfu4K5Q4rHJ4Bl/cf2AGqPqT
    nkvoBtY51FUCwgs1/LqJ5oHb8PefIaSlExbwD28Px2HD5DIlOrBsk31ivh/5/e962CmC
    JRrz0Z6Opm2gK01deSPMY5RCo2zvVOjDI5zCi4/HBGVanFJVMidvfXm59m/reLGXwm3P
    JLbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757406463;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CfSZyIFJmLJDZoKKVomM79/4/aT26ysd/GI4rNeafao=;
    b=KKHVtZe0xj88htxvynUWhH2eDNUXx7X66mwd8ND0Ns5q+eFWp1p3LTKmpCCgnliITk
    K14C0tHkmzm8L9q5O/r3ziNWWcPBa051NgpQT7Qi044N9fm7PK7QdPRuh+5MvzXkXgTa
    LI0OpTvvbv6lApMB4LgBWQ6Cab1Sk8nA+G7KkMdR/SiQiQweVInpA58G1kJEtEjSZq7A
    e8zNUwEK5RYdq/SFYVrOWtojKrAeVglMqwOUC4DiC5ytDDkddy+MUz2mJZfuzjPrDMd5
    MvUzvZc6Qmx6oaCuXGTjKmH11TW3qbzw0ZVLfODu7JRoOmGWPX8hc/jumQxyxXfRBmMo
    FHTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757406463;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CfSZyIFJmLJDZoKKVomM79/4/aT26ysd/GI4rNeafao=;
    b=nuIsxy9vqKlW4enUCeggAIGow/mbwm5nNvpPZn/SBYQp86MKtnHwKwzKU2o+ZxsZTV
    /uyPBePN4ZfJHurdl/DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611898RheYk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 10:27:43 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v4 2/2] can: reject CAN FD content when disabled on CAN XL interfaces
Date: Tue,  9 Sep 2025 10:27:36 +0200
Message-ID: <20250909082736.9912-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909082736.9912-1-socketcan@hartkopp.net>
References: <20250909082736.9912-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The CAN XL devices can be configured as CAN XL only with 'xl on fd off'.
Correctly reject CAN FD frames when FD is disabled for the outgoing CAN XL
interface.

Virtual CAN interfaces (vcan, vxcan) are not affected as they have no such
CAN CC/FD/XL content configuration option.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 12 ++++++++++++
 net/can/raw.c           | 19 ++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9a92cbe5b2cb..9fa139cc793e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -183,10 +183,22 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
 struct can_priv *safe_candev_priv(struct net_device *dev);
 
+static inline bool can_dev_ctrlmode_fd_on(struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+	/* check ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_FD);
+
+	/* virtual CAN FD/XL interfaces always support CAN FD */
+	return true;
+}
+
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 int can_change_mtu(struct net_device *dev, int new_mtu);
 int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
 int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
diff --git a/net/can/raw.c b/net/can/raw.c
index f48b1f3fd6e8..9510a4f8cd6f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -879,24 +879,29 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, struct net_device *dev)
 {
 	/* Classical CAN -> no checks for flags and device capabilities */
 	if (can_is_can_skb(skb))
 		return CAN_MTU;
 
-	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
-	if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb) &&
-	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
-		return CANFD_MTU;
+	/* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
+	if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb)) {
+		/* real/virtual CAN FD interface */
+		if (dev->mtu == CANFD_MTU)
+			return CANFD_MTU;
+		if (can_is_canxl_dev_mtu(dev->mtu) &&
+		    can_dev_ctrlmode_fd_on(dev))
+			return CANFD_MTU;
+	}
 
 	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	    can_is_canxl_dev_mtu(dev->mtu))
 		return CANXL_MTU;
 
 	return 0;
 }
 
@@ -948,11 +953,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto free_skb;
 
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, dev->mtu);
+	txmtu = raw_check_txframe(ro, skb, dev);
 	if (!txmtu)
 		goto free_skb;
 
 	/* only CANXL: clear/forward/set VCID value */
 	if (txmtu == CANXL_MTU)
-- 
2.47.3


