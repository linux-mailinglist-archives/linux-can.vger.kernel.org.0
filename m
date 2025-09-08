Return-Path: <linux-can+bounces-4530-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC48B498B4
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA8340361
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0731CA43;
	Mon,  8 Sep 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b2JZVKAH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="he75ZK34"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A731C590
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357307; cv=pass; b=UmAKUuoEgxAmvFqQH1DxuKssu4jzCOucBrIOmCAjOI5tAN6vcaoGA61nGj69VR5hqaScGA4VQbP+iIyPtaiMFGentVR/kp3L/b2j2L6TBbYzNkJmT95+14NTpqa2TiN0N9iXMPdXpMJu8HOmZD031URCbjFQV+YqHPceoNcMBks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357307; c=relaxed/simple;
	bh=lhJvh/iPYOtVs3eMH/Vf4Qy5EBu1Qlt/bKqI909kCws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUHSL5CQkyDWhTR1eyvsOZHfWwNXkmeiaieA+KcQPkTFm/3kjy9Aob9Q0NvkTd93xYNKneG0ixDTlVObx6jbQD7hABb3+1kUXhzaCA3KlsIacD30xjBbuddFaPb4QU9OqNvFO55b5HT7JwJ0f89hXUHMh3AZSRh0/9LlJ8a/Ahk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b2JZVKAH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=he75ZK34; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757357120; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fHfl9IY/Y/lh6FGBQb+MT9S58BFM9X1Qs0st24IJ0Aja239RIYAkn/LQhHF0XMKTH/
    NmmHbcQ+K6jHYBaEZcB/CfJ43v0VqL/A5J7ghyT/2jUsfb9IZMcRhXO37T4IdVLvC1en
    1b6C+7LUsTVKMvdeEiq5enNzxoyY3WnEOcpbooAYH4432DNiNCzqtaaclLlAOZBVRjDP
    ENXv5y9NKBtfYxwhfFdVOBabFumlXv0E4BuHeAcMv9KlJyOqpmtc3Yj4MqNUmUqccVJu
    pdweeB5G5sKhYDZ661LJXJrD0OoxfL3VhvuNRHxdlQxew6+7mM92XitD1V4WDyaCmsdn
    Yksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757357120;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uzKroalcT75u1j3YRqTHLCv9W1K7kqp76cYE5ekCCT0=;
    b=UrwKlXPrrHj/UWVsZtlnA346/QQZzJ1PorMdxUI7dgKI8czIvaPQo2WjIyNokegSGf
    hLyxw4zfqbQSwuwfuUnFuis8FFZxOMIWXUynCg0FKbqODiZraAokAbv//NH3HxgEo69I
    NNhjVO/PTGoPq1Ixj2HIaJbrTCpr4U8fOSqAygS4bNtiVpQQD9RIIDa/RJF8UUwCV3mE
    wnSvwaloeB8mpwtsIpGUgTka10OFPyUse1xBu/igxx6e05O42msg/xnOsiFTHRl3c1QS
    r5vQ6KuP9x96f1/WKvOcQUmaws5IyxQffkPJxfP3xyJQygd8/t07iiZ47rvncY307Ek3
    f6wA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757357120;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uzKroalcT75u1j3YRqTHLCv9W1K7kqp76cYE5ekCCT0=;
    b=b2JZVKAHEqUlGtL/ol/ITFBiclJaJ1WmjqKSMKrFhdW9ozn1o9tceg6W65xeuQvzNY
    XkItLT+gc2WLP/oGaS2tVXKdrndOJ9xsq8ftlfz4ytcCaSYZaX2OdJrr9F8brHSA+ZfD
    bC0+PZeJXn6aEvZvPQD+g0t02ZHqQM8hLa7JxhiLs7TMu8redjc3AKNIU6ahqK4/qota
    9QfaOYdXstCG9QymA/bjBGucKw3kG4lj8lBxtWmQVHSn+9HJhUQ2c46TOdUw5q5qaJPj
    S5vyw0ub26ImDZTIz210TsmsySpl5qrxxWzzuaE6yyuSZM0ui+ZGU6CTrI9jX81P7Kzv
    i8fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757357120;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uzKroalcT75u1j3YRqTHLCv9W1K7kqp76cYE5ekCCT0=;
    b=he75ZK34g7PKKIeE1sa4Lu6aHAeFjf4shsXK0Iq4rKvwchRqENzcmEplgaQziP+EaE
    UtHWNG5Mit6ZB/qDTcDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361188IjJbQW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Sep 2025 20:45:19 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v3 2/2] can: support XL only content on real CAN XL interfaces
Date: Mon,  8 Sep 2025 20:45:12 +0200
Message-ID: <20250908184512.78449-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908184512.78449-1-socketcan@hartkopp.net>
References: <20250908184512.78449-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The CAN XL devices can be configured as CAN XL only with 'xl on fd off'
which is currently not supported as the CAN XL sockopt on the CAN_RAW
socket implicitly enables CAN FD support.

This patch removes this XL/FD connection for real CAN XL interfaces and
rejects CAN FD content on CAN XL interfaces with 'fd off'.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 12 ++++++++++++
 net/can/raw.c           | 32 ++++++++++++++------------------
 2 files changed, 26 insertions(+), 18 deletions(-)

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
index f48b1f3fd6e8..6cd1f9cb050d 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -558,11 +558,10 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	struct raw_sock *ro = raw_sk(sk);
 	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
 	struct can_filter sfilter;         /* single filter */
 	struct net_device *dev = NULL;
 	can_err_mask_t err_mask = 0;
-	int fd_frames;
 	int count = 0;
 	int err = 0;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
@@ -698,33 +697,25 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			return -EFAULT;
 
 		break;
 
 	case CAN_RAW_FD_FRAMES:
-		if (optlen != sizeof(fd_frames))
+		if (optlen != sizeof(ro->fd_frames))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&fd_frames, optval, optlen))
+		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
 			return -EFAULT;
 
-		/* Enabling CAN XL includes CAN FD */
-		if (ro->xl_frames && !fd_frames)
-			return -EINVAL;
-
-		ro->fd_frames = fd_frames;
 		break;
 
 	case CAN_RAW_XL_FRAMES:
 		if (optlen != sizeof(ro->xl_frames))
 			return -EINVAL;
 
 		if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
 			return -EFAULT;
 
-		/* Enabling CAN XL includes CAN FD */
-		if (ro->xl_frames)
-			ro->fd_frames = ro->xl_frames;
 		break;
 
 	case CAN_RAW_XL_VCID_OPTS:
 		if (optlen != sizeof(ro->raw_vcid_opts))
 			return -EINVAL;
@@ -879,24 +870,29 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
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
 
@@ -948,11 +944,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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


