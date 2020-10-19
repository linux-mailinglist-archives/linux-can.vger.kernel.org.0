Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B8D292AAF
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgJSPmr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 11:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730344AbgJSPmm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 11:42:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0293AC0613D1
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 08:42:42 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUXJ2-0000nY-4d; Mon, 19 Oct 2020 17:42:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 04/12] can: tcan4x5x: tcan4x5x_clear_interrupts(): remove redundant return statement
Date:   Mon, 19 Oct 2020 17:42:25 +0200
Message-Id: <20201019154233.1262589-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019154233.1262589-1-mkl@pengutronix.de>
References: <20201019154233.1262589-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
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
index eacd428e07e9..76e5fd10d356 100644
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
2.28.0

