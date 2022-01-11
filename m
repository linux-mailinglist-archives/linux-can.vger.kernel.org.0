Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBEA48A450
	for <lists+linux-can@lfdr.de>; Tue, 11 Jan 2022 01:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345891AbiAKAXe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jan 2022 19:23:34 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345880AbiAKAXd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jan 2022 19:23:33 -0500
Received: from localhost.localdomain ([81.154.153.55]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.99]) with ESMTPSA (Nemesis) id
 1Ma1kC-1msl6M2sB2-00VxWv; Tue, 11 Jan 2022 01:23:30 +0100
From:   Phil Greenland <phil@quantulum.co.uk>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH 2/3] can: mcp251xfd: suspend and resume handlers
Date:   Tue, 11 Jan 2022 00:21:11 +0000
Message-Id: <20220111002109.927308-3-phil@quantulum.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111002109.927308-1-phil@quantulum.co.uk>
References: <20220111002109.927308-1-phil@quantulum.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pJZ2tgeJG3nJ9aac3RLwtU2SMeGkqoZlVl8ry3HOB98aluMilT0
 /oKySmGk8zCtw2U16aYq0i4ZcGgSI+y9f2tWd/JTj8vgdaDwvpoQiphFibsMb6xmO4Z7JW6
 anEbaQ3lFTdLetvfdrK22AC2mGxwjwXvDFknsOieqs0E08lu84QwUQRigNRb5l07ivRRNKx
 z7P3BhS9y4LUNdUIqEG5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0U8jAkjw638=:6V6I3fKLZ18Byu9j/7wbe3
 6lQwBgH4RbaSciLpNa2T6hX1hTtogzxUwFSamT9h5YCLjH8STmRGVJu7vnpdeU5g7AOgL4LqD
 9xDQdVT5USd/sDaR7LQLWv4M50V5pLKTq4Sq03/hLa8Vht1skpuByTp5MnMzUCkFJM+Wbj1lV
 Xr9UbMp3sDB4MjaZnPJ8FKvxwIwODN05Ifl3cJEIYHbQe/QibnjmE7IzvjqMJRRU2icup4J/1
 UScPzFxJVv43rG1pp0VNGhqpB8ZPoiOBh7ReyoMY8FgPXiMLUq9fqFDlGW6iHZQFQ5nSB1jPr
 7FZG87U/sT7HgZUGPNE7ytcInDn6kan95jv3VNsstwt/zzOT8GkAl/S5V3H0q7CzTxfppBvFT
 26PV3GXOO1oEc7fmMs13N+0CEXlOhG2qhNEliki21NR3289dijl86zovXZWJBcLpwERpoguso
 HLR074gXyYhEYw/J0RAY+WAEhmkoBwmA+FGGo1AhoR14LfMlFv2Qf5cdGfUuqIFoBgPd3VIIa
 2CKGKnK1K2+k+xn6uEZnAfkau33Ujxu753RpjwEOhmZYmLBvIM/v9uaEo5uvjo/Gf5yJ9RKqA
 MTfxTM377u2qdbGXpcXkpv+x0JChrKEiQfYc2Dk6bbaM1awBEMyJ8eR3Xed3YyIQyxdhtYh/1
 zFFbqok1UxUhnkCy6WZzJN7Nmz5nWqhJmqEtLKQcSdtvIwfGC0g9QlOevTCrkQYGftpw=
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Added suspend and resume handlers, placing the device into sleep on entry to suspend and waking it on resume.

Have tested both suspend to idle (freeze) and suspend to ram (mem).

Freeze was tested on an Allwinner A64 (pine 64 dev board I had lying around which didn't support suspend to ram), running 5.15.13.

Both freeze and mem were tested on a Coretex A7 (Quectel QuecOpen AG5xx), running my horrible mashup of 4.9.217 with a lot of backporting.

Each device has entered and exited suspend, triggered by another device, serial console in my case multiple times without issue (~50 times at least). With candump and cangen running, each time reception and transmission have resumed as I would have expected.

Logic analyser confirmed interrupt main / rx interrupt lines remain high despite traffic on the bus, transceiver enable line changes from low to high when entering sleep and reverse when resuming.

Signed-off-by: Phil Greenland <phil@quantulum.co.uk>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 110 ++++++++++++++++--
 .../can/spi/mcp251xfd/mcp251xfd-timestamp.c   |   6 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   1 +
 3 files changed, 109 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9ee2c69c5..98eb597d8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -425,6 +425,30 @@ static void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	}
 }
 
