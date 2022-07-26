Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3989581117
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiGZKZ2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiGZKZ2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE8C252BB
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c13so6203434pla.6
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzgyOo7BH7tFdrdKL3b8igSvwmrl7qlaltWraaOdaBw=;
        b=lF9zayCLW5JjcgfXYx2Q+byFAyQQ0SU+sLffXYSXr0G19OKVM1kcG+aeLrmrsFsapP
         5MoMYgW2STMyDvffC3Y3EgtSri24PEhyVlmZZt5gFPYrt8ldp5KwgEhpDXnNDiAp8S06
         vxbRv5AcnWR34cPP81/1R8Bs/JD/m36H0kNBujhkCWO6/VZHjBcGOmGQYvglPFeypbiD
         p444GN+VwTYa8GVaYwqEz+OLksbBSHk5JhCtr3fDIlRqd+jRTorNzp3V3Co8dkfgL12Y
         oTpirTh09LP/abvfjynsVw7jeXNLdz7jh1XbAbWmhjcQL1rc8VRW5OrJun6Lp5cHDcTA
         UzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bzgyOo7BH7tFdrdKL3b8igSvwmrl7qlaltWraaOdaBw=;
        b=nXPIYNTSUDa0gyL6mwtwNEcIx3odN6juXw+GNfVEfGNp/SzFiPk+MYA+gFNXiCYxwh
         WUBPdloToJ8cANgHVViVK0YjNw44NFb7U5RPC6w8cpP0BFKcipmJ0d22bEptm7RIO0NX
         lQyuuqlVw9CasfJLdFMJRP16XSiqg7mkiF+KX0WOYAi/GwiM9AkXMHZ1XBxyhD8V4JiL
         gzFqhs5cVFOGCPqirlyu23BtDyT5echxXldH54D0mXrr1o7M/Samci1r4e/ouThHUCx3
         4EH16znpf5EjIv+soDXobBcEuJ1jH77Zx2enUvyrQplOYv28T4Pos+A4dDOMq78rfVpn
         nElA==
X-Gm-Message-State: AJIora/abL+Au8cjMKAaJJTBGW5XjShquMQoo+NZR+mBqWIB6AojViN2
        Tcke/P8WRd90l0Q8r9YWRQJKEmyPofL0Bg==
X-Google-Smtp-Source: AGRyM1tEH3Qj9xp8KBLgaNHcLukq6wnGdOlt7BeIS/WCjr1cHS04FJLzy0vtHd29SpQM9Efuu6tIHA==
X-Received: by 2002:a17:90b:4c10:b0:1ef:eb4a:fbb with SMTP id na16-20020a17090b4c1000b001efeb4a0fbbmr35845169pjb.121.1658831123450;
        Tue, 26 Jul 2022 03:25:23 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:23 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 01/14] can: can327: add software tx timestamps
Date:   Tue, 26 Jul 2022 19:24:41 +0900
Message-Id: <20220726102454.95096-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
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
modules in [1]. However, can327 does not rely on that function and as
such does not offer TX timestamping.

Add a call to skb_tx_timestamp() in the can327_netdev_start_xmit()
function so that the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/can327.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 5da7778d92dc..88718d0cc569 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -836,6 +836,8 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += frame->can_id & CAN_RTR_FLAG ? 0 : frame->len;
 
+	skb_tx_timestamp(skb);
+
 out:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
-- 
2.35.1

