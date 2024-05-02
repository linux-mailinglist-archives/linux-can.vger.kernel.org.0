Return-Path: <linux-can+bounces-550-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E758BA081
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383701F227C4
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EC11836CB;
	Thu,  2 May 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="FTylqayg"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B04174EC1;
	Thu,  2 May 2024 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674553; cv=none; b=MMz5jZmsDbYycv5Wllo7uRQ20CIqSIlNiSLdQVVljUtEM8No5xZEPBQVqfNBqupXQ3Zhkm/66HP0rtWATexSYb4lhd+ZbDb7q61ylGmOFIu678ME5dk5QG9MtDSRkB7fTJHq4tZReY5+WXpuANdKi8u5eKkjv8IjQcN+IKyFf6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674553; c=relaxed/simple;
	bh=Nj+y3vaJj3DdICDvB8tBJvWf0zz26duCalPTmUbljs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqrxjzcbpFib5k+HAOCTQ9HDe0m+vO2wiky3Sex4FheKcziJ6RXGfSqZ/cUhr+G62qNg1mrw8oY6RzvzTgwqfVjG6Kpaejuq9r5n6MZnfQDUbpMq2KAr3NrqZ7PB/ub9V+yYbvT889m3PGfgmEXtNfz6md6EmWyzjxKj5n2raPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=FTylqayg; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KPRpp6UUpvbAAcRXcnyZXeimntnEpH2UpmxWaVfp/H0=; b=FTylqaygHWelxoyf+3oq1tNN/4
	/E0CGgmXMtths0ClrUnq+vdh3K9TaGJWP7afej7RrU4ptblJ2ZlhDYVKQDaOoaKhON3o/jOzUqbGV
	E0olMa725JAKfglzfJGo0A9WsrH4Y0tPx+umalQFrSXlGM3czoBhqOO6APKnbsVsDBM4=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2bB2-001ZbZ-2G;
	Thu, 02 May 2024 20:29:05 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Jiri Slaby <jirislaby@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 10/11] can: lin: Support setting LIN mode
Date: Thu,  2 May 2024 20:28:03 +0200
Message-Id: <20240502182804.145926-11-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502182804.145926-1-christoph.fritz@hexdev.de>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A LIN node can work as commander or responder. This patch is introducing
a new control mode (CAN_CTRLMODE_LIN_COMMANDER), so that e.g. the ip
tool from iproute2 can turn on commander mode when the device is being
brought up.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/net/can/lin.c            | 40 +++++++++++++++++++++++++++++++-
 include/net/lin.h                |  7 ++++++
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
index ee2ebea2c865f..96cd016228fea 100644
--- a/drivers/net/can/lin.c
+++ b/drivers/net/can/lin.c
@@ -271,11 +271,40 @@ static netdev_tx_t lin_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int lin_update_mode(struct net_device *ndev)
+{
+	struct lin_device *ldev = netdev_priv(ndev);
+	u32 ctrlmode = ldev->can.ctrlmode;
+	enum lin_mode lm;
+	int ret = 0;
+
+	lm = (ctrlmode & CAN_CTRLMODE_LIN_COMMANDER) ? LINBUS_COMMANDER :
+						       LINBUS_RESPONDER;
+	if (ldev->lmode != lm) {
+		if (!ldev->ldev_ops->update_lin_mode) {
+			netdev_err(ndev, "setting lin mode unsupported\n");
+			return -EINVAL;
+		}
+		ret = ldev->ldev_ops->update_lin_mode(ldev, lm);
+		if (ret) {
+			netdev_err(ndev, "Failed to set lin mode: %d\n", ret);
+			return ret;
+		}
+		ldev->lmode = lm;
+	}
+
+	return ret;
+}
+
 static int lin_open(struct net_device *ndev)
 {
 	struct lin_device *ldev = netdev_priv(ndev);
 	int ret;
 
+	ret = lin_update_mode(ndev);
+	if (ret)
+		return ret;
+
 	ldev->tx_busy = false;
 
 	ret = open_candev(ndev);
@@ -451,7 +480,7 @@ struct lin_device *register_lin(struct device *dev,
 	ndev->mtu = CANFD_MTU;
 	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
 	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
-	ldev->can.ctrlmode_supported = 0;
+	ldev->can.ctrlmode_supported = CAN_CTRLMODE_LIN_COMMANDER;
 	ldev->can.bitrate_const = lin_bitrate;
 	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
 	ldev->can.do_set_bittiming = lin_set_bittiming;
@@ -466,6 +495,15 @@ struct lin_device *register_lin(struct device *dev,
 		goto exit_candev;
 	}
 
+	ldev->lmode = LINBUS_RESPONDER;
+	if (ldev->ldev_ops->update_lin_mode) {
+		ret = ldev->ldev_ops->update_lin_mode(ldev, ldev->lmode);
+		if (ret) {
+			netdev_err(ndev, "updating lin mode failed\n");
+			goto exit_candev;
+		}
+	}
+
 	ret = register_candev(ndev);
 	if (ret)
 		goto exit_candev;
diff --git a/include/net/lin.h b/include/net/lin.h
index e7c7c820a6e18..e80a4509b7a8c 100644
--- a/include/net/lin.h
+++ b/include/net/lin.h
@@ -36,6 +36,11 @@ struct lin_attr {
 	struct lin_device *ldev;
 };
 
+enum lin_mode {
+	LINBUS_RESPONDER = 0,
+	LINBUS_COMMANDER,
+};
+
 struct lin_device {
 	struct can_priv can;  /* must be the first member */
 	struct net_device *ndev;
@@ -47,6 +52,7 @@ struct lin_device {
 	struct sk_buff *tx_skb;
 	struct kobject *lin_ids_kobj;
 	struct lin_attr sysfs_entries[LIN_NUM_IDS];
+	enum lin_mode lmode;
 };
 
 enum lin_checksum_mode {
@@ -73,6 +79,7 @@ struct lin_device_ops {
 	int (*ldo_open)(struct lin_device *ldev);
 	int (*ldo_stop)(struct lin_device *ldev);
 	int (*ldo_tx)(struct lin_device *ldev, const struct lin_frame *frame);
+	int (*update_lin_mode)(struct lin_device *ldev, enum lin_mode lm);
 	int (*update_bitrate)(struct lin_device *ldev, u16 bitrate);
 	int (*update_responder_answer)(struct lin_device *ldev,
 				       const struct lin_responder_answer *answ);
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 51b0e2a7624e4..6c84a7666c646 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -104,6 +104,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
 #define CAN_CTRLMODE_LIN		0x800	/* LIN bus mode */
+#define CAN_CTRLMODE_LIN_COMMANDER	0x1000	/* LIN bus specific commander mode */
 
 /*
  * CAN device statistics
-- 
2.39.2


