Return-Path: <linux-can+bounces-4901-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B303BB95357
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB613B4F85
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412532745E;
	Tue, 23 Sep 2025 09:18:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9506258CF9
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619107; cv=none; b=SRm+/WxRhaUxwP72SGju0TMfmHkEfs3Tsg3gYaSRmMrqv1urdCgLXw3Ni9Fth62dCxf+9Ciy5AWmEVGCfXZKCldFDh3vgkW20pZlZgQvWQSJ7lEwm3hhXuqVLcyxhOkIUDrwz2pBrg/zKZuiMIP9UHPCPQdDzTBZjW6oT06uCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619107; c=relaxed/simple;
	bh=I2XWrrITpsABRWcOX4HPQ5WhyP/KhZxK8Qu44NBDObI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Roy0TaIXkaMQBjDpCxJHdvxXYlfM4XNoYnoa2oRh16Arq7Md/YIIGVx8GcGamcvJZGvMu9slEZzljTwa8wXDKwNGaNnGtaCu2LJShwMPL9KnhPYjBEt+ZsRl4K4wnEv9+qHk8qQsFsUFYVzYmxN0zCu6WKnHagtfTtXf3N2M/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9e-0006Xd-2d; Tue, 23 Sep 2025 11:17:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9c-0004AQ-2k;
	Tue, 23 Sep 2025 11:17:44 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 91CE0477C08;
	Tue, 23 Sep 2025 09:17:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 23 Sep 2025 11:17:19 +0200
Subject: [PATCH v3 6/6] can: m_can: add optional support for reset
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-m_can-fix-state-handling-v3-6-06d8baccadbf@pengutronix.de>
References: <20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de>
In-Reply-To: <20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
 Wu Bo <wubo.oduw@gmail.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=I2XWrrITpsABRWcOX4HPQ5WhyP/KhZxK8Qu44NBDObI=;
 b=owEBbAGT/pANAwAKAQx0Zd/5kJGcAcsmYgBo0mW2Cx8E7vD2SbSFSP70uNJ4IZUx99dHadDgk
 tbWQHV8NeyJATIEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaNJltgAKCRAMdGXf+ZCR
 nEp/B/Y2zsV5LRXl0crc0OIFsWZT2drFFDAfxApLPpb6vnei1lOcz/1b7EHcDLag0VL7UjTiBvX
 fiEEbSS/N9ZLCHpLxXbiuS3E9mpbYlb+Dta4ukt7wO/4uNi6GeOKJAxvvnc+/hZOgReBpoH8v9b
 C57ri7fIN9R3qcPmRm9W4wBsPLnEwhB4lzkovxN2N3qvKlfgVKlAt7jbi8NLe+hKQJD3ajM3CUr
 Uax+1FyRXE6GOReuQteGhEHdNkmGOuHh+G7t3htLRMN9dRDlPtVNj5x7gHazs/W3o5MtN+2EFUD
 45ZW7D2qI7n1YN3Z2ag/9khrPbSgJ8Ul0PZUKNeyn9NpeD8=
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
 drivers/net/can/m_can/m_can.c | 27 ++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index afbab6ca5833..e6c3b089c368 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,6 +23,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "m_can.h"
 
@@ -1831,6 +1832,7 @@ static int m_can_close(struct net_device *dev)
 
 	close_candev(dev);
 
+	reset_control_assert(cdev->rst);
 	m_can_clk_stop(cdev);
 	phy_power_off(cdev->transceiver);
 
@@ -2073,11 +2075,15 @@ static int m_can_open(struct net_device *dev)
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
@@ -2133,6 +2139,8 @@ static int m_can_open(struct net_device *dev)
 	else
 		napi_disable(&cdev->napi);
 	close_candev(dev);
+out_reset_control_assert:
+	reset_control_assert(cdev->rst);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
 out_phy_power_off:
@@ -2423,15 +2431,24 @@ int m_can_class_register(struct m_can_classdev *cdev)
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
@@ -2460,8 +2477,10 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
 
 	/* Probe finished
-	 * Stop clocks. They will be reactivated once the M_CAN device is opened
+	 * Assert reset and stop clocks.
+	 * They will be reactivated once the M_CAN device is opened
 	 */
+	reset_control_assert(cdev->rst);
 	m_can_clk_stop(cdev);
 
 	return 0;
@@ -2469,6 +2488,8 @@ int m_can_class_register(struct m_can_classdev *cdev)
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


