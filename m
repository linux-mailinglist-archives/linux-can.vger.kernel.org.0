Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D6D294E
	for <lists+linux-can@lfdr.de>; Thu, 10 Oct 2019 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbfJJMSd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Oct 2019 08:18:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38551 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbfJJMSK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Oct 2019 08:18:10 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iIXOO-0006Lw-Hg; Thu, 10 Oct 2019 14:18:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     davem@davemloft.net, kernel@pengutronix.de,
        jhofstee@victronenergy.com,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/29] can: xilinx_can: Fix flags field initialization for axi can
Date:   Thu, 10 Oct 2019 14:17:32 +0200
Message-Id: <20191010121750.27237-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
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

From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

AXI CANIP doesn't support tx fifo empty interrupt feature(TXFEMP),
update the flags filed in the driver for AXI CAN case accordingly.

Fixes: 3281b380ec9f ("can: xilinx_can: Fix flags field initialization for axi can and canps")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 911b34316c9d..7c482b2d78d2 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1599,7 +1599,6 @@ static const struct xcan_devtype_data xcan_zynq_data = {
 
 static const struct xcan_devtype_data xcan_axi_data = {
 	.cantype = XAXI_CAN,
-	.flags = XCAN_FLAG_TXFEMP,
 	.bittiming_const = &xcan_bittiming_const,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
 	.btr_sjw_shift = XCAN_BTR_SJW_SHIFT,
-- 
2.23.0

