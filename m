Return-Path: <linux-can+bounces-1485-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF059763F0
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 10:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFB31C20A66
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575EF191F7C;
	Thu, 12 Sep 2024 08:06:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C518FDBA
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128378; cv=none; b=lG+zzxAKjJ6oDKVJ3nYP/VLHlSwDsZihe/H9sMzT0imSXObJxHyMGn7gBNPmkZ66kFo4iTRlPCv4Is6RU0xKP8xfLJ9TYVfwqERDL9dBoI0X5nNu1mCAsJsKYKFbD8VtjmNR8hYClX8SbgGZE6raMPDOks/qnGX3uPBC0Op4XEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128378; c=relaxed/simple;
	bh=yfVVPrbdePM+D9YKkuMycB/QyNZ8+Wze970Rbaty6cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtRpGyePUWVg2ueWXs6zZ/0dY47A1ss36xLgM7r9qtILj7L3Vyn2oEBsu0t0K26AeCFQWLFN3hkerZ5IKH5xpS1Kiyksj66UV/s67YsDeW7jU8CkKVRWTwc5Hc6cebmiM5Dyhmcyl7CjIyMuw/c3aVobFTwbXP8iTtD9UItApMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq6-00047W-Fr
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:06 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq6-007KfC-0t
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0673B338E43
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 07:58:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7CBD8338E08;
	Thu, 12 Sep 2024 07:58:06 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ab9c422b;
	Thu, 12 Sep 2024 07:58:05 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/5] can: kvaser_pciefd: Enable 64-bit DMA addressing
Date: Thu, 12 Sep 2024 09:50:52 +0200
Message-ID: <20240912075804.2825408-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912075804.2825408-1-mkl@pengutronix.de>
References: <20240912075804.2825408-1-mkl@pengutronix.de>
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

Enabling 64-bit addressing for DMA buffers will prevent issues
on some memory constrained platforms like e.g. Raspberry Pi 5,
where the driver won't load because it cannot allocate enough
continuous memory in the default 32-bit memory address range.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://patch.msgid.link/d7340f78e3db305bfeeb8229d2dd1c9077e10b92.1725875278.git.martin.jocic@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 9ffc3ffb4e8f..f86c9671a03a 100644
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
2.45.2



