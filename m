Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F6577043
	for <lists+linux-can@lfdr.de>; Sat, 16 Jul 2022 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiGPRAh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 16 Jul 2022 13:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiGPRAZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 16 Jul 2022 13:00:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EBA1FCEC
        for <linux-can@vger.kernel.org>; Sat, 16 Jul 2022 10:00:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so9992931edc.4
        for <linux-can@vger.kernel.org>; Sat, 16 Jul 2022 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTz0/chNaRML/52RPmtYk4d+f1Bk9uxvtl5nVSXDbcQ=;
        b=jJ5xawQRSUIYW860n+w62jza20Yx7yBAk+lqQxEt4jUQU9IKh9Y4GbxgTGAh/8cvXo
         rekwuCwPkNXX+Fi41/uI7A7vL3oaflshuDuKmlbO9ij6fdHqeR8PJMADMyc7YkjoA2Ty
         yRwOUiRX3rCoQODMxCxECHKGuy1C55ibBi518=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTz0/chNaRML/52RPmtYk4d+f1Bk9uxvtl5nVSXDbcQ=;
        b=nhxTywoD41z+JdXiUkX0TaitNQIMJQkAd9/OrmXfpALvYWEyHsTXiW2OrUNYTF0T/b
         2OP3X94vniwZIFBWnyKpYC9KiIfi98OA5IKWvwRDkpgR/xxAqkLVvs6UeCTHCCaUxRPG
         HQKIf26HG8xa5E8TnTdY9+s2CTe/wS6sxrClIm6m7Swlfxso6dX0YaLJOzHOy1OEnJ8H
         eTam9CFj70qIczeq/9vd65bTeLFrDrwX26eSWxgQ7xYi7ZCYecMo+mk1QeOJwz5xqeZr
         BKBvbbYFB9igtskUmkIQz7mawYbr0AcfgOQgNIFrPOIMMK3LnpLxj4hMrAZVuWrgTOoT
         Eeng==
X-Gm-Message-State: AJIora/hyQ/us+FkwDqP3CozxzHRxafu/fj6jPTP3kQUI6lK4OC4kV0V
        NADZeQc872p7WGAvuJUsxUEEIQ==
X-Google-Smtp-Source: AGRyM1sXtvqf4zSln7Foq/eD0ncB9oilB+U18ecxceYW2Zr6CyYzo1g+/L1Ov6gT9trme0v68KMDvw==
X-Received: by 2002:a05:6402:5513:b0:43a:b866:b9ab with SMTP id fi19-20020a056402551300b0043ab866b9abmr27086750edb.290.1657990816350;
        Sat, 16 Jul 2022 10:00:16 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b0072b14836087sm3363135ejo.103.2022.07.16.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 10:00:15 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 3/5] can: slcan: change every `slc' occurrence in `slcan'
Date:   Sat, 16 Jul 2022 19:00:05 +0200
Message-Id: <20220716170007.2020037-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
References: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In the driver there are parts of code where the prefix `slc' is used and
others where the prefix `slcan' is used instead. The patch replaces
every occurrence of `slc' with `slcan', except for the netdev functions
where, to avoid compilation conflicts, it was necessary to replace `slc'
with `slcan_netdev'.

The patch does not make any functional changes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan/slcan-core.c | 109 +++++++++++++++--------------
 1 file changed, 56 insertions(+), 53 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 92cab093453d..093d232c13dd 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -50,16 +50,17 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
 
 /* maximum rx buffer len: extended CAN frame with timestamp */
