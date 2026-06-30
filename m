Return-Path: <linux-can+bounces-7915-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rKaB5G2Q2qLfgoAu9opvQ
	(envelope-from <linux-can+bounces-7915-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 14:29:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDC16E42C2
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 14:29:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=HF5xdtt5;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7915-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7915-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76D1B303A678
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FE3CBE89;
	Tue, 30 Jun 2026 12:29:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A040B383
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 12:28:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822542; cv=none; b=uzLYZTryyu9lp/bBIsxpb3qr2fGcb/fC7yG5AqfSAk25q6aYpNi69VTM02B2Ou715/HRr0TSyYvT+kjZ76stdOC5F7HDckzsxzoUNiplCw7Bp2ALIKYDEm31r+Ew5cE3zsqDJIp5z3aE2YNuhYRkhRU4Mj9hRgliu/X2m/iR1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822542; c=relaxed/simple;
	bh=5K4d3a9c2RvkGp+kQqvLMHZ2Bt/PjI5n/G2uKInObac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nk3wVj4VSxynI7k6rx4yWAV4tc3u+5+G4swuqmG+hmyyXWI+ElE7gBj/ggogcwPulW+cB//iBk5Y8/8z8VeGMPQ+/dqVMWaXMGadIlMDMegIjToO+vnfQIqfYYDNwBdpviP8Oick4GdJR9vTiRyArMhH01KvtgGg0A+yiU+TWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HF5xdtt5; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2D1C24E40BAE;
	Tue, 30 Jun 2026 12:28:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E730E6025A;
	Tue, 30 Jun 2026 12:28:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF6B9106F17B5;
	Tue, 30 Jun 2026 14:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782822536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=oNGP3sotdTmFK6A7nU9ncpG1ZNmDDoUD7AUxOXF4ib4=;
	b=HF5xdtt5CnsXpRvkJRSEkWxTm+7LOvlvuahtWUHVT6H6ITA4Fm/z2tOTeePwOy0bIan7yN
	Rarubp69V8BnNPsSU0yYZ8NiFiVzPKCv+S3pwkQq+v1u37buOW7Cmi41ZEyB2YAS79dIpY
	PK2crJNBg5oEQkNlt9vPrtAV8xxQSfr1SJwHnMzWpKWeIgFM38AFLMmq6kaTBPSWw97l9D
	gHJgmftbNn2yw3NKsF5hU14Gw9QLpqiseQEQxTNQC5nJqL3AfcvrtMm9nhYf9+zkkDfv8N
	WdMmOQIoejK0N9e0cyNJbaJUPm57dX1O728T3g5cUkBRLwcUUfPpbPnY91Ph9w==
From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
Date: Tue, 30 Jun 2026 14:28:46 +0200
Subject: [PATCH] phy: phy-can-transceiver: Add suspend operation for
 tcan1043
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-phy-can-transceiver-suspend-resume-support-v1-1-6842c2d697e4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAH62Q2oC/y3NMQ7CMAyF4atUnrHUBlEFroIYQuJQD6TBTqqiq
 ncnAsbvDe/fQEmYFC7dBkILK8+pYTh04CeXHoQcmsH0ZuzHwWKe3uhdwiIuqSdeSFCrZkoBhbQ
 +qTHnWQoGOsejsScT7xbaYRaKvH5j19vPQq/amuU/7vsHXyPrKpEAAAA=
X-Change-ID: 20260618-phy-can-transceiver-suspend-resume-support-de9f32852fb8
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, richard.genoud@bootlin.com, 
 Udit Kumar <u-kumar1@ti.com>, Abhash Kumar <a-kumar2@ti.com>, 
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 "Thomas Richard (TI)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7915-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thomas.richard@bootlin.com,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:vkoul@kernel.org,m:neil.armstrong@linaro.org,m:thomas.petazzoni@bootlin.com,m:gregory.clement@bootlin.com,m:richard.genoud@bootlin.com,m:u-kumar1@ti.com,m:a-kumar2@ti.com,m:linux-can@vger.kernel.org,m:linux-phy@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:thomas.richard@bootlin.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.richard@bootlin.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FDC16E42C2

Add suspend operation for tcan1043. It switches the PHY in Sleep mode, the
lowest power mode of the device. If a bus wake-up pattern or a local
wake-up event occurs, the PHY transitions to Standby mode, set its internal
WAKERQ flag and set the INH output high. In Sleep mode INH is floating.

The WAKERQ flag prevents transition to Go-to-Sleep mode. The only way to
clear it is to switch to Normal mode. So to reach Sleep mode, we firstly
switch to Normal mode, then to Go-to-Sleep mode.

Suspend sequence (PHY is off):

    Standby -> Normal -> Go-to-Sleep -> Sleep

Suspend sequence (PHY is on):

    Normal -> Go-to-Sleep -> Sleep

Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
---
 drivers/phy/phy-can-transceiver.c | 56 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 75dc49e75ca0..2bca1a173fcc 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
  *
  */
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -12,25 +13,28 @@
 #include <linux/module.h>
 #include <linux/mux/consumer.h>
 
+struct can_transceiver_phy {
+	struct phy *generic_phy;
+	struct gpio_desc *silent_gpio;
+	struct gpio_desc *standby_gpio;
+	struct gpio_desc *enable_gpio;
+	struct can_transceiver_priv *priv;
+};
+
 struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
 #define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
 #define CAN_TRANSCEIVER_SILENT_PRESENT	BIT(3)
+	int	(*suspend)(struct can_transceiver_phy *phy);
 };
 
