Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667C926B1F7
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgIOWiz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbgIOWfb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F24C06178A
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:31 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJXt-0002Tb-67; Wed, 16 Sep 2020 00:35:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/37] can: flexcan: fix spelling mistake "reserverd" -> "reserved"
Date:   Wed, 16 Sep 2020 00:34:52 +0200
Message-Id: <20200915223527.1417033-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Fix a mistake in a register layout description.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 94d10ec954a0..19403e88daa3 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -230,7 +230,7 @@ struct flexcan_regs {
 	/* FIFO-mode:
 	 *			MB
 	 * 0x080...0x08f	0	RX message buffer
-	 * 0x090...0x0df	1-5	reserverd
+	 * 0x090...0x0df	1-5	reserved
 	 * 0x0e0...0x0ff	6-7	8 entry ID table
 	 *				(mx25, mx28, mx35, mx53)
 	 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
-- 
2.28.0

