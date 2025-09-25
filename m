Return-Path: <linux-can+bounces-5002-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54801B9F1E0
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709871BC7DD6
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216402FFFBE;
	Thu, 25 Sep 2025 12:14:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1BB2FD1A8
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802443; cv=none; b=ME0HqEZ19ssO/PcxW68beNOwZY2q/FyVqHLZ8I/tyoLftTQp86PuFyRrnCHCaA6LwdDjv4nE4B0hX8kWk0iienbVCTvBknK06n4mkhw1eRPi3+aW7QqjJFjQqeUEAMGN1NY1jfI3o5NbIltDAiGiVVbYQndTkgF8U4NkX8iK+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802443; c=relaxed/simple;
	bh=NLGJvo+FqzWgAwyH6LyPH13S/7DGb80Z4Y7+T6c0SxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHpJ5HNsJc+q8enKyXSUCiF4vI3zj0DdIy7xFIYQkTQq8YQUYoFEVtNihrxNodFwK4d3erumJyRxwURWPg7J5Eb1Btvva+BfQqk2KNLKuEAXAzEOanmXUBDSgndHCE8i3f7Onq0xApURteI6ua2MpDq1g05nGjIWYXbtM388vV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-0000YG-9p; Thu, 25 Sep 2025 14:13:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-000Pwb-2u;
	Thu, 25 Sep 2025 14:13:36 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 95259479987;
	Thu, 25 Sep 2025 12:13:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 27/48] can: populate the minimum and maximum MTU values
Date: Thu, 25 Sep 2025 14:08:04 +0200
Message-ID: <20250925121332.848157-28-mkl@pengutronix.de>
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

By populating:

  net_device->min_mtu

and

  net_device->max_mtu

the net core infrastructure will automatically:

  1. validate that the user's inputs are in range.

  2. report those min and max MTU values through the netlink
     interface.

Add can_set_default_mtu() which sets the default mtu value as well as
the minimum and maximum values. The logic for the default mtu value
remains unchanged:

  - CANFD_MTU if the device has a static CAN_CTRLMODE_FD.

  - CAN_MTU otherwise.

Call can_set_default_mtu() each time the CAN_CTRLMODE_FD is modified.
This will guarantee that the MTU value is always consistent with the
control mode flags.

With this, the checks done in can_change_mtu() become fully redundant
and will be removed in an upcoming change and it is now possible to
confirm the minimum and maximum MTU values on a physical CAN interface
by doing:

  $ ip --details link show can0

The virtual interfaces (vcan and vxcan) are not impacted by this
change.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-can-fix-mtu-v3-3-581bde113f52@kernel.org
[mkl: squashed https://patch.msgid.link/20250924143644.17622-2-mailhol@kernel.org]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c     | 20 ++++++++++++++++++--
 drivers/net/can/dev/netlink.c |  9 ++++-----
 include/linux/can/dev.h       |  1 +
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 02bfed37cc93..befdeb4c54c2 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -240,6 +240,8 @@ void can_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_CAN;
 	dev->mtu = CAN_MTU;
+	dev->min_mtu = CAN_MTU;
+	dev->max_mtu = CAN_MTU;
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->tx_queue_len = 10;
@@ -309,6 +311,21 @@ void free_candev(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(free_candev);
 
+void can_set_default_mtu(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (priv->ctrlmode & CAN_CTRLMODE_FD) {
+		dev->mtu = CANFD_MTU;
+		dev->min_mtu = CANFD_MTU;
+		dev->max_mtu = CANFD_MTU;
+	} else {
+		dev->mtu = CAN_MTU;
+		dev->min_mtu = CAN_MTU;
+		dev->max_mtu = CAN_MTU;
+	}
+}
+
 /* changing MTU and control mode for CAN/CANFD devices */
 int can_change_mtu(struct net_device *dev, int new_mtu)
 {
@@ -361,8 +378,7 @@ int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
 	priv->ctrlmode = static_mode;
 
 	/* override MTU which was set by default in can_setup()? */
-	if (static_mode & CAN_CTRLMODE_FD)
-		dev->mtu = CANFD_MTU;
+	can_set_default_mtu(dev);
 
 	return 0;
 }
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d9f6ab3efb97..248f607e3864 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -223,17 +223,16 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= maskedflags;
 
-		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
-		if (priv->ctrlmode & CAN_CTRLMODE_FD) {
-			dev->mtu = CANFD_MTU;
-		} else {
-			dev->mtu = CAN_MTU;
+		/* Wipe potential leftovers from previous CAN FD config */
+		if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
 			memset(&priv->fd.data_bittiming, 0,
 			       sizeof(priv->fd.data_bittiming));
 			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
+		can_set_default_mtu(dev);
+
 		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5dc58360c2d7..3354f70ed2c6 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -166,6 +166,7 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
+void can_set_default_mtu(struct net_device *dev);
 int can_change_mtu(struct net_device *dev, int new_mtu);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
 					 u32 static_mode);
-- 
2.51.0


