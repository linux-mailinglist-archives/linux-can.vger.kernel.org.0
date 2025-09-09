Return-Path: <linux-can+bounces-4590-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD5EB504BE
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 19:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A84E188301D
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1F3629BA;
	Tue,  9 Sep 2025 17:53:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660D35CEC2
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440432; cv=none; b=WNnHWBatG58NM5oXKzykzdJQmg6m+buBGK7bkcM3yturdBc0Jf2U6ackvdtHBObsVgrOX0wWfPInlEux7fe9mRGPc7MsfMWQm/ptaOMruUSEcnfi1++ys9+yyNpAtigC3BbcyTi1RgbOWeI3xL9VfMtrKcDzC7giQWX1IVDkYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440432; c=relaxed/simple;
	bh=37cJ0VRVY4LkRBZrQ1aDkaxTmIRzfMkMlfj/4/5OSR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkeob5q/TF1HnBhXi8AD89effwJtmKEx3xzm63G/B6b6K4b0cIQYHbTz29J3rAWW/HpOToIxPPi2/2jSgOzEGHZjEHNdhhvDI0YN7scOCd44cXZ7TR1IJs37M5jSZ9ECdyUGFr/ZGhnpBcNtO6wM39myeNn5FfyLiCAKqBX5gU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XL-0006rJ-TK
	for linux-can@vger.kernel.org; Tue, 09 Sep 2025 19:53:47 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XK-000Se6-2d
	for linux-can@vger.kernel.org;
	Tue, 09 Sep 2025 19:53:46 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7C9E246A3F9
	for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 17:53:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D1E5B46A3AA;
	Tue, 09 Sep 2025 17:53:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id eeee500c;
	Tue, 9 Sep 2025 17:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 09 Sep 2025 19:53:23 +0200
Subject: [PATCH v2 7/7] can: m_can: add optional support for reset
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-m_can-fix-state-handling-v2-7-af9fa240b68a@pengutronix.de>
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de>
In-Reply-To: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
 Wu Bo <wubo.oduw@gmail.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=3640; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=37cJ0VRVY4LkRBZrQ1aDkaxTmIRzfMkMlfj/4/5OSR4=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBowGmiaq5cEgfZlHcB6TyW+RbFlMxuSLYs0l1DH
 GHm9JQuIB6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaMBpogAKCRAMdGXf+ZCR
 nIpwCACtqZtqehRZQFlwFDfxfwBYgVewR9U7Zk1iN+wTLEqOOhOkvjBGwpe9aJq3ZzFGhkZyvG/
 U11bg2ZNvTDEMEkz7rvg72ByzPg/uP+cDrepHvFAU8uqRwJvrM/cs7vCpVKByyVJEI4Dm6oRT8w
 KsFUyk3W9g1JxOU+c+R0To0X9tA045YqyHbFdMNTFMVrYHYslLDpDMh0qwyMacX0Pgt/qEr8CfP
 3EDFhO6DY3Iuas917SPv/fjI/SPsxTqTclFiIjWMgaJ7i9YtLVsdAZlziHzm7dtcSEGJhEsL5LB
 xnT+a29K46xpipa+l+AMGG+ailPwrtqq+prL1/xwu+ffex5U
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the
CAN state and CAN error counters over an internal reset cycle. The
STM32MP15 SoC provides an external reset, which is shared between both
M_CAN cores.

Add support for an optional external reset. Take care of shared
resets, de-assert reset during the probe phase in
m_can_class_register() and while the interface is up, assert the reset
otherwise.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 26 +++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9528af8500af..93085bf1c267 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,6 +23,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "m_can.h"
 
@@ -1834,6 +1835,7 @@ static int m_can_close(struct net_device *dev)
 
 	close_candev(dev);
 
+	reset_control_assert(cdev->rst);
 	m_can_clk_stop(cdev);
 	phy_power_off(cdev->transceiver);
 
@@ -2076,11 +2078,15 @@ static int m_can_open(struct net_device *dev)
 	if (err)
 		goto out_phy_power_off;
 
+	err = reset_control_deassert(cdev->rst);
+	if (err)
+		goto exit_disable_clks;
+
 	/* open the can device */
 	err = open_candev(dev);
 	if (err) {
 		netdev_err(dev, "failed to open can device\n");
-		goto exit_disable_clks;
+		goto out_reset_control_assert;
 	}
 
 	if (cdev->is_peripheral)
@@ -2136,6 +2142,8 @@ static int m_can_open(struct net_device *dev)
 	else
 		napi_disable(&cdev->napi);
 	close_candev(dev);
+out_reset_control_assert:
+	reset_control_assert(cdev->rst);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
 out_phy_power_off:
@@ -2426,15 +2434,23 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		}
 	}
 
+	cdev->rst = devm_reset_control_get_optional_shared(cdev->dev, NULL);
+	if (IS_ERR(cdev->rst))
+		return PTR_ERR(cdev->rst);
+
 	ret = m_can_clk_start(cdev);
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(cdev->rst);
+	if (ret)
+		goto clk_disable;
+
 	if (cdev->is_peripheral) {
 		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
 						NAPI_POLL_WEIGHT);
 		if (ret)
-			goto clk_disable;
+			goto out_reset_control_assert;
 	}
 
 	if (!cdev->net->irq) {
@@ -2463,8 +2479,10 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
 
 	/* Probe finished
-	 * Stop clocks. They will be reactivated once the M_CAN device is opened
+	 * Assert reset and stop clocks.
+	 * They will be reactivated once the M_CAN device is opened
 	 */
+	reset_control_assert(cdev->rst);
 	m_can_clk_stop(cdev);
 
 	return 0;
@@ -2472,6 +2490,8 @@ int m_can_class_register(struct m_can_classdev *cdev)
 rx_offload_del:
 	if (cdev->is_peripheral)
 		can_rx_offload_del(&cdev->offload);
+out_reset_control_assert:
+	reset_control_assert(cdev->rst);
 clk_disable:
 	m_can_clk_stop(cdev);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index bd4746c63af3..7b7600697c6b 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -86,6 +86,7 @@ struct m_can_classdev {
 	struct device *dev;
 	struct clk *hclk;
 	struct clk *cclk;
+	struct reset_control *rst;
 
 	struct workqueue_struct *tx_wq;
 	struct phy *transceiver;

-- 
2.51.0



