Return-Path: <linux-can+bounces-1136-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EA5948A73
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F301C23143
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EDD1BD4FB;
	Tue,  6 Aug 2024 07:47:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533231BC9EE
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930468; cv=none; b=HunbiLIKby9MeHzIw7Xk6v18z0Ya/8Ql6orWiKfH9is5ub/kHTYLwJ4aO0SyOJOphJNpeemhXcUMKrIFOzDYgv9YU3OJoxwK2gkaRdCdAmJpnTn7V6+v14RzJ0zkhkOdqfj7F1X4te9XGBoduRf7+Nrk1P5I6VBHyoMjiqhwmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930468; c=relaxed/simple;
	bh=Fz+iFrAYeV1F9XMc/uWUhaVGP+c9EPgtkUAOvg6DzzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Krk0iRGgaMzmssEgz9PHSkvtq3PVHBb7VjvDg8AqhO95jdjPVDCen6bgsKlMxiTixQtfkZcPtDlUxvwSv64Mx9cd05F2vu5AXiJhzkiHG0eUr37aIrlNNWRK4Dw4g3tsDH2Z58EOm7iD+zK9fPdcxcqdz4Yp8DH47jowlG7srUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuw-00043h-4O
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuu-004tq6-0H
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AB2EB3179AA
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B016431796E;
	Tue, 06 Aug 2024 07:47:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6a850fff;
	Tue, 6 Aug 2024 07:47:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Haibo Chen <haibo.chen@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/20] can: flexcan: add wakeup support for imx95
Date: Tue,  6 Aug 2024 09:41:54 +0200
Message-ID: <20240806074731.1905378-4-mkl@pengutronix.de>
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

From: Haibo Chen <haibo.chen@nxp.com>

iMX95 defines a bit in GPR that sets/unsets the IPG_STOP signal to the
FlexCAN module, controlling its entry into STOP mode. Wakeup should work
even if FlexCAN is in STOP mode.

Due to iMX95 architecture design, the A-Core cannot access GPR; only the
system manager (SM) can configure GPR. To support the wakeup feature,
follow these steps:

- For suspend:
  1) During Linux suspend, when CAN suspends, do nothing for GPR and keep
     CAN-related clocks on.
  2) In ATF, check whether CAN needs to support wakeup; if yes, send a
     request to SM through the SCMI protocol.
  3) In SM, configure the GPR and unset IPG_STOP.
  4) A-Core suspends.

- For wakeup and resume:
  1) A-Core wakeup event arrives.
  2) In SM, deassert IPG_STOP.
  3) Linux resumes.

Add a new fsl_imx95_devtype_data and FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI to
reflect this.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/all/20240731-flexcan-v4-2-82ece66e5a76@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan/flexcan-core.c | 50 ++++++++++++++++++++++----
 drivers/net/can/flexcan/flexcan.h      |  2 ++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 8ea7f2795551..d11411029330 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -354,6 +354,14 @@ static struct flexcan_devtype_data fsl_imx93_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data fsl_imx95_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI,
+};
+
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
@@ -544,6 +552,13 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR) {
 		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI) {
+		/* For the SCMI mode, driver do nothing, ATF will send request to
+		 * SM(system manager, M33 core) through SCMI protocol after linux
+		 * suspend. Once SM get this request, it will send IPG_STOP signal
+		 * to Flex_CAN, let CAN in STOP mode.
+		 */
+		return 0;
 	}
 
 	return flexcan_low_power_enter_ack(priv);
@@ -555,7 +570,11 @@ static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 	u32 reg_mcr;
 	int ret;
 
-	/* remove stop request */
+	/* Remove stop request, for FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI,
+	 * do nothing here, because ATF already send request to SM before
+	 * linux resume. Once SM get this request, it will deassert the
+	 * IPG_STOP signal to Flex_CAN.
+	 */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW) {
 		ret = flexcan_stop_mode_enable_scfw(priv, false);
 		if (ret < 0)
@@ -1983,6 +2002,9 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		ret = flexcan_setup_stop_mode_scfw(pdev);
 	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
 		ret = flexcan_setup_stop_mode_gpr(pdev);
+	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
+		/* ATF will handle all STOP_IPG related work */
+		ret = 0;
 	else
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
@@ -2009,6 +2031,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx8qm-flexcan", .data = &fsl_imx8qm_devtype_data, },
 	{ .compatible = "fsl,imx8mp-flexcan", .data = &fsl_imx8mp_devtype_data, },
 	{ .compatible = "fsl,imx93-flexcan", .data = &fsl_imx93_devtype_data, },
+	{ .compatible = "fsl,imx95-flexcan", .data = &fsl_imx95_devtype_data, },
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
 	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, },
@@ -2309,9 +2332,19 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, true);
 
-		err = pm_runtime_force_suspend(device);
-		if (err)
-			return err;
+		/* For FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI, it need ATF to send
+		 * to SM through SCMI protocol, SM will assert the IPG_STOP
+		 * signal. But all this works need the CAN clocks keep on.
+		 * After the CAN module get the IPG_STOP mode, and switch to
+		 * STOP mode, whether still keep the CAN clocks on or gate them
+		 * off depend on the Hardware design.
+		 */
+		if (!(device_may_wakeup(device) &&
+		      priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)) {
+			err = pm_runtime_force_suspend(device);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
@@ -2325,9 +2358,12 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		err = pm_runtime_force_resume(device);
-		if (err)
-			return err;
+		if (!(device_may_wakeup(device) &&
+		      priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)) {
+			err = pm_runtime_force_resume(device);
+			if (err)
+				return err;
+		}
 
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, false);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 025c3417031f..4933d8c7439e 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -68,6 +68,8 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
 /* Device supports RX via FIFO */
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
+/* Setup stop mode with ATF SCMI protocol to support wakeup */
+#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.43.0



