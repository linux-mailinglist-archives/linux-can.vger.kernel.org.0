Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAEC580EE9
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiGZI1a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiGZI12 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66F62FFE2
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w7so12653936ply.12
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05C+NVlRWa5zB2fjz5qao6wSzIHQrGgL0UUJqtTYaDg=;
        b=ZP/EOKt+qL1q5J5haZmYFAXjxf2v47Nc1HM0UdYZc9UfOC91gX1Pef6Oxepk7ZiAbu
         wdop43DNi+DJRwIumj2dDHoUYYuxe9POMKVSSukwYvkL9rTdjd84h9Mws+3DjuyNucnR
         hqFFf63a2Mt5+g0F3ueB7tYdgwK7A+jnOl0SnYbCnQhdIMicZhMwdvZy+8qvTy7IReIz
         ay+z2/2uxOfwVkbJSVgsVRV6YvDR8ktjfvVSnjlHwKTZyK34eoey0x3arbjpfW1MMIlc
         qr2ZrloPxJUb5ih5jXjxk2KWeAwBYCb77yzLCUMzkp3ElM+2Ek8BFPpt3wKLAHHnl/Km
         WfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=05C+NVlRWa5zB2fjz5qao6wSzIHQrGgL0UUJqtTYaDg=;
        b=pT9euSoRe/R9hk/Qu0/UaSrdkvMDTZql/yGu4D3s2ntI/UM0qN9gbj3ArSne8H9VIT
         CMGZAzP4xzNRxJsG1yCIwhW8eflvb6avLf/WmkziKXIgMdUdJCQpCaJyITphoWn6gx3L
         rMid08Y3eZyg8YTxcBRVSI7qZeQjpuNLFV4WNFhFilgEiLhYwoJswSHnq11HAJvHIsQK
         jIi5Vz9MTs/aFTTPgWI9DtMtZuvgDCyMLA5ii6YinxjamPHyG+1Wp67Hlng71I4jt3Zm
         Eq5+W92UUqs9WoqEPN/UqZV3gYe+6WUHhZc6t7Osa55CL/vtc4jfub4T1BKXxjgcDOE1
         WNHw==
X-Gm-Message-State: AJIora+8KqpqV127OgWKV4WLfkFHUMhqaGUwqjscvA4+1c4BYH/sYNvd
        A3b48SJ7a6BPnJ704cD/v9ztEll8t83mUA==
X-Google-Smtp-Source: AGRyM1svmxbZOLEEK18TKdMxL8pPf7tRvSOZkPNqvkCNo6a92D+DJVmvLDbmG28r1bNgMUdz8Yae3w==
X-Received: by 2002:a17:90b:3907:b0:1f0:386e:c0ee with SMTP id ob7-20020a17090b390700b001f0386ec0eemr18097106pjb.141.1658824044825;
        Tue, 26 Jul 2022 01:27:24 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:24 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 03/10] can: slcan: use KBUILD_MODNAME and define pr_fmt to replace hardcoded names
Date:   Tue, 26 Jul 2022 17:27:00 +0900
Message-Id: <20220726082707.58758-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "slcan" to populate
tty_ldisc_ops::name. KBUILD_MODNAME also evaluates to "slcan". Use
KBUILD_MODNAME to get rid on the hardcoded string names.

Similarly, the pr_info() and pr_err() hardcoded the "slcan"
prefix. Define pr_fmt so that the "slcan" prefix gets automatically
added.

can: ems_ubs: use KBUILD_MODNAME instead of hard coded name

    The driver uses the string "ems_usb" to populate usb_driver::name and
    can_bittiming_const::name. KBUILD_MODNAME also evaluates to
    "ems_ubs". Use KBUILD_MODNAME and get rid on the hardcoded string
    names.

CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---

@Dario, because you are also doing a lot of changes on slcan, our
patches might conflict. Do not hesitate to take this one and add it to
your series to simplify the merge.
---
 drivers/net/can/slcan/slcan-core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index dc28e715bbe1..3039ce37c8f1 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -35,6 +35,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 
@@ -864,7 +866,7 @@ static struct slcan *slc_alloc(void)
 	if (!dev)
 		return NULL;
 
-	snprintf(dev->name, sizeof(dev->name), "slcan%d", i);
+	snprintf(dev->name, sizeof(dev->name), KBUILD_MODNAME "%d", i);
 	dev->netdev_ops = &slc_netdev_ops;
 	dev->base_addr  = i;
 	slcan_set_ethtool_ops(dev);
@@ -937,7 +939,7 @@ static int slcan_open(struct tty_struct *tty)
 		rtnl_unlock();
 		err = register_candev(sl->dev);
 		if (err) {
-			pr_err("slcan: can't register candev\n");
+			pr_err("can't register candev\n");
 			goto err_free_chan;
 		}
 	} else {
@@ -1028,7 +1030,7 @@ static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
 static struct tty_ldisc_ops slc_ldisc = {
 	.owner		= THIS_MODULE,
 	.num		= N_SLCAN,
-	.name		= "slcan",
+	.name		= KBUILD_MODNAME,
 	.open		= slcan_open,
 	.close		= slcan_close,
 	.hangup		= slcan_hangup,
@@ -1044,8 +1046,8 @@ static int __init slcan_init(void)
 	if (maxdev < 4)
 		maxdev = 4; /* Sanity */
 
-	pr_info("slcan: serial line CAN interface driver\n");
-	pr_info("slcan: %d dynamic interface channels.\n", maxdev);
+	pr_info("serial line CAN interface driver\n");
+	pr_info("%d dynamic interface channels.\n", maxdev);
 
 	slcan_devs = kcalloc(maxdev, sizeof(struct net_device *), GFP_KERNEL);
 	if (!slcan_devs)
@@ -1054,7 +1056,7 @@ static int __init slcan_init(void)
 	/* Fill in our line protocol discipline, and register it */
 	status = tty_register_ldisc(&slc_ldisc);
 	if (status)  {
-		pr_err("slcan: can't register line discipline\n");
+		pr_err("can't register line discipline\n");
 		kfree(slcan_devs);
 	}
 	return status;
-- 
2.35.1

