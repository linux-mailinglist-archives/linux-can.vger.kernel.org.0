Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B410714A90
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjE2No5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjE2Noz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE0C9
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso3430793e87.3
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367893; x=1687959893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EDURFAaglACphGgXjm8quJBGDeyprKNcuWBd0EAFRw=;
        b=U2boYgf0nZ2oxx9ZCUKai/mCAZjxqJps8iI/TW71d0/jGYFuCkKsnfuahzMOV5YmNX
         0TrQ1OpC9DIa+TpVQ5IRBJunNXmSmSGhHPZnvaliWIcHoy9TS2iz2b54ARvnavBLc+lu
         Fb6YBDW7J10dNduoNiuvLGnAZbVC9gTL4kyEHzm21dYFrm7cJEJY513FRJ5p6PzdzrXL
         d6UcOuFF8km+Pd/pl0EJtKoxfB5Q/DKSi2oqmhLMXxY6qHUOKgqahgb58nI+3FDtFSJm
         A6Ry3MyqHdBMCrT4ZSG36RQx0cTK3ofP2Pf9ZOhCfih+8NfxMtCUL5D5Nnd2I3Jx+BH0
         QooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367893; x=1687959893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EDURFAaglACphGgXjm8quJBGDeyprKNcuWBd0EAFRw=;
        b=hlA5cchrth93dVgTP7Lh0c7z9GqYMqksj9j+RqqD5a5yMMwJHILm6COq/EF8cGHIAM
         hQppKE40+OAYg8paLzbc4rzNBRS2nd/Rsd377MkL8lz0rBIXjQOoWhFwiompWkw3uNVa
         Oo+5+60Ez/aHdQqcn+kB66owq+l+t6flgpsCDoZNpr7kFe33e0i+A8SgqG8g7yfFoWzf
         b3vUnCMzwq4H1j7d8/kyyhhgSwvuWwJKQAnyU8B9LUgx5bFC/KR5DeahfwjeRjXSYmQy
         EE668pSUIljUrf4CMAdSsrbcE69pyniXt0Fr9BFADyQ6qqLgvzJQaoHrjFj2meslk1ir
         uICg==
X-Gm-Message-State: AC+VfDyKA1s4LrF4z/pTZBq9BrFxMOAHTM1KwivMNUf1KBecdv1t4xwI
        6l/SMY4GeggeMLQSssHsaZq+BZvT6GOXnaCoeaY=
X-Google-Smtp-Source: ACHHUZ6JCo3bJCwWGbbadYz5GCzT7rcUtcZLuDV3jXQZz3Fw4JZBagdb5PrnUpuOfs+B4k/iBPwaZw==
X-Received: by 2002:ac2:52ac:0:b0:4ef:f4ef:a1cc with SMTP id r12-20020ac252ac000000b004eff4efa1ccmr3268657lfm.14.1685367893549;
        Mon, 29 May 2023 06:44:53 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:53 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 09/14] can: kvaser_pciefd: Change return type for kvaser_pciefd_{receive,transmit,set_tx}_irq()
Date:   Mon, 29 May 2023 15:42:43 +0200
Message-Id: <20230529134248.752036-10-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
References: <20230529134248.752036-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Change return type to void for kvaser_pciefd_transmit_irq(),
kvaser_pciefd_receive_irq() and kvaser_pciefd_set_tx_irq().
These functions always return zero.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index bf3fa51069a9..feef044c6b0a 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -338,7 +338,7 @@ static void kvaser_pciefd_disable_err_gen(struct kvaser_pciefd_can *can)
 	spin_unlock_irqrestore(&can->lock, irq);
 }
 
-static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
+static void kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 {
 	u32 msk;
 
@@ -349,8 +349,6 @@ static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 	      KVASER_PCIEFD_KCAN_IRQ_TAR;
 
 	iowrite32(msk, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-
-	return 0;
 }
 
 static inline void kvaser_pciefd_set_skb_timestamp(const struct kvaser_pciefd *pcie,
@@ -1456,7 +1454,7 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static int kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
 	u32 irq;
 
@@ -1482,10 +1480,9 @@ static int kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
 
 	iowrite32(irq, pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
-	return 0;
 }
 
-static int kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
+static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 {
 	u32 irq = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 
@@ -1503,7 +1500,6 @@ static int kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 		netdev_err(can->can.dev, "Rx FIFO overflow\n");
 
 	iowrite32(irq, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-	return 0;
 }
 
 static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
-- 
2.40.0

