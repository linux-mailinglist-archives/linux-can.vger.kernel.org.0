Return-Path: <linux-can+bounces-5756-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FBC904C8
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 23:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18623AAB03
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 22:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412D2264CF;
	Thu, 27 Nov 2025 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="c064vL0G";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DcJFnJkp"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F62AD37;
	Thu, 27 Nov 2025 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764282776; cv=pass; b=evl26T7MTJffyG5HX1xoH7tPn05P0IRDpQdRT1qGI/tL62EuxSDyVtLOu/mV4EOoXyzrrloivwW7imTUbQrV2AW/h08iuUx+Hq3/+FcyX0bIp3ZEHY18KihuIGwfIHqiAxgrK9gGLICS7XqjJTFVTqKBuz11sXaKaJLLTRFiwt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764282776; c=relaxed/simple;
	bh=Fq33HfNND6G1xxJXqjOm5at2w4I4Ie6isCNy8BB0R74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tLp5reuWCmXYwyuqhMGb8fVz29DIn8l4a5SEOFTTKWKK5Mw53+xPkD09F6DQfeh8EgPugValTtzpyHunXuG8UIljuBHKNHPzKzRejFJJzluYmLoIk3ZEYeAgJGV+rwWlxjRHEAcbLJLqCES3VYjaXEvCDPtgqI8dhp27tlJHSbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=c064vL0G; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DcJFnJkp; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764282756; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QOkl1VxvSNMS72DK+qx/hnxhCERavGRB0rti+lfAImuVRKBOBfPbBo1FgBXXsaca8p
    4zg2Ur/4kRMelC9mmo+khHvY+bZ0VxCWYFfzT7yEHaBbfYx7QALVJ4bbPj3Ve8o36eNh
    +cLERjy+7bZkelV1u+yPbiHgCFQhnyPamK5/Z2WFDHtaFv5ceXEzAX1vYFvlwisc1+9w
    Uhe1KBE4TSndlugI4mD5RpT/aKvu1XuN5P7y4XyfH5qMXRuY/tNbNGXAhr8Hyr8FuKot
    F/X9IMCi6PvIb60ilUCN0rGotPMEhGIkDYpVoV6uLCbJ7ixEA0CiDw99reabHn/gKmlS
    FnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764282756;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=r1AiexZ+ipNQk9X6+TfKeVlGKEbFrXMA4XPpeRseuH8=;
    b=BbO1+dsOXmT/H2f9nKiM9OPKeCPqBuIdI8tuOvdwFiKLoLH4HSFRCfYEX8zJcYhkZl
    isnwJtvbkMgy4IInmpzLnfw+uFfHsE1Xr6FTDYHbL2UiwztL9b2RvYEPBTKlIunosa6F
    +baIjM07ItKtDOkstEJinSg91kVnAZm7RaA86oJQxGW93lpD9lfaPsnvBfk8WRpw1/A7
    rlO1tIausBunXKUWSEQjkuCiP9aF+CTM32DvIQ3yUVu1/uTTlbWzIZg+3V8GzBoApS3Z
    0sli4cYlqdwq8zMxDNMT314hr92xZNzxS41TWRUSi0Z6+o/Ktl4b0d+mMaOlcpsQKvfC
    RBQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764282756;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=r1AiexZ+ipNQk9X6+TfKeVlGKEbFrXMA4XPpeRseuH8=;
    b=c064vL0GSM0eSQgSbEYF9qfOCY4wgtYFuJY0bejReJwCz2ZogE3uibo8mUihOWf2Bf
    Bsmhshn53QHV9xVibP04afQ2eqdJAiYVP279yGmVt9GPAbXFs1GyX+pEJ8RPcNI+JUjI
    TlsrT5z7acPAIi1m/HBWEbMgZ1xsB9Fbm2oUXAinMP1oBQkvHkmp9V7cNnll6RYgQlaO
    A4rlpuyGA1EvFqBK28b45Qn33q4eyaQo0HLCc/gasaxRdFrRTP3POtpM06Ou5ZH01LvA
    Cy7lQTdv2c+72aU1StW5Y9skOosC6Q6RFD4JznA/KhTiZWwX0etuJY25PDtn+aYGzvha
    t5vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764282756;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=r1AiexZ+ipNQk9X6+TfKeVlGKEbFrXMA4XPpeRseuH8=;
    b=DcJFnJkpwTTO4MNpaDbs4JMbceLp/V+8fziTwwx2WYPfuDCXV1l93OEie8uqoceEIW
    Fwrw8JLLsniMI+6dAgBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ARMWZdHv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Nov 2025 23:32:35 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	kernel@pengutronix.de,
	mkl@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [net-next v2] can: raw: fix build without CONFIG_CAN_DEV
