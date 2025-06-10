Return-Path: <linux-can+bounces-3786-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2DAD32AE
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 11:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A967AB734
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2428D83B;
	Tue, 10 Jun 2025 09:49:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91028C2A0
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548981; cv=none; b=fNLNdhjKYJCvFA2be3raiGt2Zxn+aUF3rQVqDxFIc45PJo0xa+GFRWFPCpQdLMvIt/yZPPDBxAaqyKnDddt2jXNoOXOxII39ERfXnFM8tpC5u7D7jOtc1rpIJZPf0dirnprledvAuQ109H46AM8OjMQnpVnXxdhEonptNEAo44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548981; c=relaxed/simple;
	bh=KabShRj8UASUcnl3Kk5qNBy+Bq7mNbp1XnBranxRLIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8TCtdnQibFmzlzCJ2VOARa+ZF45m2tJbkR60j+EX85s8g1xB3d1B2NbsOQ3AeaFeP+4YxgcU+rUJYR1SEKX9Pk8SqOIDrC11hlf07W4uVw4pb+iAFIJtrdZ21uMqWSNRAo/SJpYpXNT9+rWDzw8geR2/vYI8GFBcNuaD/NkVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbt-00063a-HD
	for linux-can@vger.kernel.org; Tue, 10 Jun 2025 11:49:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbt-002kcV-09
	for linux-can@vger.kernel.org;
	Tue, 10 Jun 2025 11:49:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B0C224241A2
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:49:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 720E7424185;
	Tue, 10 Jun 2025 09:49:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 14bffc6d;
	Tue, 10 Jun 2025 09:49:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/7] can: netlink: can_changelink(): rename tdc_mask into fd_tdc_flag_provided
Date: Tue, 10 Jun 2025 11:46:19 +0200
Message-ID: <20250610094933.1593081-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610094933.1593081-1-mkl@pengutronix.de>
References: <20250610094933.1593081-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The only purpose of the tdc_mask variable is to check whether or not
any tdc flags (CAN_CTRLMODE_TDC_{AUTO,MANUAL}) were provided. At this
point, the actual value of the flags do no matter any more because
these can be deduced from some other information.

Rename the tdc_mask variable into fd_tdc_flag_provided to make this
more explicit. Note that the fd_ prefix is added in preparation of the
introduction of CAN XL.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20241112165118.586613-12-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 16b0f326c143..13826e8a707b 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -189,7 +189,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	u32 tdc_mask = 0;
+	bool fd_tdc_flag_provided = false;
 	int err;
 
 	/* We need synchronization with dev->stop() */
@@ -234,11 +234,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
-		tdc_mask = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
+		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
-		if (tdc_mask)
+		if (fd_tdc_flag_provided)
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
@@ -342,7 +342,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
 			}
-		} else if (!tdc_mask) {
+		} else if (!fd_tdc_flag_provided) {
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
 			 */
-- 
2.47.2



