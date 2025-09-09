Return-Path: <linux-can+bounces-4581-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BAB502CB
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168BE4E70FB
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA9E23E34C;
	Tue,  9 Sep 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="opgr0MVe";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="09fkd6Eo"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66693314BC
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435840; cv=pass; b=GzY98+l21ARrzn1nB7NKq/YyINEilk7hzPR88sy4ISsE2HGmhp8EprUzI4nbaG8x5DEG0gw2drK6r1b4ZAO5lall+iyqX3AcF2DoS0lLWNnMMf+68CtAl5bY7jQqnijBMQG0cJEOnMrw+gAsZnk+9w6OUUOv4QXDdv21DUJzOU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435840; c=relaxed/simple;
	bh=ZpQsYZ1sd4bCoUgi1CHz/Pg3zrWLlTrzpLAus4YUBGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onh8sW5yguh1a9WjcI3Rv3tVRo3liFsXPw+QiJ8by8VsQOeXBjzsytX/4Skx4hBt10IvYB8cTYG4eblAakszEaSYFtY+5vOilwyzT4kXpgW8b5e9V/gvt7c32Eltj0vLRaAAM+V7QOP6TaTgM6bGWvjI75IRH27xvKIkcBRjrPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=opgr0MVe; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=09fkd6Eo; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757435830; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XHJzuuiCQrZLswVVATvBl0GgQ1AwImBW09RbB7KatEloTArNsCQr5068/7QciliAQh
    e8W+Th6doL67m/mb+KJbx7q260px8Bl9Cce4QIPKP8QxVYLS0E89Fvx4kASsRqqeD0lK
    UJ6kCf9ngn1BrxvhbIYuJUufTngs1g83Q4taWYmzPrWPAwtjYr/9PqjJ+tFOlLMNe0CV
    POSzS8VhjomsTd+e87+2WEDkVz2EgJyjJdazWHZvqHBWF/1imknHPN/B+fOTuUvbt/jr
    ncOxK64L2RZx65IlA4ouorglxnIqi0F7goIx22ZCipgen6O86WvkssRwwKA05WRNoTS+
    aUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757435830;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=i4Yz1y24cpcM41mLxsSgh9dAv41sKak2VrQF00RcuR4=;
    b=WOZ2fjeEkkxbzL44eOhS3LxNUt0wPeVRGu4NCI1PkPhJumxY3ol44wo0omTh2WN5H1
    y/1xMhfJFtxKCXrbE+hTGR15tqsFxFyDMRxuZGoX3SpMe2ofidfefh7nymyDHYIjDpKF
    ZY0Yf7y3Af4EE25OqApVDHWUBxfam7c1nOYeGmDEeJC8KcOBywOZ1gfcSpT7i84AxByi
    HiTisnauYwqTZGeN6VJK6Ytv0bHucob7NbHNHCdXFAqW/ejJhAxi2DL3EquUygvSxGUr
    UKkFcH7ojlnU0d02TSFeUMjN6UdNp2GGJUE+5Rc5Fqsflg+QDN5Lpy4xUK0XwsW8otdy
    jH2g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757435830;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=i4Yz1y24cpcM41mLxsSgh9dAv41sKak2VrQF00RcuR4=;
    b=opgr0MVeGUTDf7lUyP/EW6IodVKPSVA0u8TWLVwmjbzzF6O8n/7uDaP2nDNRz834cT
    Jb+POOo0MN05SzRIZVUY3nTbg2/x+Qz1JH0ApQxrzoGtwoLhG9yA9W+NfTOzb1Yfzh8o
    HcZFeOC1eBXKUIbmYSQD0DstwUqal5vI29egNUWrB12UdO1/5/9bic/ActarBpxi+yuB
    wPn7qImv0kzyke4JXB9WKfgOucoKQ+7zSiTX51mta+mhJPBFSK8jMwu0C6d+ikE8QJU0
    nl0Ir7L+tyVv6B16NeE9ja8nHE5UyrnlKX37Cz4fqkHEXARsu6L3vjc8uEcTqwmD1s6j
    Spog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757435830;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=i4Yz1y24cpcM41mLxsSgh9dAv41sKak2VrQF00RcuR4=;
    b=09fkd6EoaMPnLP5Kl0m053dmNagiuvONtwt9paa6/eC2zG9PHQR3+1nu+vJd2WLc3E
    ZMAc+wM0iVSk5ySixUCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361189GbAhPL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 18:37:10 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v6 2/2] can: reject CAN FD content when disabled on CAN FD/XL interfaces
Date: Tue,  9 Sep 2025 18:37:02 +0200
Message-ID: <20250909163702.17755-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909163702.17755-1-socketcan@hartkopp.net>
References: <20250909163702.17755-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The CAN XL devices can be configured as CAN XL only with 'xl on fd off'.
Also CAN FD interfaces can be configured to only support CAN CC 'fd off'.
Correctly reject CAN FD frames when FD is disabled for the outgoing CAN
FD/XL interfaces.

Virtual CAN interfaces (vcan, vxcan) are not affected as they have no such
CAN CC/FD/XL content configuration option.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 12 ++++++++++++
 net/can/raw.c           | 12 +++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

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
index e5e3952b0e09..d9df62e15ba4 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -879,24 +879,26 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
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
+	/* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
 	if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
-	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
+	    (dev->mtu == CANFD_MTU || can_is_canxl_dev_mtu(dev->mtu)) &&
+	    can_dev_ctrlmode_fd_on(dev))
 		return CANFD_MTU;
 
 	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	    can_is_canxl_dev_mtu(dev->mtu))
 		return CANXL_MTU;
 
 	return 0;
 }
 
@@ -948,11 +950,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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


