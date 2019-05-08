Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911D817AEF
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfEHNoY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:44:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46459 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfEHNoY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:44:24 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1hOMrv-0007vK-48; Wed, 08 May 2019 15:44:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@martin.sperl.org, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/6] can: mcp25xxfd: mcp25xxfd_can_tx: mcp25xxfd_can_tx_handle_int_txatif_fifo() mark as static
Date:   Wed,  8 May 2019 15:44:19 +0200
Message-Id: <20190508134420.29982-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508134420.29982-1-mkl@pengutronix.de>
References: <20190508134420.29982-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
index 13cb898247fe..50252d530725 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
@@ -668,6 +668,7 @@ int mcp25xxfd_can_tx_submit_frame(struct mcp25xxfd_can_priv *cpriv, int fifo)
 }
 
 /* interrupt handler */
+static
 int mcp25xxfd_can_tx_handle_int_txatif_fifo(struct mcp25xxfd_can_priv *cpriv,
 					    int fifo)
 {
-- 
2.20.1

