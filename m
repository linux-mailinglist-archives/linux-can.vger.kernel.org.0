Return-Path: <linux-can+bounces-3997-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD7B058C8
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB8616CDB4
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA9E2D6401;
	Tue, 15 Jul 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="S1YBLmZy"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (outm-52.smtpout.orange.fr [193.252.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4782DE6E2;
	Tue, 15 Jul 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578934; cv=none; b=j1U4X7NXqkSbOl1F6fKk0LR4EYT+1t7nxI0AJv5yfxPpQkxu1xBnAAKvJPDL2DRO7IMAuQcowSAphUdBBVnalXPFvYbJMiFhQbQ+KFu3v5w+725NKPLwp+YnPHvTjl0lRtN1T/24rjQW0cwSuSt6zFEERy+ht8IJBJqrOObN6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578934; c=relaxed/simple;
	bh=mQb8BSEcdMpDMvEvXGXSKEFuvif2JXaZOk/FMKXmeZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hl9VPXVzIZYN/Ay+FGIUA9/m34R+yXgVgCtkDwKduk65cuqQkUAKUM94ca6DY3BVJNYcT8cYUYT/G2RDV7tIK08ZrHb2snUH4mrHwNcmq7dsf1Qfrri4Df+GcjfZr/rbibJJ+C3c9XUQrf5IQrMUlFakq3fcie+4Ja51CW3suEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=S1YBLmZy; arc=none smtp.client-ip=193.252.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id bdpWuN5ypJXJvbdpwuiCur; Tue, 15 Jul 2025 13:28:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752578922;
	bh=TQzmhPXh/jjtULqW/3CmqqSt4V5tF2Pz2aim4vtMs7o=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=S1YBLmZyKg5j6eIdeoDq+3LKyfXEBbd7+3P6IALsL+REBpUn95tsmQVHwu3++xCGL
	 IdxlGo4B3rhbQH2OxUJizffecFCYI6QJbKCJcFLezhReHEfWgM39fD6kdP8t5fwwM3
	 Repp+XscYCvJIuU2dyYHBss7c9Tv4ExupE7q4yTYgM9uKlVH+9qw6WzRsZcWzlN1Ms
	 TZq8QeNnFmBn93AEXnrVikoBz5HmvkfKV979eOLZGBeLebNIDbwOkLCIJgLZTaY2Pa
	 bcbLNQNkl7Fbyja8XjfQTDxzgVFPUEFhQk+SYkcQXUU5/08WyqA9b1FMt/FVOSkeh6
	 1vYbQe7gHQydA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 15 Jul 2025 13:28:42 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 15 Jul 2025 20:28:12 +0900
Subject: [PATCH v2 2/3] can: ti_hecc: Kconfig: add COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-can-compile-test-v2-2-f7fd566db86f@wanadoo.fr>
References: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
In-Reply-To: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=727;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=mQb8BSEcdMpDMvEvXGXSKEFuvif2JXaZOk/FMKXmeZE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBll1nGsbkelkwQ6ssQeT3co0544O3ir/pMmwdfL4sNjn
 uXx9k/tKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMJEVrQz/K++rT7Z4JP/n3Wa/
 SZms1myyRz9FfXFd++xCz/uaZ/1N7xgZ5q5fFG/3wOu6s5nlrPB1az40P1c1+Do75J3Uoi9blmV
 IMQMA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

ti_hecc depends on ARM. Add COMPILE_TEST to the dependency list so
that this driver can also be built on other platforms.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index cf989bea9aa33356a94a9bb495d4c22ae907d436..d58fab0161b3ea6e12047c3fa0f884d0142002e7 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -201,7 +201,7 @@ config CAN_SUN4I
 	  be called sun4i_can.
 
 config CAN_TI_HECC
-	depends on ARM
+	depends on ARM || COMPILE_TEST
 	tristate "TI High End CAN Controller"
 	select CAN_RX_OFFLOAD
 	help

-- 
2.49.1


