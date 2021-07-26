Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA543D5B26
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhGZNcO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbhGZNbl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 09:31:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BFC0617A5
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 07:12:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m81Kx-00017g-45
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 16:12:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4C10A6581CC
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 14:11:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id DB07A65816E;
        Mon, 26 Jul 2021 14:11:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0850c8b5;
        Mon, 26 Jul 2021 14:11:45 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH net-next 10/46] can: bittiming: fix documentation for struct can_tdc
Date:   Mon, 26 Jul 2021 16:11:08 +0200
Message-Id: <20210726141144.862529-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726141144.862529-1-mkl@pengutronix.de>
References: <20210726141144.862529-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes a typo in the documentation for struct can_tdc::tdcv.
The number "0" refers to automatic mode not the letter "O".

Further two grammar errors in the documentation for struct can_tdc are
fixed.

First grammar error: add a missing third person 's'.

Second grammar error: replace "such as" by "such that". The intent is
to give a condition, not an example.

Fixes: 289ea9e4ae59 ("can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)")
Link: https://lore.kernel.org/r/20210616095922.2430415-1-mkl@pengutronix.de
Link: https://lore.kernel.org/r/20210616124057.60723-1-mailhol.vincent@wanadoo.fr
Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/bittiming.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index ae7a3411167c..9de6e9053e34 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -37,7 +37,7 @@
  *	quanta, from when the bit is sent on the TX pin to when it is
  *	received on the RX pin of the transmitter. Possible options:
  *
- *	  O: automatic mode. The controller dynamically measure @tdcv
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
2.30.2


