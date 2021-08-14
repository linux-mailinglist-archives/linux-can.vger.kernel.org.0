Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1F3EC19B
	for <lists+linux-can@lfdr.de>; Sat, 14 Aug 2021 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhHNJUJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 14 Aug 2021 05:20:09 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:48423 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbhHNJUG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 14 Aug 2021 05:20:06 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d19 with ME
        id hMJz250060zjR6y03MKbkn; Sat, 14 Aug 2021 11:19:37 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Aug 2021 11:19:37 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 3/7] can: bittiming: change unit of TDC parameters to clock periods
Date:   Sat, 14 Aug 2021 18:17:46 +0900
Message-Id: <20210814091750.73931-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210814091750.73931-1-mailhol.vincent@wanadoo.fr>
References: <20210814091750.73931-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In the current implementation, all Transmission Delay Compensation
(TDC) parameters are expressed in time quantum. However, ISO 11898-1
actually specifies that these should be expressed in *minimum* time
quantum.

Furthermore, the minimum time quantum is specified to be "one node
clock period long" (c.f. paragraph 11.3.1.1 "Bit time"). For sake of
simplicity, we prefer to use the "clock period" term instead of
"minimum time quantum" because we believe that it is more broadly
understood.

This patch fixes that discrepancy by updating the documentation and
the formula for TDCO calculation.

N.B. In can_calc_tdco(), the sample point (in time quantum) was
calculated using a division, thus introducing a risk of rounding and
truncation errors. On top of changing the unit to clock period, we
also modified the formula to use only additions.

Suggested-by: Stefan Mätje <Stefan.Maetje@esd.eu>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/bittiming.c |  9 +++++----
 include/linux/can/bittiming.h   | 28 +++++++++++++++++-----------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 7dbda411915a..582463bc15f7 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -193,12 +193,13 @@ void can_calc_tdco(struct net_device *dev)
 	 * one or two.
 	 */
 	if (dbt->brp == 1 || dbt->brp == 2) {
-		/* Reuse "normal" sample point and convert it to time quanta */
-		u32 sample_point_in_tq = can_bit_time(dbt) * dbt->sample_point / 1000;
+		/* Sample point in clock periods */
+		u32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
+					  dbt->phase_seg1) * dbt->brp;
 
-		if (sample_point_in_tq < tdc_const->tdco_min)
+		if (sample_point_in_tc < tdc_const->tdco_min)
 			return;
-		tdc->tdco = min(sample_point_in_tq, tdc_const->tdco_max);
+		tdc->tdco = min(sample_point_in_tc, tdc_const->tdco_max);
 		priv->ctrlmode |= CAN_CTRLMODE_TDC_AUTO;
 	}
 }
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 9e20260611cc..aebbe65dab7e 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -31,8 +31,8 @@
  *
  * To solve this issue, ISO 11898-1 introduces in section 11.3.3
  * "Transmitter delay compensation" a SSP (Secondary Sample Point)
- * equal to the distance, in time quanta, from the start of the bit
- * time on the TX pin to the actual measurement on the RX pin.
+ * equal to the distance from the start of the bit time on the TX pin
+ * to the actual measurement on the RX pin.
  *
  * This structure contains the parameters to calculate that SSP.
  *
@@ -44,8 +44,13 @@
  *                           |<------- TDCO ------->|
  *  |<----------- Secondary Sample Point ---------->|
  *
+ * To increase precision, contrary to the other bittiming parameters
+ * which are measured in time quanta, the TDC parameters are measured
+ * in clock periods (also referred as "minimum time quantum" in ISO
+ * 11898-1).
+ *
  * @tdcv: Transmitter Delay Compensation Value. The time needed for
- *	the signal to propagate, i.e. the distance, in time quanta,
+ *	the signal to propagate, i.e. the distance, in clock periods,
  *	from the start of the bit on the TX pin to when it is received
  *	on the RX pin. @tdcv depends on the controller modes:
  *
@@ -62,17 +67,18 @@
  *	TDC is disabled and all the values of this structure should be
  *	ignored.
  *
- * @tdco: Transmitter Delay Compensation Offset. Offset value, in time
- *	quanta, defining the distance between the start of the bit
- *	reception on the RX pin of the transceiver and the SSP
+ * @tdco: Transmitter Delay Compensation Offset. Offset value, in
+ *	clock periods, defining the distance between the start of the
+ *	bit reception on the RX pin of the transceiver and the SSP
  *	position such that SSP = @tdcv + @tdco.
  *
  * @tdcf: Transmitter Delay Compensation Filter window. Defines the
- *	minimum value for the SSP position in time quanta. If the SSP
- *	position is less than @tdcf, then no delay compensations occur
- *	and the normal sampling point is used instead. The feature is
- *	enabled if and only if @tdcv is set to zero (automatic mode)
- *	and @tdcf is configured to a value greater than @tdco.
+ *	minimum value for the SSP position in clock periods. If the
+ *	SSP position is less than @tdcf, then no delay compensations
+ *	occur and the normal sampling point is used instead. The
+ *	feature is enabled if and only if @tdcv is set to zero
+ *	(automatic mode) and @tdcf is configured to a value greater
+ *	than @tdco.
  */
 struct can_tdc {
 	u32 tdcv;
-- 
2.31.1

