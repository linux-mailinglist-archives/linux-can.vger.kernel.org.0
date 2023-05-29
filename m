Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E35714A89
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjE2Nov (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjE2Nos (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0D49C
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af318fa2b8so34275541fa.0
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367885; x=1687959885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzXtemhPb7DwIkZbQVoJHeTOf87wCgMXq/sCnmHUr9s=;
        b=BTpCi8AGyjYMDJJbzWfNvwflRrd4Sa8RndkZuT4UeU/E8IDmJMsnOPQPJP8L+61rfY
         8UyRgXLaPC4+LTwzsWCr6fTq5pstFVqe13AdocSjt11cL/IVEvTVt0fqFku9vq+Rd9Nn
         950PlCJZfJOiqKXrXrCxV99i8hHpO2Y85mDmxpmam6qSbdMU1OLnnIPPCPB9X2LE6q9a
         RU7CCSYPWG6I4ZfkwK1hJdE47HvvGEsnvBcvvTHBpehKezWxlDGZpHwhR6xuqW+vtHvS
         2Swa/oeiLAxdWO9JNWOboURcszZU0XrEcWnlEqV13ztlGg5SLTBDMZYDD7QFs/JHRHEc
         f/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367885; x=1687959885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzXtemhPb7DwIkZbQVoJHeTOf87wCgMXq/sCnmHUr9s=;
        b=FNTRtxxwhFxKFyKnBYA1qAD4dePYmkdmdOnJ2AgTC4hnHH21u5OFzhcOd9/lFbZ8jG
         zDtrEMEFYxjIsFXDgKBN/OwHj5KzEO8ul/wxm5eEz9laSDSvSLSP2/9SERw7Eolf5RO7
         crz+A+FKG8Ebw13W9yLi9RZ11oafL5yOaUxTe72N3UXdBEfl4l3JgDa9xucA556ibyN7
         adgSieqfpBLbhBwMUDz0lpHREQM27F/mORKbpTHfOH/hzuUP2Kx8FlfX8jONFm0Of7Kk
         +L5TtM0wPCO7Zr310VyFDrHUZv+uGR4X4SRRQyxeqOguHKvpMaNFeaSBQedOYDMtlIDm
         BfxQ==
X-Gm-Message-State: AC+VfDw0x5RyN7McK5+mmHee910Yi/ehtr1oE204qVoryADhRtTfgSBV
        KJ1Niww958xllnMs53KzdAPPXqYPvgibr83aaeE=
X-Google-Smtp-Source: ACHHUZ7emjhvD1Y5N7xR45KzFSDdZage7A8AK6cNe29uOfCIR86liRPVWMCHDkmx1Gej3A3a6Z2PAQ==
X-Received: by 2002:a2e:808c:0:b0:2ad:92b9:83b4 with SMTP id i12-20020a2e808c000000b002ad92b983b4mr4535209ljg.5.1685367885292;
        Mon, 29 May 2023 06:44:45 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:44 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 01/14] can: kvaser_pciefd: Remove useless write to interrupt register
Date:   Mon, 29 May 2023 15:42:35 +0200
Message-Id: <20230529134248.752036-2-extja@kvaser.com>
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

The PCI interrupt register, KVASER_PCIEFD_IRQ_REG, is level triggered.
Writing to the register doesn't affect it.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index be189edb256c..d60d17199a1b 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1768,7 +1768,6 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-	iowrite32(board_irq, pcie->reg_base + KVASER_PCIEFD_IRQ_REG);
 	return IRQ_HANDLED;
 }
 
@@ -1842,9 +1841,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		  KVASER_PCIEFD_SRB_IRQ_DUF0 | KVASER_PCIEFD_SRB_IRQ_DUF1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_IEN_REG);
 
-	/* Reset IRQ handling, expected to be off before */
-	iowrite32(KVASER_PCIEFD_IRQ_ALL_MSK,
-		  pcie->reg_base + KVASER_PCIEFD_IRQ_REG);
+	/* Enable PCI interrupts */
 	iowrite32(KVASER_PCIEFD_IRQ_ALL_MSK,
 		  pcie->reg_base + KVASER_PCIEFD_IEN_REG);
 
@@ -1906,10 +1903,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 
 	kvaser_pciefd_remove_all_ctrls(pcie);
 
-	/* Turn off IRQ generation */
+	/* Disable interrupts */
 	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(KVASER_PCIEFD_IRQ_ALL_MSK,
-		  pcie->reg_base + KVASER_PCIEFD_IRQ_REG);
 	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_IEN_REG);
 
 	free_irq(pcie->pci->irq, pcie);
-- 
2.40.0