Date: Thu, 27 Nov 2025 23:32:26 +0100
Message-ID: <20251127223226.59150-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The feature to instantly reject unsupported CAN frames makes use of CAN
netdevice specific flags which are only accessible when the CAN device
driver infrastructure is built.

Therefore check for CONFIG_CAN_DEV and fall back to MTU testing when the
CAN device driver infrastructure is absent.

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Reported-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

v2: use #if IS_ENABLED(CONFIG_CAN_DEV) instead of #ifdev CONFIG_CAN_DEV

---
 net/can/raw.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 223630f0f9e9..ccd93d3a6115 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -890,62 +890,66 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static inline bool raw_dev_cc_enabled(struct net_device *dev,
-				      struct can_priv *priv)
+static bool raw_dev_cc_enabled(struct net_device *dev)
 {
+#if IS_ENABLED(CONFIG_CAN_DEV)
+	struct can_priv *priv = safe_candev_priv(dev);
+
 	/* The CANXL-only mode disables error-signalling on the CAN bus
 	 * which is needed to send CAN CC/FD frames
 	 */
 	if (priv)
 		return !can_dev_in_xl_only_mode(priv);
-
+#endif
 	/* virtual CAN interfaces always support CAN CC */
 	return true;
 }
 
-static inline bool raw_dev_fd_enabled(struct net_device *dev,
-				      struct can_priv *priv)
+static bool raw_dev_fd_enabled(struct net_device *dev)
 {
+#if IS_ENABLED(CONFIG_CAN_DEV)
+	struct can_priv *priv = safe_candev_priv(dev);
+
 	/* check FD ctrlmode on real CAN interfaces */
 	if (priv)
 		return (priv->ctrlmode & CAN_CTRLMODE_FD);
-
+#endif
 	/* check MTU for virtual CAN FD interfaces */
 	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
 }
 
-static inline bool raw_dev_xl_enabled(struct net_device *dev,
-				      struct can_priv *priv)
+static bool raw_dev_xl_enabled(struct net_device *dev)
 {
+#if IS_ENABLED(CONFIG_CAN_DEV)
+	struct can_priv *priv = safe_candev_priv(dev);
+
 	/* check XL ctrlmode on real CAN interfaces */
 	if (priv)
 		return (priv->ctrlmode & CAN_CTRLMODE_XL);
-
+#endif
 	/* check MTU for virtual CAN XL interfaces */
 	return can_is_canxl_dev_mtu(READ_ONCE(dev->mtu));
 }
 
 static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct can_priv *priv = safe_candev_priv(dev);
-
 	/* Classical CAN */
-	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev, priv))
+	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev))
 		return CAN_MTU;
 
 	/* CAN FD */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    raw_dev_fd_enabled(dev, priv))
+	    raw_dev_fd_enabled(dev))
 		return CANFD_MTU;
 
 	/* CAN XL */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    raw_dev_xl_enabled(dev, priv))
+	    raw_dev_xl_enabled(dev))
 		return CANXL_MTU;
 
 	return 0;
 }
 
-- 
2.47.3


