Return-Path: <linux-can+bounces-3970-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C18CB02F4C
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF5317CAAB
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF11DED5F;
	Sun, 13 Jul 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="URR7xIWU"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3079189B80;
	Sun, 13 Jul 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393888; cv=none; b=mx/mL7IY0iTPO8c9rIr5dJRjzLVQKYS7KPSMr8mtC0Bv3y2vm2QZdJt3+EGHhteFXrJfTBMKbFVvtlos60Aarv81ITmAN/XONV4OGKbubNKvF6+ogxA/A84qUxzV9Cp0Yw03ndIEqPyBfnVPyxV8xhTxG1j0N5LJTJA8MfjUqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393888; c=relaxed/simple;
	bh=u+wWC3/DzZTGABh9YY/C+ERaQcTmDqogs0K00hiDc9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HA/i01H8tNBXXC5MTol+RMXu0YAiQmOUIdtc1+0p4JZxlkTRPZi2Jrm54iQT+RUfygYKFaOQ42XhTkZCDft8g8SxEYEWlpPx2h4iJwEnwbsdsjxjwZkYhu0IUpiU63eFDbkumM3rVp6AWq1UXxIPh0hWbRKGOkNkI7P9Yo4ISkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=URR7xIWU; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id arfyuJE25DfrTargMuRCIh; Sun, 13 Jul 2025 10:03:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752393816;
	bh=GgTPVK+rkm4R0WLYzeG2cjIOMr6ZRnv+/aEAV0K4FCE=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=URR7xIWUSPXvZaIsVFxiPSWPvmyCrGwub0EIM/SGj/4wawJGaijG8EVQtPUW6oj9p
	 rhRVgMBcmQVp3coyuvQDjO+DdXWvDHBkwkevxMx+r2GEjJFkEDMs3qQDXlBLoGqJnX
	 GQxexcqmgy9b6XUeKUpdIZeRsiLqKBRfjh0Tiy1ZvPYn3Q26L73guuRmWED6e4YVor
	 Hf5p9rxqvpXi9uKhDBXcZrPoO/5JIsHBf8cKhDYdotSSJwk7Y24Jj4cVa15FzTguCn
	 nlGFOrEwhkLOTeUgbD02YPTiIFPxJlT7Nvc6AGM1o5ZwdcWVjj3YZW0aGO90Xw3XNs
	 kHtY/kvfaj/qA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jul 2025 10:03:36 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Sun, 13 Jul 2025 17:02:43 +0900
Subject: [PATCH 1/3] can: ti_hecc: fix -Woverflow compiler warning
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-can-compile-test-v1-1-b4485e057375@wanadoo.fr>
References: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
In-Reply-To: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=u+wWC3/DzZTGABh9YY/C+ERaQcTmDqogs0K00hiDc9k=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnFGV75IdonH19yMC69ZOkYoCnsdzebUeewZImUwrJdS
 nc4lpZ2lLIwiHExyIopsiwr5+RW6Cj0Djv01xJmDisTyBAGLk4BmMjT64wM73ROzJ6n2VHpu5Nb
 60vllROPpbO5+/uL1qv59L170LthF8N/V8Z7F5QCRU81Gz53yjw8/bSVT8aWjd/7Z0QG2eU3f9F
 lBQA=
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


