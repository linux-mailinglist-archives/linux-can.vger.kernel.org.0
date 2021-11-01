Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD8441B48
	for <lists+linux-can@lfdr.de>; Mon,  1 Nov 2021 13:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhKAMqX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Nov 2021 08:46:23 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:61106 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhKAMqW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Nov 2021 08:46:22 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by smtp.orange.fr with ESMTPA
        id hWejmM6H7ozlihWfDmPscz; Mon, 01 Nov 2021 13:43:48 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Mon, 01 Nov 2021 13:43:48 +0100
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v2 3/3] can: netlink: add new field to struct can_ctrlmode to report capabilities
Date:   Mon,  1 Nov 2021 21:43:14 +0900
Message-Id: <20211101124314.68200-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101124314.68200-1-mailhol.vincent@wanadoo.fr>
References: <20211101124314.68200-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch is for your convinience. iproute2-next normally directly
pulls the uapi changes but I think it will be more convinient for
people who want to test to just be able to directly apply this series
and have things working.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Do not pull.

This patch is against the head of iproute2-next which have not yet
pulled the recent IFLA_CAN_TDC uapi changes. So, even if irrelevant,
this entry was also added here to work with the kernel net-next
branch.
---
 include/uapi/linux/can/netlink.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 00c763df..c059bbe8 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -134,11 +134,22 @@ enum {
 	IFLA_CAN_BITRATE_CONST,
 	IFLA_CAN_DATA_BITRATE_CONST,
 	IFLA_CAN_BITRATE_MAX,
+	IFLA_CAN_TDC,
+	IFLA_CAN_CTRLMODE_EXT,
 	__IFLA_CAN_MAX
 };
 
 #define IFLA_CAN_MAX	(__IFLA_CAN_MAX - 1)
 
+enum {
+	IFLA_CAN_CTRLMODE_UNSPEC,
+	IFLA_CAN_CTRLMODE_SUPPORTED,	/* u32 */
+	
+	/* add new constants above here */
+	__IFLA_CAN_CTRLMODE,
+	IFLA_CAN_CTRLMODE_MAX = __IFLA_CAN_CTRLMODE - 1
+};
+
 /* u16 termination range: 1..65535 Ohms */
 #define CAN_TERMINATION_DISABLED 0
 
-- 
2.32.0

