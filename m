Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46B322EC9
	for <lists+linux-can@lfdr.de>; Tue, 23 Feb 2021 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhBWQdX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 11:33:23 -0500
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:38563 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhBWQdX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 11:33:23 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d21 with ME
        id YgXV2400g3PnFJp03gXck5; Tue, 23 Feb 2021 17:31:40 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 Feb 2021 17:31:40 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 3/5] can: netlink: move '=' operators back to previous line (checkpatch fix)
Date:   Wed, 24 Feb 2021 01:28:50 +0900
Message-Id: <20210223162852.218041-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
References: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fix the warning triggered by having an '=' at the beginning of the
line and add one indentation to fix the alignment.

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
 drivers/net/can/dev/netlink.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 867f6be31230..75851fab7ff5 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -8,20 +8,18 @@
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
+	[IFLA_CAN_STATE]		= { .type = NLA_U32 },
+	[IFLA_CAN_CTRLMODE]		= { .len = sizeof(struct can_ctrlmode) },
+	[IFLA_CAN_RESTART_MS]		= { .type = NLA_U32 },
+	[IFLA_CAN_RESTART]		= { .type = NLA_U32 },
+	[IFLA_CAN_BITTIMING]		= { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_CLOCK]		= { .len = sizeof(struct can_clock) },
+	[IFLA_CAN_BERR_COUNTER]		= { .len = sizeof(struct can_berr_counter) },
+	[IFLA_CAN_DATA_BITTIMING]	= { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_DATA_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION]		= { .type = NLA_U16 },
+	[IFLA_CAN_TERMINATION]		= { .type = NLA_U16 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.26.2

