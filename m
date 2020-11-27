Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC10B2C627C
	for <lists+linux-can@lfdr.de>; Fri, 27 Nov 2020 11:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgK0KEJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 27 Nov 2020 05:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgK0KEE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 27 Nov 2020 05:04:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A6DC0613D1
        for <linux-can@vger.kernel.org>; Fri, 27 Nov 2020 02:04:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kiabi-0007hE-UP
        for linux-can@vger.kernel.org; Fri, 27 Nov 2020 11:04:02 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 11FAF59DEA4
        for <linux-can@vger.kernel.org>; Fri, 27 Nov 2020 10:04:01 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5FF5459DE6E;
        Fri, 27 Nov 2020 10:03:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e38feaff;
        Fri, 27 Nov 2020 10:03:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Dan Murphy <dmurphy@ti.com>,
        Mario Huettel <mario.huettel@gmx.net>,
        Sriram Dash <sriram.dash@samsung.com>
Subject: [net 4/6] can: m_can: fix nominal bitiming tseg2 min for version >= 3.1
Date:   Fri, 27 Nov 2020 11:02:59 +0100
Message-Id: <20201127100301.512603-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127100301.512603-1-mkl@pengutronix.de>
References: <20201127100301.512603-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

At lest the revision 3.3.0 of the bosch m_can IP core specifies that valid
register values for "Nominal Time segment after sample point (NTSEG2)" are from
1 to 127. As the hardware uses a value of one more than the programmed value,
mean tseg2_min is 2.

This patch fixes the tseg2_min value accordingly.

Cc: Dan Murphy <dmurphy@ti.com>
Cc: Mario Huettel <mario.huettel@gmx.net>
Acked-by: Sriram Dash <sriram.dash@samsung.com>
Link: https://lore.kernel.org/r/20201124190751.3972238-1-mkl@pengutronix.de
Fixes: b03cfc5bb0e1 ("can: m_can: Enable M_CAN version dependent initialization")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c62439bdee28..d4030abad935 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1033,7 +1033,7 @@ static const struct can_bittiming_const m_can_bittiming_const_31X = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
 	.tseg1_max = 256,
-	.tseg2_min = 1,		/* Time segment 2 = phase_seg2 */
+	.tseg2_min = 2,		/* Time segment 2 = phase_seg2 */
 	.tseg2_max = 128,
 	.sjw_max = 128,
 	.brp_min = 1,
-- 
2.29.2


