Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3194E571F41
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiGLPc1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiGLPc0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEDA9FE06
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d10so7762996pfd.9
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfloflcr6GeunKX6dITsf1MVbmVF9Kn5MVpeW2/yFrE=;
        b=bKDjeUQDsxx4m+Ss4cf7BEz5JtnibYHe5n4ZmPO5r5/gGXW/qEYtFX3uNc/SNEB6sW
         7QgkmBc9Zg1hU9qOg1tXRRn/7SRYSvDTdEYxvfiXJjhJNsCY1pvjAd81+6NenW2V61Tl
         9yPSc0mv7mK2K/1T13erQyZ7S98yxZXk0h8XaSnX5vMvEnZHykVhxW1dv7E3U90MxITJ
         A7jBxh7wcgvSyZFROMXWmuf53qfy+rUWoqs6TjrEB1M10Z9yphWxF/i59i8bs00ooHkM
         SGNsP64XRu2kjUC51bz/fwtmstHQo0zc+YWaajSX73uOElqXAfGVuht2SSxFniVXPJ84
         /w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bfloflcr6GeunKX6dITsf1MVbmVF9Kn5MVpeW2/yFrE=;
        b=B3fdBKh5w/9YYRYHFJaZjKiZN6IcSUOK4S4CykNaOATmEvzrRbf+mRWMaO9fVZ2fIi
         aStoY8osagxKtTxogdpi51AMttXSgibE99N+2TtBFXpChcCnatTwi1KKll6XwYMUoIR8
         vv/OUu+wg57FXsmnNuQMkgm0x/dL1FyXsmKqTiS9MTC48PJ1vnJ/jASUMBF9l+Zo2oJg
         Lx7fQt6Xt0PlMGO7Iclh7RKynkBq82c9/qstosSCDkz1N1r7ezR3XAV+VrK8hhsF84qI
         AWWjXGWHRneJc1av0LbdUW5XJYTNznpVe5d2fKUco3S1ExCgOmf8OU4PrndxQ9znuFha
         iYHw==
X-Gm-Message-State: AJIora/qqAJaX9SbYzLjie7i3I4KKwsb/0FNBLAeocuFwr3jlySnVifn
        OlVc2B+AsjE7L/qvJ5Prp7Ah4zUwcFTdyw==
X-Google-Smtp-Source: AGRyM1ugml0rbbszweG2IPObmXCSQd2BTv2z63PqylFvOCsmbUmCiRYb8sv3vwOHyJn7PMZGz1NT0A==
X-Received: by 2002:a63:ff4c:0:b0:412:b100:786b with SMTP id s12-20020a63ff4c000000b00412b100786bmr21359041pgk.537.1657639944834;
        Tue, 12 Jul 2022 08:32:24 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:24 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 01/12] can: pch_can: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:46 +0900
Message-Id: <20220712153157.83847-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

During bus off, the error count is greater than 255 and can not fit in
a u8.

Fixes: 0c78ab76a05c ("pch_can: Add setting TEC/REC statistics processing")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/pch_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index fde3ac516d26..497ef77340ea 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -496,6 +496,9 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		cf->can_id |= CAN_ERR_BUSOFF;
 		priv->can.can_stats.bus_off++;
 		can_bus_off(ndev);
+	} else {
+		cf->data[6] = errc & PCH_TEC;
+		cf->data[7] = (errc & PCH_REC) >> 8;
 	}
 
 	errc = ioread32(&priv->regs->errc);
@@ -556,9 +559,6 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		break;
 	}
 
-	cf->data[6] = errc & PCH_TEC;
-	cf->data[7] = (errc & PCH_REC) >> 8;
-
 	priv->can.state = state;
 	netif_receive_skb(skb);
 }
-- 
2.35.1

