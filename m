Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD4299D00
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 01:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbgJ0ACw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Oct 2020 20:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411048AbgJZX4N (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 26 Oct 2020 19:56:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6440F20B1F;
        Mon, 26 Oct 2020 23:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756570;
        bh=OpIFis7+wh8rI++WHbem2rOCrI9SOsDtNkCi7Absdqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCkrmFkPsF2NCc3x/uzv2DwMzauekmMdYf68eDNjsnn3ywAwDyqx53vDGhuKgBcE7
         +VLD5/OTt6Eh/tW5wchFImIW4xq2c9RZBGeYMqJkOaSSw6/A5HbDHJ1WWFDQn5IsFq
         7adLsMBDwUlX1ArtgyGgS8zuLARcdSJFzfGsq/Ck=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 44/80] can: flexcan: disable clocks during stop mode
Date:   Mon, 26 Oct 2020 19:54:40 -0400
Message-Id: <20201026235516.1025100-44-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235516.1025100-1-sashal@kernel.org>
References: <20201026235516.1025100-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

[ Upstream commit 02f71c6605e1f8259c07f16178330db766189a74 ]

Disable clocks while CAN core is in stop mode.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Link: https://lore.kernel.org/r/20191210085721.9853-2-qiangqing.zhang@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e5c207ad3c77d..ae05ed57211df 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1681,8 +1681,6 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 			err = flexcan_chip_disable(priv);
 			if (err)
 				return err;
-
-			err = pm_runtime_force_suspend(device);
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
@@ -1708,10 +1706,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			if (err)
 				return err;
 		} else {
-			err = pm_runtime_force_resume(device);
-			if (err)
-				return err;
-
 			err = flexcan_chip_enable(priv);
 		}
 	}
@@ -1742,8 +1736,16 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 	struct net_device *dev = dev_get_drvdata(device);
 	struct flexcan_priv *priv = netdev_priv(dev);
 
-	if (netif_running(dev) && device_may_wakeup(device))
-		flexcan_enable_wakeup_irq(priv, true);
+	if (netif_running(dev)) {
+		int err;
+
+		if (device_may_wakeup(device))
+			flexcan_enable_wakeup_irq(priv, true);
+
+		err = pm_runtime_force_suspend(device);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
@@ -1753,8 +1755,16 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 	struct net_device *dev = dev_get_drvdata(device);
 	struct flexcan_priv *priv = netdev_priv(dev);
 
-	if (netif_running(dev) && device_may_wakeup(device))
-		flexcan_enable_wakeup_irq(priv, false);
+	if (netif_running(dev)) {
+		int err;
+
+		err = pm_runtime_force_resume(device);
+		if (err)
+			return err;
+
+		if (device_may_wakeup(device))
+			flexcan_enable_wakeup_irq(priv, false);
+	}
 
 	return 0;
 }
-- 
2.25.1

