Return-Path: <linux-can+bounces-5116-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB7BC7FC8
	for <lists+linux-can@lfdr.de>; Thu, 09 Oct 2025 10:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CC924EA431
	for <lists+linux-can@lfdr.de>; Thu,  9 Oct 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34596289824;
	Thu,  9 Oct 2025 08:18:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EC270ED9
	for <linux-can@vger.kernel.org>; Thu,  9 Oct 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997907; cv=none; b=DsWIIM6YwiviKaJIYT8/5LoNAzuqi6q9SJKI7c6OOpF2lUhuiSdCjY0SVe9ulNklt/muMP4uPk8sDLKMCl3s238Yynij41sb5+UFsXAJCE8TJQ6paoM2s4qftDTq3NzImOsgZHrTJqJ83r6xlby3SbYMtE1pG3J4+FJgAUzUq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997907; c=relaxed/simple;
	bh=ZpGVsMy/koLHveU/hgd7Vciyrm+mPEmZ2suptZ77FsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nTvbQB1gKETW/8t3IRpMuPFMZ8rnzjl7RZs/Zqw0ONi9rtCfWRGnw3QmNqJPlIjHFWM6McEPHxRYGeOxRFRLZ1zhTSBtRNE9eI1Dnmx5uwAD//AZAac7f9QXhwfCdZO7jEOt57j8r/Q3Kvf2VFGEcTopuB64t8e+i6CikP7ru7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6lqr-0001dq-RR; Thu, 09 Oct 2025 10:18:17 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6lqq-002hb9-2N;
	Thu, 09 Oct 2025 10:18:16 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6EA604826E6;
	Thu, 09 Oct 2025 08:18:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 09 Oct 2025 10:18:06 +0200
Subject: [PATCH] can: m_can: replace Dong Aisheng's old email address
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-m_can-update-email-address-v1-1-30a268587f69@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAL1v52gC/x3M2wrCMAwA0F8peV6gGczbr8iQ0GQasHU0KoPRf
 7f4eF7ODq7V1OESdqj6NbdX6aAhQHpwuSuadMMYx4liPGO+JS74WYXfiprZnsgiVd0xLacDkxA
 fKUEP1qqLbf/8Orf2A5Mwb4VsAAAA
X-Change-ID: 20251009-m_can-update-email-address-cf86a1d1a71c
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ZpGVsMy/koLHveU/hgd7Vciyrm+mPEmZ2suptZ77FsU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo52/EkgI24wPOaKTI1GeIFCzuf6bLkI45PQuZt
 yYv9udqUX+JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOdvxAAKCRAMdGXf+ZCR
 nFaoCACjiLk2scte/KaY1Ug/jKckQHhi01NZa85fN43ltMUGZN80RylWR0/xvystd28cuQkGbX1
 jrQq8McjR3A2rSbyIPty7HzwQCWCIZ7c26xmBKj1W9dxCSddhpexaweTvKRsp+DOw8/kzMx4A4/
 WeOvS43UmrAsByy8GUpoj5PdaDWE79DazT4FwEXSXyXVUjkRUSrR5v6PiPkgF4THPY5Wy3Siwvi
 hWLwVAdBACfsf94WaQjjC1eeifijRaxDn6gyp/d/Q5+kchBnn4uI32zdCR+BfsTYcx8pYLBEQk0
 ck47po2KfEdCCZOpWi4rFWyq323t2mYBYyoKofLc9kM1KUcu
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Dong Aisheng's old Freescale email is not valid anymore and bounces,
replace it by the new NXP one.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Dong Aisheng,

I'm not sure how you prefer to write your name. Your last mail [1] was from
"Aisheng Dong <aisheng.dong@nxp.com>", but in the kernel "Dong Aisheng
<aisheng.dong@nxp.com>" is used almost everywhere.

regards,
Marc

[1] https://lore.kernel.org/all/DU0PR04MB92993B102E3EDF8BC9223A1C80EEA@DU0PR04MB9299.eurprd04.prod.outlook.com
---
 .mailmap                               | 1 +
 drivers/net/can/m_can/m_can.c          | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index d30f9363a4c9..8160c62f11e9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -227,6 +227,7 @@ Dmitry Safonov <0x7f454c46@gmail.com> <dima@arista.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <d.safonov@partner.samsung.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
 Domen Puncer <domen@coderock.org>
+Dong Aisheng <aisheng.dong@nxp.com> <b29396@freescale.com>
 Douglas Gilbert <dougg@torque.net>
 Drew Fustini <fustini@kernel.org> <drew@pdp7.com>
 <duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e1d725979685..f3d1e57d9c21 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // CAN bus driver for Bosch M_CAN controller
 // Copyright (C) 2014 Freescale Semiconductor, Inc.
-//      Dong Aisheng <b29396@freescale.com>
+//      Dong Aisheng <aisheng.dong@nxp.com>
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
 /* Bosch M_CAN user manual can be obtained from:
@@ -2546,7 +2546,7 @@ int m_can_class_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_resume);
 
-MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b832566efda0..f16a59ffcecd 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // IOMapped CAN bus driver for Bosch M_CAN controller
 // Copyright (C) 2014 Freescale Semiconductor, Inc.
-//	Dong Aisheng <b29396@freescale.com>
+//	Dong Aisheng <aisheng.dong@nxp.com>
 //
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
@@ -236,7 +236,7 @@ static struct platform_driver m_can_plat_driver = {
 
 module_platform_driver(m_can_plat_driver);
 
-MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("M_CAN driver for IO Mapped Bosch controllers");

---
base-commit: 2c95a756e0cfc19af6d0b32b0c6cf3bada334998
change-id: 20251009-m_can-update-email-address-cf86a1d1a71c

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


