Return-Path: <linux-can+bounces-1142-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F94948A86
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CFA1F25AF4
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96531BE25E;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC71BD01D
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930469; cv=none; b=X/xjfjmU2+ICoVBNLGzh/C7K3sNRz7Um/RgHC3vYuXixUam713DdJvKkVV+zWHzJjLgLYUVv53TUIYtxVjgSVWYUW/AAqFORr3/Z+WpFkYgZw7urLNkwbfHZ8mbnPc9CauGzYO1V/qmgefbo4UG9nV4OtoIQ65KVa552R2fUwno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930469; c=relaxed/simple;
	bh=AVUfVHPlIf7yQgBJq8Kk4t5geAImLHHOoeqz9mfknRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hm152llRtvasokF1JJOSeicLI7jGSTALZ0YxqQiqXp2itDeed0E8KrwBJbVy8qBKFJmNr+vQx7hy6VBVZc9GrGEZ5DVoDrPFFRKQijWGLA/UmfLYnHZiNFtb4nvSLmVv5f+MN2nnxi964+cP0R5ISMBZVbK+axeV7ikXwhsyePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEux-00044m-RE
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:39 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuu-004trD-Jm
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 489EA3179BD
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E5529317974;
	Tue, 06 Aug 2024 07:47:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a123d63c;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/20] can: kvaser_usb: Add helper functions to convert device timestamp into ktime
Date: Tue,  6 Aug 2024 09:41:57 +0200
Message-ID: <20240806074731.1905378-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Add helper function kvaser_usb_ticks_to_ktime() that converts from
device ticks to ktime.
And kvaser_usb_timestamp{48,64}_to_ktime() that converts from device
48-bit or 64-bit timestamp, to ktime.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-2-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   | 24 +++++++++++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 10 ++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index ff10b3790d84..4256a0caae20 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -22,6 +22,8 @@
  */
 
 #include <linux/completion.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/usb.h>
@@ -216,4 +218,26 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev);
 
 extern const struct can_bittiming_const kvaser_usb_flexc_bittiming_const;
 
+static inline ktime_t kvaser_usb_ticks_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
+						u64 ticks)
+{
+	return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
+}
+
+static inline ktime_t kvaser_usb_timestamp48_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
+						      const __le16 *timestamp)
+{
+	u64 ticks = le16_to_cpu(timestamp[0]) |
+		    (u64)(le16_to_cpu(timestamp[1])) << 16 |
+		    (u64)(le16_to_cpu(timestamp[2])) << 32;
+
+	return kvaser_usb_ticks_to_ktime(cfg, ticks);
+}
+
+static inline ktime_t kvaser_usb_timestamp64_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
+						      __le64 timestamp)
+{
+	return kvaser_usb_ticks_to_ktime(cfg, le64_to_cpu(timestamp));
+}
+
 #endif /* KVASER_USB_H */
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index c7ba768dfe17..ad1c6101a0cd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -526,19 +526,17 @@ static ktime_t
 kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
 				   const struct kvaser_cmd *cmd)
 {
-	u64 ticks;
+	ktime_t hwtstamp = 0;
 
 	if (cmd->header.cmd_no == CMD_EXTENDED) {
 		struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
 
-		ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
+		hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->rx_can.timestamp);
 	} else {
-		ticks = le16_to_cpu(cmd->rx_can.timestamp[0]);
-		ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[1])) << 16;
-		ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[2])) << 32;
+		hwtstamp = kvaser_usb_timestamp48_to_ktime(cfg, cmd->rx_can.timestamp);
 	}
 
-	return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
+	return hwtstamp;
 }
 
 static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
-- 
2.43.0



