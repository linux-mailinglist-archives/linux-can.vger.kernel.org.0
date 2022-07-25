Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42A5801E9
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiGYPcL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiGYPcK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D960D2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f3-20020a17090ac28300b001f22d62bfbcso8533886pjt.0
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPxeUU0StP5c6ZgwSeiGwxhM6MlWFuGPWc1Fd7dUDPY=;
        b=Zl/tzBg8txAIRPRlFMPvLss3mnNF5nbReIjnKe6yKF6vAUpdvqEuh3dHsigqHuF+Wp
         BDQtshJ/Z1P5w63Otwt+RAokbYfZZHYRebmll9aHf10BDY2r4NTN0j8bh9WZsVO8XCav
         uPOqRO0UHSaXCPu0JsXVUQEcqGdP83x9V2fFhzbSh3HMCGGqrPX8jyCB8jDKae1MuWsY
         v+wm9ccPuKrQqtCvWXdLwmdUWWBdPIK5cbWJpmFy6wPVAuTw8KlHZVJQwc5OwNzEmFVK
         nkbpJKc5gDdUNRtKKmUAZD9shSKMWCbOd1n9TZyz7lHvOtU1sLusmYH1bh2/OMZBZR8/
         gNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lPxeUU0StP5c6ZgwSeiGwxhM6MlWFuGPWc1Fd7dUDPY=;
        b=0it7bnKZQcimXymGHlAl9WvPFRmiE5j9xgNou4YGhAm0lhqmdm3eDYYM/pWHrh3fHo
         yNkYi4gRUVEp5wKT5bJMYekXD39gIiofg4saJ00VfZYrHYxbpeo5siFqgP/1fDzjTJyK
         DnzFfAB0UJ/fwwOSgcZ9N+TsBhCuc3D2miIbxkdAir/Ci87m7MhzqVvjQYDmJ4OKTxTd
         ggnzHGDSCByaxkPE5+ZFLDacFjzg2x0toj7aRUl9nGq5mqA+rOmdfc1jR2XlEDBjdfhN
         G7nG4vWkt3xSfbUKQp1scH4LwRxT6u0vbDkzVNgkfdPnprOb5cx/dczHyN03rYTB6mLK
         zN2w==
X-Gm-Message-State: AJIora+tGGhjRaOYG8Fq4L9Gvjc5HgbnlYkbPGv1bEI1p6T3vuC2F/V1
        m/dSwHOj1c0TJZ8yv5BJO7xJA80IuliO6g==
X-Google-Smtp-Source: AGRyM1tMeHAlfRPflNbvpzI1zcC70Tp7ivhAQ6A15JIG+G3UfmA/iAwiOJ0KUu5INITMihuD3BDCNQ==
X-Received: by 2002:a17:90a:9bc4:b0:1f2:389a:7faa with SMTP id b4-20020a17090a9bc400b001f2389a7faamr15353418pjw.72.1658763129230;
        Mon, 25 Jul 2022 08:32:09 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:08 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 3/9] can: slcan: add DRV_NAME and define pr_fmt to replace hardcoded names
Date:   Tue, 26 Jul 2022 00:31:18 +0900
Message-Id: <20220725153124.467061-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
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

