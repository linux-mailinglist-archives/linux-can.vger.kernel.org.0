Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E535C48A458
	for <lists+linux-can@lfdr.de>; Tue, 11 Jan 2022 01:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiAKAXp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jan 2022 19:23:45 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbiAKAXm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jan 2022 19:23:42 -0500
Received: from localhost.localdomain ([81.154.153.55]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.99]) with ESMTPSA (Nemesis) id
 1MI5Dj-1nBFYi10gJ-00FFrK; Tue, 11 Jan 2022 01:23:39 +0100
From:   Phil Greenland <phil@quantulum.co.uk>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH 3/3] can: mcp251xfd: wake-on-can
Date:   Tue, 11 Jan 2022 00:21:13 +0000
Message-Id: <20220111002109.927308-4-phil@quantulum.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111002109.927308-1-phil@quantulum.co.uk>
References: <20220111002109.927308-1-phil@quantulum.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z5aPOoNRdkVx2KjwvWe/Bj/WuS6/YYn1lf+AHrYHllMe0gXiSDX
 m/2fOeEL2BDgI8QpeuLaN9Wz5vL0pkjyGkhs1wqNeXCdA5G0yhgQOEalvboTVPeL1xQVO24
 miuQmLbWvmEmr3P58m1d83b6/QD2xyiQULooJNoY9x6eUQ9gnNicDDZYeIzTv4sGmZX1OYn
 RVVQplX3Va4HHOZBQHhOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZuvXMTYMS2A=:UMLnuFGkaDIdITXj7RlYb1
 eSyZ9L7pClhZ2s+0BqxE/M2RulgkVyprWghkd7Fv+ltzAj8neIz+I0hH7aNTsQ8u4KP0/WNrT
 mqo8Y24pURCDn5nEKbK+5hkuZLRJLENhiBG5XBws0P3lR8QKkScPWUgkDgiqA8Xtj8+pnfId0
 kCNn6LxRsXU7U4yyr0Ihxr7oJ11H7Rr7dhjzChnK6sjvhiGFJ/s+wAp+5xkFliQte9X3mvQ99
 zKSlh9L3Imrp6GzosrflwCjAv6RXecihzXgGR9S5MjUndMFOfDRI15qi396YHeaIOpV/F5FDK
 ldHZ4ZxjZTge9x4fOSvUVBoAk8tsS6T93o4Tj6BvmUefOV4gcTG8V/3VnsEiBSlJJZqE0v8Fw
 2+mT0GC+yJjLooJxp49xuhY8vQXc7qnixtxPXnNxv/O1mDvGsU5gBEsXS1sajcycpz6oY7P8U
 /yFBGilxMnX9a90UWPCJwpuefdcEHl5uP9nsHFslsAoKhXs2pk9boQxxpIBbEny64lBIF+ePY
 r1aYcXgZkKKeyFOirqGlcG5Zltca4PU0W9qiA2MkxCjxYxY3rQ56WYienbq3+uiwoM5Sr+TM8
 9pJZ4Z56kVYb2s+nqYBPLpc42tJbxUbj0MyeJq2nRNUGaDd277fVKz3lNpfCGIWheDWH80UPp
 pNA+lNJ4kANr2hFZ9+VwnO425aP60BMVkDookddxkiIfK8Fi+0XzxkdUmXOvh1T/vddLbEB2d
 znLyMaPQhGQtZ21R
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Made driver wakeup capable, building on suspend and resume handlers. When suspending if wakeup is enabled for the device, its interrupt is flagged for wakeup and the wake interrupt is enabled before the controller is placed into sleep mode.

This appears to work well if the system is allowed to fully enter sleep before a wakeup message arrives. Performed many suspend / resume cycles via can message. Initially very encouraging.

However if the system is suspended while there's traffic on the bus. Tested with 200 msgs/s from another machine. A race condition is exposed. If enabled for wakeup I would expect the controller to either cause the system to abort the suspend process, or suspend and immediately wake up. What happens instead is the system enters suspend and remains there until woken by another source.

