Return-Path: <linux-can+bounces-4552-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B21B4A7F9
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 11:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7458E7B21C0
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC422D0602;
	Tue,  9 Sep 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ODQEDDdK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pg3xoZH5"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A32D0627
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409890; cv=pass; b=juyNBnJEOCDojk8poKBknsA9SLikgQX6fKdqKKudXGsWAPbnfnSmbq82bCY6wRcp6oCtv7iTQB4RpOOo3NGSmfrbFb3i9mmLNmSjTb93QmJcSTlT/LYiOBxT0enx26ZzXizoaEHTbQcBJOwcsD0T1WyuolQxBckjXEzMLpj5Lak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409890; c=relaxed/simple;
	bh=c/GjTu3Al7txsMD1xXNs3vTLSStM1X2JxBJmkasY69s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5B2hcvOi8uvnk/E5hgUrymgUdgzRK0NzbcMQKFdBjngbPVB/nlUhiRf9oUN3UUHrAK5ZjoG9eDjxR0qjY1NzmSypFGS7ta2DMbDvXwFroJzvBXSh+oahe3X/kxx8PaAj3Q0l0YB3SLDIKTrIPNTVAbObre32STIF1G1vZ+c4WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ODQEDDdK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pg3xoZH5; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757409879; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gPgnW/5zZuoj8XdsRCVkGOsjnZgUwARk+RPu336FLpijbYoIvr78jfodM2ueH9He0X
    EHGN6vkGOinxyU0bbeSFvhloIhpK3UAVrvRF4dsxvbogc8JibRoyJ++jqp39EtNNyEw0
    eOfBzuhGEmi3xVPTPb9FtkzlzAVyHKapI72g2l7Y17jb3YZhoPmJTuCdsCtcC6bSROAC
    wHgGC+4WbyMTH/2AEged2/lCkivIkWtCsG8vSGEScE8etW+PqNV/3jB96ya9SDQrJHDe
    Ptv1v4z7VLnBxRWkaSjNHjALdnrobwL/2pjKooJocS4ug4wZizPiLxvG+oyFB4kB4T1/
    S7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757409879;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I4lTONAQMJP1Pq5z8v3OYlLiggZWW7E7XfM/+z5f4Vk=;
    b=Yr4wjvBktyU0VjXiNhWGQVzm4o4zQ9Klf7QwCisDW47rkeCXs/mY3z9LXP8iMVigi9
    M0lWKjvuYmNDvgq9Y28xdKDaMKdpsaAaMPbKVokYn55UFjlcvEcORuZ5UDA29ovaeqCr
    7Wi282DzB90qApQktWJGezRUS9cyjnPvRyfbbjkuYPGgBy3k3q4cYInmxrUSL2PQlfYJ
    AAZjIpvU+nIhzW/VrsDfb64xCH3sR5SBHUpSdaglYcEHmsaSlQJbvD618u3doXQ7wF9g
    pUSsbpsGB+W5/Ise3dyh5TxDNWxMm5+f85RaKzzoRiPazRuTrZkjQN2yHTL4NO3+8Cx7
    Nx9A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757409879;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I4lTONAQMJP1Pq5z8v3OYlLiggZWW7E7XfM/+z5f4Vk=;
    b=ODQEDDdK3XPrckAFG64VsmaN0ygarwAxxMy1mzceWXU8G9alfuFXtK2x+hm9yCBS7w
    b9xwBTiaGHe01wDtdOUyxRpSD27IDqIoRSJAEoFHXdRhueU/k+7O74Ydm7Ui1+SaYjHj
    6epmJyUzxg2sa0l2yld2zLg/13rUJmlObskHUYiUQUly62KmyQiuIYBrQDA2paF3cNgU
    e1n89wSIeAFhtQ2v5+/IhdV9tyimsLXQ9WkM3+Xg+RrHxyo+kyW781IxceGB2v284vAL
    9I6gy5EbSyoPUCGmUPRflLdiunqHx0/PS0KnDdf88ycB/h7zXf53WYbSGjneqXAJVGlm
    uAAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757409879;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I4lTONAQMJP1Pq5z8v3OYlLiggZWW7E7XfM/+z5f4Vk=;
    b=Pg3xoZH5eIlVsuKKvpkJsNUmrHLXP2DAtGv+bC1yJ3S7Xqzi+eIoktR3PyfFs6Lklm
    s82v9BmMCZdnNkojiFAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611899Odf7Y
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 11:24:39 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on CAN XL interfaces
Date: Tue,  9 Sep 2025 11:24:33 +0200
Message-ID: <20250909092433.30546-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909092433.30546-1-socketcan@hartkopp.net>
References: <20250909092433.30546-1-socketcan@hartkopp.net>
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
 net/can/raw.c           | 20 +++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

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
index e5e3952b0e09..5ff4ed629499 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -879,24 +879,30 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
+				      struct net_device *dev)
 {
 	/* Classical CAN -> no checks for flags and device capabilities */
 	if (can_is_can_skb(skb))
 		return CAN_MTU;
 
-	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
-	if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
-	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
-		return CANFD_MTU;
+	/* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
+	if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb)) {
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
 
@@ -948,11 +954,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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


