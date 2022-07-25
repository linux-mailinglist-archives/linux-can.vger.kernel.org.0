Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBA580241
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiGYPyR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiGYPyQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D4AE003
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d7so10770861plr.9
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oBR2q0qE1t01X0e8u8RxP/CYSHsiBL5TzPp+O6mig+4=;
        b=luKfWXjQwLauxpMue38eQUn+4zGNVnTnSrtvgEWhZnbUpejiYiiJuCyDRHZuWXptHR
         /IoDTXJrLKDa4kxmoZHSu1zrCPIk7xJlP4Bp858Z2f/Vk/6zdzmHFyrEbM6eW/lEH3x/
         urawoqCzkqcBEH9wX+zgMo3Cdt80c4ZTpksr8jq3nWERstGdjW68H5pUERAp42ZaxSwY
         /2jitIGeh7e4Maz/CT2qn36oWtgSHEFbIld3LpH+v51a3iHReMpdv7AflSzb7oiFUkMg
         1eiYl19Pcapas+/h8ym+Nw1Vot6ymSFHE5vDTQmTB3am+//BvUgUVrBhdePvwcfH7+nW
         uJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oBR2q0qE1t01X0e8u8RxP/CYSHsiBL5TzPp+O6mig+4=;
        b=4yUN+4lOD+BeqGiFX90CiX5A66qKnSIenweI/TCt54W+Lp7CfDCSYaszuwLvcYqA73
         9jihOrBrHsGHlxZmrSqa0UtFhDgzY+JU8SaJBYgKIgpObzrffpzPk1jOTMPGIQwGkIa/
         zYXi+wH7Nd9IAdhgBNt5CuzsNYX5ewfikYJNz8zBNoo6QFWVjbOg5088saivQUDl8T+G
         CS8UTcG4781h6m7wpplJijZkHAh2O5TCeUt9QGuwyhKc8qJLY6iy1qAredoqA5zzaL3T
         luje5E+pxxl8NxQUgG6OL7ry0g3+mSJrmsaAAJYprcQ/F1ZoswtCJs+3xqgfIWPZGi2N
         i4MQ==
X-Gm-Message-State: AJIora84uPpscsEp2MNNqO43REeDOqd9MGf6GuUGFyQ2qKiDfct+ofTa
        fXFSr61a08RvHPo0OudpCyZrPaTyyHUOUg==
X-Google-Smtp-Source: AGRyM1vJaNp90uiXPmfkdDesI/vZMQmcRk8Q+8xrwkbNQp/mdJfaR3XlLVfZKusCFjYc4g97C0BI7A==
X-Received: by 2002:a17:902:b102:b0:16d:910a:ce03 with SMTP id q2-20020a170902b10200b0016d910ace03mr1170194plr.124.1658764452790;
        Mon, 25 Jul 2022 08:54:12 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:12 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 02/14] can: janz-ican3: add software tx timestamp
Date:   Tue, 26 Jul 2022 00:53:42 +0900
Message-Id: <20220725155354.482986-3-mailhol.vincent@wanadoo.fr>
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
index ccb5c5405224..78d9190a4220 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1277,6 +1277,8 @@ static void ican3_put_echo_skb(struct ican3_dev *mod, struct sk_buff *skb)
 	if (!skb)
 		return;
 
+	skb_tx_timestamp(skb);
+
 	/* save this skb for tx interrupt echo handling */
 	skb_queue_tail(&mod->echoq, skb);
 }
-- 
2.35.1