Having had a poke around I suspect this is related to placing the controller in sleep mode in the suspend, rather than suspend_noirq stage handler.
When a wake interrupt is registered via enable_irq_wake, after all devices have had suspend called. The wake interrupts are "armed".
Once armed the noirq handlers are called, where the docs hinted that the device should be configured to wake.
It seems that as part of handing an interrupt, irq_may_run is called, which in turn calls irq_pm_check_wakeup, which if the irq is wake enabled will wake the system.
I'd guess that the controller enters suspend and immediately wakes, generating the WAKE interrupt. As interrupts are disabled at the start of suspend (to prevent the handler running after the SPI controller has been suspended) the interrupt doesn't schedule the system to wake as the interrupt isn't "armed" yet. But is somehow marked as pending and isn't re-evaluated after the system finishes suspending.
Unfortunately I don't know all that much about the inner workings of interrupt handling within the kernel.

Let me know what you think / if you're able to give me any pointers of how to solve this one?

Signed-off-by: Phil Greenland <phil@quantulum.co.uk>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 98eb597d8..bbe7bed9e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1072,6 +1072,12 @@ static int mcp251xfd_chip_interrupts_enable(const struct mcp251xfd_priv *priv)
 	return regmap_write(priv->map_reg, MCP251XFD_REG_INT, val);
 }
 
+static int mcp251xfd_chip_interrupts_enable_suspend(const struct mcp251xfd_priv *priv)
+{
+	/* Enable only WAKE interrupt */
+	return regmap_write(priv->map_reg, MCP251XFD_REG_INT, MCP251XFD_REG_INT_WAKIE);
+}
+
 static int mcp251xfd_chip_interrupts_disable(const struct mcp251xfd_priv *priv)
 {
 	int err;
@@ -2814,6 +2820,11 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_set_mode_sleep;
 
+	device_set_wakeup_capable(&ndev->dev, true);
+
+	if (device_property_read_bool(&ndev->dev, "wakeup-source"))
+		device_set_wakeup_enable(&ndev->dev, true);
+
 	err = mcp251xfd_register_done(priv);
 	if (err)
 		goto out_unregister_candev;
@@ -2851,6 +2862,8 @@ static inline void mcp251xfd_unregister(struct mcp251xfd_priv *priv)
 
 	pm_runtime_get_sync(ndev->dev.parent);
 	pm_runtime_put_noidle(ndev->dev.parent);
+	device_set_wakeup_enable(&ndev->dev, false);
+	device_set_wakeup_capable(&ndev->dev, false);
 	mcp251xfd_clks_and_vdd_disable(priv);
 	pm_runtime_disable(ndev->dev.parent);
 }
@@ -3074,9 +3087,22 @@ static int __maybe_unused mcp251xfd_suspend(struct device *device)
 
 	mcp251xfd_timestamp_stop(priv);
 
-	err = mcp251xfd_chip_interrupts_disable(priv);
-	if (err)
-		return err;
+	if (device_may_wakeup(&priv->ndev->dev)) {
+		/* Device may wake system from sleep, enable wake on irq */
+		err = enable_irq_wake(priv->ndev->irq);
+		if (err)
+			return err;
+
+		/* Enable (only) wake interrupt */
+		err = mcp251xfd_chip_interrupts_enable_suspend(priv);
+		if (err)
+			return err;
+	} else {
+		/* Device not waking system from sleep, disable all interrupts */
+		err = mcp251xfd_chip_interrupts_disable(priv);
+		if (err)
+			return err;
+	}
 
 	err = mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
 	if (err)
@@ -3100,6 +3126,12 @@ static int __maybe_unused mcp251xfd_resume(struct device *device)
 	netif_device_attach(priv->ndev);
 	netif_start_queue(priv->ndev);
 
+	if (device_may_wakeup(&priv->ndev->dev)) {
+		err = disable_irq_wake(priv->ndev->irq);
+		if (err)
+			return err;
+	}
+
 	/* restart oscillator (disabled automatically when entering sleep) */
 	err = mcp251xfd_chip_clock_enable(priv);
 	if (err)
-- 
2.25.1

