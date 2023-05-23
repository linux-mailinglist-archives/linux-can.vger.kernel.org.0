Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4692F70D962
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjEWJp1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjEWJpV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:21 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC251A4
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:12 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2af2451b3f1so54491491fa.2
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835050; x=1687427050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EDURFAaglACphGgXjm8quJBGDeyprKNcuWBd0EAFRw=;
        b=lTUTo+Y9XMb7mHdWB023T8+naqSRikzCBI8RJRdiyYqKi4/JL7MBB/FQdq6X6bITjX
         YhSL/AAN7zxKV10S79kPqngAGHyr37g09F1YP9ut+qT3W7Mdh1DoVhuOQKrIwFvYHghd
         vY8dUiXT+HUWXrqASg1V4+BzcMQK5Hruc9p3tSaBqdRP+Z8ztEZCDCwuVt0tRB4uxHgv
         ucZd6nAfcjSewLm32IrW1i3RNZBjiXwKaw4BTkXEsPEYcFrYmiZlkM/564ccvTGLbnhb
         LdlZCQ0hsuhnpVsxIusODed/527bs/I+0zIz+zHISm4jstZTpu+Zpl2ShB4uT5FUwKCU
         X5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835050; x=1687427050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EDURFAaglACphGgXjm8quJBGDeyprKNcuWBd0EAFRw=;
        b=CpgsrTwGkV1SVpGVtu6ucPXVxj2HemFq5D8wzW1JqC1dGAZDQ3fhOUAhXcLnLomuU2
         HCWsOL7CzO9TPdzh53/x5D9/oCHW/6UC3Y1dUjEeW/x1lZYEsWhzqrrQ355drXEGWriz
         MlfiuyKwYOSkxXIqe5spPiaF/tD4kFrJlClsmVfztYuMHe8QLMBdHLmOZPxzKV7jng0c
         40+KiwGVYAEpJZRyBFJeNeCdsqyJIm7bdAF/xbJ9i7xKoQeZGVdUKkOTJLX3gxanKp55
         ApxtXZ9Pzqt8j1R7Ojr44IP/tnaRzsEkUuEPpcrIBBxV+1Rlw9YwQSOJGnOOrftJFAm9
         nahQ==
X-Gm-Message-State: AC+VfDzZrqyiU4mEuLz/gaL/DpIPzbVehZzuowgx9D4pKQ/Z5mKt8S0f
        QkIuC4TNGnZftl2MrHUznlcU1PBG5clLcSq0BzE=
X-Google-Smtp-Source: ACHHUZ5M3/5T4ppXi3Gq+VW7WRm2szVgbGgdKPV9catg+txRbD9hjZQLbmJBPG5AP4m5h1PJuCfGzw==
X-Received: by 2002:a2e:3213:0:b0:2af:1eee:84af with SMTP id y19-20020a2e3213000000b002af1eee84afmr5159281ljy.26.1684835050565;
        Tue, 23 May 2023 02:44:10 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:10 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 09/12] can: kvaser_pciefd: Change return type for kvaser_pciefd_{receive,transmit,set_tx}_irq()
Date:   Tue, 23 May 2023 11:43:47 +0200
Message-Id: <20230523094354.83792-10-extja@kvaser.com>
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

