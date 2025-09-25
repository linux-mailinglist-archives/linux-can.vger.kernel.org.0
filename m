Return-Path: <linux-can+bounces-5004-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2158B9F1F3
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4350A4E4B85
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1B2FE59B;
	Thu, 25 Sep 2025 12:14:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD782FF140
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802443; cv=none; b=rfFJW29/GnMPIX1fwvhXk87jZxODABFVwaDxYD8AA301iQWhGZ/F1CNNfH30Oj1VsnRzSYBxUfpKzOecFZuGzYx5c703omlI6iyhg8+GTwNbnWO/1zRHBlc/yN4bqKYIOL74/zUTXSsuGaAzKYINIv71+N9KonjAFEx8/na1q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802443; c=relaxed/simple;
	bh=Z/pNAdqrWIaqXBTMawOf4mTZoJtBr0M4jIi2iNGtBW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI2SQxtP/FjevZjJt1IHWMEpnSe6uENbwNpEgFn/x5LAXaPNYffBzPWLSG9FQZq2CDVxkvRLUEZQtomIDdNX2zhAlNx8Z+UEslbyDK4gjBR68altR/0T2BWaeGHBU/TO7aY0rGdOPGgkgMVVRSeTld0VXqjH6NEAYydGCq6JJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqx-0000ZM-N1; Thu, 25 Sep 2025 14:13:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-000PxS-33;
	Thu, 25 Sep 2025 14:13:37 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A8601479997;
	Thu, 25 Sep 2025 12:13:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 43/48] can: netlink: add can_bittiming_const_fill_info()
Date: Thu, 25 Sep 2025 14:08:20 +0200
Message-ID: <20250925121332.848157-44-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

Add function can_bittiming_const_fill_info() to factorise the logic
when filling the bittiming constant information for Classical CAN and
CAN FD. This function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-15-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index bedd2611d358..fa922a61f75a 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -567,6 +567,15 @@ static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
 		nla_put(skb, ifla_can_bittiming, sizeof(*bittiming), bittiming);
 }
 
+static int can_bittiming_const_fill_info(struct sk_buff *skb,
+					 int ifla_can_bittiming_const,
+					 const struct can_bittiming_const *bittiming_const)
+{
+	return bittiming_const &&
+		nla_put(skb, ifla_can_bittiming_const,
+			sizeof(*bittiming_const), bittiming_const);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -652,9 +661,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (can_bittiming_fill_info(skb, IFLA_CAN_BITTIMING,
 				    &priv->bittiming) ||
 
-	    (priv->bittiming_const &&
-	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
-		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
+	    can_bittiming_const_fill_info(skb, IFLA_CAN_BITTIMING_CONST,
+					  priv->bittiming_const) ||
 
 	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(priv->clock), &priv->clock) ||
 	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
@@ -668,10 +676,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    can_bittiming_fill_info(skb, IFLA_CAN_DATA_BITTIMING,
 				    &priv->fd.data_bittiming) ||
 
-	    (priv->fd.data_bittiming_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
-		     sizeof(*priv->fd.data_bittiming_const),
-		     priv->fd.data_bittiming_const)) ||
+	    can_bittiming_const_fill_info(skb, IFLA_CAN_DATA_BITTIMING_CONST,
+					  priv->fd.data_bittiming_const) ||
 
 	    (priv->termination_const &&
 	     (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||
-- 
2.51.0


