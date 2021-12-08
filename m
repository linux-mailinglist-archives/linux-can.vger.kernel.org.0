Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2962746D4C7
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 14:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhLHNwr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 08:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhLHNwq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 08:52:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D52C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 05:49:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1muxJo-0002JO-Qx
        for linux-can@vger.kernel.org; Wed, 08 Dec 2021 14:49:12 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C7F336BFCE8
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 13:49:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 68FA86BFCE2;
        Wed,  8 Dec 2021 13:49:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c54c71db;
        Wed, 8 Dec 2021 13:49:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 1/2] can: kvaser_pciefd: kvaser_pciefd_rx_error_frame(): increase correct stats->{rx,tx}_errors counter
Date:   Wed,  8 Dec 2021 14:49:09 +0100
Message-Id: <20211208134910.263352-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211208134910.263352-1-mkl@pengutronix.de>
References: <20211208134910.263352-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Check the direction bit in the error frame packet (EPACK) to determine
which net_device_stats {rx,tx}_errors counter to increase.

Link: https://lore.kernel.org/all/20211208115607.202859-2-extja@kvaser.com
Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 74d9899fc904..eb74cdf26b88 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -248,6 +248,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SPACK_EWLR BIT(23)
 #define KVASER_PCIEFD_SPACK_EPLR BIT(24)
 
+/* Kvaser KCAN_EPACK second word */
+#define KVASER_PCIEFD_EPACK_DIR_TX BIT(0)
+
 struct kvaser_pciefd;
 
 struct kvaser_pciefd_can {
@@ -1285,7 +1288,10 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 
 	can->err_rep_cnt++;
 	can->can.can_stats.bus_error++;
-	stats->rx_errors++;
+	if (p->header[1] & KVASER_PCIEFD_EPACK_DIR_TX)
+		stats->tx_errors++;
+	else
+		stats->rx_errors++;
 
 	can->bec.txerr = bec.txerr;
 	can->bec.rxerr = bec.rxerr;
-- 
2.33.0


