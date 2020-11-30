Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529CE2C865F
	for <lists+linux-can@lfdr.de>; Mon, 30 Nov 2020 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgK3OQO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Nov 2020 09:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgK3OQO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Nov 2020 09:16:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7883C061A4F
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 06:14:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kjjx1-0007iz-6E
        for linux-can@vger.kernel.org; Mon, 30 Nov 2020 15:14:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A337559FB1F
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 14:14:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1ECA159FACF;
        Mon, 30 Nov 2020 14:14:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0efef0e0;
        Mon, 30 Nov 2020 14:14:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Sean Nyekjaer <sean@geanix.com>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 07/14] can: tcan4x5x: tcan4x5x_clear_interrupts(): remove redundant return statement
Date:   Mon, 30 Nov 2020 15:14:25 +0100
Message-Id: <20201130141432.278219-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130141432.278219-1-mkl@pengutronix.de>
References: <20201130141432.278219-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

This patch removes a redundant return at the end of
tcan4x5x_clear_interrupts().

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: http://lore.kernel.org/r/20191211141635.322577-1-sean@geanix.com
Reported-by: Daniels Umanovskis <daniels@umanovskis.se>
Acked-by: Dan Murphy <dmurphy@ti.com>
Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index e5d7d85e0b6d..1ffcb7014154 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -328,12 +328,8 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
-				      TCAN4X5X_CLEAR_ALL_INT);
-	if (ret)
-		return ret;
-
-	return ret;
+	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
+				       TCAN4X5X_CLEAR_ALL_INT);
 }
 
 static int tcan4x5x_init(struct m_can_classdev *cdev)
-- 
2.29.2


