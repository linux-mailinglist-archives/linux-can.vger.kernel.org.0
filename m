Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E483431A0
	for <lists+linux-can@lfdr.de>; Sun, 21 Mar 2021 08:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCUHd6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 21 Mar 2021 03:33:58 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:20223 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCUHdx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 21 Mar 2021 03:33:53 -0400
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d13 with ME
        id ivZc240053PnFJp03vZrbF; Sun, 21 Mar 2021 08:33:52 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Mar 2021 08:33:52 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 1/1] can: netlink: do tdco calculation after data bittiming is copied to can_priv
Date:   Sun, 21 Mar 2021 16:33:29 +0900
Message-Id: <20210321073329.1454-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210321073329.1454-1-mailhol.vincent@wanadoo.fr>
References: <20210321073329.1454-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The call to can_calc_tdco() is done too early. The data_bittiming
field of can_priv is not yet updated.

Moving the call after tdco is memcopied solves the issue.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Marc,

Please squash this into below commit:
2b3d40020eca ("can: bittiming: add calculation for CAN FD Transmitter Delay Compensation (TDC)")
---
 drivers/net/can/dev/netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 88dc56268670..18f7beeaf7d8 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -177,7 +177,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 					priv->data_bitrate_const_cnt);
 		if (err)
 			return err;
-		can_calc_tdco(dev);
 
 		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
 			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
@@ -187,6 +186,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 
 		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
 
+		can_calc_tdco(dev);
+
 		if (priv->do_set_data_bittiming) {
 			/* Finally, set the bit-timing registers */
 			err = priv->do_set_data_bittiming(dev);
-- 
2.26.2

