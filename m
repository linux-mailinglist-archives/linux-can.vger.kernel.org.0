Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881933EC195
	for <lists+linux-can@lfdr.de>; Sat, 14 Aug 2021 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhHNJTz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 14 Aug 2021 05:19:55 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:20678 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbhHNJTv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 14 Aug 2021 05:19:51 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d19 with ME
        id hMJz250060zjR6y03MKLjg; Sat, 14 Aug 2021 11:19:22 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Aug 2021 11:19:22 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 1/7] can: netlink: allow user to turn off unsupported features
Date:   Sat, 14 Aug 2021 18:17:44 +0900
Message-Id: <20210814091750.73931-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210814091750.73931-1-mailhol.vincent@wanadoo.fr>
References: <20210814091750.73931-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The sanity checks on the control modes will reject any request related
to an unsupported features, even turning it off.

Example on an interface which does not support CAN-FD:

$ ip link set can0 type can bitrate 500000 fd off
RTNETLINK answers: Operation not supported

This patch lets such command go through (but requests to turn on an
unsupported feature are, of course, still denied).

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 147c23d7dab7..80425636049d 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -116,7 +116,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		maskedflags = cm->flags & cm->mask;
 
 		/* check whether provided bits are allowed to be passed */
-		if (cm->mask & ~(priv->ctrlmode_supported | ctrlstatic))
+		if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
 			return -EOPNOTSUPP;
 
 		/* do not check for static fd-non-iso if 'fd' is disabled */
-- 
2.31.1

