Return-Path: <linux-can+bounces-5299-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9020C29814
	for <lists+linux-can@lfdr.de>; Sun, 02 Nov 2025 23:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 616BF347094
	for <lists+linux-can@lfdr.de>; Sun,  2 Nov 2025 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02525484B;
	Sun,  2 Nov 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMWbf1++"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6C238D52;
	Sun,  2 Nov 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762120950; cv=none; b=cW4s82nK1FJ0yDjyLt/o+rC7bXLUHXo4Q1tV+0/5RvaF5AAFMN++RlzLrrMTbx7p4tBIfdPHK+TaWak7vBvZ+kbt5RDxJ398uJDZ2q/oFlufD/uI+XV6xOSpV4kYcqBMVVukDMULslQMYu3d4HjCUSuJu5TxzN2DKl81yavsTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762120950; c=relaxed/simple;
	bh=XO1jxK3wpk3B6QjmDfGFENG9FHZAlijBivkjQ2ozt0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHJXnFX/zeMb3HPBsjZqxJ+5QgW1djlDHaDGDRs6Zmaf8MJHnBJx/qA0zcYzdS6V5c+GrayeXaaw2ULof+JSfJC0al5p8oPvfcbLALvD+vwGIQ2baExb+eVxFJWo6snq9cqwAfD7tQxESrEAHBXzKPzkXtZoN6ZkQnBjm+n/q2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMWbf1++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337B0C4CEF7;
	Sun,  2 Nov 2025 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762120949;
	bh=XO1jxK3wpk3B6QjmDfGFENG9FHZAlijBivkjQ2ozt0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vMWbf1++15n+uIQxaFdYe35bpBijFwfYQ7ZdgiTPJYpb4z9tGNaqagmNaxLB04aa9
	 rZTS+6Jitw5ELb+50P+Z+20Ay5QcnNBt1jaNQEaE+ZbZtQ7YEUmSw9S3cgqPB+C7DJ
	 o0ULcC0eYZQOM+O4lF6ud7Wr8Yh6PLaygSUH49dEG/rp4JmMS3tuBKq5P/i1+q8N2o
	 irJhbcSYIfMlsZ1/y1324wNRNIEsNZWvJkQw+in92zAEnpzJpSnaVTF+brPXRPwGZW
	 mvIQtS0Dcv2U5ubRThJ9qtHtgcYQZvQjgD7f1OOWYwapk0MfhfI+mHQRCJQu/2ro85
	 Rhm/zynmr2itw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sun, 02 Nov 2025 23:01:24 +0100
Subject: [PATCH RFC 3/3] can: calc_bittiming: add
 can_calc_sample_point_pwm()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-pwm_sample_point-v1-3-3bbea180f59e@kernel.org>
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
In-Reply-To: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3006; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=XO1jxK3wpk3B6QjmDfGFENG9FHZAlijBivkjQ2ozt0Y=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnsV17fnCorNXd26c/dEr4HeBNzxYrXrxa1nsUS0ZE15
 ZJfN093RykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgImE5TMynNafntm+ZJ7DNk3J
 SUqzyg5I/exM9N4w+8+5hu1lEa/snzD8s376IvZW5LL++A/Vp6R/aPI4ePZevCp64W1otNLLSnY
 NdgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The optimum sample point value depends on the bit symmetry. The more
asymmetric the bit is, the more the sample point would be located
towards the end of the bit. On the contrary, if the transceiver only
has a small asymmetry, the optimal sample point would be slightly
after the centre of the bit.

For NRZ encoding (used by Classical CAN, CAN FD and CAN XL with TMS
off), the optimum sample points values are above 70% as implemented in
can_calc_sample_point_nrz().

When TMS is on, CAN XL optimum sample points are near to 50% or
60% [1]. Add can_calc_sample_point_pwm() which returns a sample point
which is suitable for PWM encoding. We crafted the formula to make it
return the same values as below table (source: table 3 of [1]).

       Bit rate (Mbits/s)	Sample point
       -------------------------------------
         2.0			 51.3%
         5.0			 53.1%
         8.0			 55.0%
        10.0			 56.3%
        12.3			 53.8%
        13.3			 58.3%
        14.5			 54.5%
        16.0			 60.0%
        17.7			 55.6%
        20.0			 62.5%

The calculation simply consists of setting a slightly too high sample
point and then letting can_update_sample_point() correct the values.

For now, it is just a formula up our sleeves which matches the
empirical observations of [1]. Once CiA recommendations become
available, can_calc_sample_point_pwm() should be updated accordingly.

[1] CAN XL system design: Clock tolerances and edge deviations edge
    deviations
Link: https://www.can-cia.org/fileadmin/cia/documents/publications/cnlm/december_2024/cnlm_24-4_p18_can_xl_system_design_clock_tolerances_and_edge_deviations_dr_arthur_mutter_bosch.pdf

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/calc_bittiming.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 9b2d0e458518..be6726dcd7e7 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -22,6 +22,21 @@ static int can_calc_sample_point_nrz(const struct can_bittiming *bt)
 	return 875;
 }
 
+/* Sample points for Pulse-Width Modulation encoding. */
+static int can_calc_sample_point_pwm(const struct can_bittiming *bt)
+{
+	if (bt->bitrate > 15 * MEGA /* BPS */)
+		return 625;
+
+	if (bt->bitrate > 9 * MEGA /* BPS */)
+		return 600;
+
+	if (bt->bitrate > 4 * MEGA /* BPS */)
+		return 560;
+
+	return 520;
+}
+
 /* Bit-timing calculation derived from:
  *
  * Code based on LinCAN sources and H8S2638 project
@@ -92,6 +107,10 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 
 	if (bt->sample_point)
 		sample_point = bt->sample_point;
+
+	else if (btc == priv->xl.data_bittiming_const &&
+		 (priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+		sample_point = can_calc_sample_point_pwm(bt);
 	else
 		sample_point = can_calc_sample_point_nrz(bt);
 

-- 
2.51.0


