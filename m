Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2233C9D9
	for <lists+linux-can@lfdr.de>; Tue, 16 Mar 2021 00:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhCOXWL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Mar 2021 19:22:11 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:42290 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhCOXWG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Mar 2021 19:22:06 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 19:22:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1615850123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QpXGhqSYu625X1+vRCVMOxjxi/ewShobdC/CaL1usRg=;
        b=IbwWYVc7EcK286JTfFdShd6+iHLm3iz1TPs6Z8UDoyTZNqGwtCyl/4clGPosb0mHC5Ojjw
        vTYag3RNw62IQbzcZl2qO3wQAGa8i1Z6LLcHW5r4vYXqONBNckT/BNXAC7/DLiUmcaPFDD
        sNfKNEqIy1i3fEcWtU/HvUD0atsGpLM=
Received: from localhost.localdomain (host-79-51-191-72.retail.telecomitalia.it [79.51.191.72])
        by sysam.it (OpenSMTPD) with ESMTPSA id fdf35b10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 23:15:23 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     wg@grandegger.com
Cc:     qiangqing.zhang@nxp.com, mkl@pengutronix.de,
        linux-can@vger.kernel.org,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH] can: flexcan: fix chip freeze for missing bitrate
Date:   Tue, 16 Mar 2021 00:15:10 +0100
Message-Id: <20210315231510.650593-1-angelo@kernel-space.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For cases when flexcan is built-in, bitrate is still not set
at registering. So flexcan_chip_freeze() generates:

[    1.860000] *** ZERO DIVIDE ***   FORMAT=4
[    1.860000] Current process id is 1
[    1.860000] BAD KERNEL TRAP: 00000000
[    1.860000] PC: [<402e70c8>] flexcan_chip_freeze+0x1a/0xa8

To allow chip freeze, using an hardcoded timeout when bitrate is still
not set.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 drivers/net/can/flexcan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 134c05757a3b..bb41ff3d2d1e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -697,9 +697,13 @@ static int flexcan_chip_disable(struct flexcan_priv *priv)
 static int flexcan_chip_freeze(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
-	unsigned int timeout = 1000 * 1000 * 10 / priv->can.bittiming.bitrate;
+	unsigned int timeout;
+	u32 bitrate = priv->can.bittiming.bitrate;
 	u32 reg;
 
+	timeout = bitrate ? 1000 * 1000 * 10 / bitrate :
+			FLEXCAN_TIMEOUT_US / 10;
+
 	reg = priv->read(&regs->mcr);
 	reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT;
 	priv->write(reg, &regs->mcr);
-- 
2.30.1

