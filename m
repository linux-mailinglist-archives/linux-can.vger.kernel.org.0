Return-Path: <linux-can+bounces-5356-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C01C5155B
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB343B24D0
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0252F2FE048;
	Wed, 12 Nov 2025 09:17:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594DB274B28
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939073; cv=none; b=YMmrxqXCDYKFtlSi7/r4o/EQ8Jr4Q5N+t6BN/RUC8ziDYVkYDxFxYeSTQhQg3t3XTIlSAbku5OACzcQGJHQf9F6QeVh7sOuGHBN5mq8zuNQ1vBuEo8QJ/NCdOHImlbHUL5Cb31n5XCGSAq9SkiF0ZPVpZFw/VIDmwO2wkr+2JBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939073; c=relaxed/simple;
	bh=yS5KxhWOIq8laBCLLPL8hY0CywZGKfbT5VvT4aOdYVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNa8J7npAj9SU7P90ESIeZx33oxoIQE1B26jyJmbgHHw0f57Aw2JZ2d64SJk+q20wT/mvYZJcby4ey8HXxbwRTOk/jYPf9mznDi0Q0nqqrVsqCh9lmZZjK3pRYxjTOiKY6/x7N3gtCMrVaVcOT9EQn1yYTOABsCHtCAKHWCXzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6yz-0007VD-7Z; Wed, 12 Nov 2025 10:17:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6yw-0003ch-0y;
	Wed, 12 Nov 2025 10:17:38 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1370149D9A2;
	Wed, 12 Nov 2025 09:17:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chu Guangqing <chuguangqing@inspur.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/11] can: bxcan: Fix a typo error for assign
Date: Wed, 12 Nov 2025 10:13:51 +0100
Message-ID: <20251112091734.74315-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112091734.74315-1-mkl@pengutronix.de>
References: <20251112091734.74315-1-mkl@pengutronix.de>
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

From: Chu Guangqing <chuguangqing@inspur.com>

Fix the spelling error of "assign".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20251103074009.4708-1-chuguangqing@inspur.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/bxcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index 0b579e7bb3b6..baf494d20bef 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -227,7 +227,7 @@ static void bxcan_enable_filters(struct bxcan_priv *priv, enum bxcan_cfg cfg)
 	 * mask mode with 32 bits width.
 	 */
 
-	/* Enter filter initialization mode and assing filters to CAN
+	/* Enter filter initialization mode and assign filters to CAN
 	 * controllers.
 	 */
 	regmap_update_bits(priv->gcan, BXCAN_FMR_REG,
-- 
2.51.0


