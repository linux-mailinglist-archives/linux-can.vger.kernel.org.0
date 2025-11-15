Return-Path: <linux-can+bounces-5427-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A564CC608B9
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73B1C4E5371
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE12FD68E;
	Sat, 15 Nov 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RQbIKx8g";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1UO5nEJw"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8023BF8F
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224682; cv=pass; b=ql3Pes5HDd7UKUPA3BX8DXLHPens1UIDcpqlAC1aCJQ/JJEalJwFXS4HKaqDZqLqSRXFKTXagNw6lB/cCVhwP/pJy+PuKLpetIE96E4FXY5eEBsQ6UI+cRD/zO2Dk4e1ND86Bs5OQwQXkCzT+/Bzui6DBCZpTlA38X58+xHFhfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224682; c=relaxed/simple;
	bh=nKb8rv2lOZolhnl18V9lPJZC55QIQoYwqlTb8eq+AEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fStGlyZ9v8/OQ1LWirK5MmUdtSlHhdFZkfFbe9vGH7nTlzuAEgleRI/lIyFljVdlXQdWFYsi1iJtczww6fod8uPq+tJX7MOVUxT3IcIrmHNDsCK6x/SwdUHk+XdKi8V6f89vw5ewxaudV3f+WJ4r6hc7zix30Z1sUsisAZFfVnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RQbIKx8g; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1UO5nEJw; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224677; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GuCBmtK2qw+m6Jwh+Xo6uemWqx5gdtk4OMoZJFMA6xz8NQ00j2xfMzGimxoeEfWewy
    U90ftqlXmOipf9/Vl2dUhjWmMhLq0t5ryL+0ynyJk/DT+BvQIq/3dXiAsNxvxr42fZHz
    gEbcJymTNd6wj6ldVxZAEHQYCjBUxxf4/6mUb0RRgDf3GijyqZ4NW0S+SeKE+6ytkXrM
    1OJOgkON8SmNKwLRGS+/xqaXazd/St6GRyRi0QT+n1vqb/XqIX7tMNK2desHMN64EAK1
    0WwTYuPlfUu3+ri5BsVe5BKQBi9a4ynfvwu48gHh3LO5ZraHs7YZW6NPC6RbEBQ0mn1p
    ItKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224677;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pbj1yoQIeYF/uVG0rF+2jU+s/BQlu5rO/4DLMsB0vaY=;
    b=p7oj+9fU3uA/ZBjpgGvKXt/tLGtGpoMcrooYlloLduOSXudStUTgykwtNlnIt5FENw
    AKZHNPYygQRb5KtmCdnsLyywwYwZ6kPb/NdkxTsjNwzsHQtbRsjGnNBdFooXVVV6bURb
    najTQKug0ozVCF3Kb7lUQhMvP9iF+qQC9ED7KDLK0odfMo67i3AG1T6VeoWmvPRc2Ak2
    pxz2bLJ1fOIkHk9kk1cDdGRPABKz5NHHr7Ctyq6BFL393Mjx2HSgSDZ3Nbtmf+ckAIV/
    Kv6RpQHTZ3t4SRIitRZ6hxZn9RDD00GADHl4QR0IJIY+Oq5ea2di1HjVtU8lrvnrGi0D
    F6zA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224677;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pbj1yoQIeYF/uVG0rF+2jU+s/BQlu5rO/4DLMsB0vaY=;
    b=RQbIKx8giDQx5NTNbFttH5CRLOW0IHNCBJGenaCNLzXV9dGzCDKFiqEJI2DNAq6Nsp
    OBMI58lEwRMBYo5HdjzRdUqsD8WJ3wE+5KSJA+fCnLX4cELzuUu1bqyLC86kL278JRjR
    lBZ2Xngx7j6sr0Ao4/rkRZDVfSvjqvArvUMWqX5cnKlEcb5e+ojv1E5/qjXNs8QSfFKE
    guIINi2Ny7H6DqRWPz+XicuRQN1CRmnoKBQ0AcJ/lDV5dwx2mkIOFZfmGtkV7h9Ys0aJ
    PNVSGEd9SyVnqzJ7BWlzQP79Ar8dZ1zRtoGsKmPZgDcR5OOXre9uTBK1VcM2Qj0396Fw
    jBHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224677;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pbj1yoQIeYF/uVG0rF+2jU+s/BQlu5rO/4DLMsB0vaY=;
    b=1UO5nEJw5DlHHUT3BpO5MwzYwAVVPl93PWwd9HY55e984jV3OeoGeFlz3rWK0U3oS6
    OyYYfffxmwYGoTkUglBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbveQy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:57 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v2 15/15] can: raw: instantly reject unsupported CAN frames
Date: Sat, 15 Nov 2025 17:37:40 +0100
Message-ID: <20251115163740.7875-16-socketcan@hartkopp.net>
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

For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
modes indicate whether an interface can handle those CAN FD/XL frames.

In the case a CAN XL interface is configured in CANXL-only mode with
disabled error-signalling neither CAN CC nor CAN FD frames can be sent.

The checks are performed on CAN_RAW sockets to give an instant feedback
to the user when writing unsupported CAN frames to the interface.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 54 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index f36a83d3447c..be1ef7cf4204 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -890,24 +890,62 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static inline bool raw_dev_cc_enabled(struct net_device *dev,
+				      struct can_priv *priv)
 {
-	/* Classical CAN -> no checks for flags and device capabilities */
-	if (can_is_can_skb(skb))
+	/* The CANXL-only mode disables error-signalling on the CAN bus
+	 * which is needed to send CAN CC/FD frames
+	 */
+	if (priv)
+		return !can_dev_in_xl_only_mode(priv);
+
+	/* virtual CAN interfaces always support CAN CC */
+	return true;
+}
+
+static inline bool raw_dev_fd_enabled(struct net_device *dev,
+				      struct can_priv *priv)
+{
+	/* check FD ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_FD);
+
+	/* check MTU for virtual CAN FD interfaces */
+	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
+}
+
+static inline bool raw_dev_xl_enabled(struct net_device *dev,
+				      struct can_priv *priv)
+{
+	/* check XL ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_XL);
+
+	/* check MTU for virtual CAN XL interfaces */
+	return can_is_canxl_dev_mtu(READ_ONCE(dev->mtu));
+}
+
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+	/* Classical CAN */
+	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev, priv))
 		return CAN_MTU;
 
-	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
+	/* CAN FD */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
+	    raw_dev_fd_enabled(dev, priv))
 		return CANFD_MTU;
 
-	/* CAN XL -> needs to be enabled and a CAN XL device */
+	/* CAN XL */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	    raw_dev_xl_enabled(dev, priv))
 		return CANXL_MTU;
 
 	return 0;
 }
 
@@ -959,11 +997,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto free_skb;
 
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
+	txmtu = raw_check_txframe(ro, skb, dev);
 	if (!txmtu)
 		goto free_skb;
 
 	/* only CANXL: clear/forward/set VCID value */
 	if (txmtu == CANXL_MTU)
-- 
2.47.3


