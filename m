Return-Path: <linux-can+bounces-4171-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E98B121B5
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D391CE4B3E
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4342F1FC3;
	Fri, 25 Jul 2025 16:13:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B42F0052
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460026; cv=none; b=etLmABBp6Ym+HBbrnY6K3Wv+9fOTBhjj8PU+2RUI7xaGd4QmcAIGl3vVVClunumWAFvAL1slvIilP2LDPnvgTAN4s1TYnVnD6HlKJeCgnNDf73utPfww5vAygvB4mVAEDY9FKt2pIbxa2yLv8tWV0e4xFCO+POcockeyufNKE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460026; c=relaxed/simple;
	bh=gslksNirycS0DidVfiizxxSxarzGwk6vWw3K3QY/spE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8iJ3M2nhYVPP56IPsa/ZqNZhWwP4apye2c9HEy7PR7J5lh+XF0qIAw9Etpt2MvTarRNW+p69M6xF7aKs+j2TYjpmdsYWlIdvrfAM5JqEi1QjCqWCKz6vsp3M/PgNa7GaKZD/JsFz1ZJymMUQSI4vAEWmv6HoI+o8VEA6vTVBqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3F-0006ji-D9
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-00AFcL-2Z
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 37DD34498DC
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 54CED44983A;
	Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 12a5e730;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 23/27] can: kvaser_usb: Store additional device information
Date: Fri, 25 Jul 2025 18:05:33 +0200
Message-ID: <20250725161327.4165174-24-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

Store additional device information; EAN (product number), serial_number
and hardware revision.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-8-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 3 +++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 6 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index a36d86494113..35c2cf3d4486 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -111,7 +111,10 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
+	u32 ean[2];
+	u32 serial_number;
 	struct kvaser_usb_fw_version fw_version;
+	u8 hw_revision;
 	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 388ebf2b1a5b..a59f20dad692 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -114,7 +114,7 @@ struct kvaser_cmd_card_info {
 	__le32 clock_res;
 	__le32 mfg_date;
 	__le32 ean[2];
-	u8 hw_version;
+	u8 hw_revision;
 	u8 usb_mode;
 	u8 hw_type;
 	u8 reserved0;
@@ -1918,6 +1918,10 @@ static int kvaser_usb_hydra_get_card_info(struct kvaser_usb *dev)
 	err = kvaser_usb_hydra_wait_cmd(dev, CMD_GET_CARD_INFO_RESP, &cmd);
 	if (err)
 		return err;
+	dev->ean[1] = le32_to_cpu(cmd.card_info.ean[1]);
+	dev->ean[0] = le32_to_cpu(cmd.card_info.ean[0]);
+	dev->serial_number = le32_to_cpu(cmd.card_info.serial_number);
+	dev->hw_revision = cmd.card_info.hw_revision;
 
 	dev->nchannels = cmd.card_info.nchannels;
 	if (dev->nchannels > KVASER_USB_MAX_NET_DEVICES)
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index b4f5d4fba630..c29828a94ad0 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -138,7 +138,7 @@ struct kvaser_cmd_cardinfo {
 	__le32 padding0;
 	__le32 clock_resolution;
 	__le32 mfgdate;
-	u8 ean[8];
+	__le32 ean[2];
 	u8 hw_revision;
 	union {
 		struct {
@@ -854,6 +854,10 @@ static int kvaser_usb_leaf_get_card_info(struct kvaser_usb *dev)
 	    (dev->driver_info->family == KVASER_USBCAN &&
 	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
 		return -EINVAL;
+	dev->ean[1] = le32_to_cpu(cmd.u.cardinfo.ean[1]);
+	dev->ean[0] = le32_to_cpu(cmd.u.cardinfo.ean[0]);
+	dev->serial_number = le32_to_cpu(cmd.u.cardinfo.serial_number);
+	dev->hw_revision = cmd.u.cardinfo.hw_revision;
 
 	return 0;
 }
-- 
2.47.2



