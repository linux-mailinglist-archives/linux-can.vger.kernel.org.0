Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC27A8085
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfIDKoM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34865 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfIDKoL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:11 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Slm-0003XS-88; Wed, 04 Sep 2019 12:44:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v2 11/21] can: af_can: can_rx_register(): use max() instead of open coding it
Date:   Wed,  4 Sep 2019 12:43:55 +0200
Message-Id: <20190904104405.21675-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190904104405.21675-1-mkl@pengutronix.de>
References: <20190904104405.21675-1-mkl@pengutronix.de>
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

This patch replaces an open coded max by the proper kernel define max().

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 36c7b4311936..28ea80274121 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -474,8 +474,8 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		dev_rcv_lists->entries++;
 
 		rcv_lists_stats->rcv_entries++;
-		if (rcv_lists_stats->rcv_entries_max < rcv_lists_stats->rcv_entries)
-			rcv_lists_stats->rcv_entries_max = rcv_lists_stats->rcv_entries;
+		rcv_lists_stats->rcv_entries_max = max(rcv_lists_stats->rcv_entries_max,
+						       rcv_lists_stats->rcv_entries);
 	} else {
 		kmem_cache_free(rcv_cache, rcv);
 		err = -ENODEV;
-- 
2.23.0.rc1

