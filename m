Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABD2D88CB
	for <lists+linux-can@lfdr.de>; Sat, 12 Dec 2020 18:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439616AbgLLR4P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 12 Dec 2020 12:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439614AbgLLR4I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 12 Dec 2020 12:56:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C6C061794
        for <linux-can@vger.kernel.org>; Sat, 12 Dec 2020 09:55:28 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ko979-0000zD-6h
        for linux-can@vger.kernel.org; Sat, 12 Dec 2020 18:55:27 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 811BA5ABDCD
        for <linux-can@vger.kernel.org>; Sat, 12 Dec 2020 17:55:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3A2D15ABDAA;
        Sat, 12 Dec 2020 17:55:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5ce046bd;
        Sat, 12 Dec 2020 17:55:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 3/7] can: m_can: use cdev as name for struct m_can_classdev uniformly
Date:   Sat, 12 Dec 2020 18:55:14 +0100
Message-Id: <20201212175518.139651-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212175518.139651-1-mkl@pengutronix.de>
References: <20201212175518.139651-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch coverts the m_can driver to use cdev as name for struct
m_can_classdev uniformly throughout the whole driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 98 +++++++++++++++++------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 27e736464580..fb408ca85188 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1327,79 +1327,79 @@ static bool m_can_niso_supported(struct m_can_classdev *cdev)
 	return !niso_timeout;
 }
 
