Return-Path: <linux-can+bounces-3998-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B816B058CB
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0B917D843
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBBA2D9EDA;
	Tue, 15 Jul 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qEuPkBuH"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (outm-53.smtpout.orange.fr [193.252.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83692DCBF3;
	Tue, 15 Jul 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578990; cv=none; b=XbwWop8vRVGtkT6WsmF5ZOC1y96AtW5TX/LHHvS4NRCY2VkYHOd8kiWJJQmeZ/glGfrSe9+iMUHXOElcuP1c1Dzp4ypvTh8j9k7FvHiBBPf1ZOttHV1UMAS4onkjp8vY/2bEmwoA12howVmtbRkGCDaPV9lgARfdGmrBTWSTLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578990; c=relaxed/simple;
	bh=u+wWC3/DzZTGABh9YY/C+ERaQcTmDqogs0K00hiDc9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpBOpvRR/zo18nFq4WALO+n9grK5+0VaAiV4jSuh6l3J2223qyrJjq+ns0tzAv4/+KWAXd5oPjNOy2CTJA6dAQ3hxBkGAUGlXT8H3rLObQ8w+eyPYBo/unpZYup3Wup2b6X8qwkXNMnftZv3wxrtpHmGv1w0cJETsoKLvGa4cJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qEuPkBuH; arc=none smtp.client-ip=193.252.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id bdpWuN5ypJXJvbdpvuiCqi; Tue, 15 Jul 2025 13:28:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752578920;
	bh=GgTPVK+rkm4R0WLYzeG2cjIOMr6ZRnv+/aEAV0K4FCE=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=qEuPkBuHDw9nAggK3RCvFNFP/NIHA6ob5AyT+efXJxdZ2XvZgoIGZnjkEJ+/LF66V
	 3uKYyiMh6dhyxbWahMWL7DHcet/liog2IYj6aPn4FxgLXqlmq46SstRA9H9kIr9hMI
	 oDQCDpp7Z6njm5KJnmPdApEZoww9ZuOjP+N9Z5RiwRYY4augybODYlKwVWkgYek19h
	 e3P82xJByUnFa+jrhcFOe/LmE1CSJqp7B2al0ZMz/EAK0zSqWj2qM/FdTWLUDs/dfy
	 YLO1K2qGEWXIQNLtCE8wR+jt95D7ooSKXWR9J6s2y8zNpm7ZUDxX45RYjq6v71Ijo2
	 LImTBgilA8dbQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 15 Jul 2025 13:28:40 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 15 Jul 2025 20:28:11 +0900
Subject: [PATCH v2 1/3] can: ti_hecc: fix -Woverflow compiler warning
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-can-compile-test-v2-1-f7fd566db86f@wanadoo.fr>
References: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
In-Reply-To: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=u+wWC3/DzZTGABh9YY/C+ERaQcTmDqogs0K00hiDc9k=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBll1tFOvZOyXOLubXtvHfBmeZdEhnXANNFDuieKvrtdl
 Zz1t2xCRwkLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIl8vsLw47eoMPPklH3Wl/Y7
 xP0My6oNdzc7HfXIskjm2YPL6bVKDP8j85Meu5X84PWNOqrpfXQll4RFaOr/5GMX5be4ncq5eoc
 XAA==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Fix below default (W=0) warning:

  drivers/net/can/ti_hecc.c: In function 'ti_hecc_start':
  drivers/net/can/ti_hecc.c:386:20: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551599' to '4294967279' [-Woverflow]
    386 |         mbx_mask = ~BIT(HECC_RX_LAST_MBOX);
        |                    ^

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/ti_hecc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 644e8b8eb91e74eec050841491f20d3e6796e9b7..e6d6661a908ab12eb4c7ec61c162848c18ef20f4 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -383,7 +383,7 @@ static void ti_hecc_start(struct net_device *ndev)
 	 * overflows instead of the hardware silently dropping the
 	 * messages.
 	 */
-	mbx_mask = ~BIT(HECC_RX_LAST_MBOX);
+	mbx_mask = ~BIT_U32(HECC_RX_LAST_MBOX);
 	hecc_write(priv, HECC_CANOPC, mbx_mask);
 
 	/* Enable interrupts */

-- 
2.49.1


