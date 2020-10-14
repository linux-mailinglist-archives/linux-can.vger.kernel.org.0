Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74828DFFA
	for <lists+linux-can@lfdr.de>; Wed, 14 Oct 2020 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgJNLsh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Oct 2020 07:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388327AbgJNLsY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Oct 2020 07:48:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB6C0613D3
        for <linux-can@vger.kernel.org>; Wed, 14 Oct 2020 04:48:19 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kSfGT-0002Dz-5t; Wed, 14 Oct 2020 13:48:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: flexcan_setup_stop_mode(): add missing "req_bit" to stop mode property comment
Date:   Wed, 14 Oct 2020 13:48:10 +0200
Message-Id: <20201014114810.2911135-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In the patch

    d9b081e3fc4b ("can: flexcan: remove ack_grp and ack_bit handling from driver")

the unused ack_grp and ack_bit were removed from the driver. However in the
comment, the "req_bit" was accidentally removed, too.

This patch adds back the "req_bit" bit.

Fixes: d9b081e3fc4b ("can: flexcan: remove ack_grp and ack_bit handling from driver")
Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4d594e977497..bfa11131219a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1852,7 +1852,7 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		return -EINVAL;
 
 	/* stop mode property format is:
-	 * <&gpr req_gpr>.
+	 * <&gpr req_gpr req_bit>.
 	 */
 	ret = of_property_read_u32_array(np, "fsl,stop-mode", out_val,
 					 ARRAY_SIZE(out_val));
-- 
2.28.0

