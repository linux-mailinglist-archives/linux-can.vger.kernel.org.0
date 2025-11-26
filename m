Return-Path: <linux-can+bounces-5682-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF03C89387
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBD2A34FBE5
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECBC2FDC2C;
	Wed, 26 Nov 2025 10:17:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A22EA47C
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152223; cv=none; b=S5S+/Ma+H/cGlMukL0zMQpWl43/hHmXcHJl/BsupeueWCSVDPTSQOGdFbpIZBojUyOi1r6sCVi76sYel4XEHqNYuUhK/hHoqhYBo3PTQOPHN2WEeYo5Z9Xf5EXi5gxzsQ5tSUvAUK09Yyyirz4Pb5Yr02S7RAIUo0Ms86c6WYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152223; c=relaxed/simple;
	bh=M8V6jfE7RgymR7a2gd5FDYaJ9SS0V/zDQuGkP+QUqcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VW2LUQ7C6Ld3gd85rX/ARBLYVwstMDSehXUAxD7+EsDK4qZ780rX5Ofu1xNdOTqfXG+lsDcT7cS373ZQ0WWfgTcExl2UMbNTIZvrPjNoMIZuskEvkpxKqjAHqnXw1Z0H0jtrTaCZ78BELbZcb/Cw7tauk/KifSwEZj8LzgR/IMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZw-0000RW-0r; Wed, 26 Nov 2025 11:16:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-002aSx-15;
	Wed, 26 Nov 2025 11:16:51 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 16D954A88DD;
	Wed, 26 Nov 2025 10:16:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:13 +0100
Subject: [PATCH can-next v8 12/17] can: calc_bittiming: replace misleading
 "nominal" by "reference"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-12-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4567; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zfU33+qIh3oomxHhxXPcNk3KNLPMvGySxv+hWnX3g7I=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtOHbzDxhx+EWLbkJSCzfNeoZI0f8PicE7uS6
 m+qoud6d5qJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbThwAKCRAMdGXf+ZCR
 nJtTCACX+nd0J58YwEE1RF0Hzkw6Ga3Ctpdb7lhxM7/6rW7nXSLu+WKFweIfrBvRPf2Dl/3ORjf
 Efhnmomz6n9ez3QhBbH5rIoUmu5klevtmMn2Lst25yqN5DSONxVG2W9hmu9wlMTY1ogfDMMToN2
 DllCug2iEiq8JIqsCAvTLmMkfOGtsTaY7ynKBk3AlI8QtqTZOkmK+P31NR+pskQ+ga6zqIzu91K
 FD1SBhe4t2mo0OiRIaezbGvHuUHaRR3e89SBJLOju81JOdcI6lrXztwz9Y1f3cqUD3Tu/hQC1uo
 ZoJE9YFyGs9RWKkFkV/4Y7ImhNOZORY6eI85ykK6QkRD+qp+
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

The functions can_update_sample_point() and can_calc_bittiming() are
generic and meant to be used for both the nominal and the data bittiming
calculation.

However, those functions use misleading terminologies such as "bitrate
nominal" or "sample point nominal". Replace all places where the word
"nominal" appears with "reference" in order to better distinguish it from
the calculated values.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 268ec6fa7c49..c8c166b383cd 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -24,7 +24,7 @@
  */
 static int
 can_update_sample_point(const struct can_bittiming_const *btc,
-			const unsigned int sample_point_nominal, const unsigned int tseg,
+			const unsigned int sample_point_reference, const unsigned int tseg,
 			unsigned int *tseg1_ptr, unsigned int *tseg2_ptr,
 			unsigned int *sample_point_error_ptr)
 {
@@ -35,7 +35,7 @@ can_update_sample_point(const struct can_bittiming_const *btc,
 
 	for (i = 0; i <= 1; i++) {
 		tseg2 = tseg + CAN_SYNC_SEG -
-			(sample_point_nominal * (tseg + CAN_SYNC_SEG)) /
+			(sample_point_reference * (tseg + CAN_SYNC_SEG)) /
 			1000 - i;
 		tseg2 = clamp(tseg2, btc->tseg2_min, btc->tseg2_max);
 		tseg1 = tseg - tseg2;
@@ -46,9 +46,9 @@ can_update_sample_point(const struct can_bittiming_const *btc,
 
 		sample_point = 1000 * (tseg + CAN_SYNC_SEG - tseg2) /
 			(tseg + CAN_SYNC_SEG);
-		sample_point_error = abs(sample_point_nominal - sample_point);
+		sample_point_error = abs(sample_point_reference - sample_point);
 
-		if (sample_point <= sample_point_nominal &&
+		if (sample_point <= sample_point_reference &&
 		    sample_point_error < best_sample_point_error) {
 			best_sample_point = sample_point;
 			best_sample_point_error = sample_point_error;
@@ -68,11 +68,11 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 {
 	struct can_priv *priv = netdev_priv(dev);
 	unsigned int bitrate;			/* current bitrate */
-	unsigned int bitrate_error;		/* difference between current and nominal value */
+	unsigned int bitrate_error;		/* diff between calculated and reference value */
 	unsigned int best_bitrate_error = UINT_MAX;
-	unsigned int sample_point_error;	/* difference between current and nominal value */
+	unsigned int sample_point_error;	/* diff between calculated and reference value */
 	unsigned int best_sample_point_error = UINT_MAX;
-	unsigned int sample_point_nominal;	/* nominal sample point */
+	unsigned int sample_point_reference;	/* reference sample point */
 	unsigned int best_tseg = 0;		/* current best value for tseg */
 	unsigned int best_brp = 0;		/* current best value for brp */
 	unsigned int brp, tsegall, tseg, tseg1 = 0, tseg2 = 0;
@@ -81,14 +81,14 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 
 	/* Use CiA recommended sample points */
 	if (bt->sample_point) {
-		sample_point_nominal = bt->sample_point;
+		sample_point_reference = bt->sample_point;
 	} else {
 		if (bt->bitrate > 800 * KILO /* BPS */)
-			sample_point_nominal = 750;
+			sample_point_reference = 750;
 		else if (bt->bitrate > 500 * KILO /* BPS */)
-			sample_point_nominal = 800;
+			sample_point_reference = 800;
 		else
-			sample_point_nominal = 875;
+			sample_point_reference = 875;
 	}
 
 	/* tseg even = round down, odd = round up */
@@ -115,7 +115,7 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		if (bitrate_error < best_bitrate_error)
 			best_sample_point_error = UINT_MAX;
 
-		can_update_sample_point(btc, sample_point_nominal, tseg / 2,
+		can_update_sample_point(btc, sample_point_reference, tseg / 2,
 					&tseg1, &tseg2, &sample_point_error);
 		if (sample_point_error >= best_sample_point_error)
 			continue;
@@ -146,7 +146,7 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	}
 
 	/* real sample point */
-	bt->sample_point = can_update_sample_point(btc, sample_point_nominal,
+	bt->sample_point = can_update_sample_point(btc, sample_point_reference,
 						   best_tseg, &tseg1, &tseg2,
 						   NULL);
 

-- 
2.51.0


