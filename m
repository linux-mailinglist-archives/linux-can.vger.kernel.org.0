Return-Path: <linux-can+bounces-1199-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B20956D63
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2024 16:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FBC1C22D75
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2024 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812725760;
	Mon, 19 Aug 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="gDzi0067"
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116721EB3D
	for <linux-can@vger.kernel.org>; Mon, 19 Aug 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078035; cv=none; b=Tp18SblN4KAsNcb8KzqLoOQsF03N1Hov0ZauQD2P+GuuhSZVvtZsBfPUMhS4wodSoH1S8lBj9V1z7sM2pDS0gAats2NwrERz24Lslnc38MPOHx0AzDvHloAQgY32LIK5lfvvRv7cgmWTbdSb1R34z47X/ckntZYnZHLYnzi2lsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078035; c=relaxed/simple;
	bh=BGlSRlDdUY2crX7ygCTTwpt+k6KqFNeidkVPFJlu608=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9r76yUsCES2Cf65yY2BalFtAik0xbWecP8RBqPEdj4oyph0EvSQqBTWd4qPNT0JkFsZ4rXbve3aRtq5vwtZlB/cVCD5Qr+kUaJTWXsevY1rGc52zQIb6506Oh3iF7gdeSAzeuCry7R2MGoCM64QtyuZAw8bm96NAuw6hTkW1fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=gDzi0067; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id A83CDE0103;
	Mon, 19 Aug 2024 16:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1724077426; bh=BGlSRlDdUY2crX7ygCTTwpt+k6KqFNeidkVPFJlu608=;
	h=From:To:Cc:Subject:Date:From;
	b=gDzi0067fzrFPZEMEJrQnDeJE5uBP9z+WKGg5B2w+FtJ+LtP5iW+EeqrbYbOOhkC/
	 /AIwtb3SspdT5Lb9FLIDk/kRlgUQvkisYRzQSNl+rOkfGRKySqULfeLL/lyX0WrIjR
	 YzmcM+0/dWDWoj5wbSlhQq535R+EDJtycJPwlmkJji9sKClEGFFSJJZAH5Eat73ZKg
	 eQxylpTb98xjrbd8FJuDpiLwS7TXiVFD1r93P06qjDLKhvTHkUlrvt7O8pmdMK2ZQA
	 HjaApUaEfwbbicu42VJonzid3q1QzNo7CjbK+xgyVeuoVolRkzTOm2bEmDXpZrmcTA
	 rLPNNiGuXmF3A==
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH] can: kvaser_pciefd: Enable 64-bit DMA addressing
Date: Mon, 19 Aug 2024 16:22:55 +0200
Message-ID: <20240819142255.643149-1-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling 64-bit addressing for DMA buffers will prevent issues
on some memory constrained platforms like e.g. Raspberry Pi 5,
where the driver won't load because it cannot allocate enough
continuous memory in the default 32-bit memory address range.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a60d9efd5f8d..5885f1ce189d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1104,6 +1104,11 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)

 	/* Disable the DMA */
 	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));
+#endif
+
 	for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
 		pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
 							KVASER_PCIEFD_DMA_SIZE,
--
2.43.0


