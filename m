Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF2580243
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiGYPyW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiGYPyV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7381DF66
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w7so10757911ply.12
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OAyAclI8gDeKRzlzTjGfCuF1/4VXKJq5MDqz3fHHbI=;
        b=JZjcxMSPrKRwFIGWFNuiswBbPYPeRLk6WieCQMM0sR3Kkzei6AG5w5Yn3QjjUUca9Z
         v08sj3KiTaeax0UuFA1AAum/cPhhHLpf68mRzlunoM+eGYxsKG1P70q6ZgmQ5Wpi5QJw
         GPS5z1qL61flEjZlWmD+tBfD0ZFkdd+UlZFDjvtd4swxy53pbyBSrC5c0at092usj9HK
         R6HovnzebKNVBVodymhuppHxv0Oc84OpHOrkNM58RWIu01QVgYnPMVAPvrfOPzG8XzXh
         y6vqrBW866claRY3CvtZE3ve0LGbrcv9tQ17r+d09fLaxcC2sHkz2qWOvC7LNf32BRYD
         J21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3OAyAclI8gDeKRzlzTjGfCuF1/4VXKJq5MDqz3fHHbI=;
        b=aLbcIjPeKgRLPsBoTVqFxKCLyPabaSt9UAQZwcVpQABxAmEKE8Le3kxK+s0IyyR6Ln
         hhLYQWlz2JVrZsKbGE1Y2yGo5fB5rbZK6en64k56T3vNcK7iKUgKdew5Behu6p+MrMpk
         SQtVU+p3Mv+pN0mm636bi0wwGMtfbQP6vmzDjBC0eUYZqq/qMJfv71p9194pRBlwc1un
         hFKAmWhUP/VJpk/oHUc/3YhhiiAdFxc0dIavJNE1/EswsgEWC0FTFrlifzz1ddAU4eb3
         D9UNgbxHNBqTENCoT4POeTZmeWydfadKfGFYyytWijqCIgUyvg9HqxZ66JfRmF1/bztx
         0HIA==
X-Gm-Message-State: AJIora/REhHAJQFIqwyT+8Dw6+6b5UVScEhQDSHXZrKQh07bAWWPP3CM
        X66n+xtbkU2RXaHI8Sithnu8uIzSHxlWLQ==
X-Google-Smtp-Source: AGRyM1uXiJPBw+8m257Urt5LVBTJDn/kJAOdKAH3Qm1gtlIv/HR3QQ1yyyEmyIr0eMgYJSVzY6dO6g==
X-Received: by 2002:a17:902:bd47:b0:16a:71a4:9bfd with SMTP id b7-20020a170902bd4700b0016a71a49bfdmr13130936plx.109.1658764457247;
        Mon, 25 Jul 2022 08:54:17 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:17 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 04/14] can: v(x)can: add software tx timestamps
Date:   Tue, 26 Jul 2022 00:53:44 +0900
Message-Id: <20220725155354.482986-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

TX timestamps were added to the can_put_echo_skb() function of can_dev
modules in [1]. However, vcan and vxcan do not rely on that function
and as such do not offer TX timestamping.

While it could be arguable whether TX timestamps are really needed for
virtual interfaces, we prefer to still add it so that all CAN dirvers,
without exception supports the TX software timestamps.

Add a call to skb_tx_timestamp() in the vcan_tx() and vxcan_xmit()
functions so that the modules now support TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/vcan.c  | 2 ++
 drivers/net/can/vxcan.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index a15619d883ec..4a363cfcf97c 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -99,6 +99,8 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
 
+	skb_tx_timestamp(skb);
+
 	if (!echo) {
 		/* no echo handling available inside this driver */
 		if (loop) {
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 577a80300514..61b6eca383f8 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -53,6 +53,8 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 		goto out_unlock;
 	}
 
+	skb_tx_timestamp(oskb);
+
 	skb = skb_clone(oskb, GFP_ATOMIC);
 	if (skb) {
 		consume_skb(oskb);
-- 
2.35.1

