Return-Path: <linux-can+bounces-3643-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33881AC0761
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C041898A7A
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBA2868AB;
	Thu, 22 May 2025 08:41:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC51280309
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903300; cv=none; b=ZAM5P5bHSc8JeTptmrH6p9RXFEKQ4tlFloJa80g8yjcBjTlt/QTzO1RDW2lLN0Sf9HsOzt5YsUJJFlub01svChugn5Ba0kTQnvPRewI7NNfn+MzY1uIOCezL6xtzEsRywf0LMYtmTtFHEdf6Z4ksLqUBe3iukaGOA5SQkRxtOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903300; c=relaxed/simple;
	bh=ByThKT2U3wMRqOqBHca1zff+ZDUZEHHIspEsFwCXhi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExPZtjYpfUXbAiijVwAKYb5ewTMD5H2mWGW1slZk4X/D94e5+f+BxtZAiQcY9K5mfZgRrsJbfEBIWY9uqUCz+mQrVjjHZ1uh0C41tyjPg1fakPWkLUcXw5p2Su+AROw5UlUiIrb4x+mBNABXMkLtNJ8X6NQZKPTC1C4iVRSkvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Uf-00064h-35
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ue-000hjk-0E
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AC2594172DF
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9A6714172B7;
	Thu, 22 May 2025 08:41:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 30f2b310;
	Thu, 22 May 2025 08:41:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/22] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
Date: Thu, 22 May 2025 10:36:33 +0200
Message-ID: <20250522084128.501049-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF. The macros
RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by FIELD_PREP() and
drop the redundant macro RCANFD_GERFL_EEF(ch).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250417054320.14100-6-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 565a91c2ca83..d53aa71f11c4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -21,6 +21,7 @@
  * wherever it is modified to a readable name.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/can/dev.h>
@@ -74,18 +75,18 @@
 #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
 
 /* RSCFDnCFDGERFL / RSCFDnGERFL */
-#define RCANFD_GERFL_EEF0_7		GENMASK(23, 16)
-#define RCANFD_GERFL_EEF(ch)		BIT(16 + (ch))
+#define RCANFD_GERFL_EEF		GENMASK(23, 16)
 #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
 #define RCANFD_GERFL_THLES		BIT(2)
 #define RCANFD_GERFL_MES		BIT(1)
 #define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
-	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
-			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
-		RCANFD_GERFL_MES | \
-		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
+({\
+	typeof(gpriv) (_gpriv) = (gpriv); \
+	((x) & ((FIELD_PREP(RCANFD_GERFL_EEF, (_gpriv)->channels_mask)) | \
+		RCANFD_GERFL_MES | ((_gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0))); \
+})
 
 /* AFL Rx rules registers */
 
@@ -938,7 +939,7 @@ static void rcar_canfd_global_error(struct net_device *ndev)
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
 	gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
-	if (gerfl & RCANFD_GERFL_EEF(ch)) {
+	if (gerfl & FIELD_PREP(RCANFD_GERFL_EEF, BIT(ch))) {
 		netdev_dbg(ndev, "Ch%u: ECC Error flag\n", ch);
 		stats->tx_dropped++;
 	}
-- 
2.47.2



