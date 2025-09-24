Return-Path: <linux-can+bounces-4936-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F222B98D00
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56B3166329
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50374287252;
	Wed, 24 Sep 2025 08:21:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1F2848B7
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702110; cv=none; b=RF7PfW5SPAlyx9VAPqCU1JO+A1C7VQrJkoA5VNxbZwDp+InL5JZChB4RFDuOh0HaGZCBG90G3keEecJsjOyVl0jf6z1bvQwmJBeLcJ0yyQUaVN82pTgxTgenOGkELTogP5x3Xyup9n0zPCservUFbgJZfx+CsUCbvHcuavulahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702110; c=relaxed/simple;
	bh=koejMSnOXLk+bOqf979uqmvE5afDfT8lXBoI2voiyMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nmau835ZXn1MIwvknPpWcbyF86LO6CXvbEVHlPU7pH4xJJUQhfUo530vb3CNn74eF7cKzxhrRe+zZCyvboLYmgbX6GcoTT5MOOQ05QJOH5urYJg1xQNAs0HRsjIkHaiPqWb3Wrr50skjDaMGEFlyO+fGbEJtxpIk+PB/e0ZjKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001GW-80; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dwh-28;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E55FD4788B8;
	Wed, 24 Sep 2025 08:21:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 42/48] can: netlink: add can_bittiming_fill_info()
Date: Wed, 24 Sep 2025 10:06:59 +0200
Message-ID: <20250924082104.595459-43-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

Add can_bittiming_fill_info() to factorise the logic when filling the
bittiming information for Classical CAN and CAN FD. This function will
be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-14-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 5d2b524daea9..bedd2611d358 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -559,6 +559,14 @@ static size_t can_get_size(const struct net_device *dev)
 	return size;
 }
 
+static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
+				   struct can_bittiming *bittiming)
+{
+	return bittiming->bitrate != CAN_BITRATE_UNSET &&
+		bittiming->bitrate != CAN_BITRATE_UNKNOWN &&
+		nla_put(skb, ifla_can_bittiming, sizeof(*bittiming), bittiming);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -641,10 +649,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
 
-	if ((priv->bittiming.bitrate != CAN_BITRATE_UNSET &&
-	     priv->bittiming.bitrate != CAN_BITRATE_UNKNOWN &&
-	     nla_put(skb, IFLA_CAN_BITTIMING,
-		     sizeof(priv->bittiming), &priv->bittiming)) ||
+	if (can_bittiming_fill_info(skb, IFLA_CAN_BITTIMING,
+				    &priv->bittiming) ||
 
 	    (priv->bittiming_const &&
 	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
@@ -659,9 +665,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
 
-	    (priv->fd.data_bittiming.bitrate &&
-	     nla_put(skb, IFLA_CAN_DATA_BITTIMING,
-		     sizeof(priv->fd.data_bittiming), &priv->fd.data_bittiming)) ||
+	    can_bittiming_fill_info(skb, IFLA_CAN_DATA_BITTIMING,
+				    &priv->fd.data_bittiming) ||
 
 	    (priv->fd.data_bittiming_const &&
 	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
-- 
2.51.0


