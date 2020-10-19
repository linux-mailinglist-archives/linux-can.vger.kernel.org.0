Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D84292E1A
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgJSTFe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 15:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbgJSTFe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 15:05:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48003C0613CE
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 12:05:34 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUaTM-0005v5-Eb; Mon, 19 Oct 2020 21:05:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 05/16] can: dev: __can_get_echo_skb(): fix the returned length of CAN frame
Date:   Mon, 19 Oct 2020 21:05:13 +0200
Message-Id: <20201019190524.1285319-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019190524.1285319-1-mkl@pengutronix.de>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The length of Remote Transmission Request (RTR) frames is always 0 bytes. The
DLC represents the requested length, not the actual length of the RTR. But
__can_get_echo_skb() returns the DLC value regardless.

Apply can_get_len() function to retrieve the correct length.

This patch depends on:

    7d4b1cbca3bd can: dev: can_get_len():  add a helper function to get the correct length of Classical frames

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20201002154219.4887-5-mailhol.vincent@wanadoo.fr
Fixes: cf5046b309b3 ("can: dev: let can_get_echo_skb() return dlc of CAN frame")
[mkl: renamed get_can_len() -> can_get_len()]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 73cfcd7e9517..47b45a2223f9 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -507,14 +507,9 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 	}
 
 	if (priv->echo_skb[idx]) {
-		/* Using "struct canfd_frame::len" for the frame
-		 * length is supported on both CAN and CANFD frames.
-		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-		u8 len = cf->len;
 
-		*len_ptr = len;
+		*len_ptr = can_get_len(skb);
 		priv->echo_skb[idx] = NULL;
 
 		return skb;
-- 
2.28.0

