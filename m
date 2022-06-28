Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6770E55E9F4
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiF1Qf4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Jun 2022 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiF1Qey (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Jun 2022 12:34:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864FB34660
        for <linux-can@vger.kernel.org>; Tue, 28 Jun 2022 09:31:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ge10so26898667ejb.7
        for <linux-can@vger.kernel.org>; Tue, 28 Jun 2022 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zyw3StTTBZQE50VIbm/+yoJ4bqV04RBr+wi4S3Ganwc=;
        b=S41zUjUKFlhBCYHOrerU5Xli96L0AvUDZCtir9tl9KKhDeC8JN0+3ZNV+HKTkyOqCy
         h3eg+RxMKxD5a3XHNmdMZaq8L7ZqxdgDedkPkKoUBvQabLUnKEwbbvKjK2MSudgj7GP+
         GftuGtwXXeo/ZzamCA1zlRh+75OmhWbo//6JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zyw3StTTBZQE50VIbm/+yoJ4bqV04RBr+wi4S3Ganwc=;
        b=0RKURQIX4rTOPoMNjhr9gcrxikSEAuCuyjzhYK6YuIS03VsOpHhOjop/3QiOV2TdrR
         aA7iKnGCEZDNgcRGCQPsBVKApSobKmZpcrQiHzwtGCkCCPkCcKCfAAST7HRqC8SVqWHM
         UDPldKl5zmuctFTM8O00mFd0wbcE7GZVFo9u0rRXLCBbCc14dnhCbkL+EWMPry8RRO0e
         6RErLAI8uwHNCeuOcu9KOgZjBiSHQOZ7Ok+MGOPVdq/x+yTpXtE+zB2hIo4qtUXiEQL3
         mLfUO+ji7HpWUoU9yg7G1kOFk4gy92+MNbYcYLT92CUxy9k+AXlNoum9CtbLnbXs/L53
         yQvg==
X-Gm-Message-State: AJIora8azfh1wpVsIdntQAcfGrFSySe0Tf1XlYnCF1sQdUm5hmEEWKtM
        4aqUS6qUiFFqerxGVunGQmBFcA==
X-Google-Smtp-Source: AGRyM1vBk2wMNW/HbxmnPsFpzK+heKZBIMg8aMv9NVyx6WCQ/nsUdgJrApjNpv2e8d6nEmWoA1gitA==
X-Received: by 2002:a17:907:72c7:b0:722:f046:c9d9 with SMTP id du7-20020a17090772c700b00722f046c9d9mr18152763ejc.409.1656433916978;
        Tue, 28 Jun 2022 09:31:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id b20-20020a0564021f1400b0042e15364d14sm9916952edb.8.2022.06.28.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:31:56 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 06/12] can: slcan: allow to send commands to the adapter
Date:   Tue, 28 Jun 2022 18:31:30 +0200
Message-Id: <20220628163137.413025-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
References: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a preparation patch for the upcoming support to change the
bitrate via ip tool, reset the adapter error states via the ethtool API
and, more generally, send commands to the adapter.

Since the close command (i. e. "C\r") will be sent in the ndo_stop()
where netif_running() returns false, a new flag bit (i. e. SLF_XCMD) for
serial transmission has to be added.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- Replace `sl->tty == NULL' with `!sl->tty'.

Changes in v3:
- Update the commit description.

 drivers/net/can/slcan.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index bf84698f1a81..dfccf8d6c9a5 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -97,6 +97,9 @@ struct slcan {
 	unsigned long		flags;		/* Flag values/ mode etc     */
 #define SLF_INUSE		0		/* Channel in use            */
 #define SLF_ERROR		1               /* Parity, etc. error        */
+#define SLF_XCMD		2               /* Command transmission      */
+	wait_queue_head_t       xcmd_wait;      /* Wait queue for commands   */
+						/* transmission              */
 };
 
 static struct net_device **slcan_devs;
@@ -314,12 +317,22 @@ static void slcan_transmit(struct work_struct *work)
 
 	spin_lock_bh(&sl->lock);
 	/* First make sure we're connected. */
-	if (!sl->tty || sl->magic != SLCAN_MAGIC || !netif_running(sl->dev)) {
+	if (!sl->tty || sl->magic != SLCAN_MAGIC ||
+	    (unlikely(!netif_running(sl->dev)) &&
+	     likely(!test_bit(SLF_XCMD, &sl->flags)))) {
 		spin_unlock_bh(&sl->lock);
 		return;
 	}
 
 	if (sl->xleft <= 0)  {
+		if (unlikely(test_bit(SLF_XCMD, &sl->flags))) {
+			clear_bit(SLF_XCMD, &sl->flags);
+			clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
+			spin_unlock_bh(&sl->lock);
+			wake_up(&sl->xcmd_wait);
+			return;
+		}
+
 		/* Now serial buffer is almost free & we can start
 		 * transmission of another packet */
 		sl->dev->stats.tx_packets++;
@@ -383,6 +396,36 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
  *   Routines looking at netdevice side.
  ******************************************/
 
+static int slcan_transmit_cmd(struct slcan *sl, const unsigned char *cmd)
+{
+	int ret, actual, n;
+
+	spin_lock(&sl->lock);
+	if (!sl->tty) {
+		spin_unlock(&sl->lock);
+		return -ENODEV;
+	}
+
+	n = snprintf(sl->xbuff, sizeof(sl->xbuff), "%s", cmd);
+	set_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
+	actual = sl->tty->ops->write(sl->tty, sl->xbuff, n);
+	sl->xleft = n - actual;
+	sl->xhead = sl->xbuff + actual;
+	set_bit(SLF_XCMD, &sl->flags);
+	spin_unlock(&sl->lock);
+	ret = wait_event_interruptible_timeout(sl->xcmd_wait,
+					       !test_bit(SLF_XCMD, &sl->flags),
+					       HZ);
+	clear_bit(SLF_XCMD, &sl->flags);
+	if (ret == -ERESTARTSYS)
+		return ret;
+
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 /* Netdevice UP -> DOWN routine */
 static int slc_close(struct net_device *dev)
 {
@@ -540,6 +583,7 @@ static struct slcan *slc_alloc(void)
 	sl->dev	= dev;
 	spin_lock_init(&sl->lock);
 	INIT_WORK(&sl->tx_work, slcan_transmit);
+	init_waitqueue_head(&sl->xcmd_wait);
 	slcan_devs[i] = dev;
 
 	return sl;
-- 
2.32.0

