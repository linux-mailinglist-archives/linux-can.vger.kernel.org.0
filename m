Return-Path: <linux-can+bounces-5679-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B71EC8938D
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3200C3B4F5A
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8182FD1D9;
	Wed, 26 Nov 2025 10:17:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C982DF137
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152222; cv=none; b=fuImt8qH7N1m63JAbacD3pW/pgazwdXP7520Sg3lsYgJzSBLtU3bz2eQiIKIUqZEn6LXKtl3k6gOATSNMgSoSW+wLHF5iwIS8jKNsyUih29jeSRrt5U77dF2h/Ol1GO93LaOficJ3pvn3NKRdhdhJCSEN5JkC7bKKXbNMHH2qLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152222; c=relaxed/simple;
	bh=MScOCfDrBIGGLEV5Z/jnAJ1aO10K3UXaIkiluDN85BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rD3GEiyYUR4aG4ThHs1MDzWryQxaavmm1SIgScnYBLa58hdbkwjpXnc+croqsCmWw6s7EenRTOB+3KHTU7G9auh1jPIMrQHK8V7UVcVPDGn10TDWLrUzDczl8gx9Xwa+wRas5dpMo6EPlTrP07N7CKgitR+rKvAm4kYu8/YqfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZw-0000SI-Cx; Wed, 26 Nov 2025 11:16:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-002aTP-26;
	Wed, 26 Nov 2025 11:16:51 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6D4974A88E1;
	Wed, 26 Nov 2025 10:16:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:17 +0100
Subject: [PATCH can-next v8 16/17] can: raw: instantly reject unsupported
 CAN frames
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-16-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3205; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Y3SasBv/Q/I8DywbkyCugANDFbbNJUqqKc8k6Nel8BQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtOOq5kZGxHteFMg9Lyl168pclqxvKiaKm5pW
 KamL14NMaqJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTjgAKCRAMdGXf+ZCR
 nJQJB/9eIG1wvEaC+swgxtejg1VpYunET3OFhxULKYEiWQayN/CEfVfsr3zRZzroLDEkMfYpyqb
 ZrSyNP/co2DDCqMke+j+xqwGer38ndChMyGeh/UjXSuXbYTQi4Bg/Q8v+Ncozctz2qj5UOmL7K+
 Kg4pqA2ZNKDW8R5gXRQB7JzK9wuhmM18zIirlj0MeoxtqWuVHSb9GLCDL/BlPFj6KAbvKWJl7uB
 Qx1X/YyQy9IanvZDHrVLUU5gsuex1a+lTrnjN2umnCDDQPxdqgDV34jYd0ONAaXg1oUAtzimD7W
 /ev8r8Omp6x6NHrgpfoAlAzi+pYl8BuotetsQ5KASMzTD8w7
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
modes indicate whether an interface can handle those CAN FD/XL frames.

In the case a CAN XL interface is configured in CANXL-only mode with
disabled error-signalling neither CAN CC nor CAN FD frames can be sent.

The checks are performed on CAN_RAW sockets to give an instant feedback
to the user when writing unsupported CAN frames to the interface.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index f36a83d3447c..be1ef7cf4204 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -892,20 +892,58 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
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
@@ -961,7 +999,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
+	txmtu = raw_check_txframe(ro, skb, dev);
 	if (!txmtu)
 		goto free_skb;
 

-- 
2.51.0