-struct can_transceiver_phy {
-	struct phy *generic_phy;
-	struct gpio_desc *silent_gpio;
-	struct gpio_desc *standby_gpio;
-	struct gpio_desc *enable_gpio;
-	struct can_transceiver_priv *priv;
-};
 
 struct can_transceiver_priv {
 	struct mux_state *mux_state;
 	int num_ch;
+	const struct can_transceiver_data *data;
 	struct can_transceiver_phy can_transceiver_phy[] __counted_by(num_ch);
 };
 
@@ -76,12 +80,28 @@ static const struct phy_ops can_transceiver_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static int tcan1043_suspend(struct can_transceiver_phy *phy)
+{
+	/* Switch to Normal mode, it clears WAKERQ */
+	gpiod_set_value_cansleep(phy->standby_gpio, 0);
+	gpiod_set_value_cansleep(phy->enable_gpio, 1);
+
+	/* Switch to Go-to-Sleep mode */
+	gpiod_set_value_cansleep(phy->standby_gpio, 1);
+
+	/* Wait transition to Sleep mode */
+	fsleep(5);
+
+	return 0;
+}
+
 static const struct can_transceiver_data tcan1042_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT,
 };
 
 static const struct can_transceiver_data tcan1043_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
+	.suspend = tcan1043_suspend,
 };
 
 static const struct can_transceiver_data tja1048_drvdata = {
@@ -115,6 +135,26 @@ static struct phy *can_transceiver_phy_xlate(struct device *dev,
 	return priv->can_transceiver_phy[idx].generic_phy;
 }
 
+static int can_transceiver_phy_suspend(struct device *dev)
+{
+	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
+	const struct can_transceiver_data *data = priv->data;
+	int ret, i;
+
+	for (i = 0; i < priv->num_ch; i++) {
+		if (data->suspend) {
+			ret = data->suspend(&priv->can_transceiver_phy[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(can_transceiver_phy_pm_ops,
+				can_transceiver_phy_suspend, NULL);
+
 static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -145,6 +185,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->num_ch = num_ch;
+	priv->data = drvdata;
 	platform_set_drvdata(pdev, priv);
 
 	mux_state = devm_mux_state_get_optional(dev, NULL);
@@ -247,6 +288,7 @@ static struct platform_driver can_transceiver_phy_driver = {
 	.driver = {
 		.name = "can-transceiver-phy",
 		.of_match_table = can_transceiver_phy_ids,
+		.pm = pm_sleep_ptr(&can_transceiver_phy_pm_ops),
 	},
 };
 

---
base-commit: a25d586f7f9e7f22e7e0350053c15924d28ed6ee
change-id: 20260618-phy-can-transceiver-suspend-resume-support-de9f32852fb8

Best regards,
-- 
Thomas Richard (TI) <thomas.richard@bootlin.com>


