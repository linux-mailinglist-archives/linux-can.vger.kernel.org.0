Return-Path: <linux-can+bounces-1213-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7842C95BC1C
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 18:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F071F26646
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79411C9ED0;
	Thu, 22 Aug 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="vvxelsIQ"
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8C71CCB50
	for <linux-can@vger.kernel.org>; Thu, 22 Aug 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344801; cv=none; b=Hg3ksahmdcT/00j33FBLhzuOHpvWOqHeYLWjygF15Eeub+Acb8uV1oHebDM5mXI+nGgjaQ/qqTyA6HimQpybJ1p9veLrh2smgnGyUsOR+wcoTpC8baUrG2bjRZzJ3bT1D6tHfUAu3qvpgz5/rvV3IW2BL4XWmjMkUlN7GnfJPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344801; c=relaxed/simple;
	bh=FP8sOkpSd0D+Rvv7eKeSdYm8TdaDuj43p745282Ea68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH7t+5209gttQSsGDM9D1o8maWJQmmuUaqcEGPzQ/niEOkIU9avbuF9tK+KtshB24z+L/MYwmc8NTsf/WSgnZkKpbArH7exo44/p0zUY0fxexCKTrWO5NObLey0SF3PseqZH0Yi0lwx2AwL4Rt8mB0evY3heuwELf0ay6+0uJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=vvxelsIQ; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id B8CD5E014A;
	Thu, 22 Aug 2024 18:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1724344771; bh=FP8sOkpSd0D+Rvv7eKeSdYm8TdaDuj43p745282Ea68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vvxelsIQgZqnC5AanieCVU6ST/n+PsN1qe0pkIKktJLeFB00oYYwnPLnspD5oNAko
	 b5Z75mk8IAj/XUp3zX9bp31/skNsjbDaKJ6C4y8KhrEGBvBJerfiDnHIvYBoGNEQfK
	 wqRmjHBZMkO0ga7bdXDRAu83arCDSvBni9Fjx76mUBrJ30gaLiGlcsx1JRUh5GmNR5
	 4eW7XT5XiD3mougt6qhokpUE1X93fzHoywhzWxFUGsx++HCwP5DG9rOwAMYS7HoFS4
	 DJbDhCRcnVMpGgiejoJG9Ge6wHbwN9Ehqk3oA3J6ZzMOeONpf6P+caaiR/1mFV0iHV
	 k6Y48Rzg2ZDmA==
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH] can: kvaser_pciefd: Use IS_ENABLED() instead of #ifdef
Date: Thu, 22 Aug 2024 18:38:59 +0200
Message-ID: <2084fc26b4759606fe78ab7da1a2d73c12f75a9c.1724331802.git.martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68d084a334418fce1944c8f9f5fd431d1bb34a09.1724331797.git.martin.jocic@kvaser.com>
References: <68d084a334418fce1944c8f9f5fd431d1bb34a09.1724331797.git.martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the IS_ENABLED() macro to check kernel config defines
instead of #ifdef.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 99fad592965a..4068af8243c5 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1053,13 +1053,13 @@ static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
 	void __iomem *serdes_base;
 	u32 word1, word2;

-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	word1 = addr | KVASER_PCIEFD_ALTERA_DMA_64BIT;
-	word2 = addr >> 32;
-#else
-	word1 = addr;
-	word2 = 0;
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)) {
+		word1 = addr | KVASER_PCIEFD_ALTERA_DMA_64BIT;
+		word2 = addr >> 32;
+	} else {
+		word1 = addr;
+		word2 = 0;
+	}
 	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x8 * index;
 	iowrite32(word1, serdes_base);
 	iowrite32(word2, serdes_base + 0x4);
@@ -1072,9 +1072,9 @@ static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
 	u32 lsb = addr & KVASER_PCIEFD_SF2_DMA_LSB_MASK;
 	u32 msb = 0x0;

-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	msb = addr >> 32;
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		msb = addr >> 32;
+
 	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x10 * index;
 	iowrite32(lsb, serdes_base);
 	iowrite32(msb, serdes_base + 0x4);
@@ -1087,9 +1087,9 @@ static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
 	u32 lsb = addr & KVASER_PCIEFD_XILINX_DMA_LSB_MASK;
 	u32 msb = 0x0;

-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	msb = addr >> 32;
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		msb = addr >> 32;
+
 	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x8 * index;
 	iowrite32(msb, serdes_base);
 	iowrite32(lsb, serdes_base + 0x4);
--
2.43.0


