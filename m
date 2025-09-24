Return-Path: <linux-can+bounces-4941-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BACAB98D09
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1B62E1336
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16852287505;
	Wed, 24 Sep 2025 08:21:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61C283FE9
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702111; cv=none; b=ODk5+g8h+bKDAB49mKGxVpB6m99sb4Caz+fq1DqkOdZmotRTZ74A+y5RSbbeCVL0StC39NUgh2D6aP8JxFC0mxcrvkUvgRWf2Syk4qAwCq9EoaS/GPoJQkW9MzN8IfHy0xC1xgl78wxSad1EBCIWitjKMJxDwjim4lgUKocGbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702111; c=relaxed/simple;
	bh=8kazcmo+vnijgvTt+pY6bcaPfuTPkvoiYz3DMDAHuiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c32mxrPFzUeRGz1kYsfe/FgxSda2MFyOE2ja6v4kxWrosSB9ZnDLI/Mn/WuV971ILfwpPftcgS8uz0iR0xVzsFf8sKqb5xqpxMR5X09MotSpbVfSr7IP1+9B0YGIWjr2cDjNPv+5g0EojaJdHllP/Bw3Aq3hTRXCfKE19y5zmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kke-0001Fm-Os; Wed, 24 Sep 2025 10:21:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dw4-0n;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 776134788AE;
	Wed, 24 Sep 2025 08:21:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 37/48] can: netlink: make can_tdc_changelink() FD agnostic
Date: Wed, 24 Sep 2025 10:06:54 +0200
Message-ID: <20250924082104.595459-38-mkl@pengutronix.de>
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

can_tdc_changelink() needs to access can_priv->fd making it
specific to CAN FD. Change the function parameter from struct can_priv
to struct data_bittiming_params. This way, the function becomes CAN FD
agnostic and can be reused later on for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-9-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 17ed52d238e3..abff7b84fdce 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -172,12 +172,13 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
+static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
+			      const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_tdc tdc = { 0 };
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 	int err;
 
 	if (!tdc_const)
@@ -215,7 +216,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 		tdc.tdcf = tdcf;
 	}
 
-	priv->fd.tdc = tdc;
+	dbt_params->tdc = tdc;
 
 	return 0;
 }
@@ -382,8 +383,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		if (data[IFLA_CAN_TDC]) {
 			/* TDC parameters are provided: use them */
-			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
-						 extack);
+			err = can_tdc_changelink(&priv->fd,
+						 data[IFLA_CAN_TDC], extack);
 			if (err) {
 				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
-- 
2.51.0


