Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC234D2D88
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiCIK7H (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 05:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiCIK7D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 05:59:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2229470925
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 02:58:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRu14-0005Vd-Ia
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 11:58:02 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 61870469FD
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 10:58:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F358C469F4;
        Wed,  9 Mar 2022 10:57:59 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3c93ee5c;
        Wed, 9 Mar 2022 10:57:55 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 12/13] can: mcp251xfd: ring: increase number of RX-FIFOs to 3 and increase max TX-FIFO depth to 16
Date:   Wed,  9 Mar 2022 11:57:52 +0100
Message-Id: <20220309105753.267264-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309105753.267264-1-mkl@pengutronix.de>
References: <20220309105753.267264-1-mkl@pengutronix.de>
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

This leads to 80 RX buffers and 16 TX buffers:

| FIFO setup: TEF:         0x400: 16*12 bytes =  192 bytes
| FIFO setup: RX-0: FIFO 1/0x4c0: 32*20 bytes =  640 bytes
| FIFO setup: RX-1: FIFO 2/0x740: 32*20 bytes =  640 bytes
| FIFO setup: RX-2: FIFO 3/0x9c0: 16*20 bytes =  320 bytes
| FIFO setup: TX:   FIFO 4/0xb00: 16*16 bytes =  256 bytes
| FIFO setup: free:                                0 bytes

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index c6cb8c3391b3..9cb6b5ad8dda 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -398,7 +398,7 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 
 /* FIFO and Ring */
 #define MCP251XFD_FIFO_TEF_NUM 1U
-#define MCP251XFD_FIFO_RX_NUM 1U
+#define MCP251XFD_FIFO_RX_NUM 3U
 #define MCP251XFD_FIFO_TX_NUM 1U
 
 #define MCP251XFD_FIFO_DEPTH 32U
@@ -409,7 +409,7 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_RX_FIFO_DEPTH_COALESCE_MIN 8U
 
 #define MCP251XFD_TX_OBJ_NUM_MIN 2U
-#define MCP251XFD_TX_OBJ_NUM_MAX 8U
+#define MCP251XFD_TX_OBJ_NUM_MAX 16U
 #define MCP251XFD_TX_OBJ_NUM_CAN_DEFAULT 8U
 #define MCP251XFD_TX_OBJ_NUM_CANFD_DEFAULT 4U
 #define MCP251XFD_TX_FIFO_DEPTH_MIN 2U
-- 
2.34.1


