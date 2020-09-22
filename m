Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C002274487
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIVOoi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIVOoi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C14C061755
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:38 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjX2-0001FU-5l; Tue, 22 Sep 2020 16:44:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/20] can: flexcan: Add check for transceiver maximum bitrate limitation
Date:   Tue, 22 Sep 2020 16:44:17 +0200
Message-Id: <20200922144429.2613631-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922144429.2613631-1-mkl@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

CAN FD can transmit up to 8Mbps, but some transceivers only can support
5Mbps, so add check in driver.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Link: https://lore.kernel.org/r/20191030064245.12923-2-qiangqing.zhang@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 52b53ff223f4..5c6903e23c01 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1674,6 +1674,7 @@ static int flexcan_probe(struct platform_device *pdev)
 		goto failed_register;
 	}
 
+	of_can_transceiver(dev);
 	devm_can_led_init(dev);
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
-- 
2.28.0

