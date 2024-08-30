Return-Path: <linux-can+bounces-1243-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F99663CD
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB9228145D
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E06A1B013F;
	Fri, 30 Aug 2024 14:10:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873221AF4F8
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027047; cv=none; b=cVZZUbJAhAII4c/Rryuw/r2ZV+z9xrw2a/WQhlCTgKttdh8Usz6q8tWzl5FgRuqUiYHav+1Mf4e0hxYSfFB1mE+DB2b+e+YovkMIm407oNIV7RFPeZLU9Vx1AvG5ms+M5YYkw8ovVAx9yzRSgmp86qWF+IyZ47SE9UKhGg7rfWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027047; c=relaxed/simple;
	bh=1foSGIKij+FVxBZcwoGgKNTycYrXa6uS6sgbEYt8mJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qk1mYObMpA/MqBnzxorf91iAO8HRrbspJRy/DonQ69ZOelQPRdSakJgKB1y95yZi3Y+kpaYsI2YPYGgkq5EnwOoo74aQ1chBGb1p1ZHx7V3IBu6v4H4VFFGIWkbi4T58zpP58ISBZGjEjYN8g46Xhlk4c+zBsY8RF4/Ic9yb5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk2Kn-0001rb-B9
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 16:10:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk2Km-004AJs-T7
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 16:10:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 94F4432DEF2
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 14:10:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AFD4832DEEE;
	Fri, 30 Aug 2024 14:10:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8e18e4e6;
	Fri, 30 Aug 2024 14:10:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: kvaser_pciefd: Use IS_ENABLED() instead of #ifdef
Date: Fri, 30 Aug 2024 16:08:59 +0200
Message-ID: <20240830141038.1402217-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Martin Jocic <martin.jocic@kvaser.com>

Use the IS_ENABLED() macro to check kernel config defines instead of
ifdef. Use upper_32_bits() to avoid warnings about "right shift count
>= width of type" on systems with CONFIG_ARCH_DMA_ADDR_T_64BIT not
set. In kvaser_pciefd_write_dma_map_altera() use lower_32_bits() for
symmetry.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hi,

picking up Martin's patch and fixing warnings about right shift count
>= width of type" on systems with CONFIG_ARCH_DMA_ADDR_T_64BIT not set.

regards,
Marc

drivers/net/can/kvaser_pciefd.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a60d9efd5f8d..dc7e5ea1e3ac 100644
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
+		word1 = lower_32_bits(addr) | KVASER_PCIEFD_ALTERA_DMA_64BIT;
+		word2 = upper_32_bits(addr);
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
+		msb = upper_32_bits(addr);
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
+		msb = upper_32_bits(addr);
+
 	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x8 * index;
 	iowrite32(msb, serdes_base);
 	iowrite32(lsb, serdes_base + 0x4);
-- 
2.45.2



