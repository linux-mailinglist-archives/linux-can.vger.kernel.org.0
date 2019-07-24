Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1E72F78
	for <lists+linux-can@lfdr.de>; Wed, 24 Jul 2019 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfGXNDo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Jul 2019 09:03:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45735 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfGXNDa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jul 2019 09:03:30 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hqGvW-0006gK-67; Wed, 24 Jul 2019 15:03:26 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        linux-stable <stable@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/7] can: rcar_canfd: fix possible IRQ storm on high load
Date:   Wed, 24 Jul 2019 15:03:17 +0200
Message-Id: <20190724130322.31702-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724130322.31702-1-mkl@pengutronix.de>
References: <20190724130322.31702-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

We have observed rcar_canfd driver entering IRQ storm under high load,
with following scenario:
- rcar_canfd_global_interrupt() in entered due to Rx available,
- napi_schedule_prep() is called, and sets NAPIF_STATE_SCHED in state
- Rx fifo interrupts are masked,
- rcar_canfd_global_interrupt() is entered again, this time due to
  error interrupt (e.g. due to overflow),
- since scheduled napi poller has not yet executed, condition for calling
  napi_schedule_prep() from rcar_canfd_global_interrupt() remains true,
  thus napi_schedule_prep() gets called and sets NAPIF_STATE_MISSED flag
  in state,
- later, napi poller function rcar_canfd_rx_poll() gets executed, and
  calls napi_complete_done(),
- due to NAPIF_STATE_MISSED flag in state, this call does not clear
  NAPIF_STATE_SCHED flag from state,
- on return from napi_complete_done(), rcar_canfd_rx_poll() unmasks Rx
  interrutps,
- Rx interrupt happens, rcar_canfd_global_interrupt() gets called
  and calls napi_schedule_prep(),
- since NAPIF_STATE_SCHED is set in state at this time, this call
  returns false,
- due to that false return, rcar_canfd_global_interrupt() returns
  without masking Rx interrupt
- and this results into IRQ storm: unmasked Rx interrupt happens again
  and again is misprocessed in the same way.

This patch fixes that scenario by unmasking Rx interrupts only when
napi_complete_done() returns true, which means it has cleared
NAPIF_STATE_SCHED in state.

Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 05410008aa6b..de34a4b82d4a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1508,10 +1508,11 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 
 	/* All packets processed */
 	if (num_pkts < quota) {
-		napi_complete_done(napi, num_pkts);
-		/* Enable Rx FIFO interrupts */
-		rcar_canfd_set_bit(priv->base, RCANFD_RFCC(ridx),
-				   RCANFD_RFCC_RFIE);
+		if (napi_complete_done(napi, num_pkts)) {
+			/* Enable Rx FIFO interrupts */
+			rcar_canfd_set_bit(priv->base, RCANFD_RFCC(ridx),
+					   RCANFD_RFCC_RFIE);
+		}
 	}
 	return num_pkts;
 }
-- 
2.20.1

