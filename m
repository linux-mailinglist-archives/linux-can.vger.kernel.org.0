Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929DC2B3744
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 18:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgKORlq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 12:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgKORlp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 12:41:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30ABC0613D1
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 09:41:45 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1keM20-0005uQ-JT; Sun, 15 Nov 2020 18:41:40 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Zhang Qilong <zhangqilong3@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 08/15] can: flexcan: fix failure handling of pm_runtime_get_sync()
Date:   Sun, 15 Nov 2020 18:41:24 +0100
Message-Id: <20201115174131.2089251-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115174131.2089251-1-mkl@pengutronix.de>
References: <20201115174131.2089251-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Zhang Qilong <zhangqilong3@huawei.com>

pm_runtime_get_sync() will increment pm usage at first and it will resume the
device later. If runtime of the device has error or device is in inaccessible
state(or other error state), resume operation will fail. If we do not call put
operation to decrease the reference, it will result in reference leak in the
two functions flexcan_get_berr_counter() and flexcan_open().

Moreover, this device cannot enter the idle state and always stay busy or other
non-idle state later. So we should fix it through adding
pm_runtime_put_noidle().

Fixes: ca10989632d88 ("can: flexcan: implement can Runtime PM")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Link: https://lore.kernel.org/r/20201108083000.2599705-1-zhangqilong3@huawei.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4e8fdb6064bd..d6a9cf0e9b60 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -728,8 +728,10 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
 	int err;
 
 	err = pm_runtime_get_sync(priv->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_noidle(priv->dev);
 		return err;
+	}
 
 	err = __flexcan_get_berr_counter(dev, bec);
 
@@ -1654,8 +1656,10 @@ static int flexcan_open(struct net_device *dev)
 	}
 
 	err = pm_runtime_get_sync(priv->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_noidle(priv->dev);
 		return err;
+	}
 
 	err = open_candev(dev);
 	if (err)
-- 
2.29.2

