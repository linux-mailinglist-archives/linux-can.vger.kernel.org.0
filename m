Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E35957FFD9
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiGYNce (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiGYNcd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE613D02
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so12709311pjj.5
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgKZK1ryW7n8FfY8HQ02RysHFRJf9yfLai6BH3I1/14=;
        b=lXpx1X1ezwRvIZaxdZLCLusUXPkhOJBWtkHVQ3KEkc4eARbUrFFaQ2M86TzO0plkeC
         6Pg6DXCE6gnaqi5VzoIgrHBD21KHl/eBQSU+1ALHJ4ATUw9BoXO1pStL1CGJRJIi9iVi
         X47K+lTTql2x4J/A1M5i/kRTCF/ILFS3/CEVDH4OFHfJt7FG4vhKESsIgi0Z3KLByKVv
         WT6oMtUrWN2qc3mjUOnF95zBIejI9sgwTgTO/lfyT6EBJb4HgDIVZKoOfSe1HSLWeN1U
         ITpcCEjm623CHqmfBWeIZZxsc0TcJQgLpC6ydhUIHPTrL2Jrj7fFK2lWZy8rFQVhpl/J
         DwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WgKZK1ryW7n8FfY8HQ02RysHFRJf9yfLai6BH3I1/14=;
        b=g8CAiR0yBaiFhCCrTc4Cxq8xx4pAYVPsWPVH1UUIcOzyQGfCFWwPR1lFHUu39QDQoy
         apmSufzuffHGUCQ7YctKK5eMWKWfRwSp9Q0swECG6ECnTTNVNmUxaK9S6gdF55/L/hZu
         1l+smO9FBJJBNTM6g+jnRfN8L+uPYfPPfObSlBkGiki6LEha89ugnJUte1KyDr1nY/st
         aQzvbmY8VVIR5981u4rdlCRZ61razqyxM+bVig151Q6RQaImocLrb5qizqm2PrlAQ0HA
         /jukw0pjuswGVb4a438d2l3bvAiUiQmAcHIp+NzNCwEYzzLVLmr+qKoxz1gshFM4USMg
         VWew==
X-Gm-Message-State: AJIora/LMYEMLgQph+D54M+I93PIJdNVb4O/1x1hIVzWcvT+/X8XUjkV
        urAu/dla92xXYHJ9NEwC1vVwkBxGQvqnjg==
X-Google-Smtp-Source: AGRyM1usxxGgf/vGOdCv98kggLAP1U91XdFm5k+7gHqmnzKQA14iw0PrR177e9hIYJtesimNHhR5SQ==
X-Received: by 2002:a17:902:f541:b0:16d:46f1:bd14 with SMTP id h1-20020a170902f54100b0016d46f1bd14mr12280551plf.77.1658755950493;
        Mon, 25 Jul 2022 06:32:30 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:30 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 01/24]  can: can327: use KBUILD_MODNAME instead of hard coded name
Date:   Mon, 25 Jul 2022 22:31:45 +0900
Message-Id: <20220725133208.432176-2-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "can327" to populate
tty_ldisc_ops::name. KBUILD_MODNAME also evaluates to "can327". Use
KBUILD_MODNAME and get rid on the hardcoded string names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/can327.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 5da7778d92dc..bf0cce2dbb40 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -10,7 +10,7 @@
  *                   Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>
  */
 
-#define pr_fmt(fmt) "can327: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -1100,7 +1100,7 @@ static int can327_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
 
 static struct tty_ldisc_ops can327_ldisc = {
 	.owner = THIS_MODULE,
-	.name = "can327",
+	.name = KBUILD_MODNAME,
 	.num = N_CAN327,
 	.receive_buf = can327_ldisc_rx,
 	.write_wakeup = can327_ldisc_tx_wakeup,
-- 
2.35.1

