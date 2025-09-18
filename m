Return-Path: <linux-can+bounces-4748-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAB7B84B87
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52373B75E3
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B16306B28;
	Thu, 18 Sep 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+HKpYRY"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E6306B13;
	Thu, 18 Sep 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200377; cv=none; b=Jw43Ubf+Mxb5Py4826cLJ0e4xaWcuSkDMd8c+lXEoQTxq7pod/r9562UrWB80SLcNdzQr0Y5PE+ysakrQX5LA/g8bx0d+kMgZCFCmaen7otZBXCuQJA8AKz+4YOEUkMcLSO+s/RvrkADrOOEECikt60pL1vwUPkA2fvjUCrKuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200377; c=relaxed/simple;
	bh=gK7abQXc0cr8q5l7D1BR+bo/xg4UM1mzmwrdqOR2Vmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nzhLRTw3fXBWqo7sIyXxrnP3hlZVCR3Rb6DyL2V2LY5A2nXy2LQRShJUhZThin7xIPyXWcYgeQdWaLG6Mp2k2zLmAJR/FgIFr8LmUqeJY1t50807GAhLEnI0eTMFWaZmjLetWeri3isE57u/woJQH0aClthxNC0XAKIA62D3Nbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+HKpYRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03D4C4CEE7;
	Thu, 18 Sep 2025 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758200376;
	bh=gK7abQXc0cr8q5l7D1BR+bo/xg4UM1mzmwrdqOR2Vmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V+HKpYRYfEVBMVoOK1kJ6evGvvOmJ9ccLpTy6jYwXp98WstRPkesnss5hcC+gVIz7
	 SN0xvxc7KB26xPhqq8lOQsPUtruqkGhPjkql/i52VWM+PldhI9jh3KDqFWTTAEFV28
	 hsIawK0cHZv8YXWXJEyGCEhcaY+aNL091qolO+xsDY3dk0RdxDZdfKQoR4XeF7oBOx
	 vn2wuAE+ST184PxHtmn/OIJzAFYlVORU938Ey4rSC3XIJlGRyKofC8Pl0Nh3MqiK5d
	 8ocfL2g7FwpDdxEXJ7cC/6Rofv4DkcemujCB/OjmhEZzbCAxQpQBjBMpWycvVk7jyf
	 ToJrYHV2tSJPQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 21:59:13 +0900
Subject: [PATCH RFC 3/5] can: populate the minimum and maximum MTU values
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-3-471edb942295@kernel.org>
References: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
In-Reply-To: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5070; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=gK7abQXc0cr8q5l7D1BR+bo/xg4UM1mzmwrdqOR2Vmg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlnmHR/y1+5sNbSLDVllcwsk6fTm79skTpt7l+9xb345
 Gt98bgTHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACaiGsfIMO/9f/vkLfN3vPjA
 fuf6m2mxzJ/iS58wcOaoyAjdqr1zehvDP7vKIxaasw6c9zaZ/94jN/HOkSL3zyuFrwlsEW3j3mv
 ynAsA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

By populating:

  net_device->min_mtu

and

  net_device->max_mtu

the net core infrastructure will automatically:

  1. validate that the user's inputs are in range.

  2. report those min and max MTU values through the netlink
     interface.

Add can_set_default_mtu() which will set the default mtu value as well
as the minimum and maximum values. The logic for the default mtu value
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
---
With this, when adding the CAN XL netlink interface, all we have to do
is to add one if branch to can_set_default_mtu() like this:

	void can_set_default_mtu(struct net_device *dev)
	{
		struct can_priv *priv = netdev_priv(dev);

		if (priv->ctrlmode & CAN_CTRLMODE_XL) {
			dev->mtu = CANXL_MTU;
			dev->min_mtu = CANXL_MIN_MTU;
			dev->max_mtu = CANXL_MAX_MTU;
		} else if (priv->ctrlmode & CAN_CTRLMODE_FD) {
			dev->mtu = CANFD_MTU;
			dev->min_mtu = CANFD_MTU;
			dev->max_mtu = CANFD_MTU;
		} else {
			dev->mtu = CAN_MTU;
			dev->min_mtu = CAN_MTU;
			dev->max_mtu = CAN_MTU;
		}
	}

and we will be done!
---
 drivers/net/can/dev/dev.c     | 21 ++++++++++++++++++---
 drivers/net/can/dev/netlink.c |  9 ++++-----
 include/linux/can/dev.h       |  1 +
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index a0ae659beedcd1fa0979662c12614ae7846032c0..69c00720e9956cad986ea86fbba49285d76f51db 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -239,11 +239,12 @@ EXPORT_SYMBOL_GPL(can_bus_off);
 void can_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_CAN;
-	dev->mtu = CAN_MTU;
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->tx_queue_len = 10;
 
+	can_set_default_mtu(dev);
+
 	/* New-style flags. */
 	dev->flags = IFF_NOARP;
 	dev->features = NETIF_F_HW_CSUM;
@@ -309,6 +310,21 @@ void free_candev(struct net_device *dev)
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
@@ -361,8 +377,7 @@ int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
 	priv->ctrlmode = static_mode;
 
 	/* override MTU which was set by default in can_setup()? */
-	if (static_mode & CAN_CTRLMODE_FD)
-		dev->mtu = CANFD_MTU;
+	can_set_default_mtu(dev);
 
 	return 0;
 }
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d9f6ab3efb9767409c318b714f19df8a30e51137..248f607e3864ffbda6f0b8daf4e2484179cf9cd5 100644
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
index 5dc58360c2d74a1711d4e02d28fe52ae20b146e0..3354f70ed2c684d7d482549560d4cb5838cbebd5 100644
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
2.49.1


