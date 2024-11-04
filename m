Return-Path: <linux-can+bounces-1862-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACA9BAEED
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 10:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25B41F20FDD
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C271AC892;
	Mon,  4 Nov 2024 08:59:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F611AB507;
	Mon,  4 Nov 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.240.192.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710799; cv=none; b=UyKreLMsg/56HG1Um/W9/883e9COC7U9Fynapwka3iPONnZJU5AFO0M6a2KlMI4RicvFMmXLQum8RWZiw2Z+kyex0yiTYVQqJ8BW3J6TrSl5ETuz61azea16GsA3o8WRZLvUDnFNuaK2n728QLVlBtCoC1eoQO4gR2aZMdZx6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710799; c=relaxed/simple;
	bh=LL47etnmzWJJki/OsiG0tCx1tTBob14vUbzMkhMrRNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XF7VBaksyhu6S/g9mjDkM16IbYFvxzsxXo0nI6dhdDzLOo/FmOXe5RqDKIJFsv0z4n63PWemZpJxAejEhLFuZSnVWaid7MzqR8eddhEQ6B3KBlb0WsxEwSkXGfCrGZ2xcKGBy2rijeAuV2BvpVZWnb4tQP04A7V185XObEWRfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com; spf=pass smtp.mailfrom=siengine.com; arc=none smtp.client-ip=43.240.192.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siengine.com
Received: from mail03.siengine.com (localhost [127.0.0.2] (may be forged))
	by mail03.siengine.com with ESMTP id 4A48mDCN027577;
	Mon, 4 Nov 2024 16:48:13 +0800 (+08)
	(envelope-from lucas.liu@siengine.com)
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
	by mail03.siengine.com with ESMTPS id 4A48lApu027481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 4 Nov 2024 16:47:10 +0800 (+08)
	(envelope-from lucas.liu@siengine.com)
Received: from SEEXMB03-2019.siengine.com (SEEXMB03-2019.siengine.com [10.8.1.33])
	by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4XhlT93YMLz7ZMvT;
	Mon,  4 Nov 2024 16:47:09 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB03-2019.siengine.com (10.8.1.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 16:47:09 +0800
Received: from localhost (10.12.6.21) by SEEXMB03-2019.siengine.com
 (10.8.1.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.1544.11 via Frontend
 Transport; Mon, 4 Nov 2024 16:47:09 +0800
From: "baozhu.liu" <lucas.liu@siengine.com>
To: <mkl@pengutronix.de>
CC: <wg@grandegger.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        "baozhu.liu"
	<lucas.liu@siengine.com>
Subject: [PATCH] can: flexcan: simplify the calculation of priv->mb_count
Date: Mon, 4 Nov 2024 16:47:05 +0800
Message-ID: <20241104084705.5005-1-lucas.liu@siengine.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:mail03.siengine.com 4A48mDCN027577

Since mb is a fixed-size two-dimensional array (u8 mb[2][512]),
"priv->mb_count = sizeof(priv->regs->mb)/priv->mb_size;",
this expression calculates mb_count correctly and is more concise.

Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 6d638c939..e3a8bad21 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1371,8 +1371,7 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_MB_16)
 		priv->mb_count = 16;
 	else
-		priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
-				 (sizeof(priv->regs->mb[1]) / priv->mb_size);
+		priv->mb_count = sizeof(priv->regs->mb) / priv->mb_size;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
 		priv->tx_mb_reserved =
-- 
2.17.1


