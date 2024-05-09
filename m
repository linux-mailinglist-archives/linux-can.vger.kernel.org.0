Return-Path: <linux-can+bounces-616-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2D88C13D3
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A5A281FBF
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DC63B7A0;
	Thu,  9 May 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="DmlzDXeN"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00512E73;
	Thu,  9 May 2024 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275179; cv=none; b=A7sb079YjbT3QMnuv+fTpNUsjO+pODF/vtqww9j9WUKtqKLsX5fM9MgeKuQD7N/HT9NVJJkMYVva9YZXtuPqhJw2aGGlqF8bCNM7JZo/xrN5WtmcdZ7QifeOQLOPobMTsVBdOHYiLLzUNsKBAAibxiAeo91GP6CLq9sKKiFFFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275179; c=relaxed/simple;
	bh=sMluPj+jC7yMLoz5EGyg5Bjoc4Ga76mBFeLDoKWv4ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/8FMIpTtwUCSAm45fsinuqAlBDnINPD5J7Jz4HxdHbYnrzCOzJ0JgsYhzf4qGMp9StpQ/QouCsW7mf4ztjVKiVGR0MOE56DH2DKZwnHPUtYyM1bOwQQaI0fg0eEraknEjUz16r0epNsMbHY5nGPSEEfUniNPLn70vikb/ZBYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=DmlzDXeN; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=n03cPb38QYSs83+us38pW77fDCs4X3Pw+BwJ3PvVIWg=; b=DmlzDXeNnVz0F7KXqi5uWx+l4B
	GhGlcLCrCldBQ5KlegwLUh/rrrDnGI9f/05SiNYTqR/De3c/NClkiD8cZ4OD89EEAfakp7dCoZIMN
	SInTXd0zjz7cW6RKQSBsBFcJ1GEzrxQvq+QCls7IQHiGGXZJ1YGD+4o1CeWCzaEFVdzc=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57QR-001jf8-0y;
	Thu, 09 May 2024 19:19:23 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
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
Subject: [PATCH v4 10/11] can: lin: Support setting LIN mode
Date: Thu,  9 May 2024 19:17:35 +0200
Message-Id: <20240509171736.2048414-11-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A LIN node can work as commander or responder, so introduce a new
control mode (CAN_CTRLMODE_LIN_COMMANDER) for configuration.

This enables e.g. the userland tool ip from iproute2 to turn on
commander mode when the device is being brought up.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/net/can/lin.c            | 40 +++++++++++++++++++++++++++++++-
 include/net/lin.h                |  7 ++++++
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
index f77abd7d7d21c..03ddf5d5a31b8 100644
--- a/drivers/net/can/lin.c
+++ b/drivers/net/can/lin.c
@@ -262,11 +262,40 @@ static netdev_tx_t lin_start_xmit(struct sk_buff *skb,
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
@@ -443,7 +472,7 @@ struct lin_device *register_lin(struct device *dev,
 	ndev->sysfs_groups[0] = &lin_sysfs_group;
 	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
 	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
-	ldev->can.ctrlmode_supported = 0;
+	ldev->can.ctrlmode_supported = CAN_CTRLMODE_LIN_COMMANDER;
 	ldev->can.bitrate_const = lin_bitrate;
 	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
 	ldev->can.do_set_bittiming = lin_set_bittiming;
@@ -458,6 +487,15 @@ struct lin_device *register_lin(struct device *dev,
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
index 31bb0feefd188..63ac870a0ab6f 100644
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
@@ -45,6 +50,7 @@ struct lin_device {
 	struct work_struct tx_work;
 	bool tx_busy;
 	struct sk_buff *tx_skb;
+	enum lin_mode lmode;
 };
 
 enum lin_checksum_mode {
@@ -71,6 +77,7 @@ struct lin_device_ops {
 	int (*ldo_open)(struct lin_device *ldev);
 	int (*ldo_stop)(struct lin_device *ldev);
 	int (*ldo_tx)(struct lin_device *ldev, const struct lin_frame *frame);
+	int (*update_lin_mode)(struct lin_device *ldev, enum lin_mode lm);
 	int (*update_bitrate)(struct lin_device *ldev, u16 bitrate);
 	int (*update_responder_answer)(struct lin_device *ldev,
 				       const struct lin_responder_answer *answ);
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index a37f56d86c5f2..cc390f6444d59 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -104,6 +104,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
 #define CAN_CTRLMODE_LIN		BIT(11)	/* LIN bus mode */
+#define CAN_CTRLMODE_LIN_COMMANDER	BIT(12)	/* LIN bus specific commander mode */
 
 /*
  * CAN device statistics
-- 
2.39.2


