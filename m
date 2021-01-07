Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35A2ECD20
	for <lists+linux-can@lfdr.de>; Thu,  7 Jan 2021 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbhAGJuc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 Jan 2021 04:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbhAGJub (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Jan 2021 04:50:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57790C0612F6
        for <linux-can@vger.kernel.org>; Thu,  7 Jan 2021 01:49:51 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kxRvR-00013M-Vi
        for linux-can@vger.kernel.org; Thu, 07 Jan 2021 10:49:50 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 073645BBAAD
        for <linux-can@vger.kernel.org>; Thu,  7 Jan 2021 09:49:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 225DB5BBA27;
        Thu,  7 Jan 2021 09:49:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 273b812e;
        Thu, 7 Jan 2021 09:49:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Subject: [net-next 11/19] can: tcan4x5x: fix max register value
Date:   Thu,  7 Jan 2021 10:48:52 +0100
Message-Id: <20210107094900.173046-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107094900.173046-1-mkl@pengutronix.de>
References: <20210107094900.173046-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes the max register value for the regmap.

Reviewed-by: Dan Murphy <dmurphy@ti.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Link: https://lore.kernel.org/r/20201215231746.1132907-12-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 4d43c145fdec..73be4b661305 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -12,7 +12,7 @@
 #define TCAN4X5X_WRITE_CMD (0x61 << 24)
 #define TCAN4X5X_READ_CMD (0x41 << 24)
 
-#define TCAN4X5X_MAX_REGISTER 0x8fff
+#define TCAN4X5X_MAX_REGISTER 0x8ffc
 
 static int tcan4x5x_regmap_gather_write(void *context, const void *reg,
 					size_t reg_len, const void *val,
-- 
2.29.2


