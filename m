Return-Path: <linux-can+bounces-3972-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE1B02F50
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88F64A0202
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E01EDA02;
	Sun, 13 Jul 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qa0pfjoM"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184821E25EF;
	Sun, 13 Jul 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393891; cv=none; b=cinorEUvhpFLt5dLUrt1Wpj+lQjHCs7WkB5R1x60dRUip/OhFS5YbL8GGN9vyWxa3Wht2950wl9pyBf6gPm2Q6LcE6JnDNN4a4xtqDQ5BflVB3WSUub+3Llk67tYq6+WPLCCBi5wJC6P58JZsC0vwTRYzo4yqeh+47qA1SuPw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393891; c=relaxed/simple;
	bh=UR+gDb4IrC0T6pAt2Vs9Hh7lhC4JEvfQ6RB9Dp7lrqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W+Slreinyi2iBU8g/akZRqVTO0lnE9oBgoOtf8ifrORhBpSgS8WIlSHbPEjAlwfEm28uccKmSmGkNn0uXKAiHBrQDxvhHsAdxnEkRk4MqAYKu8ouKGLtdRlVEm0rC6rZlTiG8MEPMp78Mpo385m9BrISk9FpdAMH3PZGpD+JK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qa0pfjoM; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id arfyuJE25DfrTargQuRCNG; Sun, 13 Jul 2025 10:03:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752393819;
	bh=IAWMrA2/J0cINk3PCo9jM9heAqQ798UsSZiUUY7jDmE=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=qa0pfjoMq1OxbPnHf7I+Wkf+doPJk7pdw+k78wiU6tB5NtI/FTC2Sv/APVmL/Q1Ff
	 NckrmURFNX+iNYMAEoQe2nEpiplObCl8dqmYxvIXhV030IepJwh7KCozPea952UHWC
	 ck9FODy+uc7qiaGFji3M4xbqCAZxqkVtBfiWRK6z7ZjIVJ4jQX4V7x4n+pw20GddJq
	 E0DHwTV7P9PU+ATiaWItcI2eXLPyHCV8UuHpB6l+0b1vETtwsc2pBGWYmC9/wMDe2G
	 h/y0s1RMTQUi7ZXRx5G7INfrOQmptA1BS5aFWyrH6J01/jrop6ENSx1Y71o6n1E4nz
	 FLkYEwE7VCFDQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jul 2025 10:03:39 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Sun, 13 Jul 2025 17:02:45 +0900
Subject: [PATCH 3/3] can: tscan1: Kconfig: add COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-can-compile-test-v1-3-b4485e057375@wanadoo.fr>
References: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
In-Reply-To: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=812;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=UR+gDb4IrC0T6pAt2Vs9Hh7lhC4JEvfQ6RB9Dp7lrqA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnFGYEvuh1O1t+2Z0ow2urLeTroEUPJhjesPcdi93TUM
 VuvUPLsKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMBH/M4wMC1dUpXfvZ8zSNorI
 ynihlLGN/1GdTlpkuODVQD2Lv6eAKo7t7Q3J7vondX771InLl/1PVfKRXXo29EHa/Ai76XaNX/k B
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

tscan1 depends on ISA. Add COMPILE_TEST so that this driver can also be
built on other platforms.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/sja1000/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 2f516cc6d22c4028b1de383baa6b3d3a7605b791..fee9d6f84f5fb9d6a81df00be9d216219723a854 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
-	depends on ISA
+	depends on ISA || COMPILE_TEST
 	help
 	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
 	  https://www.embeddedts.com/products/TS-CAN1

-- 
2.49.1


