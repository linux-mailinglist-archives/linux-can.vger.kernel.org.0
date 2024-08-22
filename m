Return-Path: <linux-can+bounces-1212-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178BF95BC1B
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BA7282060
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147DE1CDA17;
	Thu, 22 Aug 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="a9fQg2iY"
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D9F1EB5B
	for <linux-can@vger.kernel.org>; Thu, 22 Aug 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344776; cv=none; b=bp63IT+wPXGbS5aY58RT0enXqMIwdF2KR7M95uzsvBc0GraaVHeiyX15Z+BVJ9CRwRAY1LuQmttRyUdhqhng6wZljqgrICZWYrhiovhR9ozNlQhcNYyPzrDRqJHChEDwuF0rzjJLUc9Lykvj5TvqeFC6/BcURCqbvZe7o2jL6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344776; c=relaxed/simple;
	bh=6AEd7aqey2TwjaChtAuEHs95x45dJmuQMYJ/nKoWbbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9C7NgtNDExGgDcMu84XQ11dsQ133B2ZWMLj8elknUyiOwUQ7miqeG5adyjkgVUMJ1PxTOysegmI4KDRQ/YX6f0sglJ/b28/gP5kwhtB9pcep+uBCJqSyVj3T+KInNbZ9/j5b45jlftavAVOwl0Mp3GuqTyX8IMJYN4rB+3/p7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=a9fQg2iY; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id 24943E0149;
	Thu, 22 Aug 2024 18:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1724344763; bh=6AEd7aqey2TwjaChtAuEHs95x45dJmuQMYJ/nKoWbbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=a9fQg2iYBq1auBDGSf3I6AsWjiP4s4wT5WQztHlPU7CJtWpaebW7sraGdWzf94clt
	 /r0S/rrJRjDaIhPsL+zmsbMzmcB26Z8MxVs+fAyxPLR3vdzz22LwDDFRUZMyuaHtQs
	 NReVRyYKw4bA1vFioTLUMOeAcMYmpGYCNke+R8n4V8gUuwXkHHA+hj39h1hMtXDyBT
	 Z0feRZADtgYIrjB7y9r/17W11uejpYOA6HMV1hdECLYciAF/h1sGYnb4knIGEIlSTq
	 bNDuthgRWB8zVfBYw2ylRPt+uRd2zg9KnWyDVQ0HBX8zSxS+VF428+wksm7LrvERcK
	 KKpbPVr1cpIhg==
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH v2] can: kvaser_pciefd: Enable 64-bit DMA addressing
Date: Thu, 22 Aug 2024 18:38:58 +0200
Message-ID: <68d084a334418fce1944c8f9f5fd431d1bb34a09.1724331797.git.martin.jocic@kvaser.com>
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
Changes in v2:
* Use IS_ENABLED() macro instead of #ifdef.

 drivers/net/can/kvaser_pciefd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a60d9efd5f8d..99fad592965a 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1104,6 +1104,10 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)

 	/* Disable the DMA */
 	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
+
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));
+
 	for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
 		pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
 							KVASER_PCIEFD_DMA_SIZE,
--
2.43.0


