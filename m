Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3526E292AA4
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgJSPml (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgJSPmk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 11:42:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71580C0613CE
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 08:42:40 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUXJ0-0000nY-Hy; Mon, 19 Oct 2020 17:42:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Wu Bo <wubo.oduw@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 02/12] can: m_can: m_can_handle_state_change(): fix state change
Date:   Mon, 19 Oct 2020 17:42:23 +0200
Message-Id: <20201019154233.1262589-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019154233.1262589-1-mkl@pengutronix.de>
References: <20201019154233.1262589-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Wu Bo <wubo.oduw@gmail.com>

m_can_handle_state_change() is called with the new_state as an argument.

In the switch statements for CAN_STATE_ERROR_ACTIVE, the comment and the
following code indicate that a CAN_STATE_ERROR_WARNING is handled.

This patch fixes this problem by changing the case to CAN_STATE_ERROR_WARNING.

Signed-off-by: Wu Bo <wubo.oduw@gmail.com>
Link: http://lore.kernel.org/r/20200129022330.21248-2-wubo.oduw@gmail.com
Cc: Dan Murphy <dmurphy@ti.com>
Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 4edc6f6e5165..1b72e6fffb31 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -661,7 +661,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 	unsigned int ecr;
 
 	switch (new_state) {
-	case CAN_STATE_ERROR_ACTIVE:
+	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cdev->can.can_stats.error_warning++;
 		cdev->can.state = CAN_STATE_ERROR_WARNING;
@@ -690,7 +690,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 	__m_can_get_berr_counter(dev, &bec);
 
 	switch (new_state) {
-	case CAN_STATE_ERROR_ACTIVE:
+	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = (bec.txerr > bec.rxerr) ?
-- 
2.28.0

