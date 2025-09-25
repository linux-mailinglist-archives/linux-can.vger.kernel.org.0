Return-Path: <linux-can+bounces-5013-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B746B9F20A
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D00D326805
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612F2FE072;
	Thu, 25 Sep 2025 12:14:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50312FFFB9
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802447; cv=none; b=GWta+fs+mFmCLrzNYW50MCXTkOgEigkfPQU9PdeFxQAJrxT3iYwuSK8UZ1sg1CcU+R1N9lCqZ1Sk8OIuZtYmlup7CIiCkcn41KpLLIVkGVrv5IPBfM2EO1H5H6O8zrlVnrZkwqVrZKytTFdcC4BoFvfuanmMV3CJGILhY2f2wY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802447; c=relaxed/simple;
	bh=sXpzd6oUo3UyW91hUmC8uhHGVtMXnFG9Jy4/tr9rhiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRDLU6AyoyatagKpTd1SgEDfx4lSxGMWFbIkKR2WiwYbhY9dLPU+4TuFC1QndQi2KkXNMLZ1jvDUCfgKcEdgeW1f0Fo0VJzCDUJDihSbUsZfzU/7jc07cwdteqafXf8RAqS1qyX8WDtb4VGRqylq4EKrvX8ZwJFbkeT9ieN+JDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-0000Yc-OX; Thu, 25 Sep 2025 14:13:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-000Pwz-1E;
	Thu, 25 Sep 2025 14:13:37 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2B85F47998F;
	Thu, 25 Sep 2025 12:13:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 35/48] can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
Date: Thu, 25 Sep 2025 14:08:12 +0200
Message-ID: <20250925121332.848157-36-mkl@pengutronix.de>
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

CAN_CTRLMODE_TDC_AUTO and CAN_CTRLMODE_TDC_MANUAL are mutually
exclusive. This means that whenever the user switches from auto to
manual mode (or vice versa), the other flag which was set previously
needs to be cleared.

Currently, this is handled with a masking operation. It can be done in
a simpler manner by clearing any of the previous TDC flags before
copying netlink attributes. The code becomes easier to understand and
will make it easier to add the new upcoming CAN XL flags which will
have a similar reset logic as the current TDC flags.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-7-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 549a2247d847..c212c7ff26cd 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -255,6 +255,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		if ((maskedflags & ctrlstatic) != ctrlstatic)
 			return -EOPNOTSUPP;
 
+		/* If a top dependency flag is provided, reset all its dependencies */
+		if (cm->mask & CAN_CTRLMODE_FD)
+			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+
 		/* clear bits to be modified and copy the flag values */
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= maskedflags;
@@ -270,11 +274,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		can_set_default_mtu(dev);
 
 		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
-		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
-		 * exclusive: make sure to turn the other one off
-		 */
-		if (fd_tdc_flag_provided)
-			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
-- 
2.51.0


