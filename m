Return-Path: <linux-can+bounces-2096-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F69D1C9C
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 01:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F08B20E33
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 00:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F3AC149;
	Tue, 19 Nov 2024 00:39:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F9AD4B;
	Tue, 19 Nov 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976742; cv=none; b=h/XjzG9VvE3gT8kCbJVV0z2GJufIq7j5dutac1H1PxC1WTwHqaW1fQ0SCHja4/XC8e7U0ZPYsxJ1zZRGh0UEsbLCRi/DjK4/rUq1720MpWCZ7GmU2wK+/cDaXEOzJokMvR0bqocEc59ppl0wbdqTl3RLSBVoTQ9tj6m8r/6Ji0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976742; c=relaxed/simple;
	bh=9rXs6EnLwloRAJ6hLDa1fajPXTLWepX+HpgcmcXUAVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gvo47LLrtR5oMnEiWllmoL3Pq9hewLdrRQMmQgpgHxWjy9CLrPrQXNhLlFsjEw59sz11k4R310AO8M1teAMHW7as1SBoHpYfhIOvrK33RmS3rx1AUKlO2vPvfg3FrcalFRkpjEUZiWFFBE2l6dpT66lZwIpr/81S2I1oxDeV9z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id AC30D102EBC;
	Tue, 19 Nov 2024 00:38:48 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1] can: can327: Clean up payload encoding in can327_handle_prompt()
Date: Tue, 19 Nov 2024 09:38:15 +0900
Message-Id: <20241119003815.767004-1-max@enpas.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hex dump encoding of outgoing payloads used snprintf() with a
too large length of the target buffer. While the length was wrong, the
buffer size and its filling logic were fine (sprintf() would have been
sufficient), hence this is not security relevant.

Still, it's a good opportunity to simplify the code, and since no
length checking is required, let's implement it with bin2hex().

Since bin2hex() outputs lowercase letters, this changes the spoken
wire protocol with the ELM327 chip, resulting in a change in
can327_is_valid_rx_char() because the ELM327 is set to echo the
characters sent to it. The documentation says that this is fine, and
I have verified the change on actual hardware.

Finally, since the reporter's worry was that frame->len may be larger
than 8, resulting in a buffer overflow in can327_handle_prompt()'s
local_txbuf, a comment describes how the CAN stack prevents that. This
is also the reason why the size passed to snprintf() was not relevant
to preventing a buffer overflow, because there was no overflow possible
in the first place.

Fixes: 43da2f07622f ("can: can327: CAN/ldisc driver for ELM327 based OBD-II adapters")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Tested-by: Max Staudt <max@enpas.org>
Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/net/can/can327.c | 46 ++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 24af63961030..3ae7b4eb6ca5 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
+#include <linux/hex.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -622,17 +623,14 @@ static void can327_handle_prompt(struct can327 *elm)
 			 */
 			snprintf(local_txbuf, sizeof(local_txbuf), "ATRTR\r");
 		} else {
-			/* Send a regular CAN data frame */
-			int i;
-
-			for (i = 0; i < frame->len; i++) {
-				snprintf(&local_txbuf[2 * i],
-					 sizeof(local_txbuf), "%02X",
-					 frame->data[i]);
-			}
-
-			snprintf(&local_txbuf[2 * i], sizeof(local_txbuf),
-				 "\r");
+			/* Send a regular CAN data frame.
+			 *
+			 * frame->len is guaranteed to be <= 8. Please refer
+			 * to the comment in can327_netdev_start_xmit().
+			 */
+			bin2hex(local_txbuf, frame->data, frame->len);
+			local_txbuf[2 * frame->len] = '\r';
+			local_txbuf[2 * frame->len + 1] = '\0';
 		}
 
 		elm->drop_next_line = 1;
@@ -815,6 +813,26 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
 	struct can327 *elm = netdev_priv(dev);
 	struct can_frame *frame = (struct can_frame *)skb->data;
 
+	/* Why this driver can rely on frame->len <= 8:
+	 *
+	 * While can_dev_dropped_skb() sanity checks the skb to contain a
+	 * CAN 2.0, CAN FD, or other CAN frame type supported by the CAN
+	 * stack, it does not restrict these types of CAN frames.
+	 *
+	 * Instead, this driver is guaranteed to receive only classic CAN 2.0
+	 * frames, with frame->len <= 8, by a chain of checks around the CAN
+	 * device's MTU (as of v6.12):
+	 *
+	 *  - can_changelink() sets the CAN device's MTU to CAN_MTU since we
+	 *    don't advertise CAN_CTRLMODE_FD support in ctrlmode_supported.
+	 *  - can_send() then refuses to pass any skb that exceeds CAN_MTU.
+	 *  - Since CAN_MTU is the smallest currently (v6.12) supported CAN
+	 *    MTU, it is clear that we are dealing with an ETH_P_CAN frame.
+	 *  - All ETH_P_CAN (classic CAN 2.0) frames have frame->len <= 8,
+	 *    as enforced by a call to can_is_can_skb() in can_send().
+	 *  - Thus for all CAN frames reaching this function, frame->len <= 8.
+	 */
+
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
@@ -871,8 +889,10 @@ static bool can327_is_valid_rx_char(u8 c)
 		['H'] = true, true, true, true, true, true, true,
 		['O'] = true, true, true, true, true, true, true,
 		['V'] = true, true, true, true, true,
-		['a'] = true,
-		['b'] = true,
+		/* Note: c-f are needed only if outgoing CAN payloads are
+		 * sent as lowercase hex dumps instead of uppercase.
+		 */
+		['a'] = true, true, true, true, true, true,
 		['v'] = true,
 		[CAN327_DUMMY_CHAR] = true,
 	};
-- 
2.39.5


