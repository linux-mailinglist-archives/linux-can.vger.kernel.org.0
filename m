Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2834E69F
	for <lists+linux-can@lfdr.de>; Tue, 30 Mar 2021 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhC3LrD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Mar 2021 07:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhC3Lql (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Mar 2021 07:46:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B0C061574
        for <linux-can@vger.kernel.org>; Tue, 30 Mar 2021 04:46:40 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRCpT-0006Lp-As
        for linux-can@vger.kernel.org; Tue, 30 Mar 2021 13:46:39 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 77E1C603E9A
        for <linux-can@vger.kernel.org>; Tue, 30 Mar 2021 11:46:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 34C86603E29;
        Tue, 30 Mar 2021 11:46:12 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 650ae66e;
        Tue, 30 Mar 2021 11:46:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 25/39] can: mcp251xfd: mcp251xfd_get_timestamp(): move to mcp251xfd.h
Date:   Tue, 30 Mar 2021 13:45:45 +0200
Message-Id: <20210330114559.1114855-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330114559.1114855-1-mkl@pengutronix.de>
References: <20210330114559.1114855-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a preparation patch, it moves the mcp251xfd_get_timestamp()
function into the mcp251xfd.h file.

Link: https://lore.kernel.org/r/20210304160328.2752293-5-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 6 ------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index e2e5b5c7f736..41e322954d9a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1597,12 +1597,6 @@ static int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv)
 	return 0;
 }
 
-static inline int mcp251xfd_get_timestamp(const struct mcp251xfd_priv *priv,
-					  u32 *timestamp)
-{
-	return regmap_read(priv->map_reg, MCP251XFD_REG_TBC, timestamp);
-}
-
 static struct sk_buff *
 mcp251xfd_alloc_can_err_skb(const struct mcp251xfd_priv *priv,
 			    struct can_frame **cf, u32 *timestamp)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index d0a0d2f91dac..074c5adf9b94 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -728,6 +728,12 @@ mcp251xfd_spi_cmd_write(const struct mcp251xfd_priv *priv,
 	return data;
 }
 
+static inline int mcp251xfd_get_timestamp(const struct mcp251xfd_priv *priv,
+					  u32 *timestamp)
+{
+	return regmap_read(priv->map_reg, MCP251XFD_REG_TBC, timestamp);
+}
+
 static inline u16 mcp251xfd_get_tef_obj_addr(u8 n)
 {
 	return MCP251XFD_RAM_START +
-- 
2.30.2


