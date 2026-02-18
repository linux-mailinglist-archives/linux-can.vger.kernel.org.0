Return-Path: <linux-can+bounces-6585-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLkQDpXQlWkaVAIAu9opvQ
	(envelope-from <linux-can+bounces-6585-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 15:45:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7E157205
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 15:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73D613015D27
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43E2E62C4;
	Wed, 18 Feb 2026 14:45:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401932AAD6
	for <linux-can@vger.kernel.org>; Wed, 18 Feb 2026 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771425937; cv=none; b=qMoL/PA1UNzEnglMKgIp+DWy0NB6J/EcvNftXuzqkfrQsvf7W0fDKGT7PCvdfSzhsKSm4rp2Nvg4Seb7yiRW+E6klOMd9bqK1aa+GOutSZkVXrl9okWlsNd181gtZZSQgEXHP+03NutbmhnBUAybT3xcS5DWWg1RQzt33/tysq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771425937; c=relaxed/simple;
	bh=/qDCeM49X4+Z0bmDMqbc0ByiVKbp4U2j46DJfzQ6U2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T61/v52wbv1k6ivpHpAA7ZEC+8r+GOaoBJJK3jIP4vWsHBFW/Js538+7exq5LRnC4HsdYPsZkpR3hybn8N/91QLN5Kb4iMDyZw85uTjUCtz2Rp1cPBxwa9to3R3AKd+0zJU8+C0Fg7bH+vh4MlBmZ1D/8C8IcLlougfuoTcmpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vsinu-0000zC-AU; Wed, 18 Feb 2026 15:45:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vsi8x-001Pvh-22;
	Wed, 18 Feb 2026 15:03:09 +0100
Received: from hardanger.blackshift.org (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AB3194EBB4F;
	Wed, 18 Feb 2026 14:03:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Feb 2026 15:03:00 +0100
Subject: [PATCH] can: gs_usb: gs_can_open(): always configure bitrates
 before starting device
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-gs_usb-always-configure-bitrates-v1-1-6b4e0970b18a@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJPGlWkC/yXNQQrCMBBA0auUWTuQRijqVUQkk07iiKSSSapSe
 vdGXb7N/wsoZ2GFU7dA5llUptTQ7zrwN5cio4zNYI0djO0PGPValdA9Xu6j6KcUJNbMSFKyK6x
 I3rpAe2OPNEDLPDMHef8W58vfWunOvny7sK4b0hrIeYQAAAA=
X-Change-ID: 20260218-gs_usb-always-configure-bitrates-bc2afb3029b6
To: Vincent Mailhol <mailhol@kernel.org>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3561; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/qDCeM49X4+Z0bmDMqbc0ByiVKbp4U2j46DJfzQ6U2A=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsicemzWBN24+BdNl6+pLvzxNVZQvnmu5b2nXyL0r4pHL
 p1x0e/k6o5SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBMZG4OI8O7R3Nzn+89d4tD
 Mluz9npNzp4dCnIiyuHLRFojkuJCHn9h+O9wuOfxJjPVmHrvCX+S1AQ/TpCIeVQuN8Vg4xHPlQE
 OM5gB
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-6585-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A7C7E157205
X-Rspamd-Action: no action

So far the driver populated the struct can_priv::do_set_bittiming() and
struct can_priv::fd::do_set_data_bittiming() callbacks.

Before bringing up the interface, user space has to configure the bitrates.
With these callbacks the configuration is directly forwarded into the CAN
hardware. Then the interface can be brought up.

An ifdown-ifup cycle (without changing the bit rates) doesn't re-configure
the bitrates in the CAN hardware. This leads to a problem with the
CANable-2.5 [1] firmware, which resets the configured bit rates during
ifdown.

To fix the problem remove both bit timing callbacks and always configure
the bitrates in the struct net_device_ops::ndo_open() callback.

[1] https://github.com/Elmue/CANable-2.5-firmware-Slcan-and-Candlelight

Cc: stable@vger.kernel.org
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d8b2dd74b3a1..6a54fd0717f5 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -772,9 +772,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 }
 
-static int gs_usb_set_bittiming(struct net_device *netdev)
+static int gs_usb_set_bittiming(struct gs_can *dev)
 {
-	struct gs_can *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
@@ -791,9 +790,8 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 				    GFP_KERNEL);
 }
 
-static int gs_usb_set_data_bittiming(struct net_device *netdev)
+static int gs_usb_set_data_bittiming(struct gs_can *dev)
 {
-	struct gs_can *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.fd.data_bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
@@ -1057,6 +1055,20 @@ static int gs_can_open(struct net_device *netdev)
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 		flags |= GS_CAN_MODE_HW_TIMESTAMP;
 
+	rc = gs_usb_set_bittiming(dev);
+	if (rc) {
+		netdev_err(netdev, "failed to set bittiming: %pe)\n", ERR_PTR(rc));
+		goto out_usb_kill_anchored_urbs;
+	}
+
+	if (ctrlmode & CAN_CTRLMODE_FD) {
+		rc = gs_usb_set_data_bittiming(dev);
+		if (rc) {
+			netdev_err(netdev, "failed to set data bittiming: %pe)\n", ERR_PTR(rc));
+			goto out_usb_kill_anchored_urbs;
+		}
+	}
+
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm.flags = cpu_to_le32(flags);
@@ -1370,7 +1382,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev->can.state = CAN_STATE_STOPPED;
 	dev->can.clock.freq = le32_to_cpu(bt_const.fclk_can);
 	dev->can.bittiming_const = &dev->bt_const;
-	dev->can.do_set_bittiming = gs_usb_set_bittiming;
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
@@ -1394,7 +1405,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		 * GS_CAN_FEATURE_BT_CONST_EXT is set.
 		 */
 		dev->can.fd.data_bittiming_const = &dev->bt_const;
-		dev->can.fd.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
 	if (feature & GS_CAN_FEATURE_TERMINATION) {

---
base-commit: 77c5e3fdd2793f478e6fdae55c9ea85b21d06f8f
change-id: 20260218-gs_usb-always-configure-bitrates-bc2afb3029b6

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


