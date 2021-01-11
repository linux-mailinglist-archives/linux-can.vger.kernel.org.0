Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873342F1803
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 15:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAKOWu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 09:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbhAKOWu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 09:22:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B324CC06179F
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 06:22:09 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyy5A-0007aK-77
        for linux-can@vger.kernel.org; Mon, 11 Jan 2021 15:22:08 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 22B9E5C0FB5
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 14:19:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E92C05C0F94;
        Mon, 11 Jan 2021 14:19:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e71e1a34;
        Mon, 11 Jan 2021 14:19:32 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next v3 15/15] can: dev: add software tx timestamps
Date:   Mon, 11 Jan 2021 15:19:30 +0100
Message-Id: <20210111141930.693847-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111141930.693847-1-mkl@pengutronix.de>
References: <20210111141930.693847-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Call skb_tx_timestamp() within can_put_echo_skb() so that a software
tx timestamp gets attached on the skb.

There two main reasons to include this call in can_put_echo_skb():

  * It easily allow to enable the tx timestamp on all devices with
    just one small change.

  * According to Documentation/networking/timestamping.rst, the tx
    timestamps should be generated in the device driver as close as
    possible, but always prior to passing the packet to the network
    interface. During the call to can_put_echo_skb(), the skb gets
    cloned meaning that the driver should not dereference the skb
    variable anymore after can_put_echo_skb() returns. This makes
    can_put_echo_skb() the very last place we can use the skb without
    having to access the echo_skb[] array.

Remarks:

  * By default, skb_tx_timestamp() does nothing. It needs to be
    activated by passing the SOF_TIMESTAMPING_TX_SOFTWARE flag either
    through socket options or control messages.

  * The hardware rx timestamp of a local loopback message is the
    hardware tx timestamp. This means that there are no needs to
    implement SOF_TIMESTAMPING_TX_HARDWARE for CAN sockets.

References:

Support for the error queue in CAN RAW sockets (which is needed for tx
timestamps) was introduced in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb88531bdbfaafb827192d1fc6c5a3fcc4fadd96

Put the call to skb_tx_timestamp() just before adding it to the array:
https://lkml.org/lkml/2021/1/10/54

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20210110124903.109773-2-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 53683d4312f1..6a64fe410987 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -65,6 +65,8 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		/* save frame_len to reuse it when transmission is completed */
 		can_skb_prv(skb)->frame_len = frame_len;
 
+		skb_tx_timestamp(skb);
+
 		/* save this skb for tx interrupt echo handling */
 		priv->echo_skb[idx] = skb;
 	} else {
-- 
2.29.2


