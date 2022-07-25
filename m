Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5781457FFDB
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiGYNci (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYNch (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8252BE0BB
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p1so1898307plr.11
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPxeUU0StP5c6ZgwSeiGwxhM6MlWFuGPWc1Fd7dUDPY=;
        b=SUtazaFk02f0sRJ76j+jB+1tDqPAV8f8c38aHSEuuXlWvb0RxOvhXkrcojRdLyP+Aa
         boVRn5H9MbiafRoVRLtGbxIg5W4dszQMGAMnahgT8RAX917JzbKAFsi1npHQMjBT+bJf
         3hCnyNfPzTcot5Y+/giew6xbmzcm/kJfTZzzTuvCsSJC6tZInuR/56REMC86TU4HpCw5
         adyts+1fkJF31C1DChO9vOOFJkRgtixCmYo2J8FNeIhht2PQ7v1F+PZ5SPUhgLDOWV+b
         RN9C4EHCHGgtBRe30XDmogBagsndjU4bV5BIRjm5LutFCgpresSnQaJCry3RVDqy2Dez
         o8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lPxeUU0StP5c6ZgwSeiGwxhM6MlWFuGPWc1Fd7dUDPY=;
        b=0DsMLqsvpwtDlOzpZ35X1GODC12xMcoTUz76BaN6OSzgRirrYfX83/t9gwdTj5tkzc
         N7H5f9GGjbMq5+f3y+xUaLUWnS50D7jVnIrL7GeaCZDyz1NyRovvyV7oQVRtb5Bb/1rk
         p9k71lmKrpNNFPwolTQaY4ZBI5oqaKwTJ0sbwc6TBRKbVNLG1SajV75oIEsKvIjjiRf7
         J/BJoqLycMIV7b0yzAEtU+tABFY/9jvDb40NJqZ1674Sr+/iG6sHlO7Qd9UZDyc0na0x
         8EDt9vZEOeyj0FxEtIEJXrf8KWJNdBTwqA6NpJiLCP7DILwZwPW9tKxRfjjawujWs7KV
         fh5w==
X-Gm-Message-State: AJIora850t2fztS4Xvf34L1mIjDWOobPh34TK2+IVXQP8FwTvS8vkUDr
        VzSz/a75LaavbLBDTa/CMtKB3WnU0iPlNQ==
X-Google-Smtp-Source: AGRyM1vM/0gIKH/cC3OnkuRg1QAC0taNofNKERDEbijNgye+sC+88sH0haFzTK/eTSoa2CBFWPuYxA==
X-Received: by 2002:a17:902:f787:b0:16a:1e2b:e97 with SMTP id q7-20020a170902f78700b0016a1e2b0e97mr12009382pln.27.1658755954822;
        Mon, 25 Jul 2022 06:32:34 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:34 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 03/24] can: slcan: add DRV_NAME and define pr_fmt to replace hardcoded names
Date:   Mon, 25 Jul 2022 22:31:47 +0900
Message-Id: <20220725133208.432176-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
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
tty_ldisc_ops::name. Add a new macro DRV_NAME which evaluates to
"slcan" and then use DRV_NAME and to get rid on the hardcoded string
names.

Similarly, the pr_info() and pr_err() hardcoded the "slcan"
prefix. Define pr_fmt so that the "slcan" prefix gets automatically
added.

CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---

@Dario, because you are also doing a lot of changes on slcan, our
patches might conflict. Do not hesitate to take this one and add it to
your series to simplify the merge.
---
 drivers/net/can/slcan/slcan-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index dc28e715bbe1..d1562f9474c9 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -35,6 +35,9 @@
  *
  */
 
+#define DRV_NAME "slcan"
+#define pr_fmt(fmt) DRV_NAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 
@@ -864,7 +867,7 @@ static struct slcan *slc_alloc(void)
 	if (!dev)
 		return NULL;
 
-	snprintf(dev->name, sizeof(dev->name), "slcan%d", i);
+	snprintf(dev->name, sizeof(dev->name), DRV_NAME "%d", i);
 	dev->netdev_ops = &slc_netdev_ops;
 	dev->base_addr  = i;
 	slcan_set_ethtool_ops(dev);
@@ -937,7 +940,7 @@ static int slcan_open(struct tty_struct *tty)
 		rtnl_unlock();
 		err = register_candev(sl->dev);
 		if (err) {
-			pr_err("slcan: can't register candev\n");
+			pr_err("can't register candev\n");
 			goto err_free_chan;
 		}
 	} else {
@@ -1028,7 +1031,7 @@ static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
 static struct tty_ldisc_ops slc_ldisc = {
 	.owner		= THIS_MODULE,
 	.num		= N_SLCAN,
-	.name		= "slcan",
+	.name		= DRV_NAME,
 	.open		= slcan_open,
 	.close		= slcan_close,
 	.hangup		= slcan_hangup,
@@ -1044,8 +1047,8 @@ static int __init slcan_init(void)
 	if (maxdev < 4)
 		maxdev = 4; /* Sanity */
 
-	pr_info("slcan: serial line CAN interface driver\n");
-	pr_info("slcan: %d dynamic interface channels.\n", maxdev);
+	pr_info("serial line CAN interface driver\n");
+	pr_info("%d dynamic interface channels.\n", maxdev);
 
 	slcan_devs = kcalloc(maxdev, sizeof(struct net_device *), GFP_KERNEL);
 	if (!slcan_devs)
@@ -1054,7 +1057,7 @@ static int __init slcan_init(void)
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

