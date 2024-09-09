Return-Path: <linux-can+bounces-1447-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6B97187F
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 13:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E031C2231D
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7C1B653B;
	Mon,  9 Sep 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="RCORrkIJ"
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457901B652C
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882255; cv=none; b=HUvWiqLT6Uu4DOKZ423lnhOcTBdUCojNa1dDhfSallpvz6uV/fiIpCI2ebpKydFZK04BqBB/HkKcjLzAqyTIsClvJ/w79rkj8w6PUc5EBWK71WI8NKGgtWPvGfS4poRfF6onu3TQhNjMTtm3OvnLvzuBmJQHPgU5Nw5WieZaMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882255; c=relaxed/simple;
	bh=yVrIkZlh+Zd3NPYKjZKrQPFP9WARDVeQBOO00/pysCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ob+zxkXspbJvDZkp+NYWDAp/tNx7laKx7it/grDbpdzx/NfVe/du3UAXGX6i/dlqKpD29uaFhMaqClxPokPbGiSoNqK7Nhi2nSmvT7fo1UWukBLEnXhSjzUVonEek9uLNHlNK6qSzzuNriLu6Z6tsfvpaqgdwOyLtKIQyk4oJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=RCORrkIJ; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id 93D67E014A;
	Mon,  9 Sep 2024 13:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1725881802; bh=yVrIkZlh+Zd3NPYKjZKrQPFP9WARDVeQBOO00/pysCk=;
	h=From:To:Cc:Subject:Date:From;
	b=RCORrkIJZGxyo9eaXCXHZ7WU4F8PwXd2w45nGmQdj/vJR4dk4/MMkJlx2oGh93rRq
	 Iz5VPucazluqPaalN1wJhOtjyvRHKe7Mmxg2PNT92iRLKWZikcLULaYUWtK+7FRT2N
	 q0j+zrNyxgHMTzpxjETHsuuByzD68C8nNNczYkFfluvFlMM3p9wrPpVDc0G9bV4nDK
	 1ifmOzmp2gACLyhDfH9d6q7Mh6IotxuJDxkhgZjC2m5aaNpRE0N5HM0DSJ+BTgVMk6
	 vRYwR4lLF2r2OSYR0eomJ0fwg3VkMnwJ+yIIvY173ab5sF2DZIUVF9/jUdnx83g+v3
	 FC36J2OA/Lolw==
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH v3] can: kvaser_pciefd: Enable 64-bit DMA addressing
Date: Mon,  9 Sep 2024 13:35:12 +0200
Message-ID: <d7340f78e3db305bfeeb8229d2dd1c9077e10b92.1725875278.git.martin.jocic@kvaser.com>
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

Changes in v3:
* Apply unconditionally, do not check OS-version.

Link: https://lore.kernel.org/linux-can/20240830131724.7c08eac4@kernel.org/
---
 drivers/net/can/kvaser_pciefd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 9283408d1b29..fee012b57f33 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1104,6 +1104,9 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)

 	/* Disable the DMA */
 	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
+
+	dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));
+
 	for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
 		pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
 							KVASER_PCIEFD_DMA_SIZE,
--
2.43.0