-static int m_can_dev_setup(struct m_can_classdev *m_can_dev)
+static int m_can_dev_setup(struct m_can_classdev *cdev)
 {
-	struct net_device *dev = m_can_dev->net;
+	struct net_device *dev = cdev->net;
 	int m_can_version;
 
-	m_can_version = m_can_check_core_release(m_can_dev);
+	m_can_version = m_can_check_core_release(cdev);
 	/* return if unsupported version */
 	if (!m_can_version) {
-		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
+		dev_err(cdev->dev, "Unsupported version number: %2d",
 			m_can_version);
 		return -EINVAL;
 	}
 
-	if (!m_can_dev->is_peripheral)
-		netif_napi_add(dev, &m_can_dev->napi,
+	if (!cdev->is_peripheral)
+		netif_napi_add(dev, &cdev->napi,
 			       m_can_poll, M_CAN_NAPI_WEIGHT);
 
 	/* Shared properties of all M_CAN versions */
-	m_can_dev->version = m_can_version;
-	m_can_dev->can.do_set_mode = m_can_set_mode;
-	m_can_dev->can.do_get_berr_counter = m_can_get_berr_counter;
+	cdev->version = m_can_version;
+	cdev->can.do_set_mode = m_can_set_mode;
+	cdev->can.do_get_berr_counter = m_can_get_berr_counter;
 
 	/* Set M_CAN supported operations */
-	m_can_dev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+	cdev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_BERR_REPORTING |
 		CAN_CTRLMODE_FD |
 		CAN_CTRLMODE_ONE_SHOT;
 
 	/* Set properties depending on M_CAN version */
-	switch (m_can_dev->version) {
+	switch (cdev->version) {
 	case 30:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
 		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
-		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
-			m_can_dev->bit_timing : &m_can_bittiming_const_30X;
+		cdev->can.bittiming_const = cdev->bit_timing ?
+			cdev->bit_timing : &m_can_bittiming_const_30X;
 
-		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
-			m_can_dev->data_timing :
+		cdev->can.data_bittiming_const = cdev->data_timing ?
+			cdev->data_timing :
 			&m_can_data_bittiming_const_30X;
 		break;
 	case 31:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
 		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
-		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
-			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
+		cdev->can.bittiming_const = cdev->bit_timing ?
+			cdev->bit_timing : &m_can_bittiming_const_31X;
 
-		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
-			m_can_dev->data_timing :
+		cdev->can.data_bittiming_const = cdev->data_timing ?
+			cdev->data_timing :
 			&m_can_data_bittiming_const_31X;
 		break;
 	case 32:
 	case 33:
 		/* Support both MCAN version v3.2.x and v3.3.0 */
-		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
-			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
+		cdev->can.bittiming_const = cdev->bit_timing ?
+			cdev->bit_timing : &m_can_bittiming_const_31X;
 
-		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
-			m_can_dev->data_timing :
+		cdev->can.data_bittiming_const = cdev->data_timing ?
+			cdev->data_timing :
 			&m_can_data_bittiming_const_31X;
 
-		m_can_dev->can.ctrlmode_supported |=
-			(m_can_niso_supported(m_can_dev) ?
+		cdev->can.ctrlmode_supported |=
+			(m_can_niso_supported(cdev) ?
 			 CAN_CTRLMODE_FD_NON_ISO : 0);
 		break;
 	default:
-		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
-			m_can_dev->version);
+		dev_err(cdev->dev, "Unsupported version number: %2d",
+			cdev->version);
 		return -EINVAL;
 	}
 
-	if (m_can_dev->ops->init)
-		m_can_dev->ops->init(m_can_dev);
+	if (cdev->ops->init)
+		cdev->ops->init(cdev);
 
 	return 0;
 }
@@ -1751,15 +1751,15 @@ void m_can_init_ram(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_init_ram);
 
-int m_can_class_get_clocks(struct m_can_classdev *m_can_dev)
+int m_can_class_get_clocks(struct m_can_classdev *cdev)
 {
 	int ret = 0;
 
-	m_can_dev->hclk = devm_clk_get(m_can_dev->dev, "hclk");
-	m_can_dev->cclk = devm_clk_get(m_can_dev->dev, "cclk");
+	cdev->hclk = devm_clk_get(cdev->dev, "hclk");
+	cdev->cclk = devm_clk_get(cdev->dev, "cclk");
 
-	if (IS_ERR(m_can_dev->cclk)) {
-		dev_err(m_can_dev->dev, "no clock found\n");
+	if (IS_ERR(cdev->cclk)) {
+		dev_err(cdev->dev, "no clock found\n");
 		ret = -ENODEV;
 	}
 
@@ -1818,49 +1818,49 @@ void m_can_class_free_dev(struct net_device *net)
 }
 EXPORT_SYMBOL_GPL(m_can_class_free_dev);
 
-int m_can_class_register(struct m_can_classdev *m_can_dev)
+int m_can_class_register(struct m_can_classdev *cdev)
 {
 	int ret;
 
-	if (m_can_dev->pm_clock_support) {
-		ret = m_can_clk_start(m_can_dev);
+	if (cdev->pm_clock_support) {
+		ret = m_can_clk_start(cdev);
 		if (ret)
 			return ret;
 	}
 
-	ret = m_can_dev_setup(m_can_dev);
+	ret = m_can_dev_setup(cdev);
 	if (ret)
 		goto clk_disable;
 
-	ret = register_m_can_dev(m_can_dev->net);
+	ret = register_m_can_dev(cdev->net);
 	if (ret) {
-		dev_err(m_can_dev->dev, "registering %s failed (err=%d)\n",
-			m_can_dev->net->name, ret);
+		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
+			cdev->net->name, ret);
 		goto clk_disable;
 	}
 
-	devm_can_led_init(m_can_dev->net);
+	devm_can_led_init(cdev->net);
 
-	of_can_transceiver(m_can_dev->net);
+	of_can_transceiver(cdev->net);
 
-	dev_info(m_can_dev->dev, "%s device registered (irq=%d, version=%d)\n",
-		 KBUILD_MODNAME, m_can_dev->net->irq, m_can_dev->version);
+	dev_info(cdev->dev, "%s device registered (irq=%d, version=%d)\n",
+		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
 
 	/* Probe finished
 	 * Stop clocks. They will be reactivated once the M_CAN device is opened
 	 */
 clk_disable:
-	m_can_clk_stop(m_can_dev);
+	m_can_clk_stop(cdev);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_register);
 
-void m_can_class_unregister(struct m_can_classdev *m_can_dev)
+void m_can_class_unregister(struct m_can_classdev *cdev)
 {
-	unregister_candev(m_can_dev->net);
+	unregister_candev(cdev->net);
 
-	m_can_clk_stop(m_can_dev);
+	m_can_clk_stop(cdev);
 }
 EXPORT_SYMBOL_GPL(m_can_class_unregister);
 
-- 
2.29.2


