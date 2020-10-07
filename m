Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8498286A28
	for <lists+linux-can@lfdr.de>; Wed,  7 Oct 2020 23:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgJGVcU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Oct 2020 17:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgJGVcK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Oct 2020 17:32:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64BCC0613D6
        for <linux-can@vger.kernel.org>; Wed,  7 Oct 2020 14:32:09 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kQH2c-0005qi-JY; Wed, 07 Oct 2020 23:32:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/17] can: softing: softing_card_shutdown(): add  braces around empty body in an 'if' statement
Date:   Wed,  7 Oct 2020 23:31:44 +0200
Message-Id: <20201007213159.1959308-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007213159.1959308-1-mkl@pengutronix.de>
References: <20201007213159.1959308-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes the following warning when building the kernel with "W=1":

    warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Link: http://lore.kernel.org/r/20201006203748.1750156-3-mkl@pengutronix.de
Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/softing/softing_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 11b0f3bcfe80..9d2faaa39ce4 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -447,8 +447,9 @@ static void softing_card_shutdown(struct softing *card)
 {
 	int fw_up = 0;
 
-	if (mutex_lock_interruptible(&card->fw.lock))
+	if (mutex_lock_interruptible(&card->fw.lock)) {
 		/* return -ERESTARTSYS */;
+	}
 	fw_up = card->fw.up;
 	card->fw.up = 0;
 
-- 
2.28.0

