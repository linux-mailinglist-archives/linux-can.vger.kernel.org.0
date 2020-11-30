Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7716E2C85B7
	for <lists+linux-can@lfdr.de>; Mon, 30 Nov 2020 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgK3Nil (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Nov 2020 08:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgK3Nik (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Nov 2020 08:38:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59489C0617A7
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 05:37:22 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kjjMn-0002Hv-0L
        for linux-can@vger.kernel.org; Mon, 30 Nov 2020 14:37:21 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 37D6C59F9F7
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 13:37:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7756159F9E0;
        Mon, 30 Nov 2020 13:37:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c49a5254;
        Mon, 30 Nov 2020 13:37:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>, Sriram Dash <sriram.dash@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 6/6] can: m_can: m_can_class_unregister(): move right after m_can_class_register()
Date:   Mon, 30 Nov 2020 14:37:13 +0100
Message-Id: <20201130133713.269256-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130133713.269256-1-mkl@pengutronix.de>
References: <20201130133713.269256-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch moves the function m_can_class_unregister() directly after the
m_can_class_register() function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 553ff39199aa..05c978d1c53d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1869,6 +1869,14 @@ int m_can_class_register(struct m_can_classdev *m_can_dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_register);
 
+void m_can_class_unregister(struct m_can_classdev *m_can_dev)
+{
+	unregister_candev(m_can_dev->net);
+
+	m_can_clk_stop(m_can_dev);
+}
+EXPORT_SYMBOL_GPL(m_can_class_unregister);
+
 int m_can_class_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
@@ -1915,14 +1923,6 @@ int m_can_class_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_resume);
 
-void m_can_class_unregister(struct m_can_classdev *m_can_dev)
-{
-	unregister_candev(m_can_dev->net);
-
-	m_can_clk_stop(m_can_dev);
-}
-EXPORT_SYMBOL_GPL(m_can_class_unregister);
-
 MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.29.2


