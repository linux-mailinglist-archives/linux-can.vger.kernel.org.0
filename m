Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5520369F
	for <lists+linux-can@lfdr.de>; Mon, 22 Jun 2020 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgFVMVW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Jun 2020 08:21:22 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:55746 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgFVMVW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 08:21:22 -0400
X-ASG-Debug-ID: 1592828478-0a7ff575aa1bc1640001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([213.219.130.186]) by relay-b01.edpnet.be with ESMTP id M5C3DTIBV8sL629D for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 14:21:18 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[213.219.130.186]
X-Barracuda-Apparent-Source-IP: 213.219.130.186
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 3A5DAF6A1B2;
        Mon, 22 Jun 2020 14:21:11 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH] can: mcp25xxfd: add listen-only mode
Date:   Mon, 22 Jun 2020 14:20:47 +0200
X-ASG-Orig-Subj: [PATCH] can: mcp25xxfd: add listen-only mode
Message-Id: <20200622122047.9494-1-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[213.219.130.186]
X-Barracuda-Start-Time: 1592828478
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2601
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3430
X-Barracuda-Spam-Score: 4.84
X-Barracuda-Spam-Status: No, SCORE=4.84 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82728
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This commit enables listen-only mode, which works internally like CANFD mode.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index c744a0bf2faa..f3bc7d0f1f94 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -392,7 +392,8 @@ static int mcp25xxfd_ring_alloc(struct mcp25xxfd_priv *priv)
 	int ram_free, i;
 
 	tef_obj_size = sizeof(struct mcp25xxfd_hw_tef_obj);
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+	/* listen-only mode works like FD mode */
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY)) {
 		tx_obj_num = MCP25XXFD_TX_OBJ_NUM_CANFD;
 		tx_obj_size = sizeof(struct mcp25xxfd_hw_tx_obj_canfd);
 		rx_obj_size = sizeof(struct mcp25xxfd_hw_rx_obj_canfd);
@@ -807,7 +808,7 @@ mcp25xxfd_chip_rx_fifo_init_one(const struct mcp25xxfd_priv *priv,
 		MCP25XXFD_REG_FIFOCON_RXOVIE |
 		MCP25XXFD_REG_FIFOCON_TFNRFNIE;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY))
 		fifo_con |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
 				       MCP25XXFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -857,7 +858,7 @@ static int mcp25xxfd_chip_fifo_init(const struct mcp25xxfd_priv *priv)
 		MCP25XXFD_REG_FIFOCON_TXEN |
 		MCP25XXFD_REG_FIFOCON_TXATIE;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY))
 		val |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
 				  MCP25XXFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -930,7 +931,9 @@ static u8 mcp25xxfd_get_normal_mode(const struct mcp25xxfd_priv *priv)
 {
 	u8 mode;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		mode = MCP25XXFD_REG_CON_MODE_LISTENONLY;
+	else if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
 		mode = MCP25XXFD_REG_CON_MODE_MIXED;
 	else
 		mode = MCP25XXFD_REG_CON_MODE_CAN2_0;
@@ -2778,6 +2781,7 @@ static int mcp25xxfd_probe(struct spi_device *spi)
 	priv->can.bittiming_const = &mcp25xxfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp25xxfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_FD |
+		CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD_NON_ISO;
 	priv->ndev = ndev;
 	priv->spi = spi;
-- 
2.25.0

