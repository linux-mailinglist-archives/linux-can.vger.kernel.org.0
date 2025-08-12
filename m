Return-Path: <linux-can+bounces-4214-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1401FB22F55
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC2068145F
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FDF2FF150;
	Tue, 12 Aug 2025 17:37:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09972FDC4A
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020247; cv=none; b=IgB8KK8XIq1T3RZXpFxKF5jCyLinExNjW7NM3B4WrAuHZ8BuAP1U70/jmn7sjBw/cXw20VaMGm/l8usEASm/HPUhjyTdDzzCreVN5ZXhn58lWGFm9B2zcAP9ngyFNlvOwQRRDiqQ+l0AMQSfeWQD/0ZvIwG4um41OQdKyrjQVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020247; c=relaxed/simple;
	bh=ADOn7ZMH2Q2fpAKxg4S8RBm4xi1hnJJ+M+eDiEmS1fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOXjyorNsIlOWaW7HiD9jU1GH3NaS3OALpfWN89c4FfMnhUe5+Dz1d7gBeLeXLXQvsN1qcpV8ZLX3KjXQV7UFrNTBgUI0G4wbcEZSgljDJw/HbZs6knKtZvusJOORHiI0Z+L4c/t09iXiEsFFC+juFPz2H6EMoglcRwAnD+l8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw7-0008OK-Rh
	for linux-can@vger.kernel.org; Tue, 12 Aug 2025 19:37:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw7-00DEcb-0W
	for linux-can@vger.kernel.org;
	Tue, 12 Aug 2025 19:37:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id CE38745625E
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 17:37:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B41AF456203;
	Tue, 12 Aug 2025 17:37:17 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f2d72401;
	Tue, 12 Aug 2025 17:37:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 12 Aug 2025 19:36:57 +0200
Subject: [PATCH 7/7] can: m_can: add optional support for reset
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-m_can-fix-state-handling-v1-7-b739e06c0a3b@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=3596; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ADOn7ZMH2Q2fpAKxg4S8RBm4xi1hnJJ+M+eDiEmS1fE=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBom3vK0Q1u08n9LtlJhTdiBEqmYQq6lcphxkQpe
 UuLyEfvG5SJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJt7ygAKCRAMdGXf+ZCR
 nKBNB/9aXuli48yrbb2ITSRzcyynp0OXVQMgsZyWOtt6/0Yjhab+nPzNoYZ1tMEy3luYyrzz9lx
 F7C1DcuKzfcfTuBegQroId6jmciHcP17eL+mjxrtlO3uDibqcTggvWjNpBimxLEiMiDYO8XJxJn
 /Cf7Z2TCJ4i2BOAkWvhUfthxqq6lLA3f1EI4rsn4hjeKupTWV1E/OLYLmCesViUPqn5iJAJvAOR
 rTCUGXmVcQfTvpQ05FSzoFxbYCoxYDFExsnQ1tH/gSG+7vm8N9l7fsYRZITkkfjzsjuErml+JXa
 eS2d0d8UHFNi5WNvdYEoswpwHIvJb7IeoTD85Kl44R5vt/h7
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

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 26 +++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c24ea0e5599f..0a6d4b523c33 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,6 +23,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "m_can.h"
 
@@ -1833,6 +1834,7 @@ static int m_can_close(struct net_device *dev)
 
 	close_candev(dev);
 
+	reset_control_assert(cdev->rsts);
 	m_can_clk_stop(cdev);
 	phy_power_off(cdev->transceiver);
 
@@ -2075,11 +2077,15 @@ static int m_can_open(struct net_device *dev)
 	if (err)
 		goto out_phy_power_off;
 
+	err = reset_control_deassert(cdev->rsts);
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
@@ -2135,6 +2141,8 @@ static int m_can_open(struct net_device *dev)
 	else
 		napi_disable(&cdev->napi);
 	close_candev(dev);
+out_reset_control_assert:
+	reset_control_assert(cdev->rsts);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
 out_phy_power_off:
@@ -2425,15 +2433,23 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		}
 	}
 
+	cdev->rsts = devm_reset_control_get_optional_shared(cdev->dev, NULL);
+	if (IS_ERR(cdev->rsts))
+		return PTR_ERR(cdev->rsts);
+
 	ret = m_can_clk_start(cdev);
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(cdev->rsts);
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
@@ -2462,8 +2478,10 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
 
 	/* Probe finished
-	 * Stop clocks. They will be reactivated once the M_CAN device is opened
+	 * Assert rest and stop clocks.
+	 * They will be reactivated once the M_CAN device is opened
 	 */
+	reset_control_assert(cdev->rsts);
 	m_can_clk_stop(cdev);
 
 	return 0;
@@ -2471,6 +2489,8 @@ int m_can_class_register(struct m_can_classdev *cdev)
 rx_offload_del:
 	if (cdev->is_peripheral)
 		can_rx_offload_del(&cdev->offload);
+out_reset_control_assert:
+	reset_control_assert(cdev->rsts);
 clk_disable:
 	m_can_clk_stop(cdev);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index bd4746c63af3..5e901d5bf6ff 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -86,6 +86,7 @@ struct m_can_classdev {
 	struct device *dev;
 	struct clk *hclk;
 	struct clk *cclk;
+	struct reset_control *rsts;
 
 	struct workqueue_struct *tx_wq;
 	struct phy *transceiver;

-- 
2.50.1



