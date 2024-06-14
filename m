Return-Path: <linux-can+bounces-755-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4871908E78
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3501F277F7
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BFD15FA73;
	Fri, 14 Jun 2024 15:15:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C815F406
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378153; cv=none; b=d8KHxK2GdGnThQjWdTkQnVWXhAopBdFaJWtYI7v/wOD7fuih1IQAQpsSWPFtEcrG98v75Xwos3fzWGxLxyW6sV2P0WsHA0A2VYvlK8/B82XaVg8/kJPPYvesHQiZA0h5nhPLBSnJ2DjkcM1FWb+xrDuK23jTgxWe+Lk3xW8QVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378153; c=relaxed/simple;
	bh=3F2jXqKnrFVR2ZrHHI0lKVhSJgJrM9XqGW8wke1i+vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOu5B+P4YqBLIcDiThEfyXie1e2gtg/N7Ki4rxihxi+jP8iKHmi8JbLPTk/JhnuJg9x60/ATIs6Zo+tAFof1S53tQ9rrcl0l2JFLoCtpGPvx4xJEQrHa7N75q34v9NTjtJLTfw8KQBD2sO15nN043qSty9mfxTwhVDsrSKvmPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id C80C1E0119;
	Fri, 14 Jun 2024 17:15:41 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 2/7] can: kvaser_pciefd: Skip redundant NULL pointer check in ISR
Date: Fri, 14 Jun 2024 17:15:19 +0200
Message-Id: <20240614151524.2718287-3-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240614151524.2718287-1-martin.jocic@kvaser.com>
References: <20240614151524.2718287-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This check is already done at the creation of the net devices in
kvaser_pciefd_setup_can_ctrls called from kvaser_pciefd_probe.

If it fails, the driver won't load, so there should be no need to
repeat the check inside the ISR. The number of channels is read
from the FPGA and should be trusted.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fa205091aafe..4832a93d34de 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1701,12 +1701,6 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
-		if (!pcie->can[i]) {
-			dev_err(&pcie->pci->dev,
-				"IRQ mask points to unallocated controller\n");
-			break;
-		}
-
 		/* Check that mask matches channel (i) IRQ mask */
 		if (board_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
-- 
2.40.1


