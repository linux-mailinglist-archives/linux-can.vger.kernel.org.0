Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA99704FA7
	for <lists+linux-can@lfdr.de>; Tue, 16 May 2023 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjEPNnl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 May 2023 09:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjEPNnj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2023 09:43:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2CF527A
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 06:43:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f37b860173so3883651e87.2
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684244614; x=1686836614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf1T06d9zC40FGOrBAlaznx6paY6CVq6Y4pYw+XXmt0=;
        b=YwEpXizJi4rg/h43NHcMbqM2avd5dJ9Z3XzHaKt0p18zSPZXuoHhaLa13eCEUM+Kjt
         F0Lmt7gIdXypzo/7/wu+TWMpo7tcMwkst6ia9iPbU5pzI4/IAOcIiCJRhYJUoEZbP3Oo
         YPPLO2R2s4PJ0FpZ0EePie8OT7Eo1oMNVfxxfcDuvKca/FMzc8kZ8/35MiTTIZHksIEZ
         24UBOkXyFaThm+cwHjjWmKV4TUX/mUSWjK+irq0D2AxIKvci6AvnoRkfBmGRHA+q3moX
         ICn2pnMzdig073uPZhCxuFI9cOGqgghysHPLyiRYV30BEAt8lUluxaHz/1QfBspV+n/Q
         /3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244614; x=1686836614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf1T06d9zC40FGOrBAlaznx6paY6CVq6Y4pYw+XXmt0=;
        b=dxhR0J9sI3PZp4xAgGUUxCjEkWLZLkL4/3b73+hawjKkoERqq0jJ0IgDQW5Xz/sSUa
         NEaCmf6EnwVn+b/720bE/fJoJZ5idYUkt+fIc13/yT59eYcfNgfJjHK2ui8lVW7MvfbW
         P1cF40IzJd2ryTb6Q4zz7Q7AisG5+csywUVBvKk9FU+quL2WJaPmTp9va4zk/YUafE+O
         WIGa0+66JH1Ev4j5Nnsidv9KHBCjOGJZYCcH+Oz+vh/ARRg3k1fSaeOlBldtoUHo0xH4
         baM/a/JqJ8/6GBMuI0BUAxiVJVbwdpRdWu5TxULGMx7ZUqlysdh1wZIGRCjEkNkfFPn1
         9eiw==
X-Gm-Message-State: AC+VfDzK/J6ULU4t9SHdgY/F9xorsEJiDLzPrPlUCHTVIl1GKjDN4o3R
        +tCvuLyWx+5KxMgI1M0iEyrTBm4sNI/42tWRGBg=
X-Google-Smtp-Source: ACHHUZ6h+m2BPpL207HU1R0d4xvGWIHAh82NvJfDLiBYy6XakeLrhrV/It1rr7849QLz3xbZpNAKYw==
X-Received: by 2002:ac2:5583:0:b0:4ec:a12a:4967 with SMTP id v3-20020ac25583000000b004eca12a4967mr7066470lfg.54.1684244614620;
        Tue, 16 May 2023 06:43:34 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id l26-20020ac24a9a000000b004f13b59307asm2962558lfp.232.2023.05.16.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:43:33 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 5/6] can: kvaser_pciefd: Do not send EFLUSH command on TFD interrupt
Date:   Tue, 16 May 2023 15:43:17 +0200
Message-Id: <20230516134318.104279-6-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516134318.104279-1-extja@kvaser.com>
References: <20230516134318.104279-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Under certain circumstances we send two EFLUSH commands, resulting in two
EFLUSH ack packets, while only expecting a single EFLUSH ack.
This can cause the driver Tx flush completion to get out of sync.

To avoid this problem, don't enable the "Transmit buffer flush done" (TFD)
interrupt and remove the code handling it.
Now we only send EFLUSH command after receiving status packet with
"Init detected" (IDET) bit set.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 0e03c1cd47b3..4fafb7658349 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -531,7 +531,7 @@ static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 	      KVASER_PCIEFD_KCAN_IRQ_TOF | KVASER_PCIEFD_KCAN_IRQ_ABD |
 	      KVASER_PCIEFD_KCAN_IRQ_TAE | KVASER_PCIEFD_KCAN_IRQ_TAL |
 	      KVASER_PCIEFD_KCAN_IRQ_FDIC | KVASER_PCIEFD_KCAN_IRQ_BPP |
-	      KVASER_PCIEFD_KCAN_IRQ_TAR | KVASER_PCIEFD_KCAN_IRQ_TFD;
+	      KVASER_PCIEFD_KCAN_IRQ_TAR;
 
 	iowrite32(msk, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
@@ -579,7 +579,7 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
 
 	spin_lock_irqsave(&can->lock, irq);
 	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD | KVASER_PCIEFD_KCAN_IRQ_TFD,
+	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 	status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
@@ -622,7 +622,7 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 
-	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD | KVASER_PCIEFD_KCAN_IRQ_TFD,
+	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
@@ -1015,8 +1015,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		SET_NETDEV_DEV(netdev, &pcie->pci->dev);
 
 		iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD |
-			  KVASER_PCIEFD_KCAN_IRQ_TFD,
+		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 			  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 		pcie->can[i] = can;
@@ -1443,9 +1442,6 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 		cmd = KVASER_PCIEFD_KCAN_CMD_AT;
 		cmd |= ++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT;
 		iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
-
-		iowrite32(KVASER_PCIEFD_KCAN_IRQ_TFD,
-			  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 	} else if (p->header[0] & KVASER_PCIEFD_SPACK_IDET &&
 		   p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
 		   cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MSK) &&
@@ -1732,15 +1728,6 @@ static int kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 	if (irq & KVASER_PCIEFD_KCAN_IRQ_TOF)
 		netdev_err(can->can.dev, "Tx FIFO overflow\n");
 
-	if (irq & KVASER_PCIEFD_KCAN_IRQ_TFD) {
-		u8 count = ioread32(can->reg_base +
-				    KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
-
-		if (count == 0)
-			iowrite32(KVASER_PCIEFD_KCAN_CTRL_EFLUSH,
-				  can->reg_base + KVASER_PCIEFD_KCAN_CTRL_REG);
-	}
-
 	if (irq & KVASER_PCIEFD_KCAN_IRQ_BPP)
 		netdev_err(can->can.dev,
 			   "Fail to change bittiming, when not in reset mode\n");
-- 
2.40.0

