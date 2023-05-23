Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430970D95A
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjEWJpI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjEWJpH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:07 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E91126
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:05 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f37b860173so7851256e87.2
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835044; x=1687427044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzXtemhPb7DwIkZbQVoJHeTOf87wCgMXq/sCnmHUr9s=;
        b=wV3MpVtdp/LSdG34CI7YrNVFYpmOdUCJqz8tqiA6Obq5FfRnSpkr39MywwG/Q94q4n
         BfwQMwk3P5yGjimJqsQRENNY5MzI3/9tx4YyMuIt/u8YoPKGWI67R4iKy7W8eMgcNUmj
         jLsFEpxb8m/hqDbiabfpQ3RXq2Ajwuh82SfXbIPcrjDwkkiY6p+cQUyDnaG1e7INhr4T
         0ph/KX0k8j9aGLq6o5RKQWyMqWp4Miiw9A6Z1925h5yiRhwE+y0Uq1jO1KasNorVqAcx
         TzSspw5VxHiEOCs7KQNWEmDmpG5a1WMbBN+bgnOLXyZgsiwB4J0jnfmd5R+yAJVbT/tu
         jAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835044; x=1687427044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzXtemhPb7DwIkZbQVoJHeTOf87wCgMXq/sCnmHUr9s=;
        b=Fh70BN0sNNwnyoMPqZH68FjyUWVDplSEIirJRgThRzwet8SETgZUxlqylnJ+9JdBqJ
         WwT/NSyrDG4vWLd5CDFALLmGmYd7YBuQQ10/TJQGIXjgSwnfLwq167yMgNYhvmn/zJoR
         SsGltSQxI57s39zxJQ6PfsbHrTh5UFcmMC8lxVAxmMYhf+fcSxi2Jz0fnUVSgZTJx/S/
         ByYPfDGIwng+wtG3iYEXw5jqslvls/fNRTwvP7GRgIGQ/DoqpmSpkZgPVxN/4S8/U8k8
         rsXCHyK34Cw0ETW+hda3pbQ0A5ReQxwQm4DEqb/Ka7lp54SLrVBg1xe4x2GGHdEYHYvh
         MPTQ==
X-Gm-Message-State: AC+VfDzz7QO+HEC/ALRpixt6+YFNIZD99hZzPOiP0dLaoXIiSMHGhicv
        8afrwdTv88dQgHGsNTGSWw73BMz1mNF+yWpYjYM=
X-Google-Smtp-Source: ACHHUZ5sTC4TgDSUxtTO6iSRQTtzpFI4z4Zk6xfl/ffWQSW9VxU42UDFxlUlohjCg8SWRtZ7HvN7zA==
X-Received: by 2002:a2e:9690:0:b0:2af:1fd4:9011 with SMTP id q16-20020a2e9690000000b002af1fd49011mr4820808lji.34.1684835044040;
        Tue, 23 May 2023 02:44:04 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:03 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 01/12] can: kvaser_pciefd: Remove useless write to interrupt register
Date:   Tue, 23 May 2023 11:43:39 +0200
Message-Id: <20230523094354.83792-2-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

