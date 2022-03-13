Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035D74D73B4
	for <lists+linux-can@lfdr.de>; Sun, 13 Mar 2022 09:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiCMIhz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Mar 2022 04:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiCMIhy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Mar 2022 04:37:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280371AC2A7
        for <linux-can@vger.kernel.org>; Sun, 13 Mar 2022 00:36:46 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nTJiU-00072X-Ob
        for linux-can@vger.kernel.org; Sun, 13 Mar 2022 09:36:42 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3EE0149A92
        for <linux-can@vger.kernel.org>; Sun, 13 Mar 2022 08:36:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 001F749A7E;
        Sun, 13 Mar 2022 08:36:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 66c657bf;
        Sun, 13 Mar 2022 08:36:40 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 01/12] can: mcp251xfd: mcp251xfd_ring_init(): use %d to print free RAM
Date:   Sun, 13 Mar 2022 09:36:29 +0100
Message-Id: <20220313083640.501791-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313083640.501791-1-mkl@pengutronix.de>
References: <20220313083640.501791-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In case of an erroneous ring configuration more RAM than available
might be used. Change the printf modifier to a signed int to properly
print this erroneous value.

Fixes: 83daa863f16b ("can: mcp251xfd: ring: update FIFO setup debug info")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 848b8b2ecb5f..b1c4d9b19347 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -261,7 +261,7 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 		   priv->tx->obj_num * priv->tx->obj_size);
 
 	netdev_dbg(priv->ndev,
-		   "FIFO setup: free:                             %4u bytes\n",
+		   "FIFO setup: free:                             %4d bytes\n",
 		   MCP251XFD_RAM_SIZE - (base - MCP251XFD_RAM_START));
 
 	ram_used = base - MCP251XFD_RAM_START;

base-commit: 97aeb877de7f14f819fc2cf8388d7a2d8090489d
-- 
2.35.1


