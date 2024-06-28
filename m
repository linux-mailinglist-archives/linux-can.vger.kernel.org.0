Return-Path: <linux-can+bounces-883-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47291C83E
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 23:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F727283BD4
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DB80024;
	Fri, 28 Jun 2024 21:41:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208F7F7F7
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610885; cv=none; b=IzITXMk64Md+8BlaZZqc3wMlFmBzTYaIOma0J+UZwmMdgBcmGM+a3RP4RjyeCLS8o+vSKjRC8utTK3DLzgRLbBbfKnyqc9KNh1AndZqDfzataCxgPBxfrNBcfmE8BtR2p0g8fLKKNIATrDUDaVwv5LJuPqw1rbji7VR5vW2ya9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610885; c=relaxed/simple;
	bh=Tk1BepryybxQVHRrSY2HKDddFLLMkj8GqUh/lFfXw/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fn6N89ZV1ITLlLqeyQcprLj7mKFE66XMSzl5d4mnlPFiq83JrSDzl8vPpuvBDnE8yBfDBaI+Y51xUuzOR/RTXzHCDXa1r1KkF6EHSDwj/nNFGlVgkd7goxTNR4ICTYsfxB1DBrqB4cmWKIYBEQAE0QSPBZseA94uypCS+jjvQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLN-0001Zv-MK
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLM-005h2W-Gy
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2EB7C2F60A4
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E89E62F6071;
	Fri, 28 Jun 2024 21:41:16 +0000 (UTC)
Received: from [10.11.86.119] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 99d2b9cf;
	Fri, 28 Jun 2024 21:41:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 28 Jun 2024 23:40:25 +0200
Subject: [PATCH v4 1/9] can: mcp251xfd: properly indent labels
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-mcp251xfd-workaround-erratum-6-v4-1-53586f168524@pengutronix.de>
References: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
In-Reply-To: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 =?utf-8?q?Stefan_Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=4588; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Tk1BepryybxQVHRrSY2HKDddFLLMkj8GqUh/lFfXw/A=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmfy3tJ0zoA+nlD2ulN9sHVDSc3ySJmU8+K/zwa
 aS1pS9Fl6aJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZn8t7QAKCRAoOKI+ei28
 b9hAB/9TTDjyxf1bt8+Qw0ICrWVmTgAj1uJy3c7UCifbD44ni169TZiEW+uBTMoInB2FUtI1PZo
 RBlMcsMu/LJPrVYGruRZ8lwKXtlVgYFrWU1Ykf6tjRQXeMiOvwNZFPqzbv83BXgU6RdQv45Kzzf
 yHQ3safJaMhfdM9RFSRudeTADzFfdLoyrmxPmuN1XT6ouyRkhQCuccaxNX0GbFlH/uRVJ5h6kW5
 ZKSr6lDt31g6ylfZ0JxcHUtVzQwj0j1PWhU410C2yyr1s+8CP5HOF2YPYAyUdgFCAsITFTcLhIx
 8/ydULM8mcWCPwUvnoVuK9Ixph1WDYm7BF5x3TQbonZPfVX7
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

To fix the coding style, remove the whitespace in front of labels.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 34 ++++++++++++------------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c   |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c    |  2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c116d3255207..61e749f97650 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -791,7 +791,7 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 
 	return 0;
 
- out_chip_stop:
+out_chip_stop:
 	mcp251xfd_dump(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 
@@ -1576,7 +1576,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 		handled = IRQ_HANDLED;
 	} while (1);
 
- out_fail:
+out_fail:
 	can_rx_offload_threaded_irq_finish(&priv->offload);
 
 	netdev_err(priv->ndev, "IRQ handler returned %d (intf=0x%08x).\n",
@@ -1641,22 +1641,22 @@ static int mcp251xfd_open(struct net_device *ndev)
 
 	return 0;
 
- out_free_irq:
+out_free_irq:
 	free_irq(spi->irq, priv);
- out_destroy_workqueue:
+out_destroy_workqueue:
 	destroy_workqueue(priv->wq);
- out_can_rx_offload_disable:
+out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	mcp251xfd_timestamp_stop(priv);
- out_transceiver_disable:
+out_transceiver_disable:
 	mcp251xfd_transceiver_disable(priv);
- out_mcp251xfd_ring_free:
+out_mcp251xfd_ring_free:
 	mcp251xfd_ring_free(priv);
- out_pm_runtime_put:
+out_pm_runtime_put:
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
- out_close_candev:
+out_close_candev:
 	close_candev(ndev);
 
 	return err;
@@ -1820,9 +1820,9 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 	*effective_speed_hz_slow = xfer[0].effective_speed_hz;
 	*effective_speed_hz_fast = xfer[1].effective_speed_hz;
 
- out_kfree_buf_tx:
+out_kfree_buf_tx:
 	kfree(buf_tx);
- out_kfree_buf_rx:
+out_kfree_buf_rx:
 	kfree(buf_rx);
 
 	return err;
@@ -1936,13 +1936,13 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 	return 0;
 
- out_unregister_candev:
+out_unregister_candev:
 	unregister_candev(ndev);
- out_chip_sleep:
+out_chip_sleep:
 	mcp251xfd_chip_sleep(priv);
- out_runtime_disable:
+out_runtime_disable:
 	pm_runtime_disable(ndev->dev.parent);
- out_runtime_put_noidle:
+out_runtime_put_noidle:
 	pm_runtime_put_noidle(ndev->dev.parent);
 	mcp251xfd_clks_and_vdd_disable(priv);
 
@@ -2155,9 +2155,9 @@ static int mcp251xfd_probe(struct spi_device *spi)
 
 	return 0;
 
- out_can_rx_offload_del:
+out_can_rx_offload_del:
 	can_rx_offload_del(&priv->offload);
- out_free_candev:
+out_free_candev:
 	spi->max_speed_hz = priv->spi_max_speed_hz_orig;
 
 	free_candev(ndev);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
index 004eaf96262b..050321345304 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
@@ -94,7 +94,7 @@ static void mcp251xfd_dump_registers(const struct mcp251xfd_priv *priv,
 		kfree(buf);
 	}
 
- out:
+out:
 	mcp251xfd_dump_header(iter, MCP251XFD_DUMP_OBJECT_TYPE_REG, reg);
 }
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 92b7bc7f14b9..65150e762007 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -397,7 +397,7 @@ mcp251xfd_regmap_crc_read(void *context,
 
 		return err;
 	}
- out:
+out:
 	memcpy(val_buf, buf_rx->data, val_len);
 
 	return 0;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index e5bd57b65aaf..ee7028c027b5 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -216,7 +216,7 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		total_frame_len += frame_len;
 	}
 
- out_netif_wake_queue:
+out_netif_wake_queue:
 	len = i;	/* number of handled goods TEFs */
 	if (len) {
 		struct mcp251xfd_tef_ring *ring = priv->tef;

-- 
2.43.0



