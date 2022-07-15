Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B75575C58
	for <lists+linux-can@lfdr.de>; Fri, 15 Jul 2022 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiGOHaM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jul 2022 03:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiGOHaK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jul 2022 03:30:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADFA7AC2B
        for <linux-can@vger.kernel.org>; Fri, 15 Jul 2022 00:30:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v12so5187817edc.10
        for <linux-can@vger.kernel.org>; Fri, 15 Jul 2022 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHnTn6VhmtnfWqf0g7Gj+G785dxWqdgYwW9ZzmaeJh4=;
        b=AVIZkYqmlFqGyQyc7TgsQ34JecaSIs4T8qLG5N3Hp0xrVzxcXrS3uzP60Pb8HTdcmT
         NNGLnCb4Z9g7363Stm9NWRyWEhV7UQj1cA1KUh9ersScVzQznP+DuLsHeTVH54CzogV6
         sDh41C5MSXZZjAFvypRAwrByZXHmsniHxPdoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHnTn6VhmtnfWqf0g7Gj+G785dxWqdgYwW9ZzmaeJh4=;
        b=NlNpUOKoUEuyMkGZtXgC1o9BRWO1ZN93Mfp7mTt5IDFD8rGYRZiuEdT3yZNR20wNvC
         LT/XRQj7Z0t5AXEhl4Qkaq358PyylwfjAlm1WWe09OrUElVOac/w7oDFz8m7KnjLfp2y
         ZTbivwhk3QRWg252LnPr6SuaSm5GspPKzhp3QbT+vbXb5vkTgUwBQ6Jx5Q9nT2lsNLT1
         duU3L9gauyWiI0BA3xtAVf/Jmyx1CnQDCGEyPv1xj06I1Rt1XvQzQB7m7MkDEfiVubLX
         NrHw05lza9fBA0C/9asecA+y8qLVSZI0nuubLYnKVQssfEDcI3MK7Ayy0ZduwqVY8e7K
         +SCg==
X-Gm-Message-State: AJIora8zCPAkYoqHEojBcjRoN7SMAv39V16joqW42Jdgf3LzpxWxgLDa
        7eR9IQjFQ3f1lbURLk3MeI4v3w==
X-Google-Smtp-Source: AGRyM1veMbMMZYqaMJnj/C70UuvPpYLJnS6n0L96smOnFkBPJaiYLrr37MwwvBcLdyxnSZvMMZunqw==
X-Received: by 2002:aa7:c585:0:b0:43a:725b:9851 with SMTP id g5-20020aa7c585000000b0043a725b9851mr17229990edq.399.1657870207114;
        Fri, 15 Jul 2022 00:30:07 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-80-182-13-224.retail.telecomitalia.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id lb11-20020a170907784b00b007246492658asm1692756ejc.117.2022.07.15.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:30:06 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     ltp@lists.linux.it, Jeroen Hofstee <jhofstee@victronenergy.com>,
        lkp@intel.com, Richard Palethorpe <rpalethorpe@suse.de>,
        kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3] can: slcan: do not sleep with a spin lock held
Date:   Fri, 15 Jul 2022 09:29:51 +0200
Message-Id: <20220715072951.859586-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We can't call close_candev() with a spin lock held, so release the lock
before calling it. After calling close_candev(), we can update the
fields of the private `struct can_priv' without having to acquire the
lock.

Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Update the commit message.
- Reset sl->rcount and sl->xleft before releasing the spin lock.

Changes in v2:
- Release the lock just before calling the close_candev().

 drivers/net/can/slcan/slcan-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 54d29a410ad5..d40ddc596596 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -689,15 +689,14 @@ static int slc_close(struct net_device *dev)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
 	netif_stop_queue(dev);
+	sl->rcount   = 0;
+	sl->xleft    = 0;
+	spin_unlock_bh(&sl->lock);
 	close_candev(dev);
 	sl->can.state = CAN_STATE_STOPPED;
 	if (sl->can.bittiming.bitrate == CAN_BITRATE_UNKNOWN)
 		sl->can.bittiming.bitrate = CAN_BITRATE_UNSET;
 
-	sl->rcount   = 0;
-	sl->xleft    = 0;
-	spin_unlock_bh(&sl->lock);
-
 	return 0;
 }
 
-- 
2.32.0

