Return-Path: <linux-can+bounces-3999-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A8FB058D1
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 13:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363F81897E21
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1B12DE70B;
	Tue, 15 Jul 2025 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iMT0WHW1"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (outm-53.smtpout.orange.fr [193.252.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480C2D8DBE;
	Tue, 15 Jul 2025 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578997; cv=none; b=pJeMptNoVlhH2bj9ECzbF/cRoe/706YZEHGdYYCc6Bi7iMv5JMmqN3onCXQbHcq4sgJEl88k2PeoXnmBKJd6HCKLzVLXfMjGw0fx5sSR+cpoRMbWh0vAOd9Pmgh/Z811z83RPf/2qtKN2RRp5fBI6B+49nKUXU80SVS0W0kKe3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578997; c=relaxed/simple;
	bh=BxRJVx8kXdIZKglDaftTW/AKzR/s8mQG7XTuOk2yUI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VoqkDEb2wth49XTHOVD98eK/w4NIvkqvijdLcpYwT/hD+lq2rwINLAQ0aSURmVGx5rRNRCU4h6QoYErRjnk7YOvRTWfc94EXR/Zc/SEFF6+veNDCceLODrLiaPuE4zldMD57ozzXZpe+F3n/PpdLGAad2iUMzP4c98mvJqq8uCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iMT0WHW1; arc=none smtp.client-ip=193.252.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id bdpWuN5ypJXJvbdpyuiCyT; Tue, 15 Jul 2025 13:28:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752578923;
	bh=hJYi/43qocRw/wrecelZ5S5HLmp0zRyZK5SULniDlIQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=iMT0WHW1gysZft9FmgAFxmzL3lvY/1WknnzH3wAjJcXW8zZVoqTQyEbodXawO7AxD
	 m2hl+5N3XIg5FQX2po4aDO+m6GKK55kOylwatUySZMfTb3Qo+Ms2Aoodf4X+HJms8Y
	 xmTB2Pc43/dwFfovjlqrmS1w0RQNl/3otq196Ssyd5wknktSn+4pnAh9yGF3rpZwCe
	 ZfRO7j4nsA9+SIaqO1bSTNbYUajGkeFMvuIgzGH52yYE2jnyK8xn+mo9/68Hqp/dCj
	 zb5A1Y3GYoI6yHXaPcG0fY9mKIcpnzQxewtRvi4TB+L5zc0uRss0X/PgUL+r7jBU3J
	 2RrVFXRrU+o4w==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 15 Jul 2025 13:28:43 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 15 Jul 2025 20:28:13 +0900
Subject: [PATCH v2 3/3] can: tscan1: Kconfig: add COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-can-compile-test-v2-3-f7fd566db86f@wanadoo.fr>
References: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
In-Reply-To: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=BxRJVx8kXdIZKglDaftTW/AKzR/s8mQG7XTuOk2yUI8=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBll1on5N0R/HIizsehgSnLOa27ddVxgzZGYO3w3Jlyx/
 8DLLSDRUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCIPFRkZ3umeYfmWuuX/k5IZ
 fRfmd5W9PrVN2spQ42DJxowG6UWVkYwM+2Xc8982Hit8V3pLV317+rO+BaKLa7+L9z5uum7o4xz
 FBwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

tscan1 depends on ISA. It also has a hidden dependency on HAS_IOPORT
as reported by the kernel test bot [1]. That dependency is implied by
ISA which explains why this was not an issue so far.

Add both COMPILE_TEST and HAS_IOPORT to the dependency list so that
this driver can also be built on other platforms.

[1] https://lore.kernel.org/linux-can/202507141417.qAMrchyV-lkp@intel.com/

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v1 -> v2:

    - Add HAS_IOPORT
---
 drivers/net/can/sja1000/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 2f516cc6d22c4028b1de383baa6b3d3a7605b791..ba16d7bc09ef7e9551d9ce200f0febd19bf11eca 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
-	depends on ISA
+	depends on ISA || (COMPILE_TEST && HAS_IOPORT)
 	help
 	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
 	  https://www.embeddedts.com/products/TS-CAN1

-- 
2.49.1


