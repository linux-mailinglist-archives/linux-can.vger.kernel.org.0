Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28F13A9A9F
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFPMnX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 08:43:23 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:44495 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFPMnX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 08:43:23 -0400
Received: from localhost.localdomain ([114.149.34.46])
        by mwinf5d50 with ME
        id Hoh22500M0zjR6y03ohCBC; Wed, 16 Jun 2021 14:41:14 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 16 Jun 2021 14:41:14 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: bittiming: fix two grammar mistakes in documentation for struct can_tdc
Date:   Wed, 16 Jun 2021 21:40:57 +0900
Message-Id: <20210616124057.60723-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes two grammar errors in the documentation for struct
can_tdc.

First grammar error: add a missing third person 's'.

Second grammar error: replace "such as" by "such that". The intent is
to give a condition, not an example.

Fixes: 289ea9e4ae59 ("can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Marc,

If that makes sense to you, feel free to squash this in your other
patch.
---
 include/linux/can/bittiming.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index d61d8716345e..9de6e9053e34 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -37,7 +37,7 @@
  *	quanta, from when the bit is sent on the TX pin to when it is
  *	received on the RX pin of the transmitter. Possible options:
  *
- *	  0: automatic mode. The controller dynamically measure @tdcv
+ *	  0: automatic mode. The controller dynamically measures @tdcv
  *	  for each transmitted CAN FD frame.
  *
  *	  Other values: manual mode. Use the fixed provided value.
@@ -45,7 +45,7 @@
  * @tdco: Transmitter Delay Compensation Offset. Offset value, in time
  *	quanta, defining the distance between the start of the bit
  *	reception on the RX pin of the transceiver and the SSP
- *	position such as SSP = @tdcv + @tdco.
+ *	position such that SSP = @tdcv + @tdco.
  *
  *	If @tdco is zero, then TDC is disabled and both @tdcv and
  *	@tdcf should be ignored.
-- 
2.31.1

