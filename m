Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935CB3B64E5
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhF1PRb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:17:31 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:24279 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbhF1PP0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:15:26 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id NfCP250070zjR6y03fCylx; Mon, 28 Jun 2021 17:13:00 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:13:00 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 3/4] can: dev: add can_tdc_get_relative_tdco() helper function
Date:   Tue, 29 Jun 2021 00:06:06 +0900
Message-Id: <20210628150607.1128574-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628150607.1128574-1-mailhol.vincent@wanadoo.fr>
References: <20210628150607.1128574-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

struct can_tdc::tdco represents the absolute offset from TDCV. Some
controllers use instead an offset relative to the Sample Point (SP)
such that:
| SSP = TDCV + absolute TDCO
|     = TDCV + SP + relative TDCO

Consequently:
| relative TDCO = absolute TDCO - SP

The function can_tdc_get_relative_tdco() allow to retrieve this
relative TDCO value.

CC: Stefan Mätje <Stefan.Maetje@esd.eu>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/can/dev.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0be982fd22fb..c912d8e92a41 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -93,6 +93,34 @@ static inline bool can_tdc_is_enabled(const struct can_priv *priv)
 	return !!(priv->ctrlmode & CAN_CTRLMODE_TDC_MASK);
 }
 
+/*
+ * can_tdc_get_relative_tdco() - TDCO relative to the sample point
+ *
+ * struct can_tdc::tdco represents the absolute offset from TDCV. Some
+ * controllers use instead an offset relative to the Sample Point (SP)
+ * such that:
+ *
+ * SSP = TDCV + absolute TDCO
+ *     = TDCV + SP + relative TDCO
+ *
+ * -+----------- one bit ----------+-- TX pin
+ *  |<--- Sample Point --->|
+ *
+ *                         --+----------- one bit ----------+-- RX pin
+ *  |<-------- TDCV -------->|
+ *                           |<------------------------>| absolute TDCO
+ *                           |<--- Sample Point --->|
+ *                           |                      |<->| relative TDCO
+ *  |<------------- Secondary Sample Point ------------>|
+ */
+static inline s32 can_tdc_get_relative_tdco(const struct can_priv *priv)
+{
+	const struct can_bittiming *dbt = &priv->data_bittiming;
+	s32 sample_point_in_tq = can_bit_time(dbt) * dbt->sample_point / 1000;
+
+	return (s32)priv->tdc.tdco - sample_point_in_tq;
+}
+
 /* helper to define static CAN controller features at device creation time */
 static inline void can_set_static_ctrlmode(struct net_device *dev,
 					   u32 static_mode)
-- 
2.31.1

