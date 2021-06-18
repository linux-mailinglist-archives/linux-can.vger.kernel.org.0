Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E83AC5DD
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 10:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhFRIV5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 04:21:57 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:54489 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhFRIV4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 04:21:56 -0400
Received: from localhost.localdomain ([114.149.34.46])
        by mwinf5d28 with ME
        id JYKA2500J0zjR6y03YKlfG; Fri, 18 Jun 2021 10:19:47 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Jun 2021 10:19:47 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 2/2] can: netlink: clear tdc if fd is turned off
Date:   Fri, 18 Jun 2021 17:19:04 +0900
Message-Id: <20210618081904.141114-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210618081904.141114-1-mailhol.vincent@wanadoo.fr>
References: <20210618081904.141114-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When the FD is turned off through the netlink interface, the value
still remain in struct can_tdc and are displayed despite of the
feature being disabled.

This patch clears priv->tdc whenever FD is set to off. This way, the
TDC variables are not displayed anymore.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Marc,

I would suggest to squash that into commit 5eb2cd8e2ded ("can:
netlink: add interface for CAN-FD Transmitter Delay Compensation
(TDC)").
---
 drivers/net/can/dev/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index b8d531e49540..b33e6da6ca5a 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -207,6 +207,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			dev->mtu = CAN_MTU;
 			memset(&priv->data_bittiming, 0,
 			       sizeof(priv->data_bittiming));
+			memset(&priv->tdc, 0, sizeof(priv->tdc));
 		}
 	}
 
-- 
2.31.1

