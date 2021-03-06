Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1E32F887
	for <lists+linux-can@lfdr.de>; Sat,  6 Mar 2021 06:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhCFFlP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 Mar 2021 00:41:15 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:31757 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhCFFlE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 Mar 2021 00:41:04 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d16 with ME
        id ctgt240063PnFJp03th00T; Sat, 06 Mar 2021 06:41:02 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 Mar 2021 06:41:02 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1] can: bittiming: add CAN_KBPS, CAN_MBPS and CAN_MHZ macros
Date:   Sat,  6 Mar 2021 14:40:40 +0900
Message-Id: <20210306054040.76483-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add three macro to simplify the readibility of big bittiming numbers:
  - CAN_KBPS: kilobits per second (one thousand)
  - CAN_MBPS: megabits per second (one million)
  - CAN_MHZ: megahertz per second (one million)

Example:
	u32 bitrate_max = 8 * CAN_MBPS;
	struct can_clock clock = {.freq = 80 * CAN_MHZ};
instead of:
	u32 bitrate_max = 8000000;
	struct can_clock clock = {.freq = 80000000};

Apply the new macro to driver/net/can/dev/bittiming.c.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/bittiming.c | 4 ++--
 include/linux/can/bittiming.h   | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 5d6c2f217210..853b0ffb443c 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -81,9 +81,9 @@ int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
 	if (bt->sample_point) {
 		sample_point_nominal = bt->sample_point;
 	} else {
-		if (bt->bitrate > 800000)
+		if (bt->bitrate > 800 * CAN_KBPS)
 			sample_point_nominal = 750;
-		else if (bt->bitrate > 500000)
+		else if (bt->bitrate > 500 * CAN_KBPS)
 			sample_point_nominal = 800;
 		else
 			sample_point_nominal = 875;
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 3c4cad7b52c0..2450b94f535c 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -11,6 +11,13 @@
 
 #define CAN_SYNC_SEG 1
 
+/* Kilobits and Megabits per second */
+#define CAN_KBPS 1000UL
+#define CAN_MBPS 1000000UL
+
+/* Megahertz */
+#define CAN_MHZ 1000000UL
+
 /*
  * struct can_tdc - CAN FD Transmission Delay Compensation parameters
  *

base-commit: 69436537f3461627d1ad3beccb19a4dc772cbd6a
-- 
2.26.2

