Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF15823F9
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiG0KRO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiG0KRM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95289220DA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 17so15758339pfy.0
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcmcc74LPJ9v8k189QMe7EObgqycBUan5EfDKQHMTAc=;
        b=arzgnaKRuhbubp5QoHD89YGxmdmf9I5uW/v1YeyXbtGlRaAe57o4CWIlnSK+QGxZZz
         SzVu4BgkgxmE6XrQV+D6KKMcXOod2CwuDvQkWb3C6dEDlM7YlYAFy7lEUg4v0O4I8vlD
         kJiyuDfmaPvXmK5OOgVILnq89dQRI7Ff59i08sIdZtpad/18Yntsxm0DFuv7Mkogqj9k
         oQgzq2tT3TuIAQboHNCxcNkL4kpT9A7NmPHE4O+pLUTmQOJul/RWQ362oFwkP7eWOQMO
         SMZa8UA/hJkMVxJYN2emPHOTOfxdvgDLIp4nKfs5BB1YqmbxxcZjsFAZbOG0Cf0YT450
         mY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xcmcc74LPJ9v8k189QMe7EObgqycBUan5EfDKQHMTAc=;
        b=pg81SIVqnexvRj04iT+8LdmOwGb8j4tMJ3voA6MmCs2ctCsozeSqHo5pi6dTIX6GL6
         VNKSZ3G+oYwYPMk/INmbCyQPXUPvLifydqsjAm3oNtAF1VdTb7oZJ7PMYJrqo8XGnGth
         bSMj5vGO+pMcBn+lfOz6EpCnfLKIt9m1NLj0rlLTzBLo2GzmW17baESCOpwx6QZgEU8Q
         JdxbWl1WUdLjYg/eWPs7BpeZiu4i0QS3G4GOH23uxals+v3dhfqzXn6OFVOJPAEgRIsz
         f19dcV2n9NwGUuUfMoQTuH3DrxEnRXusVSX2bFgu+ouwPV6Un3h5K56YFBhv59Dm07zP
         YPEw==
X-Gm-Message-State: AJIora89ngcQmKH8IAZ58UoTlcJEUWKQu1zuFb9eqLF2LMXM7vPg/J4u
        KF81Q1Ee7RxVmx+iPO6CBCFRJMdmlJkVWQ==
X-Google-Smtp-Source: AGRyM1uc+4xh66wdo1z37AsoIhdgI9sthxo0Xac8ULEUcu3Y2eP7ZVHwdXgY5YRRuACyWS2rotjDZQ==
X-Received: by 2002:a05:6a00:26f1:b0:52b:d0aa:4178 with SMTP id p49-20020a056a0026f100b0052bd0aa4178mr21514578pfw.86.1658917030753;
        Wed, 27 Jul 2022 03:17:10 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:10 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 04/14] can: v(x)can: add software tx timestamps
Date:   Wed, 27 Jul 2022 19:16:31 +0900
Message-Id: <20220727101641.198847-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
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
virtual interfaces, we prefer to still add it so that all CAN drivers,
without exception, support the software TX timestamps.

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

