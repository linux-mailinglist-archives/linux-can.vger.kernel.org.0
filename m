Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6B3327F2
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 14:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCIN6c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 08:58:32 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:24969 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhCIN6L (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 08:58:11 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d12 with ME
        id eDxt240033PnFJp03Dy9Qd; Tue, 09 Mar 2021 14:58:10 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Mar 2021 14:58:10 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 1/2] can: netlink: reorder IFLA_CAN_TDC* entries in can_policy structure
Date:   Tue,  9 Mar 2021 22:57:47 +0900
Message-Id: <20210309135748.29258-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210309135748.29258-1-mailhol.vincent@wanadoo.fr>
References: <20210309135748.29258-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The IFLA_CAN_TDC* entries within the can_policy structure appear in a
different order than their declaration in
include/uapi/linux/can/netlink.h

Reorder them to follow the same order.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Marc,

Please squash this patch into:
5aed4df12f1b ("can: add netlink interface for CAN-FD Transmitter Delay Compensation (TDC)")
---
 drivers/net/can/dev/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index a3b71465849c..58e458dc8be2 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -20,10 +20,10 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_DATA_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
 	[IFLA_CAN_TDCV] = { .type = NLA_U32 },
-	[IFLA_CAN_TDCV_MAX_CONST] = { .type = NLA_U32 },
 	[IFLA_CAN_TDCO] = { .type = NLA_U32 },
-	[IFLA_CAN_TDCO_MAX_CONST] = { .type = NLA_U32 },
 	[IFLA_CAN_TDCF] = { .type = NLA_U32 },
+	[IFLA_CAN_TDCV_MAX_CONST] = { .type = NLA_U32 },
+	[IFLA_CAN_TDCO_MAX_CONST] = { .type = NLA_U32 },
 	[IFLA_CAN_TDCF_MAX_CONST] = { .type = NLA_U32 },
 };
 
-- 
2.26.2

