Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9355823F8
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiG0KRL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiG0KRK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1698542AE3
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g12so15727527pfb.3
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUfBhfopMVBb3MFwSEXJ1qSIyFCctmXAqcvt99jbLEk=;
        b=ezOLn2l9VgVNOAIzWhcJ6KPX5LSuHu87tWAlSN+fSXF/MFybsjSh4+PVwKr2REgrc9
         Yra50CdCgQ76vVv4J18X/kqK+3M/8PgIHGFuGiVPhff1YKOf9w09KBglwqC+zGUOrZHB
         lcxUvxrrVn3BuGoY4p6I6IHzE/BNqaz4YRY5dB57wMfQXRI/FqbsCHVqpBuX1/sb63o3
         Ogr7k90oRx9eZp+OiG8QxaXHCRdyBY62xkAXI0xc2UqY3PmFSGs0w4vJNRZuQLSDMTo7
         JwLbed36gaG7xFe1f/tsqRS0cXOHROMD1q3ccMIZqGztczUXxPE6z89C/KNTDrAM6UyQ
         D0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mUfBhfopMVBb3MFwSEXJ1qSIyFCctmXAqcvt99jbLEk=;
        b=hh1w3CCrRIjHdNR9eUQm7fcDEyAyQt2u/aDApJ2tTPyd6H+KJUdLqWNCWjr2xz7tIq
         hLcgolHT+Kz5vxQQGY5RKw8rw2z5hy9WkYP72pUplgr29coQjEPCmd5Fl1dhdevfAkHD
         MmENuVlJ+rpEVlrlfgB3CWhA7gOSEFVbRXVw7uFfJzNAg0eSN1ZR4lLS0EWdZXEUUxWf
         Bz8LMnQkogRx84fViYI3VpZoAqtsIXZ4ExgnMCarQzEj5e3y8DYq5sUy6kY3kyqsyYMZ
         siVCNKYLYXTGexovNHbyxs4VOeWngYFJI7jsJFfLs2gDQ4jfUw0yuk7KFNEQZN3INXUJ
         KXNg==
X-Gm-Message-State: AJIora8IihnpSph+Ee4uu0Ji9+f+H6SYxJtogIwAot0XqXO8LUBjdI4+
        Uoruw+N4jfOKmMah1tVve1OjAcj6W7Zv1A==
X-Google-Smtp-Source: AGRyM1sipYwU5eoqvMBUmDjD7xFm41DpFtsVQEn3Hf3p4PWkhbHFRFffaOye6Y6A4MfaK3BjQnaNEg==
X-Received: by 2002:aa7:8ec2:0:b0:52a:d4f5:20b with SMTP id b2-20020aa78ec2000000b0052ad4f5020bmr20898521pfr.71.1658917028416;
        Wed, 27 Jul 2022 03:17:08 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:07 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 03/14] can: slcan: add software tx timestamps
Date:   Wed, 27 Jul 2022 19:16:30 +0900
Message-Id: <20220727101641.198847-4-mailhol.vincent@wanadoo.fr>
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
modules in [1]. However, slcan does not rely on that function and as
such does not offer TX timestamping.

Add a call to skb_tx_timestamp() in the slc_xmit() function so that
the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/slcan/slcan-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index dc28e715bbe1..d4dbeb849432 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -626,6 +626,8 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 	slc_encaps(sl, (struct can_frame *)skb->data); /* encaps & send */
 	spin_unlock(&sl->lock);
 
+	skb_tx_timestamp(skb);
+
 out:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
-- 
2.35.1

