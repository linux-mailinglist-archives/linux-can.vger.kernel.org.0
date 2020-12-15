Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA62DAAF6
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 11:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgLOKd0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 05:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgLOKdZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 05:33:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F1C0617A7
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 02:32:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kp7dL-0006L4-0M
        for linux-can@vger.kernel.org; Tue, 15 Dec 2020 11:32:43 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 441835ADD17
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 10:32:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 69C0A5ADD09;
        Tue, 15 Dec 2020 10:32:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 13baa16f;
        Tue, 15 Dec 2020 10:32:39 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 1/2] can: m_can: m_can_class_unregister(): remove erroneous m_can_clk_stop()
Date:   Tue, 15 Dec 2020 11:32:37 +0100
Message-Id: <20201215103238.524029-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215103238.524029-1-mkl@pengutronix.de>
References: <20201215103238.524029-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In m_can_class_register() the clock is started, but stopped on exit. When
calling m_can_class_unregister(), the clock is stopped a second time.

This patch removes the erroneous m_can_clk_stop() in  m_can_class_unregister().

Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Sriram Dash <sriram.dash@samsung.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 61a93b192037..075ee760b5ba 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1918,8 +1918,6 @@ EXPORT_SYMBOL_GPL(m_can_class_resume);
 void m_can_class_unregister(struct m_can_classdev *m_can_dev)
 {
 	unregister_candev(m_can_dev->net);
-
-	m_can_clk_stop(m_can_dev);
 }
 EXPORT_SYMBOL_GPL(m_can_class_unregister);
 

base-commit: 7f376f1917d7461e05b648983e8d2aea9d0712b2
-- 
2.29.2


