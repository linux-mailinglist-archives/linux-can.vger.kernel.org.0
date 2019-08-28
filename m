Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7937B9FAE2
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 08:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfH1Gwi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 02:52:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51543 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfH1Gwh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 02:52:37 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2roq-0002oO-8L; Wed, 28 Aug 2019 08:52:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 19/21] can: add socket type for CAN_J1939
Date:   Wed, 28 Aug 2019 08:52:24 +0200
Message-Id: <20190828065226.23604-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190828065226.23604-1-mkl@pengutronix.de>
References: <20190828065226.23604-1-mkl@pengutronix.de>
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

From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

This patch is a preparation for SAE J1939 and adds CAN_J1939
socket type.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 0afb7d8e867f..06d92d6be6e6 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -157,7 +157,8 @@ struct canfd_frame {
 #define CAN_TP20	4 /* VAG Transport Protocol v2.0 */
 #define CAN_MCNET	5 /* Bosch MCNet */
 #define CAN_ISOTP	6 /* ISO 15765-2 Transport Protocol */
-#define CAN_NPROTO	7
+#define CAN_J1939	7 /* SAE J1939 */
+#define CAN_NPROTO	8
 
 #define SOL_CAN_BASE 100
 
-- 
2.23.0.rc1

