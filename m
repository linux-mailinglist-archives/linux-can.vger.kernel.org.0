Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC426B1EF
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgIOWiM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgIOWfc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76671C06178B
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:31 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJXt-0002Tb-EP; Wed, 16 Sep 2020 00:35:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/37] can: include: fix spelling mistakes
Date:   Wed, 16 Sep 2020 00:34:53 +0200
Message-Id: <20200915223527.1417033-4-mkl@pengutronix.de>
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

This patch fixes spelling erros found by "codespell" in the
include/linux/can subtree.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/core.h | 2 +-
 include/linux/can/dev.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index e20a0cd09ba5..7da9f1f82e8e 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -2,7 +2,7 @@
 /*
  * linux/can/core.h
  *
- * Protoypes and definitions for CAN protocol modules using the PF_CAN core
+ * Prototypes and definitions for CAN protocol modules using the PF_CAN core
  *
  * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  *          Urs Thuermann   <urs.thuermann@volkswagen.de>
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5e3d45525bd3..516892566ac9 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -108,7 +108,7 @@ static inline bool can_skb_headroom_valid(struct net_device *dev,
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
-		/* preform proper loopback on capable devices */
+		/* perform proper loopback on capable devices */
 		if (dev->flags & IFF_ECHO)
 			skb->pkt_type = PACKET_LOOPBACK;
 		else
-- 
2.28.0

