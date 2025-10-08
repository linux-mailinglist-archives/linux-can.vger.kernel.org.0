Return-Path: <linux-can+bounces-5103-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69DBC42C5
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79F8A4ED640
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F12ED14C;
	Wed,  8 Oct 2025 09:38:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD32EBDF4
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916332; cv=none; b=VmlTqaWI4pZMAGli/AtiqMeKNLfniz1PTduWWlzD+QQZ1IfLmffQkneabhI2ZDUpYmiASeca3W58FshgeuM72hnnfOp1tW6GkdpYaZh+xH+Uvx+8YpazC25KObVwcFQPk/g62dacyYL0B0SMHaOvLsqH3Ic18w6OCk/CsyEdoZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916332; c=relaxed/simple;
	bh=xfEzirY/nt1DJN1CvcO4+exFhSIFPVcVcgxgsPcUUrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z48v4zSGLPiHcndWAem7DbR0Bnr5ilRwx/Da4ZoGHxE1WY50hR0X9fVD7aD7N5xodLHexIRX/T7mi3IL9adnA6EGO2QPYP7KAYUDx/+CKa8MiVc3bZMQsYwVmFHwNBl/E8p60evz+1X8qWHDLxjBwMp+/yaQ5YtyzufpzoCg6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6Qd8-0004Hl-17; Wed, 08 Oct 2025 11:38:42 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6Qd6-002XwW-2O;
	Wed, 08 Oct 2025 11:38:40 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7302A481D72;
	Wed, 08 Oct 2025 09:38:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 08 Oct 2025 11:38:30 +0200
Subject: [PATCH can-next] can: m_can: add support for optional reset
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-m_can-add-reset-v1-1-49f0bbf820c4@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIABUx5mgC/x2MQQqAMAzAviI9W+gUQfyKiHRb1R6csokI4t+dH
 gNJbkgSVRJ0xQ1RTk26hQymLMAtHGZB9ZmhoqoxRC2uo+OA7D1GSXIgT4bYkqtbtpCrPcqk13/
 s4VODXAcMz/MC61XgcWsAAAA=
X-Change-ID: 20251008-m_can-add-reset-af10ab0c38ab
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-b87af
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xfEzirY/nt1DJN1CvcO4+exFhSIFPVcVcgxgsPcUUrc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5jEdXsAQZgtVSn/CpYcb8dLxhrRo27mRHg1rP
 tzFee5m1aKJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOYxHQAKCRAMdGXf+ZCR
 nHCFB/9Povbb0Hd0ZpB/fx3g4c5Y9IlBKv73OWLXqZ6uXPBiLMep0kX9GgpykZG+Cvi0yNZzyc+
 AknKIm0b9SK/d/LcVsD7vjabaOAD6BeGo1CrYv2uj7tfkH8y7jH6xpdt2y/L0qvyb55KVAcwEfI
 DfUqOUYBC0suetmY/ji030owr+hH6lOk7ioJpAG7a/r56YI4niPVxeqfrHzWbTKLuWpLqPGC/Mi
 byl1fJwYavpbS0fGjreCt9OYhu0uKVx3cr9ja28BJ/GzTSaxjSk2JiiZdHahniJwLBrxSyyYEKZ
 BkEk/NSPvSPq7aDfFTjd8UxjPdbSzKGytm6REKMoymRNwG/Q
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

This patch has been split from the original series [1].

In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the CAN
state and CAN error counters over an internal reset cycle. The STM32MP15
SoC provides an external reset, which is shared between both M_CAN cores.

Add support for an optional external reset. Take care of shared resets,
de-assert reset during the probe phase in m_can_class_register() and while
the interface is up, assert the reset otherwise.

[1] https://lore.kernel.org/all/20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 27 ++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e1d725979685..520e079d2bd4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,6 +23,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "m_can.h"
 
@@ -1816,6 +1817,7 @@ static int m_can_close(struct net_device *dev)
 
 	close_candev(dev);
 
+	reset_control_assert(cdev->rst);
 	m_can_clk_stop(cdev);
 	phy_power_off(cdev->transceiver);
 
@@ -2058,11 +2060,15 @@ static int m_can_open(struct net_device *dev)
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
@@ -2118,6 +2124,8 @@ static int m_can_open(struct net_device *dev)
 	else
 		napi_disable(&cdev->napi);
 	close_candev(dev);
+out_reset_control_assert:
+	reset_control_assert(cdev->rst);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
 out_phy_power_off:
@@ -2406,15 +2414,24 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		}
 	}
 
+	cdev->rst = devm_reset_control_get_optional_shared(cdev->dev, NULL);
+	if (IS_ERR(cdev->rst))
+		return dev_err_probe(cdev->dev, PTR_ERR(cdev->rst),
+				     "Failed to get reset line\n");
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
@@ -2443,8 +2460,10 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
 
 	/* Probe finished
-	 * Stop clocks. They will be reactivated once the M_CAN device is opened
+	 * Assert reset and stop clocks.
+	 * They will be reactivated once the M_CAN device is opened
 	 */
+	reset_control_assert(cdev->rst);
 	m_can_clk_stop(cdev);
 
 	return 0;
@@ -2452,6 +2471,8 @@ int m_can_class_register(struct m_can_classdev *cdev)
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

---
base-commit: 07fdad3a93756b872da7b53647715c48d0f4a2d0
change-id: 20251008-m_can-add-reset-af10ab0c38ab

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


