Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041623B1C71
	for <lists+linux-can@lfdr.de>; Wed, 23 Jun 2021 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFWOaV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Jun 2021 10:30:21 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60026 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFWOaV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 23 Jun 2021 10:30:21 -0400
Received: from Focal.peak-system.com (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 536E05FFA8;
        Wed, 23 Jun 2021 16:27:29 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_pciefd: fix a potential issue of sending frames
Date:   Wed, 23 Jun 2021 16:26:00 +0200
Message-Id: <20210623142600.149904-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Rather than just indicating that transmission can start, this patch
requires the explicit flushing of the network Tx queue when the driver is
informed by the device that it can transmit, next to its configuration.
In this way, if frames have already been written by the application, they
will actually be transmitted.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 00847cbaf7b6..d08718e98e11 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -351,8 +351,8 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 				return err;
 		}
 
-		/* start network queue (echo_skb array is empty) */
-		netif_start_queue(ndev);
+		/* wake network queue up (echo_skb array is empty) */
+		netif_wake_queue(ndev);
 
 		return 0;
 	}
-- 
2.25.1

