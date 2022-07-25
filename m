Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680C57FFF2
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiGYNdG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiGYNdB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E00E13F2A
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w7so10377242ply.12
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbX60wfiMYhFo+jtYSx5zI+7aEsZJIo99OSthaaFXwI=;
        b=el20M1A5dt2Inc6eMuWp09miabW9lYJDmykpdaS7faUnNg491pfvsS3fbLdJsfevZ5
         YcYvXj20xEZiKqsqX4CjmQejh6ILK5MmhYjcOmHpgNUU1siMqjub3HVEEjoteFSDsVjU
         qTN81iX145qJbiYOZQqGVQgyCx5LACPVtfe0LmE/7PSVd9g9msUZaSev6MmG+XsP5aFJ
         B9nsy458rVY57ELWsA9nwDurie/zh/qGAoOcwX/UUSMQHbEimg9haX/MZCMMye+nOHRZ
         nTjJddJXcf6N7pvk3VCVHTvuWFV/82aQXZaapDesTM7wwspx8MjgZIX9zasay5gDJ2Tp
         vdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KbX60wfiMYhFo+jtYSx5zI+7aEsZJIo99OSthaaFXwI=;
        b=webnFmteRX3cZB0VISumElJJzJx5K9/nzOofXtoB1HmfhjDIaFtrdx02VxKvNF8qcM
         LqspNizBjzr8rjUy4zMfwaT+0XsjvEhO4ztfLQkF4Kd02TtoUJUSJpj5em4vkczjsBqs
         +eFXPY87UN2tNhLtqWJoijUvDAUdk8SwNPkyUUmfTtQiXaTUXShX6khy2oM8i3X29GiX
         UEMtWZWvn+U7bx/NRcXmZcVxX4XatxXJ/SNNyba3Wz+OyDUxsynWu9XwL1B1e4eavSN2
         r3G3z8YDS01QdCv6Ay5lpy7cd4KCzeqK8l/CyqalIBQbXfCbKQzPZTKimzpubJjudzlL
         hpDg==
X-Gm-Message-State: AJIora/wiXjO/UFLFQ6JAnb3uSJRpigaUkSnj/I2HUo4J/MRP727nDSZ
        jIRh0dLhhf6JQ4/3xRNwgpzdQ2WuVCX4bA==
X-Google-Smtp-Source: AGRyM1vK4dfT4z+bbj7YoMIghXriQX/Mg5jeirrcI+0SS155Bej+KNx9ccykDlNE20cHKtC9qauA4w==
X-Received: by 2002:a17:902:e154:b0:16d:3e9e:3c39 with SMTP id d20-20020a170902e15400b0016d3e9e3c39mr12512381pla.58.1658755975573;
        Mon, 25 Jul 2022 06:32:55 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:55 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 12/24] can: janz-ican3: add software tx timestamp
Date:   Mon, 25 Jul 2022 22:31:56 +0900
Message-Id: <20220725133208.432176-13-mailhol.vincent@wanadoo.fr>
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

TX timestamps were added to the can_put_echo_skb() function of can_dev
modules in [1]. However, janz-ican3 does not rely on that function but
instead implements its own echo_skb logic. As such it does not offer
TX timestamping.

Add a call to skb_tx_timestamp() in the ican3_put_echo_skb() function
so that the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/janz-ican3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 2534364e8be3..923df896512f 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1278,6 +1278,8 @@ static void ican3_put_echo_skb(struct ican3_dev *mod, struct sk_buff *skb)
 	if (!skb)
 		return;
 
+	skb_tx_timestamp(skb);
+
 	/* save this skb for tx interrupt echo handling */
 	skb_queue_tail(&mod->echoq, skb);
 }
-- 
2.35.1

