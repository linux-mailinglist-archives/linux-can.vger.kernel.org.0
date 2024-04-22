Return-Path: <linux-can+bounces-456-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818988AC4EC
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 09:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4551F21B67
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 07:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208E4F5FD;
	Mon, 22 Apr 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="wp2AVsGi"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B44EB31;
	Mon, 22 Apr 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769927; cv=none; b=eXq8cZmZUu7z4gZP/b1+ZNTzi+AIxYrH9Rusm2AICcj0JmBNqfakrQUKHoyl7+u6VQT3XBidE0Cssd5CjtANe60M1anGzro7azOqiIlK4o9lK/E+ulHoHOXsRQlMWGwNXs+k11oP8b6yIGXaSavMEZBPX6FdvmoufVH6tt/gUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769927; c=relaxed/simple;
	bh=krD0iz5yDHjwModWFOjp3v1zoAQ+Ig0NhtFaxrrUM8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmd7XaSblxTNxz1jdR+KXdFCghAvU79/iPpO2VW4H0dEOVJBzcx5fPG/yduO8Zf+xZPUo7GTKBm8FmGbj3e7zqmESuBaEUG0y/GeCJI23mVcqR18S+rcDioI+VLJ7DY9mu2f0VjJcNLJ12WtW+Ib0JqJDB0CoEChOJv/9vLWffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=wp2AVsGi; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BY62nQijxUeNJybs25WudsjQVAhkq/ZVnshjoAuu+z4=; b=wp2AVsGi7Y2vg1sBOEtnlD2vl5
	ZkSiu7z7IUIn7QD5sbicduLdKdxHtUBxaGlUCN+i8KucVXXh9K6c56jOfaTZCryY8Golg5swemur2
	Nh6aNopFpyNC4nOOKDqdNjv8JHnGPdRYh7AizxWtMMc+X0Y5XLiWg+okO1SpGbrpHgOc=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1rynWq-001JRH-1W;
	Mon, 22 Apr 2024 08:51:53 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
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
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 10/11] can: lin: Support setting LIN mode
Date: Mon, 22 Apr 2024 08:51:13 +0200
Message-Id: <20240422065114.3185505-11-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
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
index 56492952c8588..472cadc87ad86 100644
--- a/drivers/net/can/lin.c
+++ b/drivers/net/can/lin.c
@@ -254,11 +254,40 @@ static netdev_tx_t lin_start_xmit(struct sk_buff *skb,
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
@@ -437,7 +466,7 @@ struct lin_device *register_lin(struct device *dev,
 	ndev->mtu = CANFD_MTU;
 	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
 	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
-	ldev->can.ctrlmode_supported = 0;
+	ldev->can.ctrlmode_supported = CAN_CTRLMODE_LIN_COMMANDER;
 	ldev->can.bitrate_const = lin_bitrate;
 	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
 	ldev->can.do_set_bittiming = lin_set_bittiming;
@@ -452,6 +481,15 @@ struct lin_device *register_lin(struct device *dev,
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
index 3f78cfda9c657..4f064a2ce2ca8 100644
--- a/include/net/lin.h
+++ b/include/net/lin.h
@@ -44,6 +44,11 @@ struct lin_attr {
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
@@ -55,6 +60,7 @@ struct lin_device {
 	struct sk_buff *tx_skb;
 	struct kobject *lin_ids_kobj;
 	struct lin_attr sysfs_entries[LIN_NUM_IDS];
+	enum lin_mode lmode;
 };
 
 enum lin_checksum_mode {
@@ -79,6 +85,7 @@ struct lin_responder_answer {
 
 struct lin_device_ops {
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


