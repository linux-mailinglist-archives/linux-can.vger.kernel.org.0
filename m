Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470E32F0259
	for <lists+linux-can@lfdr.de>; Sat,  9 Jan 2021 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAIRlE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 9 Jan 2021 12:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbhAIRlD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Jan 2021 12:41:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFC9C061786
        for <linux-can@vger.kernel.org>; Sat,  9 Jan 2021 09:40:23 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyIDp-0004ji-Pi
        for linux-can@vger.kernel.org; Sat, 09 Jan 2021 18:40:17 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 05A9C5BE8A0
        for <linux-can@vger.kernel.org>; Sat,  9 Jan 2021 17:40:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1EF6E5BE896;
        Sat,  9 Jan 2021 17:40:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8ae7607f;
        Sat, 9 Jan 2021 17:40:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [net-next 00/13] can: dev: cleanup and add CAN frame length handling support
Date:   Sat,  9 Jan 2021 18:40:00 +0100
Message-Id: <20210109174013.534145-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this series splits the CAN driver related infrastructure into several files
(patches 1...6), followed by some cleanup patches (7, 8), and support for
CAN frame length handling (9...13).

I took the path and put the calculated frame length into the struct
can_skb_priv and extended the can_get_echo_skb() and
can_rx_offload_get_echo_skb() to optionally return the CAN frame length.

This patch illustrated how the new code can be used. I'll send mcp251xfd BQL
support in a separate series, once details about this code have settled.

@@ -1352,7 +1357,9 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
        }
 
        for (i = 0; i < len; i++) {
-               err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i]);
+               unsigned int frame_len;
+
+               err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i], &frame_len);
                /* -EAGAIN means the Sequence Number in the TEF
                 * doesn't match our tef_tail. This can happen if we
                 * read the TEF objects too early. Leave loop let the
@@ -1362,6 +1369,8 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
                        goto out_netif_wake_queue;
                if (err)
                        return err;
+
+               total_frame_len += frame_len;
        }
 
  out_netif_wake_queue:
@@ -1393,6 +1402,7 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
                        return err;
 
                tx_ring->tail += len;
+               netdev_completed_queue(priv->ndev, len, total_frame_len);
 
                err = mcp251xfd_check_tef_tail(priv);
                if (err)
@@ -2433,6 +2443,7 @@ static bool mcp251xfd_tx_busy(const struct mcp251xfd_priv *priv,
 static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
                                        struct net_device *ndev)
 {
+       struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
        struct mcp251xfd_priv *priv = netdev_priv(ndev);
        struct mcp251xfd_tx_ring *tx_ring = priv->tx;
        struct mcp251xfd_tx_obj *tx_obj;
@@ -2455,6 +2466,8 @@ static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
                netif_stop_queue(ndev);
 
        can_put_echo_skb(skb, ndev, tx_head);
+       can_skb_priv->frame_len = can_skb_get_frame_len(skb);
+       netdev_sent_queue(priv->ndev, can_skb_priv->frame_len);
 
        err = mcp251xfd_tx_obj_write(priv, tx_obj);
        if (err)

regards,
Marc



