Return-Path: <linux-can+bounces-4173-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC637B121B9
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC04F173F34
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9DA2F1FD1;
	Fri, 25 Jul 2025 16:13:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DB2F0055
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460027; cv=none; b=fLG87zpWRZFWB+3PLSRzUO5PONOUasAPQz4do5XXYBf4mrRCRENz1it8L+XRbhF8Xf52Q2CKHi1TLrVbsd+hPKk/vd3jXebnOQIXZp1aP9pr9YdDqhUlLmAK5j7BCJojso2byXq2hbxka3/6Sgx55S6mTE45uC4fUs9RTRHVazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460027; c=relaxed/simple;
	bh=BWTeLR4h2tGsxN5RPznOx7QFkkax8BiXRBL/L9vX+PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge2FVKysv0/OjPPJXF/wKZZY9gGt0CtLOSc5cUm2QJ3pJRaEWSB3418Kwa7nFabDxsD77wq/+pJBXZzMj6Gn2ZfaqPxUp+0ec6GEyc2nro0j9t3Whai4U55Vod/AyItsW+IICQfVQ3s42Lmob+X0+qh79hyhoQ6kQma6kwyosZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3F-0006jC-3u
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-00AFcG-1r
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2A07E4498DA
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 47C6A449839;
	Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6169d074;
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
Subject: [PATCH net-next 22/27] can: kvaser_usb: Store the different firmware version components in a struct
Date: Fri, 25 Jul 2025 18:05:32 +0200
Message-ID: <20250725161327.4165174-23-mkl@pengutronix.de>
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

Store firmware version in kvaser_usb_fw_version struct, specifying the
different components of the version number.
And drop debug prinout of firmware version, since later patches will expose
it via the devlink interface.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-7-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 12 +++++++++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |  5 -----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  6 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 15 +++++++++++++--
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index fba972e7220d..a36d86494113 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -47,6 +47,10 @@
 #define KVASER_USB_CAP_EXT_CAP			0x02
 #define KVASER_USB_HYDRA_CAP_EXT_CMD		0x04
 
+#define KVASER_USB_SW_VERSION_MAJOR_MASK GENMASK(31, 24)
+#define KVASER_USB_SW_VERSION_MINOR_MASK GENMASK(23, 16)
+#define KVASER_USB_SW_VERSION_BUILD_MASK GENMASK(15, 0)
+
 struct kvaser_usb_dev_cfg;
 
 enum kvaser_usb_leaf_family {
@@ -83,6 +87,12 @@ struct kvaser_usb_tx_urb_context {
 	u32 echo_index;
 };
 
+struct kvaser_usb_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
 struct kvaser_usb_busparams {
 	__le32 bitrate;
 	u8 tseg1;
@@ -101,7 +111,7 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
-	u32 fw_version;
+	struct kvaser_usb_fw_version fw_version;
 	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 46e6cda0bf8d..2313fbc1a2c3 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -963,11 +963,6 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	if (WARN_ON(!dev->cfg))
 		return -ENODEV;
 
-	dev_dbg(&intf->dev, "Firmware version: %d.%d.%d\n",
-		((dev->fw_version >> 24) & 0xff),
-		((dev->fw_version >> 16) & 0xff),
-		(dev->fw_version & 0xffff));
-
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
 	err = ops->dev_get_card_info(dev);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index a4402b4845c6..388ebf2b1a5b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1839,6 +1839,7 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 	size_t cmd_len;
 	int err;
 	u32 flags;
+	u32 fw_version;
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
@@ -1863,7 +1864,10 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 	if (err)
 		goto end;
 
-	dev->fw_version = le32_to_cpu(cmd->sw_detail_res.sw_version);
+	fw_version = le32_to_cpu(cmd->sw_detail_res.sw_version);
+	dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK, fw_version);
+	dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK, fw_version);
+	dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK, fw_version);
 	flags = le32_to_cpu(cmd->sw_detail_res.sw_flags);
 
 	if (flags & KVASER_USB_HYDRA_SW_FLAG_FW_BAD) {
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index a67855521ccc..b4f5d4fba630 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -741,9 +741,13 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
 static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 						   const struct leaf_cmd_softinfo *softinfo)
 {
+	u32 fw_version;
 	u32 sw_options = le32_to_cpu(softinfo->sw_options);
 
-	dev->fw_version = le32_to_cpu(softinfo->fw_version);
+	fw_version = le32_to_cpu(softinfo->fw_version);
+	dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK, fw_version);
+	dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK, fw_version);
+	dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK, fw_version);
 	dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);
 
 	if (sw_options & KVASER_USB_LEAF_SWOPTION_EXT_CAP)
@@ -784,6 +788,7 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 {
 	struct kvaser_cmd cmd;
 	int err;
+	u32 fw_version;
 
 	err = kvaser_usb_leaf_send_simple_cmd(dev, CMD_GET_SOFTWARE_INFO, 0);
 	if (err)
@@ -798,7 +803,13 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 		kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.u.leaf.softinfo);
 		break;
 	case KVASER_USBCAN:
-		dev->fw_version = le32_to_cpu(cmd.u.usbcan.softinfo.fw_version);
+		fw_version = le32_to_cpu(cmd.u.usbcan.softinfo.fw_version);
+		dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK,
+						  fw_version);
+		dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK,
+						  fw_version);
+		dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK,
+						  fw_version);
 		dev->max_tx_urbs =
 			le16_to_cpu(cmd.u.usbcan.softinfo.max_outstanding_tx);
 		dev->cfg = &kvaser_usb_leaf_usbcan_dev_cfg;
-- 
2.47.2