-#define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r") + 1)
-
-#define SLC_CMD_LEN 1
-#define SLC_SFF_ID_LEN 3
-#define SLC_EFF_ID_LEN 8
-#define SLC_STATE_LEN 1
-#define SLC_STATE_BE_RXCNT_LEN 3
-#define SLC_STATE_BE_TXCNT_LEN 3
-#define SLC_STATE_FRAME_LEN       (1 + SLC_CMD_LEN + SLC_STATE_BE_RXCNT_LEN + \
-				   SLC_STATE_BE_TXCNT_LEN)
+#define SLCAN_MTU (sizeof("T1111222281122334455667788EA5F\r") + 1)
+
+#define SLCAN_CMD_LEN 1
+#define SLCAN_SFF_ID_LEN 3
+#define SLCAN_EFF_ID_LEN 8
+#define SLCAN_STATE_LEN 1
+#define SLCAN_STATE_BE_RXCNT_LEN 3
+#define SLCAN_STATE_BE_TXCNT_LEN 3
+#define SLCAN_STATE_FRAME_LEN       (1 + SLCAN_CMD_LEN + \
+				     SLCAN_STATE_BE_RXCNT_LEN + \
+				     SLCAN_STATE_BE_TXCNT_LEN)
 struct slcan {
 	struct can_priv         can;
 
@@ -70,9 +71,9 @@ struct slcan {
 	struct work_struct	tx_work;	/* Flushes transmit buffer   */
 
 	/* These are pointers to the malloc()ed frame buffers. */
-	unsigned char		rbuff[SLC_MTU];	/* receiver buffer	     */
+	unsigned char		rbuff[SLCAN_MTU];	/* receiver buffer   */
 	int			rcount;         /* received chars counter    */
-	unsigned char		xbuff[SLC_MTU];	/* transmitter buffer	     */
+	unsigned char		xbuff[SLCAN_MTU];	/* transmitter buffer*/
 	unsigned char		*xhead;         /* pointer to next XMIT byte */
 	int			xleft;          /* bytes left in XMIT queue  */
 
@@ -151,7 +152,7 @@ int slcan_enable_err_rst_on_open(struct net_device *ndev, bool on)
  *************************************************************************/
 
 /* Send one completely decapsulated can_frame to the network layer */
-static void slc_bump_frame(struct slcan *sl)
+static void slcan_bump_frame(struct slcan *sl)
 {
 	struct sk_buff *skb;
 	struct can_frame *cf;
@@ -171,10 +172,10 @@ static void slc_bump_frame(struct slcan *sl)
 		fallthrough;
 	case 't':
 		/* store dlc ASCII value and terminate SFF CAN ID string */
-		cf->len = sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN];
-		sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN] = 0;
+		cf->len = sl->rbuff[SLCAN_CMD_LEN + SLCAN_SFF_ID_LEN];
+		sl->rbuff[SLCAN_CMD_LEN + SLCAN_SFF_ID_LEN] = 0;
 		/* point to payload data behind the dlc */
-		cmd += SLC_CMD_LEN + SLC_SFF_ID_LEN + 1;
+		cmd += SLCAN_CMD_LEN + SLCAN_SFF_ID_LEN + 1;
 		break;
 	case 'R':
 		cf->can_id = CAN_RTR_FLAG;
@@ -182,16 +183,16 @@ static void slc_bump_frame(struct slcan *sl)
 	case 'T':
 		cf->can_id |= CAN_EFF_FLAG;
 		/* store dlc ASCII value and terminate EFF CAN ID string */
-		cf->len = sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN];
-		sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN] = 0;
+		cf->len = sl->rbuff[SLCAN_CMD_LEN + SLCAN_EFF_ID_LEN];
+		sl->rbuff[SLCAN_CMD_LEN + SLCAN_EFF_ID_LEN] = 0;
 		/* point to payload data behind the dlc */
-		cmd += SLC_CMD_LEN + SLC_EFF_ID_LEN + 1;
+		cmd += SLCAN_CMD_LEN + SLCAN_EFF_ID_LEN + 1;
 		break;
 	default:
 		goto decode_failed;
 	}
 
-	if (kstrtou32(sl->rbuff + SLC_CMD_LEN, 16, &tmpid))
+	if (kstrtou32(sl->rbuff + SLCAN_CMD_LEN, 16, &tmpid))
 		goto decode_failed;
 
 	cf->can_id |= tmpid;
@@ -238,7 +239,7 @@ static void slc_bump_frame(struct slcan *sl)
  * sb256256 : state bus-off: rx counter 256, tx counter 256
  * sa057033 : state active, rx counter 57, tx counter 33
  */
-static void slc_bump_state(struct slcan *sl)
+static void slcan_bump_state(struct slcan *sl)
 {
 	struct net_device *dev = sl->dev;
 	struct sk_buff *skb;
@@ -264,16 +265,16 @@ static void slc_bump_state(struct slcan *sl)
 		return;
 	}
 
-	if (state == sl->can.state || sl->rcount < SLC_STATE_FRAME_LEN)
+	if (state == sl->can.state || sl->rcount < SLCAN_STATE_FRAME_LEN)
 		return;
 
