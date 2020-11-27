Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCF32C6275
	for <lists+linux-can@lfdr.de>; Fri, 27 Nov 2020 11:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgK0KEE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 27 Nov 2020 05:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgK0KED (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 27 Nov 2020 05:04:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F37C061A47
        for <linux-can@vger.kernel.org>; Fri, 27 Nov 2020 02:04:03 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kiabi-0007fs-7n
        for linux-can@vger.kernel.org; Fri, 27 Nov 2020 11:04:02 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 86DED59DE9B
        for <linux-can@vger.kernel.org>; Fri, 27 Nov 2020 10:03:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7943D59DE70;
        Fri, 27 Nov 2020 10:03:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5546832f;
        Fri, 27 Nov 2020 10:03:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Pankaj Sharma <pankj.sharma@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 5/6] can: m_can: m_can_dev_setup(): add support for bosch mcan version 3.3.0
Date:   Fri, 27 Nov 2020 11:03:00 +0100
Message-Id: <20201127100301.512603-6-mkl@pengutronix.de>
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

From: Pankaj Sharma <pankj.sharma@samsung.com>

Add support for mcan bit timing and control mode according to bosch mcan IP
version 3.3.0. The mcan version read from the Core Release field of CREL
register would be 33. Accordingly the properties are to be set for mcan v3.3.0

Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
Link: https://lore.kernel.org/r/1606366302-5520-1-git-send-email-pankj.sharma@samsung.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d4030abad935..61a93b192037 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1385,6 +1385,8 @@ static int m_can_dev_setup(struct m_can_classdev *m_can_dev)
 						&m_can_data_bittiming_const_31X;
 		break;
 	case 32:
+	case 33:
+		/* Support both MCAN version v3.2.x and v3.3.0 */
 		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
 			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
 
-- 
2.29.2


