Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5405E3234EB
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 02:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhBXBHs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 20:07:48 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:51130 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbhBXAfU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 19:35:20 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d12 with ME
        id YoNW240083PnFJp03oNcc5; Wed, 24 Feb 2021 01:22:39 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Feb 2021 01:22:39 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 3/5] can: netlink: move '=' operators back to previous line (checkpatch fix)
Date:   Wed, 24 Feb 2021 09:20:06 +0900
Message-Id: <20210224002008.4158-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fix the warning triggered by having an '=' at the beginning of the
line by moving it back to the previous line. Also replace all
indentations with a single space so that future entries can be more
easily added.

Extract of ./scripts/checkpatch.pl -f drivers/net/can/dev/netlink.c:

CHECK: Assignment operator '=' should be on the previous line
+       [IFLA_CAN_BITTIMING_CONST]
+                               = { .len = sizeof(struct can_bittiming_const) },

CHECK: Assignment operator '=' should be on the previous line
+       [IFLA_CAN_DATA_BITTIMING]
+                               = { .len = sizeof(struct can_bittiming) },

CHECK: Assignment operator '=' should be on the previous line
+       [IFLA_CAN_DATA_BITTIMING_CONST]
+                               = { .len = sizeof(struct can_bittiming_const) },

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 867f6be31230..c19eef775ec8 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -8,20 +8,17 @@
 #include <net/rtnetlink.h>
 
 static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
-	[IFLA_CAN_STATE]	= { .type = NLA_U32 },
-	[IFLA_CAN_CTRLMODE]	= { .len = sizeof(struct can_ctrlmode) },
-	[IFLA_CAN_RESTART_MS]	= { .type = NLA_U32 },
-	[IFLA_CAN_RESTART]	= { .type = NLA_U32 },
-	[IFLA_CAN_BITTIMING]	= { .len = sizeof(struct can_bittiming) },
-	[IFLA_CAN_BITTIMING_CONST]
-				= { .len = sizeof(struct can_bittiming_const) },
-	[IFLA_CAN_CLOCK]	= { .len = sizeof(struct can_clock) },
-	[IFLA_CAN_BERR_COUNTER]	= { .len = sizeof(struct can_berr_counter) },
-	[IFLA_CAN_DATA_BITTIMING]
-				= { .len = sizeof(struct can_bittiming) },
-	[IFLA_CAN_DATA_BITTIMING_CONST]
-				= { .len = sizeof(struct can_bittiming_const) },
-	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
+	[IFLA_CAN_STATE] = { .type = NLA_U32 },
+	[IFLA_CAN_CTRLMODE] = { .len = sizeof(struct can_ctrlmode) },
+	[IFLA_CAN_RESTART_MS] = { .type = NLA_U32 },
+	[IFLA_CAN_RESTART] = { .type = NLA_U32 },
+	[IFLA_CAN_BITTIMING] = { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_CLOCK] = { .len = sizeof(struct can_clock) },
+	[IFLA_CAN_BERR_COUNTER] = { .len = sizeof(struct can_berr_counter) },
+	[IFLA_CAN_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_DATA_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.26.2

