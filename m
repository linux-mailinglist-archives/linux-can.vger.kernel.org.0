Return-Path: <linux-can+bounces-5689-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC76C8939F
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12FA8345887
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9A72FFF87;
	Wed, 26 Nov 2025 10:17:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911E625A2C9
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152224; cv=none; b=s4tjdbRlbJMbtIMl67GsJjnhPex1Xosul2CrXqDZSuefISgIp9M0RYCwtaLmtuc+rjo5JG7P6I9FYOJsA8W+471LqGL0yzmS5oheYTokDIbFiOeVvjhVWeBQGznGSC4m4QfNG9I42bUoDCchs43Vs5GMbPx3P6qwdD+pfG2k5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152224; c=relaxed/simple;
	bh=7upFcfNtk02ZrLQVj1Y75LsfDYr/ckHj8RmqRB7L5yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5hp5r8mk6dcfDziVc3xT8K5LX3WdaG9pHK/DD1ReAvkBlKTyv5NM3xoINl+Z0BBdbMi2+PZTS5GeIJL2q/CBI8ZEdoSgGH1wpu/hhTeuGRipjwJHuPvkCKN/uapOO/tsfTES5akASTpi14/xXtzi8JBVHDe5AaKwCfnT+HC+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZw-0000RV-0c; Wed, 26 Nov 2025 11:16:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-002aSy-15;
	Wed, 26 Nov 2025 11:16:51 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1EAAB4A88DE;
	Wed, 26 Nov 2025 10:16:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:14 +0100
Subject: [PATCH can-next v8 13/17] can: calc_bittiming: add
 can_calc_sample_point_nrz()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-13-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2123; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=h8iUAW6OBOFyCa9dq/JPiYvY0k8Oxvczhn5v3kx3D/4=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtOJYtjRl8SeCMThJIdwh0AW+aWDgJuOvFrBE
 0cAqpFUooaJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTiQAKCRAMdGXf+ZCR
 nBc6B/9ghzzQw0+RyLt9eKJ9cAzyR+jbUbNkc5lkT/ZhjA+GXHzdd4N9skB59nJCMU6UTeCJiVa
 IaNsQNKyO3aISxTVOQmolB/Fsjti+3Hp66uNuYQ44EgV6qKKefTDmeqtRAOFlEclnYPOmO9BVYA
 fWOmtINg7swiX00EFo2GaMYIqugE214CiIQ1rMEiM0w6yPKQ8an9AlVLTH6VeZ/+eM9rfl4/hX3
 kndOboOlAyU9nBZW/D6OYMayxDbNr1QrQgOXHN4kryzTYZmfZYFyx25xBsdF16cNLVwFfnRNo3z
 oswsP/JlbpW8TocaQF9icCciBKvIinAlIYnWRdxuHUcB1te6
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

CAN XL optimal sample point for PWM encoding (when TMS is on) differs
from the NRZ optimal one. There is thus a need to calculate a
different sample point depending whether TMS is on or off.

This is a preparation change: move the sample point calculation from
can_calc_bittiming() into the new can_calc_sample_point_nrz()
function.

In an upcoming change, a function will be added to calculate the
sample point for PWM encoding.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index c8c166b383cd..bacdf3b218d3 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -10,6 +10,18 @@
 
 #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
 
+/* CiA recommended sample points for Non Return to Zero encoding. */
+static int can_calc_sample_point_nrz(const struct can_bittiming *bt)
+{
+	if (bt->bitrate > 800 * KILO /* BPS */)
+		return 750;
+
+	if (bt->bitrate > 500 * KILO /* BPS */)
+		return 800;
+
+	return 875;
+}
+
 /* Bit-timing calculation derived from:
  *
  * Code based on LinCAN sources and H8S2638 project
@@ -79,17 +91,10 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	u64 v64;
 	int err;
 
-	/* Use CiA recommended sample points */
-	if (bt->sample_point) {
+	if (bt->sample_point)
 		sample_point_reference = bt->sample_point;
-	} else {
-		if (bt->bitrate > 800 * KILO /* BPS */)
-			sample_point_reference = 750;
-		else if (bt->bitrate > 500 * KILO /* BPS */)
-			sample_point_reference = 800;
-		else
-			sample_point_reference = 875;
-	}
+	else
+		sample_point_reference = can_calc_sample_point_nrz(bt);
 
 	/* tseg even = round down, odd = round up */
 	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;

-- 
2.51.0


