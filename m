Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A94228171B
	for <lists+linux-can@lfdr.de>; Fri,  2 Oct 2020 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbgJBPt6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Oct 2020 11:49:58 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:40837 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgJBPt6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Oct 2020 11:49:58 -0400
Received: from tomoyo.flets-east.jp ([153.230.197.127])
        by mwinf5d76 with ME
        id b3pm230052lQRaH033psje; Fri, 02 Oct 2020 17:49:57 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Oct 2020 17:49:57 +0200
X-ME-IP: 153.230.197.127
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        linux-usb@vger.kernel.org (open list:USB ACM DRIVER)
Subject: [PATCH v3 4/7] can: dev: __can_get_echo_skb(): fix the return length
Date:   Sat,  3 Oct 2020 00:41:48 +0900
Message-Id: <20201002154219.4887-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002154219.4887-1-mailhol.vincent@wanadoo.fr>
References: <20200926175810.278529-1-mailhol.vincent@wanadoo.fr>
 <20201002154219.4887-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The length of Remote Transmission Request (RTR) frames is always 0
bytes. The DLC represents the requested length, not the actual length
of the RTR. But __can_get_echo_skb() returns the DLC value regardless.

Apply get_can_len() function to retrieve the correct length.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---

Changes in v3: None

Changes in v2: None
---
 drivers/net/can/dev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index e291fda395a0..8c3e11820e03 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -481,14 +481,9 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 	}
 
 	if (priv->echo_skb[idx]) {
-		/* Using "struct canfd_frame::len" for the frame
-		 * length is supported on both CAN and CANFD frames.
-		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-		u8 len = cf->len;
 
-		*len_ptr = len;
+		*len_ptr = get_can_len(skb);
 		priv->echo_skb[idx] = NULL;
 
 		return skb;
-- 
2.26.2

