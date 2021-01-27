Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF30F3056E6
	for <lists+linux-can@lfdr.de>; Wed, 27 Jan 2021 10:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhA0J1U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jan 2021 04:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhA0JZW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jan 2021 04:25:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9BC061794
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 01:22:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l4h2C-0008Gt-8o
        for linux-can@vger.kernel.org; Wed, 27 Jan 2021 10:22:44 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 09A7A5CF12A
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 09:22:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E4F2B5CF0EB;
        Wed, 27 Jan 2021 09:22:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 74183b7c;
        Wed, 27 Jan 2021 09:22:28 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 09/12] can: mcp251xfd: mcp251xfd_hw_rx_obj_to_skb(): don't copy data for RTR CAN frames in RX-path
Date:   Wed, 27 Jan 2021 10:22:24 +0100
Message-Id: <20210127092227.2775573-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127092227.2775573-1-mkl@pengutronix.de>
References: <20210127092227.2775573-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In Classical CAN there are RTR frames. RTR frames have the RTR bit set, may
have a dlc != 0, but contain no data.

This patch changes the RX-path to no copy any data for RTR frames, so that the
data field in the CAN frame stays 0x0.

Link: https://lore.kernel.org/r/20210114153448.1506901-4-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index aa992e71d787..92816be4f3d4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1474,7 +1474,8 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 						 hw_rx_obj->flags));
 	}
 
-	memcpy(cfd->data, hw_rx_obj->data, cfd->len);
+	if (!(hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR))
+		memcpy(cfd->data, hw_rx_obj->data, cfd->len);
 }
 
 static int
-- 
2.29.2


