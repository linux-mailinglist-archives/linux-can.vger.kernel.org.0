Return-Path: <linux-can+bounces-5673-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0EC89375
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E616034A4D6
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773982EB5A1;
	Wed, 26 Nov 2025 10:17:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCC1448E0
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152221; cv=none; b=U07Fc/aMQdLiZvi9GYVFGwVmDeFbtx7/y8QtaX+OM0BlcU14wuMF67CcYzZw5uk8u/PPz1oKl3TY6p3o1DzXBgKcwX7Q14TBhnecQyj9PF8IpQDNvQ0v6utHN1PPApVMhoBrXk0NuyPJIFYDteH3cYU8ty72d0451xPg0rdqYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152221; c=relaxed/simple;
	bh=nairXQ9rIPW+imcD7BjKitK2BHOOiL01JpUuX5MLgc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OnDFU7WqyhCHPiF6Z3iA2NRxxwKz1V9hj4yZvQuhCw06cWRgBQ3kSvSq+avVKsVpz2ggBWb8JUet6VNeR6ViRO4aggxrPVuHJ1qi/HEnvBL8T3wgR11GS6mEJnYvgdzx2dQ9tJhblBpq4E+5CCzgcvAGHbsU7aaWS8xkfIkTBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-0000Qx-H4; Wed, 26 Nov 2025 11:16:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-002aSl-0Q;
	Wed, 26 Nov 2025 11:16:51 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DAA584A88D8;
	Wed, 26 Nov 2025 10:16:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:08 +0100
Subject: [PATCH can-next v8 07/17] can: dev: can_dev_dropped_skb: drop
 CC/FD frames in CANXL-only mode
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-7-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2650; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+xs9GjCtM7BOsuxCHzohc9NNywqTNpj79PW2gV2riAI=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtN+zZfLLPlMTzDKzV20ZAJ0kIkZrI3lIRS8x
 TRMuOoVHMmJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTfgAKCRAMdGXf+ZCR
 nJPuB/sFg0o1dDoDJA2av5pFNPf57YuKrcX4DrUNhGigx950d9v1Uz5aflCDKUzoE4RzgcjtrY/
 1PzpWiYT+juf71gqFziQutyda5/47lhjGopd/3zSObtwIdfob/+BUesHSMN4gauCdkW7i6B7fFj
 +Mmbh1MxMvtf0Yfwg5b5t2xNUpgRevyM3QbOTGAReotaHQRH+anHJMXOINo2lK4fjpKyO27JG2G
 iWg/yM0okLABdMLHsc4jySTi8DtSKaC0Y+xa/j4/reDkZKaSDtF6yh6JvvQKmhRIuq3Mgjjfwgz
 Q9dhGN3YafivRo0N2XGwfMqoJStUAb7+NofZc5+QJwJ+/IhG
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

The error-signalling (ES) is a mandatory functionality for CAN CC and
CAN FD to report CAN frame format violations by sending an error-frame
signal on the bus.

A so-called 'mixed-mode' is intended to have (XL-tolerant) CAN FD nodes
and CAN XL nodes on one CAN segment, where the FD-controllers can talk
CC/FD and the XL-controllers can talk CC/FD/XL. This mixed-mode
utilizes the error-signalling for sending CC/FD/XL frames.

The CANXL-only mode disables the error-signalling in the CAN XL
controller. This mode does not allow CC/FD frames to be sent but
additionally offers a CAN XL transceiver mode switching (TMS).

Configured with CAN_CTRLMODE_FD and CAN_CTRLMODE_XL this leads to:

FD=0 XL=0 CC-only mode         (ES=1)
FD=1 XL=0 FD/CC mixed-mode     (ES=1)
FD=1 XL=1 XL/FD/CC mixed-mode  (ES=1)
FD=0 XL=1 XL-only mode         (ES=0, TMS optional)

The helper function can_dev_in_xl_only_mode() determines the required
value to disable error signalling in the CAN XL controller.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/dev.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index f15879bd818d..52c8be5c160e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -135,6 +135,19 @@ void can_bus_off(struct net_device *dev);
 const char *can_get_state_str(const enum can_state state);
 const char *can_get_ctrlmode_str(u32 ctrlmode);
 
+static inline bool can_dev_in_xl_only_mode(struct can_priv *priv)
+{
+	const u32 mixed_mode = CAN_CTRLMODE_FD | CAN_CTRLMODE_XL;
+
+	/* When CAN XL is enabled but FD is disabled we are running in
+	 * the so-called 'CANXL-only mode' where the error signalling is
+	 * disabled. This helper function determines the required value
+	 * to disable error signalling in the CAN XL controller.
+	 * The so-called CC/FD/XL 'mixed mode' requires error signalling.
+	 */
+	return ((priv->ctrlmode & mixed_mode) == CAN_CTRLMODE_XL);
+}
+
 /* drop skb if it does not contain a valid CAN frame for sending */
 static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
 {
@@ -153,6 +166,12 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 		goto invalid_skb;
 	}
 
+	if (can_dev_in_xl_only_mode(priv) && !can_is_canxl_skb(skb)) {
+		netdev_info_once(dev,
+				 "Error signaling is disabled, dropping skb\n");
+		goto invalid_skb;
+	}
+
 	return can_dropped_invalid_skb(dev, skb);
 
 invalid_skb:

-- 
2.51.0


