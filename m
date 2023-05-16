Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B7704FA5
	for <lists+linux-can@lfdr.de>; Tue, 16 May 2023 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjEPNnk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 May 2023 09:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjEPNnj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2023 09:43:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489D5BAA
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 06:43:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f383d6f2f8so2600145e87.2
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684244615; x=1686836615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUrnaPZiHRCWiU1zEMklXRMCT4bH7aOLlPIEURJmk4A=;
        b=czIC0G1q1pZ0jWQdlxL8Sr3dc1s4BqikIcdNHEFFJikL5bSDM9JZiQTjd2YVmejjHZ
         oBQ16gw7tOsW7FsiTZsrMfLtiYCGytNEjb0gmSoDaiuafg91cBZBkR4gWd7vSvFgVfFZ
         N8pz/tVyKJmRrrXnLM9xGk1krVjlmuKToiTQkgchgS1OZLIfNGFCeW7zAowP4+JKyrOz
         rgb4qcqHLDEaR5rLyFT51xT8n3JgnpF6yiuBgNhOvda3l9JfFZJH8Xiod4mtQJJIVfGS
         uJ8vR78MsjDmwyDFU+9wt8J71uRkafAXGSzCUlf3xRRGbivtcT/VkGWFTpbyJIBLxyAk
         3p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244615; x=1686836615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUrnaPZiHRCWiU1zEMklXRMCT4bH7aOLlPIEURJmk4A=;
        b=hYaHrphWPziiVnUD42syDRWNeZcb+7JRaZQInCfQT7+qqj8om5DiDalk4Sj1dkBVlx
         8n59AkjGag918aNxQqIDlV17JrsuIIYvTFMqJeaR+O7o6h9pDXFzOoh+omZxivWmXxDt
         U/oVcx0Kk4sxNFFDfgJNl+ndDryG0F2vGsTECAdZZId9oKFA3LhFHmBHhS4sUQ+gOao7
         mbOKWQC/RewVzpBCU6/ph7GPeMOSdizoPTLewYSXBjL3fFJa5HPZzPXuFKnDZYvst5C9
         ushrYuoeiBfEj//h9WOzL/yfi+4JW5QvkxfxQ4EBpaZJBIbwI7ypk2Z17tfKDRIZOmua
         bvrQ==
X-Gm-Message-State: AC+VfDw3S+x4HHsYl2uH8yqiBogu0V3UG7aFKfQ0ZmmqtHnD3UFxZD1J
        hkzAAlxwZrCp1dG9TI0+Bz/YiQv0N1pHEiv896E=
X-Google-Smtp-Source: ACHHUZ5QnlcGhf5WkKXPlZxHyDpU6RcBXrp4a+TEOyD1cCrtucgo4Ubj4vVLAZrZFW+gThvEwAPkwQ==
X-Received: by 2002:ac2:5683:0:b0:4f1:3797:58d7 with SMTP id 3-20020ac25683000000b004f1379758d7mr7424765lfr.20.1684244615557;
        Tue, 16 May 2023 06:43:35 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id l26-20020ac24a9a000000b004f13b59307asm2962558lfp.232.2023.05.16.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:43:35 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 6/6] can: kvaser_pciefd: Disable interrupts in probe error path
Date:   Tue, 16 May 2023 15:43:18 +0200
Message-Id: <20230516134318.104279-7-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516134318.104279-1-extja@kvaser.com>
References: <20230516134318.104279-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Disable interrupts in error path of probe function.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4fafb7658349..be189edb256c 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1861,6 +1861,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* Disable PCI interrupts */
+	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_IEN_REG);
 	free_irq(pcie->pci->irq, pcie);
 
 err_teardown_can_ctrls:
-- 
2.40.0