+static void mcp251xfd_ring_reset(struct mcp251xfd_priv *priv)
+{
+	struct mcp251xfd_tef_ring *tef_ring;
+	struct mcp251xfd_tx_ring *tx_ring;
+	struct mcp251xfd_rx_ring *rx_ring = NULL;
+	int i;
+
+	/* TEF */
+	tef_ring = priv->tef;
+	tef_ring->head = 0;
+	tef_ring->tail = 0;
+
+	/* TX */
+	tx_ring = priv->tx;
+	tx_ring->head = 0;
+	tx_ring->tail = 0;
+
+	/* RX */
+	mcp251xfd_for_each_rx_ring(priv, rx_ring, i) {
+		rx_ring->head = 0;
+		rx_ring->tail = 0;
+	}
+}
+
 static void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)
 {
 	int i;
@@ -703,13 +727,8 @@ static int mcp251xfd_chip_clock_init(const struct mcp251xfd_priv *priv)
 	u32 osc;
 	int err;
 
-	/* Activate Low Power Mode on Oscillator Disable. This only
-	 * works on the MCP2518FD. The MCP2517FD will go into normal
-	 * Sleep Mode instead.
-	 */
-	osc = MCP251XFD_REG_OSC_LPMEN |
-		FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
-			   MCP251XFD_REG_OSC_CLKODIV_10);
+	/* Divide clock by 10 before presenting on clk output */
+	osc = FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK, MCP251XFD_REG_OSC_CLKODIV_10);
 	err = regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
 	if (err)
 		return err;
@@ -723,6 +742,16 @@ static int mcp251xfd_chip_clock_init(const struct mcp251xfd_priv *priv)
 			    MCP251XFD_REG_TSCON_TBCEN);
 }
 
+static int mcp251xfd_sleep_in_low_power_mode(const struct mcp251xfd_priv *priv)
+{
+	/* Activate Low Power Mode for sleep. This only
+	 * works on the MCP2518FD. The MCP2517FD will go into normal
+	 * Sleep Mode instead.
+	 */
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_OSC,
+				  MCP251XFD_REG_OSC_LPMEN, MCP251XFD_REG_OSC_LPMEN);
+}
+
 static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 {
 	const struct can_bittiming *bt = &priv->can.bittiming;
@@ -1068,6 +1097,7 @@ static int mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_configure_gpio(priv, false);
+	mcp251xfd_sleep_in_low_power_mode(priv);
 	return mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
 }
 
@@ -2525,6 +2555,7 @@ static int mcp251xfd_open(struct net_device *ndev)
 		goto out_transceiver_disable;
 
 	mcp251xfd_timestamp_init(priv);
+	mcp251xfd_timestamp_start(priv);
 	can_rx_offload_enable(&priv->offload);
 
 	err = request_threaded_irq(spi->irq, NULL, mcp251xfd_irq,
@@ -3030,6 +3061,70 @@ static int mcp251xfd_remove(struct spi_device *spi)
 	return 0;
 }
 
+static int __maybe_unused mcp251xfd_suspend(struct device *device)
+{
+	struct spi_device *spi = to_spi_device(device);
+	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
+	int err;
+
+	if (!netif_running(priv->ndev))
+		return 0;
+
+	disable_irq(priv->ndev->irq);
+
+	mcp251xfd_timestamp_stop(priv);
+
+	err = mcp251xfd_chip_interrupts_disable(priv);
+	if (err)
+		return err;
+
+	err = mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
+	if (err)
+		return err;
+
+	netif_stop_queue(priv->ndev);
+	netif_device_detach(priv->ndev);
+
+	return 0;
+}
+
+static int __maybe_unused mcp251xfd_resume(struct device *device)
+{
+	struct spi_device *spi = to_spi_device(device);
+	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
+	int err;
+
+	if (!netif_running(priv->ndev))
+		return 0;
+
+	netif_device_attach(priv->ndev);
+	netif_start_queue(priv->ndev);
+
+	/* restart oscillator (disabled automatically when entering sleep) */
+	err = mcp251xfd_chip_clock_enable(priv);
+	if (err)
+		return err;
+
+	/* reset tx and rx fifos (controller resets them all when entering configuration
+	 * mode as it does when exiting sleep)
+	 */
+	mcp251xfd_ring_reset(priv);
+
+	err = mcp251xfd_chip_set_normal_mode(priv);
+	if (err)
+		return err;
+
+	err = mcp251xfd_chip_interrupts_enable(priv);
+	if (err)
+		return err;
+
+	mcp251xfd_timestamp_start(priv);
+
+	enable_irq(priv->ndev->irq);
+
+	return 0;
+}
+
 static int __maybe_unused mcp251xfd_runtime_suspend(struct device *device)
 {
 	const struct mcp251xfd_priv *priv = dev_get_drvdata(device);
@@ -3045,6 +3140,7 @@ static int __maybe_unused mcp251xfd_runtime_resume(struct device *device)
 }
 
 static const struct dev_pm_ops mcp251xfd_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mcp251xfd_suspend, mcp251xfd_resume)
 	SET_RUNTIME_PM_OPS(mcp251xfd_runtime_suspend,
 			   mcp251xfd_runtime_resume, NULL)
 };
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 712e09186..d889c19b0 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -61,8 +61,12 @@ void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv)
 	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
 
 	INIT_DELAYED_WORK(&priv->timestamp, mcp251xfd_timestamp_work);
+}
+
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv)
+{
 	schedule_delayed_work(&priv->timestamp,
-			      MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
+						  MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index ad658faa2..111f88dc2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -858,6 +858,7 @@ u16 mcp251xfd_crc16_compute(const void *data, size_t data_size);
 void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
 				 struct sk_buff *skb, u32 timestamp);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
 #if IS_ENABLED(CONFIG_DEV_COREDUMP)
-- 
2.25.1

