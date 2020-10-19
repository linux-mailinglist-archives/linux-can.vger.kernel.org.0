Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893C3292E1B
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgJSTFf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 15:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbgJSTFf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 15:05:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC839C0613CE
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 12:05:34 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUaTM-0005v5-Os; Mon, 19 Oct 2020 21:05:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 06/16] can: can_create_echo_skb(): fix echo skb generation: always use skb_clone()
Date:   Mon, 19 Oct 2020 21:05:14 +0200
Message-Id: <20201019190524.1285319-7-mkl@pengutronix.de>
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

From: Oleksij Rempel <o.rempel@pengutronix.de>

All user space generated SKBs are owned by a socket (unless injected into the
key via AF_PACKET). If a socket is closed, all associated skbs will be cleaned
up.

This leads to a problem when a CAN driver calls can_put_echo_skb() on a
unshared SKB. If the socket is closed prior to the TX complete handler,
can_get_echo_skb() and the subsequent delivering of the echo SKB to all
registered callbacks, a SKB with a refcount of 0 is delivered.

To avoid the problem, in can_get_echo_skb() the original SKB is now always
cloned, regardless of shared SKB or not. If the process exists it can now
safely discard its SKBs, without disturbing the delivery of the echo SKB.

The problem shows up in the j1939 stack, when it clones the incoming skb, which
detects the already 0 refcount.

We can easily reproduce this with following example:

testj1939 -B -r can0: &
cansend can0 1823ff40#0123

WARNING: CPU: 0 PID: 293 at lib/refcount.c:25 refcount_warn_saturate+0x108/0x174
refcount_t: addition on 0; use-after-free.
Modules linked in: coda_vpu imx_vdoa videobuf2_vmalloc dw_hdmi_ahb_audio vcan
CPU: 0 PID: 293 Comm: cansend Not tainted 5.5.0-rc6-00376-g9e20dcb7040d #1
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace:
[<c010f570>] (dump_backtrace) from [<c010f90c>] (show_stack+0x20/0x24)
[<c010f8ec>] (show_stack) from [<c0c3e1a4>] (dump_stack+0x8c/0xa0)
[<c0c3e118>] (dump_stack) from [<c0127fec>] (__warn+0xe0/0x108)
[<c0127f0c>] (__warn) from [<c01283c8>] (warn_slowpath_fmt+0xa8/0xcc)
[<c0128324>] (warn_slowpath_fmt) from [<c0539c0c>] (refcount_warn_saturate+0x108/0x174)
[<c0539b04>] (refcount_warn_saturate) from [<c0ad2cac>] (j1939_can_recv+0x20c/0x210)
[<c0ad2aa0>] (j1939_can_recv) from [<c0ac9dc8>] (can_rcv_filter+0xb4/0x268)
[<c0ac9d14>] (can_rcv_filter) from [<c0aca2cc>] (can_receive+0xb0/0xe4)
[<c0aca21c>] (can_receive) from [<c0aca348>] (can_rcv+0x48/0x98)
[<c0aca300>] (can_rcv) from [<c09b1fdc>] (__netif_receive_skb_one_core+0x64/0x88)
[<c09b1f78>] (__netif_receive_skb_one_core) from [<c09b2070>] (__netif_receive_skb+0x38/0x94)
[<c09b2038>] (__netif_receive_skb) from [<c09b2130>] (netif_receive_skb_internal+0x64/0xf8)
[<c09b20cc>] (netif_receive_skb_internal) from [<c09b21f8>] (netif_receive_skb+0x34/0x19c)
[<c09b21c4>] (netif_receive_skb) from [<c0791278>] (can_rx_offload_napi_poll+0x58/0xb4)

Fixes: 0ae89beb283a ("can: add destructor for self generated skbs")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: http://lore.kernel.org/r/20200124132656.22156-1-o.rempel@pengutronix.de
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/skb.h | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 900b9f4e0605..fc61cf4eff1c 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -61,21 +61,17 @@ static inline void can_skb_set_owner(struct sk_buff *skb, struct sock *sk)
  */
 static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
 {
-	if (skb_shared(skb)) {
-		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+	struct sk_buff *nskb;
 
-		if (likely(nskb)) {
-			can_skb_set_owner(nskb, skb->sk);
-			consume_skb(skb);
-			return nskb;
-		} else {
-			kfree_skb(skb);
-			return NULL;
-		}
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (unlikely(!nskb)) {
+		kfree_skb(skb);
+		return NULL;
 	}
 
-	/* we can assume to have an unshared skb with proper owner */
-	return skb;
+	can_skb_set_owner(nskb, skb->sk);
+	consume_skb(skb);
+	return nskb;
 }
 
 #endif /* !_CAN_SKB_H */
-- 
2.28.0

