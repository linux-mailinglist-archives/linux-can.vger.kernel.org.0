Return-Path: <linux-can+bounces-5298-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A2BC2981A
	for <lists+linux-can@lfdr.de>; Sun, 02 Nov 2025 23:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75503A41E3
	for <lists+linux-can@lfdr.de>; Sun,  2 Nov 2025 22:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79C24DCE6;
	Sun,  2 Nov 2025 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQIdkl0s"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CBF24BD04;
	Sun,  2 Nov 2025 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762120948; cv=none; b=PlH3PWZQPWGV4AvA+0EdnXPBz675NuzRASrc7rPavuxyh78SCah1w+UY3HEMdJvkwUvVsn41BulytBOzCmictjtG6QSp4GpMM0s+k2vy2fpYLeQgMSx/YD5lGghVdXWLQqa24LmprwA5Um+7QLaBNviqG6d3e2Lj+1Akr8C4H4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762120948; c=relaxed/simple;
	bh=iwfVHvGnDcHWXBErKl2dZ5emFhyZ5/kSEItrfe34yyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uBGX0LKFDbh/CZP+y0+e0+0p0NgvqMTKNHongUCR4uOmh1VfKbCDZYVHE2+PUHSzaqXXa02k6UvXq1ewaa4rbIYlgErpo1hBnQoMQ5Mp6pvKmOSVBCpHgPYlmU6BwpYoE7mnHVCgSCjLT1oU6WIFq/JlbWVXK8MqFnpYPoG8wuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQIdkl0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2838CC116C6;
	Sun,  2 Nov 2025 22:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762120947;
	bh=iwfVHvGnDcHWXBErKl2dZ5emFhyZ5/kSEItrfe34yyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fQIdkl0smLbCYUAMfjMuQeQnrR1XB2jHvzecA0jUNvhwrdDegJ4P0C63bhScwshNh
	 G+mI0DFYaFErR0XXkTRz3xJjsY/b6jxWxYNcibWCrJSCz/sxO8T5bxvj0WbGz61Iah
	 aKl7i5rfC8BCwQ7j87LQoCtGywSel77fnCyLXGiy6zNBfRZTDP0flNKgMI6WVK4d4w
	 XFYvdWR/EBjXFBseu/AEs0/rfcs9YhkBwXHcM2aaXte8lW9E+xLKuVjRKYssi2mVRi
	 W4AToxEoU+GM5sqLADbWXPPgqutCLlLifJMPBwEJKUKavykPmZDP/XuknT9tZtfKvh
	 KeJueDHqGfLhA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sun, 02 Nov 2025 23:01:23 +0100
Subject: [PATCH RFC 2/3] can: calc_bittiming: add
 can_calc_sample_point_nrz()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-pwm_sample_point-v1-2-3bbea180f59e@kernel.org>
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
In-Reply-To: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=iwfVHvGnDcHWXBErKl2dZ5emFhyZ5/kSEItrfe34yyY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnsV14IGpbXSlTx623jy70tM8czUF6Bde4sqQMBUx8Y3
 pO65hTeUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCIFBYwM0w7/WbL5yzX7lQaR
 HO/+WnE55had5FJlkf9wamqKVG/aV0aGH84VT99++bdCfJvKDMGIyuWM3KvX3JezXLNihsenaM9
 NvAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

CAN XL optimal sample point for PWM encoding (when TMS is on) differs
from the NRZ optimal one. There is thus a need to calculate a
different sample point depending whether TMS is on or off.

This is a preparation change: move the sample point calculation from
can_calc_bittiming() into the new can_calc_sample_point_nrz()
function.

In an upcoming change, a function will be added to calculate the
sample point for PWM encoding.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/calc_bittiming.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 222117596704..9b2d0e458518 100644
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
@@ -78,17 +90,10 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	u64 v64;
 	int err;
 
-	/* Use CiA recommended sample points */
-	if (bt->sample_point) {
+	if (bt->sample_point)
 		sample_point = bt->sample_point;
-	} else {
-		if (bt->bitrate > 800 * KILO /* BPS */)
-			sample_point = 750;
-		else if (bt->bitrate > 500 * KILO /* BPS */)
-			sample_point = 800;
-		else
-			sample_point = 875;
-	}
+	else
+		sample_point = can_calc_sample_point_nrz(bt);
 
 	/* tseg even = round down, odd = round up */
 	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;

-- 
2.51.0


