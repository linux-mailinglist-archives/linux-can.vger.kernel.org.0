Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B257FFF1
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiGYNdG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiGYNdB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269613F97
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h132so10370869pgc.10
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIurGZ9gWzVivCD7XoqtaSNsErrr0Rl2wmAvoT60Reo=;
        b=EO5/ZWq+j2EEiOl3Tu375c7hKef9PSMaGXOuT5pSIjKNBN15E3+tw0Ddi4Lr1AaQGo
         6fF0aCIP6/ZynnWV5eIqnjJn8qeBN5OqAE/ssZPJZy0RqMV3U9RYA2O3NrzuADvnWHBG
         V0OlISZmsOQShd2M8gekyQLEnLq1S/cn93TQIW8yBpdUwcIuTE5f49ugflQLuHJWMSPw
         7Y7tQmyzDeYjarDsGcRcCgvv5YtSWDjwnjvuT6H/dg/rq4FtjglSFmt9adCsSlHnasJo
         3luy3AweubUTOeBzgFL6EgBxvfhuMFMBv2wIk4h3P50Oo82TVay+JcB5nFEJLfNaemmj
         h4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bIurGZ9gWzVivCD7XoqtaSNsErrr0Rl2wmAvoT60Reo=;
        b=Ac1GD6Ti+vVvuBOIQeRnYlfmfLYwViDamh2qkyC+h9S/jsckb/xpbvDYx0pRk4UGEr
         Vpbl7szB6ELDPxRRnfX2yc5p716cCMMQ72duS4pyPxN7vR3ZaghKKlCfT4urcPn6taYx
         7xQUahkheJle0ehglXkUS4tz6OvHWLiLrj9PPMjArUS4MG8LBN+EqYDfFD8oL2krLPYF
         k8lVCcOT//8RwcTlK7O4zrPd4gKuVcX0TvcWeGDws8mGb4TSQZHjDKSCdPTmeSpRIw9s
         p5ad7Gzbe/70O9bFcZY8/p7AimJM8DQnje1yTddZorCrtdvmsXq4cAzAfC5JEUM62lV+
         e+Mg==
X-Gm-Message-State: AJIora8vXwCrNdhZNXwKrI0mMIiIbR/bW+Sza8pJUXx/0JgnqRBZpk6Z
        s2r9UIYHOOO9aZPd974AHl+W9pQk5nUMRQ==
X-Google-Smtp-Source: AGRyM1vjFKJsNMHANSpaNePdIueLOvbf0maZ8NBSKLTVtUoSi/r2wxckcXmOic0Y+aYUTZems39t6A==
X-Received: by 2002:a63:4c:0:b0:41a:dbc0:18a4 with SMTP id 73-20020a63004c000000b0041adbc018a4mr7815800pga.305.1658755973444;
        Mon, 25 Jul 2022 06:32:53 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:52 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 11/24] can: can327: add software tx timestamps
Date:   Mon, 25 Jul 2022 22:31:55 +0900
Message-Id: <20220725133208.432176-12-mailhol.vincent@wanadoo.fr>
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
index 03c9e8c6990d..497a298c3de7 100644
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

