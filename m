Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E1322EC3
	for <lists+linux-can@lfdr.de>; Tue, 23 Feb 2021 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhBWQcA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 11:32:00 -0500
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:58625 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBWQb7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 11:31:59 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d21 with ME
        id YgW92400H3PnFJp03gWDZK; Tue, 23 Feb 2021 17:30:16 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 Feb 2021 17:30:16 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 1/5] can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)
Date:   Wed, 24 Feb 2021 01:28:48 +0900
Message-Id: <20210223162852.218041-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
References: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

At high bit rates, the propagation delay from the TX pin to the RX pin
of the transceiver causes measurement errors: the sample point on the
RX pin might occur on the previous bit.

This issue is addressed in ISO 11898-1 section 11.3.3 "Transmitter
delay compensation" (TDC).

This patch adds two new structures: can_tdc and can_tdc_const in order
to implement this TDC.

The structures are then added to can_priv.

A controller supports TDC if an only if can_priv::tdc_const is not
NULL. TDC is active if and only if can_priv::tdc.tdco is not zero.  No
new controller modes are introduced (i.e. no CAN_CTRL_MODE_TDC) in
order not to be redundant with above logic.

The names of the parameters are chosen to match existing CAN
controllers specification. References:
  - Bosch C_CAN FD8:
https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/users_manual_c_can_fd8_r210_1.pdf
  - Microchip CAN FD Controller Module:
http://ww1.microchip.com/downloads/en/DeviceDoc/MCP251XXFD-CAN-FD-Controller-Module-Family-Reference-Manual-20005678B.pdf
  - SAM E701/S70/V70/V71 Family:
https://www.mouser.com/datasheet/2/268/60001527A-1284321.pdf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/can/bittiming.h | 65 +++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h       |  3 ++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 707575c668f4..91bf9f8926a7 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright (c) 2020 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+ * Copyright (c) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef _CAN_BITTIMING_H
@@ -10,6 +11,70 @@
 
 #define CAN_SYNC_SEG 1
 
+/*
+ * struct can_tdc - CAN FD Transmission Delay Compensation parameters
+ *
+ * At high bit rates, the propagation delay from the TX pin to the RX
+ * pin of the transceiver causes measurement errors: the sample point
+ * on the RX pin might occur on the previous bit.
+ *
+ * To solve this issue, ISO 11898-1 introduces in section 11.3.3
+ * "Transmitter delay compensation" a SSP (Secondary Sample Point)
+ * equal to the distance, in time quanta, from the start of the bit
+ * time on the TX pin to the actual measurement on the RX pin.
+ *
+ * This structure contains the parameters to calculate that SSP.
+ *
+ * @tdcv: Transmitter Delay Compensation Value. Distance, in time
+ *	quanta, from when the bit is sent on the TX pin to when it is
+ *	received on the RX pin of the transmitter. Possible options:
+ *
+ *	  O: automatic mode. The controller dynamically measure @tdcv
+ *	  for each transmited CAN FD frame.
+ *
+ *	  Other values: manual mode. Use the fixed provided value.
+ *
+ * @tdco: Transmitter Delay Compensation Offset. Offset value, in time
+ *	quanta, defining the distance between the start of the bit
+ *	reception on the RX pin of the transceiver and the SSP
+ *	position such as SSP = @tdcv + @tdco.
+ *
+ *	If @tdco is zero, then TDC is disabled and both @tdcv and
+ *	@tdcf should be ignored.
+ *
+ * @tdcf: Transmitter Delay Compensation Filter window. Defines the
+ *	minimum value for the SSP position in time quanta. If SSP is
+ *	less than @tdcf, then no delay compensations occur and the
+ *	normal sampling point is used instead. The feature is enabled
+ *	if and only if @tdcv is set to zero (automatic mode) and @tdcf
+ *	is configured to a value greater than @tdco.
+ */
+struct can_tdc {
+	u32 tdcv;
+	u32 tdco;
+	u32 tdcf;
+};
+
+/*
+ * struct can_tdc_const - CAN hardware-dependent constant for
+ *	Transmission Delay Compensation
+ *
+ * @tdcv_max: Transmitter Delay Compensation Value maximum value.
+ *	Should be set to zero if the controller does not support
+ *	manual mode for tdcv.
+ * @tdco_max: Transmitter Delay Compensation Offset maximum value.
+ *	Should not be zero. If the controller does not support TDC,
+ *	then the pointer to this structure should be NULL.
+ * @tdcf_max: Transmitter Delay Compensation Filter window maximum
+ *	value. Should be set to zero if the controller does not
+ *	support this feature.
+ */
+struct can_tdc_const {
+	u32 tdcv_max;
+	u32 tdco_max;
+	u32 tdcf_max;
+};
+
 #ifdef CONFIG_CAN_CALC_BITTIMING
 int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
 		       const struct can_bittiming_const *btc);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index ac4d83a1ab81..4795da0eb949 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -42,6 +42,9 @@ struct can_priv {
 	struct can_bittiming bittiming, data_bittiming;
 	const struct can_bittiming_const *bittiming_const,
 		*data_bittiming_const;
+	struct can_tdc tdc;
+	const struct can_tdc_const *tdc_const;
+
 	const u16 *termination_const;
 	unsigned int termination_const_cnt;
 	u16 termination;
-- 
2.26.2