-	cmd += SLC_STATE_BE_RXCNT_LEN + SLC_CMD_LEN + 1;
-	cmd[SLC_STATE_BE_TXCNT_LEN] = 0;
+	cmd += SLCAN_STATE_BE_RXCNT_LEN + SLCAN_CMD_LEN + 1;
+	cmd[SLCAN_STATE_BE_TXCNT_LEN] = 0;
 	if (kstrtou32(cmd, 10, &txerr))
 		return;
 
 	*cmd = 0;
-	cmd -= SLC_STATE_BE_RXCNT_LEN;
+	cmd -= SLCAN_STATE_BE_RXCNT_LEN;
 	if (kstrtou32(cmd, 10, &rxerr))
 		return;
 
@@ -301,7 +302,7 @@ static void slc_bump_state(struct slcan *sl)
  * e1a : len 1, errors: ACK error
  * e3bcO: len 3, errors: Bit0 error, CRC error, Tx overrun error
  */
-static void slc_bump_err(struct slcan *sl)
+static void slcan_bump_err(struct slcan *sl)
 {
 	struct net_device *dev = sl->dev;
 	struct sk_buff *skb;
@@ -317,7 +318,7 @@ static void slc_bump_err(struct slcan *sl)
 	else
 		return;
 
-	if ((len + SLC_CMD_LEN + 1) > sl->rcount)
+	if ((len + SLCAN_CMD_LEN + 1) > sl->rcount)
 		return;
 
 	skb = alloc_can_err_skb(dev, &cf);
@@ -325,7 +326,7 @@ static void slc_bump_err(struct slcan *sl)
 	if (skb)
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-	cmd += SLC_CMD_LEN + 1;
+	cmd += SLCAN_CMD_LEN + 1;
 	for (i = 0; i < len; i++, cmd++) {
 		switch (*cmd) {
 		case 'a':
@@ -414,7 +415,7 @@ static void slc_bump_err(struct slcan *sl)
 		netif_rx(skb);
 }
 
-static void slc_bump(struct slcan *sl)
+static void slcan_bump(struct slcan *sl)
 {
 	switch (sl->rbuff[0]) {
 	case 'r':
@@ -424,11 +425,11 @@ static void slc_bump(struct slcan *sl)
 	case 'R':
 		fallthrough;
 	case 'T':
-		return slc_bump_frame(sl);
+		return slcan_bump_frame(sl);
 	case 'e':
-		return slc_bump_err(sl);
+		return slcan_bump_err(sl);
 	case 's':
-		return slc_bump_state(sl);
+		return slcan_bump_state(sl);
 	default:
 		return;
 	}
@@ -440,12 +441,12 @@ static void slcan_unesc(struct slcan *sl, unsigned char s)
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
 		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
 		    sl->rcount > 4)
-			slc_bump(sl);
+			slcan_bump(sl);
 
 		sl->rcount = 0;
 	} else {
 		if (!test_bit(SLF_ERROR, &sl->flags))  {
-			if (sl->rcount < SLC_MTU)  {
+			if (sl->rcount < SLCAN_MTU)  {
 				sl->rbuff[sl->rcount++] = s;
 				return;
 			}
@@ -461,7 +462,7 @@ static void slcan_unesc(struct slcan *sl, unsigned char s)
  *************************************************************************/
 
 /* Encapsulate one can_frame and stuff into a TTY queue. */
-static void slc_encaps(struct slcan *sl, struct can_frame *cf)
+static void slcan_encaps(struct slcan *sl, struct can_frame *cf)
 {
 	int actual, i;
 	unsigned char *pos;
@@ -478,11 +479,11 @@ static void slc_encaps(struct slcan *sl, struct can_frame *cf)
 	/* determine number of chars for the CAN-identifier */
 	if (cf->can_id & CAN_EFF_FLAG) {
 		id &= CAN_EFF_MASK;
-		endpos = pos + SLC_EFF_ID_LEN;
+		endpos = pos + SLCAN_EFF_ID_LEN;
 	} else {
 		*pos |= 0x20; /* convert R/T to lower case for SFF */
 		id &= CAN_SFF_MASK;
-		endpos = pos + SLC_SFF_ID_LEN;
+		endpos = pos + SLCAN_SFF_ID_LEN;
 	}
 
 	/* build 3 (SFF) or 8 (EFF) digit CAN identifier */
@@ -492,7 +493,8 @@ static void slc_encaps(struct slcan *sl, struct can_frame *cf)
 		id >>= 4;
 	}
 
-	pos += (cf->can_id & CAN_EFF_FLAG) ? SLC_EFF_ID_LEN : SLC_SFF_ID_LEN;
+	pos += (cf->can_id & CAN_EFF_FLAG) ?
+		SLCAN_EFF_ID_LEN : SLCAN_SFF_ID_LEN;
 
 	*pos++ = cf->len + '0';
 
@@ -570,7 +572,8 @@ static void slcan_write_wakeup(struct tty_struct *tty)
 }
 
 /* Send a can_frame to a TTY queue. */
-static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t slcan_netdev_xmit(struct sk_buff *skb,
+				     struct net_device *dev)
 {
 	struct slcan *sl = netdev_priv(dev);
 
@@ -589,7 +592,7 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	netif_stop_queue(sl->dev);
-	slc_encaps(sl, (struct can_frame *)skb->data); /* encaps & send */
+	slcan_encaps(sl, (struct can_frame *)skb->data); /* encaps & send */
 	spin_unlock(&sl->lock);
 
 out:
@@ -632,7 +635,7 @@ static int slcan_transmit_cmd(struct slcan *sl, const unsigned char *cmd)
 }
 
 /* Netdevice UP -> DOWN routine */
-static int slc_close(struct net_device *dev)
+static int slcan_netdev_close(struct net_device *dev)
 {
 	struct slcan *sl = netdev_priv(dev);
 	int err;
@@ -661,10 +664,10 @@ static int slc_close(struct net_device *dev)
 }
 
 /* Netdevice DOWN -> UP routine */
-static int slc_open(struct net_device *dev)
+static int slcan_netdev_open(struct net_device *dev)
 {
 	struct slcan *sl = netdev_priv(dev);
-	unsigned char cmd[SLC_MTU];
+	unsigned char cmd[SLCAN_MTU];
 	int err, s;
 
 	/* The baud rate is not set with the command
@@ -724,16 +727,16 @@ static int slc_open(struct net_device *dev)
 	return err;
 }
 
-static int slcan_change_mtu(struct net_device *dev, int new_mtu)
+static int slcan_netdev_change_mtu(struct net_device *dev, int new_mtu)
 {
 	return -EINVAL;
 }
 
-static const struct net_device_ops slc_netdev_ops = {
-	.ndo_open               = slc_open,
-	.ndo_stop               = slc_close,
-	.ndo_start_xmit         = slc_xmit,
-	.ndo_change_mtu         = slcan_change_mtu,
+static const struct net_device_ops slcan_netdev_ops = {
+	.ndo_open               = slcan_netdev_open,
+	.ndo_stop               = slcan_netdev_close,
+	.ndo_start_xmit         = slcan_netdev_xmit,
+	.ndo_change_mtu         = slcan_netdev_change_mtu,
 };
 
 /******************************************
@@ -807,7 +810,7 @@ static int slcan_open(struct tty_struct *tty)
 	/* Configure netdev interface */
 	sl->dev	= dev;
 	strscpy(dev->name, "slcan%d", sizeof(dev->name));
-	dev->netdev_ops = &slc_netdev_ops;
+	dev->netdev_ops = &slcan_netdev_ops;
 	slcan_set_ethtool_ops(dev);
 
 	/* Mark ldisc channel as alive */
@@ -875,7 +878,7 @@ static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
 	}
 }
 
-static struct tty_ldisc_ops slc_ldisc = {
+static struct tty_ldisc_ops slcan_ldisc = {
 	.owner		= THIS_MODULE,
 	.num		= N_SLCAN,
 	.name		= "slcan",
@@ -893,7 +896,7 @@ static int __init slcan_init(void)
 	pr_info("slcan: serial line CAN interface driver\n");
 
 	/* Fill in our line protocol discipline, and register it */
-	status = tty_register_ldisc(&slc_ldisc);
+	status = tty_register_ldisc(&slcan_ldisc);
 	if (status)
 		pr_err("slcan: can't register line discipline\n");
 
@@ -905,7 +908,7 @@ static void __exit slcan_exit(void)
 	/* This will only be called when all channels have been closed by
 	 * userspace - tty_ldisc.c takes care of the module's refcount.
 	 */
-	tty_unregister_ldisc(&slc_ldisc);
+	tty_unregister_ldisc(&slcan_ldisc);
 }
 
 module_init(slcan_init);
-- 
2.32.0

