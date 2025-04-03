Return-Path: <linux-can+bounces-3360-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8216A7AA1D
	for <lists+linux-can@lfdr.de>; Thu,  3 Apr 2025 21:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BC217A22A
	for <lists+linux-can@lfdr.de>; Thu,  3 Apr 2025 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1C256C91;
	Thu,  3 Apr 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjZi3qnX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD9253F0D;
	Thu,  3 Apr 2025 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706970; cv=none; b=DYfbLc4MESK1pKf8XBppgcLJ/q7hHb/K6X0NHhE1JiNMYxEkRqao8gtoZGowUcJ9MXYaRBXl/4JwrfMkH+xnxfsNc/m81yGDbjwP2w9qcc7ObNqWTWAnrE5l3ObdYIZgQ8iD9mErH2wXEBC7wjqVL6eAOLdZjI5Y9Jg8Vu6B0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706970; c=relaxed/simple;
	bh=3bIlYTdaLb9xaxL8gTon7Tsyr9gCmJa6rdM5x+MuB8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4rwljAG0MOBCbUkXkv9IfHUhDU/JSH7HvNzaBA5QhBiIxvXDeGP4rQxbQtNTRh4gNrvesd8pxeQp+tsjEOY3+o+R2BQj2yXWJYTx0RYLAwP4uNWcjxQ8KBU04XEoUSbqJmAX1+a7nB2V2GPcOd8tp6r0j7Tf5WmazvMyobPjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjZi3qnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8437DC4CEE3;
	Thu,  3 Apr 2025 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706970;
	bh=3bIlYTdaLb9xaxL8gTon7Tsyr9gCmJa6rdM5x+MuB8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjZi3qnXxAw32FIvvi9bzKKGBJ4V4Nj09QaZcW7OHo2emgB3jDi4cMavLaZ8q3yYB
	 umgWp0UdQcR0L1iKvz/5gIgkj9UrU4u2D8D6hIPZi7ohBzSk6ccPRdWMvOxuuip2T0
	 +OyAx97+XBnaT/ev5RRzMvQgClhF77xlEmNQE9y5LEgMTadL29c27hn4vgEGNcuIy+
	 EXuF6pvGTDI4RlCD9jZZcFCJ0xwd4zMm4+QFK0rJY6I4inkERCduWazXGPoJPiYHm8
	 3JptaUpNwXy5SCI7J9TVkTEy46fEhdoWQFt933G+yCG+dS+3TDzR1COUnIcb2OyoIx
	 r2GBr3h0tUfBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	haibo.chen@nxp.com,
	frank.li@nxp.com,
	u.kleine-koenig@baylibre.com,
	dimitri.fedrau@liebherr.com,
	linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 17/54] can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
Date: Thu,  3 Apr 2025 15:01:32 -0400
Message-Id: <20250403190209.2675485-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

[ Upstream commit 8c652cf030a769fbfc73cfc280ed3f1656343c35 ]

Introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk to handle a FlexCAN
hardware module integration particularity where two ranges of mailboxes
are controlled by separate hardware interrupt lines.
The same 'flexcan_irq' handler is used for both separate mailbox interrupt
lines, with no other changes.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250113120704.522307-3-ciprianmarian.costea@oss.nxp.com
[mkl: flexcan_open(): change order and free irq_secondary_mb first]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan/flexcan-core.c | 24 +++++++++++++++++++++++-
 drivers/net/can/flexcan/flexcan.h      |  5 +++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index b080740bcb104..1a94586cbd11e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1762,14 +1762,25 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = request_irq(priv->irq_secondary_mb,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_err;
+	}
+
 	flexcan_chip_interrupts_enable(dev);
 
 	netif_start_queue(dev);
 
 	return 0;
 
+ out_free_irq_err:
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
-	free_irq(priv->irq_boff, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_boff, dev);
  out_free_irq:
 	free_irq(dev->irq, dev);
  out_can_rx_offload_disable:
@@ -1794,6 +1805,9 @@ static int flexcan_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	flexcan_chip_interrupts_disable(dev);
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		free_irq(priv->irq_secondary_mb, dev);
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		free_irq(priv->irq_err, dev);
 		free_irq(priv->irq_boff, dev);
@@ -2187,6 +2201,14 @@ static int flexcan_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		priv->irq_secondary_mb = platform_get_irq_byname(pdev, "mb-1");
+		if (priv->irq_secondary_mb < 0) {
+			err = priv->irq_secondary_mb;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 4933d8c7439e6..2cf886618c962 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -70,6 +70,10 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
 /* Setup stop mode with ATF SCMI protocol to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
+/* Device has two separate interrupt lines for two mailbox ranges, which
+ * both need to have an interrupt handler registered.
+ */
+#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
@@ -107,6 +111,7 @@ struct flexcan_priv {
 
 	int irq_boff;
 	int irq_err;
+	int irq_secondary_mb;
 
 	/* IPC handle when setup stop mode by System Controller firmware(scfw) */
 	struct imx_sc_ipc *sc_ipc_handle;
-- 
2.39.5


