Return-Path: <linux-can+bounces-4919-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E9B98CB0
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36B22E11B7
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50A28506F;
	Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472492848A9
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702105; cv=none; b=U9zLBRvAGVvDi6A+Mtmf1QEQePVnQ/sqWePvvW/z3W/wl6yMnnSZAX8Bz6gwAwMab5d0TYWyzj8wRyKKmEGWsOhJmDZoUPQQye/oYMmbTT5fCSQvkw6kZriSpGgdoi26YW+qmiq3tBDbB+AKSVbPC99dVtGLo6O0Jd5Z3uS3mZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702105; c=relaxed/simple;
	bh=LXBwPtzIPzsiF9cPpC4tq+WoyqwIS/4mHj0clFC6H3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFrspW9Qb1eYa7hyns5L5W54cYiIt1Htc24bVJRxXht2SS4uD4M+Y5s4e4AjKn1csvjHkYr/1119zKaxzwI+IS8DINfYT7tNOBJbepF/PTezzgs/3rBKJOkNph2N9cTFe80bQuaj+DtzPJdZIMl7GGJe+JZpmgdHhGVAJHplXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001EU-Kp; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000Dvf-2N;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 487E547887E;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 13/48] can: rcar_can: Convert to GENMASK()
Date: Wed, 24 Sep 2025 10:06:30 +0200
Message-ID: <20250924082104.595459-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use the GENMASK() macro instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/3f947f0f91a8857a2cbce74807e42258e9f209ca.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index c47ee4e41eb6..7b94224bbc9b 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -114,16 +114,16 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 };
 
 /* Control Register bits */
-#define RCAR_CAN_CTLR_BOM	(3 << 11) /* Bus-Off Recovery Mode Bits */
+#define RCAR_CAN_CTLR_BOM	GENMASK(12, 11)	/* Bus-Off Recovery Mode Bits */
 #define RCAR_CAN_CTLR_BOM_ENT	(1 << 11) /* Entry to halt mode */
 					/* at bus-off entry */
 #define RCAR_CAN_CTLR_SLPM	BIT(10)		/* Sleep Mode */
-#define RCAR_CAN_CTLR_CANM	(3 << 8) /* Operating Mode Select Bit */
+#define RCAR_CAN_CTLR_CANM	GENMASK(9, 8)	/* Operating Mode Select Bit */
 #define RCAR_CAN_CTLR_CANM_HALT	(1 << 9)
 #define RCAR_CAN_CTLR_CANM_RESET (1 << 8)
 #define RCAR_CAN_CTLR_CANM_FORCE_RESET (3 << 8)
 #define RCAR_CAN_CTLR_MLM	BIT(3)		/* Message Lost Mode Select */
-#define RCAR_CAN_CTLR_IDFM	(3 << 1) /* ID Format Mode Select Bits */
+#define RCAR_CAN_CTLR_IDFM	GENMASK(2, 1)	/* ID Format Mode Select Bits */
 #define RCAR_CAN_CTLR_IDFM_MIXED (1 << 2) /* Mixed ID mode */
 #define RCAR_CAN_CTLR_MBM	BIT(0)		/* Mailbox Mode select */
 
@@ -139,7 +139,7 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 #define RCAR_CAN_RFCR_RFE	BIT(0)		/* Receive FIFO Enable */
 
 /* Transmit FIFO Control Register bits */
-#define RCAR_CAN_TFCR_TFUST	(7 << 1)	/* Transmit FIFO Unsent Message */
+#define RCAR_CAN_TFCR_TFUST	GENMASK(3, 1)	/* Transmit FIFO Unsent Message */
 						/* Number Status Bits */
 #define RCAR_CAN_TFCR_TFUST_SHIFT 1		/* Offset of Transmit FIFO Unsent */
 						/* Message Number Status Bits */
-- 
2.51.0


