Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B059216105
	for <lists+linux-can@lfdr.de>; Tue,  7 May 2019 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEGJeu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 May 2019 05:34:50 -0400
Received: from first.geanix.com ([116.203.34.67]:44182 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfEGJeu (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 7 May 2019 05:34:50 -0400
Received: from localhost.localdomain (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 263DE9A4;
        Tue,  7 May 2019 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557221649; bh=yBLR3iOoe1mMPTULDowI1lVh0ljPr5pvjWWAwBsNOkQ=;
        h=From:To:Cc:Subject:Date;
        b=hDQ2hiSBOS1XR2u2194WjpVqOu0TxF6EFbA8dqrm1Iq2T5fK79Fw079yC8V7l/dwB
         ifw18ocjcWW0fbvhO6y9x5hcy00AlUWGt6rJc54tleIbQP52l3+cEvwjXp4E/QXAU9
         Jl+71DH+nW/UioBoPUAmUXsLLKrUBXeCGrMd9zHaNo2XPfj0Imu/gWV2WAK6Fv6VVQ
         PrUe78nRv+BgWL0DhCqxD3md2sqm0Iqw4Hxz+rI1EP/IKPLlOjSL4Z6kXcoKwEzQuN
         w0ravoI28WMIcA8rlCU44E8tm69chjGssVJxwfrXUp9yO21DTgc1d5pCwmeHbXLWJO
         1nM3AvhJMfSHg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        mkl@pengutronix.de
Cc:     Sean Nyekjaer <sean@geanix.com>, robh+dt@kernel.org
Subject: [PATCH 1/2] can: mcp251x: add support for mcp25625
Date:   Tue,  7 May 2019 11:34:36 +0200
Message-Id: <20190507093437.26025-1-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 9cf0eadf640b
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fully compatible with mcp2515, the mcp25625 have
integrated transceiver.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/spi/mcp251x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index e90817608645..4113621569d2 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1006,6 +1006,10 @@ static const struct of_device_id mcp251x_of_match[] = {
 		.compatible	= "microchip,mcp2515",
 		.data		= (void *)CAN_MCP251X_MCP2515,
 	},
+	{
+		.compatible	= "microchip,mcp25625",
+		.data		= (void *)CAN_MCP251X_MCP2515,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp251x_of_match);
@@ -1019,6 +1023,10 @@ static const struct spi_device_id mcp251x_id_table[] = {
 		.name		= "mcp2515",
 		.driver_data	= (kernel_ulong_t)CAN_MCP251X_MCP2515,
 	},
+	{
+		.name		= "mcp25625",
+		.driver_data	= (kernel_ulong_t)CAN_MCP251X_MCP2515,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
-- 
2.21.0

