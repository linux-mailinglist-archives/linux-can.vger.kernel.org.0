Return-Path: <linux-can+bounces-5131-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62513BD03BB
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 16:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A363BE1A4
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AA287271;
	Sun, 12 Oct 2025 14:28:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847B287254
	for <linux-can@vger.kernel.org>; Sun, 12 Oct 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279331; cv=none; b=Li+vzR0waCTMpmTQdP1G3Xtr3BzR0tQ/kjKwH6XwA4S9wwLbyiOhc/lRmMa+YGMO19mLopzIHF5uCz4AijdXw+nPotsDNUp90wIAh5c0X7ChAvcVsPtOWSdIh+RDia+yBjcxH/OMC07BlD0ZK1OITttVu6LGk7QjQeVuUR0zxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279331; c=relaxed/simple;
	bh=GYgaT837COzfq0a2uDjVt7G+BVNrg+bGNkXg4+DLpZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfWpi7YLV/SvdFA0lTWRqyanxchDDJd9MVHEsTXCjzBgUaMsWd58VzbaJxjsn9QkCo62WHpFB9c2WZGzOIWprjXm4pHnpNGCNCbeQSsFG9tCZ6vk5SvrDH6Zsnky8ngAfuHfkhIet2JFebab+Jl0UQW3+hNoTh4lfkGmeFW/vbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3w-00044o-FI; Sun, 12 Oct 2025 16:28:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3v-003EUv-2H;
	Sun, 12 Oct 2025 16:28:39 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6DE52484064;
	Sun, 12 Oct 2025 14:28:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH net 7/9] can: m_can: replace Dong Aisheng's old email address
Date: Sun, 12 Oct 2025 16:20:51 +0200
Message-ID: <20251012142836.285370-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012142836.285370-1-mkl@pengutronix.de>
References: <20251012142836.285370-1-mkl@pengutronix.de>
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

Dong Aisheng's old Freescale email is not valid anymore and bounces,
replace it by the new NXP one.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Link: https://patch.msgid.link/20251009-m_can-update-email-address-v1-1-30a268587f69@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
index f2576e577058..ad4f577c1ef7 100644
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
@@ -2556,7 +2556,7 @@ int m_can_class_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_resume);
 
-MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 057eaa7b8b4b..4a412add2b8d 100644
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
-- 
2.51.0


