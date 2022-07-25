Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEDA57FFF3
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiGYNdI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiGYNdE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168214093
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so14379750pjq.4
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWTAg/nzp72M5u56GaA4jk4lzA1MIQMUotpG5C3qNQ4=;
        b=CAGw5pUY3Xfxaidewwtjf3VdxXVjN67z9YgdfO4zoTg4fGCSKxrN6qRN4+O+cIG+8o
         UA6WXCZkVUKeTXwTsUPbxttTOFo2bVCPWdB/2kUIswAqPi5HZqoz3iNibfh2lyaUNX6U
         uRkNji1+5JLFvlr0EiimP1ks0SRaWvCofqCd71olGuhrtlnuh6u6dex9JXkDCom829mb
         MSLc3z/7geDd9r54zIM77I8sqyZV+G0/4mnlJETSALfs42kSeCIG84/M/yjj1aGBLa+y
         36QWXShtajr/GEPGdfL2Dw/fmnBeeHFXy1iDpj0iZol8wsb35sXi3FWy+xy52JgNr3Ll
         Cwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yWTAg/nzp72M5u56GaA4jk4lzA1MIQMUotpG5C3qNQ4=;
        b=4IsN44sjZZULxlea7lyAxFm8bI1N10YCXtVkKPblRurW9XpnPMSw8fS6Z9JFqX/EIU
         PM6dlLxF6sx8OJKLcs63Pw9gLyGPvOtxf8/7mTfMhLhQtpUFXObdAC56tPS/rzCam8f5
         IhEsPDrq0hQLxvZRqlUD45qzv7MdNuZvdyoAdwZMZI7waT6MPP3mLrd8AZQ0OHbQG+4K
         DH9uKFlixgmzzLRJisvJ80yZYWMfmr+d7nyZixOvQV/1rf7oX91nu++4es6OVdo80oXe
         4aLn6fgWDUzqbAh8HPK9fTHT70xuk4cDX+gaH34XwMAehu2Mfka4fc1QJN3mJXHpNSrz
         FB2w==
X-Gm-Message-State: AJIora+Y+VmxFh5//FUCYAQ1ufJyv/oqPcUvZ63MLXlUXS5M1N+vrv7a
        +W0m12ERlI0ZbZiWJIsfPWaz3DUzFq77vg==
X-Google-Smtp-Source: AGRyM1uoQtwjZWASwd/py1icgZeWwDpDLAiypDb7a3heXSNG3oyNk8S2tkZr5K3dPWWMLAZu8EM7YA==
X-Received: by 2002:a17:902:e889:b0:16d:7280:4651 with SMTP id w9-20020a170902e88900b0016d72804651mr5126338plg.64.1658755977702;
        Mon, 25 Jul 2022 06:32:57 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:57 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 13/24] can: slcan: add software tx timestamps
Date:   Mon, 25 Jul 2022 22:31:57 +0900
Message-Id: <20220725133208.432176-14-mailhol.vincent@wanadoo.fr>
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
index 1b86001c85f8..65f466582fa2 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -630,6 +630,8 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 	slc_encaps(sl, (struct can_frame *)skb->data); /* encaps & send */
 	spin_unlock(&sl->lock);
 
+	skb_tx_timestamp(skb);
+
 out:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
-- 
2.35.1

