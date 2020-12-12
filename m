Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF82D88CF
	for <lists+linux-can@lfdr.de>; Sat, 12 Dec 2020 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgLLR46 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 12 Dec 2020 12:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439617AbgLLR4Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 12 Dec 2020 12:56:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D925C0617A6
        for <linux-can@vger.kernel.org>; Sat, 12 Dec 2020 09:55:29 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ko97A-00010G-01
        for linux-can@vger.kernel.org; Sat, 12 Dec 2020 18:55:28 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 309635ABDDA
        for <linux-can@vger.kernel.org>; Sat, 12 Dec 2020 17:55:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5B5CF5ABDAC;
        Sat, 12 Dec 2020 17:55:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 75018a9b;
        Sat, 12 Dec 2020 17:55:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 5/7] can: m_can: m_can_clk_start(): make use of pm_runtime_resume_and_get()
Date:   Sat, 12 Dec 2020 18:55:16 +0100
Message-Id: <20201212175518.139651-6-mkl@pengutronix.de>
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

With patch

| dd8088d5a896 PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter

the usual pm_runtime_get_sync() and pm_runtime_put_noidle() in-case-of-error
dance is no longer needed. Convert the m_can driver to use this function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b1ed925ead63..d556cd95bd8e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -612,18 +612,10 @@ static int __m_can_get_berr_counter(const struct net_device *dev,
 
 static int m_can_clk_start(struct m_can_classdev *cdev)
 {
-	int err;
-
 	if (cdev->pm_clock_support == 0)
 		return 0;
 
-	err = pm_runtime_get_sync(cdev->dev);
-	if (err < 0) {
-		pm_runtime_put_noidle(cdev->dev);
-		return err;
-	}
-
-	return 0;
+	return pm_runtime_resume_and_get(cdev->dev);
 }
 
 static void m_can_clk_stop(struct m_can_classdev *cdev)
-- 
2.29.2


