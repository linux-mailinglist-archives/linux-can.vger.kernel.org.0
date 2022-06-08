Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E285439E1
	for <lists+linux-can@lfdr.de>; Wed,  8 Jun 2022 19:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiFHQ6D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Jun 2022 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiFHQz3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Jun 2022 12:55:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89CD3CAF41
        for <linux-can@vger.kernel.org>; Wed,  8 Jun 2022 09:51:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y19so42627966ejq.6
        for <linux-can@vger.kernel.org>; Wed, 08 Jun 2022 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTTwzX/aiA/HRTscWPld7sV0y4pSfK/bYOnDrdN63VI=;
        b=OSyMEpVoLY2gHejWkMk9SCxrTmHFgHLaZDyBg2ojZQlfFiKUmG6vVhu2pb0EN62d4y
         XWAcHLQr18NR0yAc/EVfYRCOzh73nKlABEU9WIfbyoXNMp3D40jTiZd/7DcR3gXz3idz
         8rByJjSs0u69EFn5sr/zghXbyFofFSOrFApak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTTwzX/aiA/HRTscWPld7sV0y4pSfK/bYOnDrdN63VI=;
        b=hXbx3Xy/gJ0RvEmPu1j1+6kvPVJganx82+FLzvaQjGDE4WlDxJQrJg6G7BRRgd1zc6
         8yXYRQf74cGpVCFqVkt7qTTE2HpJG0QxfM+uZ1+gPNw7GpbUzm9YS58dQlnyVN65GTZu
         sLu54j3/dex07eFzIshQ21lUOUN7gQGzl7ACf++nlI71FtszBGxqC7uko+Z6WcU5X5xp
         +0qooYmQPHmy+U91IWf++GtQDmXJP15lhm7Clv//81ebSvR3EWal6MN2vJSE3JfRDJXG
         uvgUxcYjWJ0esL2+6AJ0fakzO+6o/KVs3phWiW7SIEdrJS8lZeH0CyVbyKA57+S1vLLu
         1N+w==
X-Gm-Message-State: AOAM533+79oUIR6eleEBp7S5+D/MUTU9PGxHxvw1gNWWGKXrSFX23Dt2
        OUs0uRc6QOxzILCDBgkdOmuQ7CkrrECoHg==
X-Google-Smtp-Source: ABdhPJxAr2mTP/F9B9ZnVXAL2CsYGfXcBzPWLp0fZ9ItNEGjJoTX1tLRSK3GZKYtPy3itMuQYlLMOQ==
X-Received: by 2002:a05:6402:f97:b0:431:8d1d:397d with SMTP id eh23-20020a0564020f9700b004318d1d397dmr11248102edb.423.1654707092277;
        Wed, 08 Jun 2022 09:51:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:31 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 06/13] can: slcan: allow to send commands to the adapter
Date:   Wed,  8 Jun 2022 18:51:09 +0200
Message-Id: <20220608165116.1575390-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
References: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
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

Since some commands (e. g. setting the bitrate) will be sent before
calling the open_candev(), the netif_running() will return false and so
a new flag bit (i. e. SLF_XCMD) for serial transmission has to be added.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/slcan.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index cf05c30b8da5..cab0a2a8c84c 100644
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
+	if (sl->tty == NULL) {
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
@@ -546,6 +589,7 @@ static struct slcan *slc_alloc(void)
 	sl->dev	= dev;
 	spin_lock_init(&sl->lock);
 	INIT_WORK(&sl->tx_work, slcan_transmit);
+	init_waitqueue_head(&sl->xcmd_wait);
 	slcan_devs[i] = dev;
 
 	return sl;
-- 
2.32.0

