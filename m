Return-Path: <linux-can+bounces-2436-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7D9F65B3
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 13:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB251889858
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F71A23B6;
	Wed, 18 Dec 2024 12:17:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52A19CD01
	for <linux-can@vger.kernel.org>; Wed, 18 Dec 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524251; cv=none; b=ou9bYQW81KNN/Ibg3ewllr7AjMoPmzFB25fz/Mt7pNROG7DNPo5ASLqhw6fZkQx4FoqRjadVEbVp4HjGWz9PoCCNbtDv8NFu0Y/uI8ZgeqihNSoFmyVWecZ85eeO+IrBUYiNbSLInRCqiX/sCR4n8wu3Gx20JUkQQL19OfcBX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524251; c=relaxed/simple;
	bh=8FQkIr/JQzA65cdd+driappzDuk1TtYwvWRQXL7aQWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6EuTajRvlZbmCkjJd6yliUMWoGvgbjIqDK8C27H0IxbWg0qjKYCJMpkKQJxM1q0q/RG9Nd4Lu+N70oXQESP3K+7NgxkvQbXTxm+JZpKiSKT4+qFyiyvwSxU3Mdr5y5L8Gj+Le0gjXrO77f1pXsRw9/K5Qp1EgbRuBg8/xmv+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNszW-0003Uw-WD
	for linux-can@vger.kernel.org; Wed, 18 Dec 2024 13:17:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNszV-0041w2-34
	for linux-can@vger.kernel.org;
	Wed, 18 Dec 2024 13:17:26 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 66C6E39168B
	for <linux-can@vger.kernel.org>; Wed, 18 Dec 2024 12:17:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 85C2A391679;
	Wed, 18 Dec 2024 12:17:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 973026e7;
	Wed, 18 Dec 2024 12:17:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/2] can: m_can: fix missed interrupts with m_can_pci
Date: Wed, 18 Dec 2024 13:10:28 +0100
Message-ID: <20241218121722.2311963-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218121722.2311963-1-mkl@pengutronix.de>
References: <20241218121722.2311963-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

The interrupt line of PCI devices is interpreted as edge-triggered,
however the interrupt signal of the m_can controller integrated in Intel
Elkhart Lake CPUs appears to be generated level-triggered.

Consider the following sequence of events:

- IR register is read, interrupt X is set
- A new interrupt Y is triggered in the m_can controller
- IR register is written to acknowledge interrupt X. Y remains set in IR

As at no point in this sequence no interrupt flag is set in IR, the
m_can interrupt line will never become deasserted, and no edge will ever
be observed to trigger another run of the ISR. This was observed to
result in the TX queue of the EHL m_can to get stuck under high load,
because frames were queued to the hardware in m_can_start_xmit(), but
m_can_finish_tx() was never run to account for their successful
transmission.

On an Elkhart Lake based board with the two CAN interfaces connected to
each other, the following script can reproduce the issue:

    ip link set can0 up type can bitrate 1000000
    ip link set can1 up type can bitrate 1000000

    cangen can0 -g 2 -I 000 -L 8 &
    cangen can0 -g 2 -I 001 -L 8 &
    cangen can0 -g 2 -I 002 -L 8 &
    cangen can0 -g 2 -I 003 -L 8 &
    cangen can0 -g 2 -I 004 -L 8 &
    cangen can0 -g 2 -I 005 -L 8 &
    cangen can0 -g 2 -I 006 -L 8 &
    cangen can0 -g 2 -I 007 -L 8 &

    cangen can1 -g 2 -I 100 -L 8 &
    cangen can1 -g 2 -I 101 -L 8 &
    cangen can1 -g 2 -I 102 -L 8 &
    cangen can1 -g 2 -I 103 -L 8 &
    cangen can1 -g 2 -I 104 -L 8 &
    cangen can1 -g 2 -I 105 -L 8 &
    cangen can1 -g 2 -I 106 -L 8 &
    cangen can1 -g 2 -I 107 -L 8 &

    stress-ng --matrix 0 &

To fix the issue, repeatedly read and acknowledge interrupts at the
start of the ISR until no interrupt flags are set, so the next incoming
interrupt will also result in an edge on the interrupt line.

While we have received a report that even with this patch, the TX queue
can become stuck under certain (currently unknown) circumstances on the
Elkhart Lake, this patch completely fixes the issue with the above
reproducer, and it is unclear whether the remaining issue has a similar
cause at all.

Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart Lake")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://patch.msgid.link/fdf0439c51bcb3a46c21e9fb21c7f1d06363be84.1728288535.git.matthias.schiffer@ew.tq-group.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c     | 22 +++++++++++++++++-----
 drivers/net/can/m_can/m_can.h     |  1 +
 drivers/net/can/m_can/m_can_pci.c |  1 +
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 67c404fbe166..97cd8bbf2e32 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1220,20 +1220,32 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 {
 	struct net_device *dev = cdev->net;
-	u32 ir;
+	u32 ir = 0, ir_read;
 	int ret;
 
 	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
 
-	ir = m_can_read(cdev, M_CAN_IR);
+	/* The m_can controller signals its interrupt status as a level, but
+	 * depending in the integration the CPU may interpret the signal as
+	 * edge-triggered (for example with m_can_pci). For these
+	 * edge-triggered integrations, we must observe that IR is 0 at least
+	 * once to be sure that the next interrupt will generate an edge.
+	 */
+	while ((ir_read = m_can_read(cdev, M_CAN_IR)) != 0) {
+		ir |= ir_read;
+
+		/* ACK all irqs */
+		m_can_write(cdev, M_CAN_IR, ir);
+
+		if (!cdev->irq_edge_triggered)
+			break;
+	}
+
 	m_can_coalescing_update(cdev, ir);
 	if (!ir)
 		return IRQ_NONE;
 
-	/* ACK all irqs */
-	m_can_write(cdev, M_CAN_IR, ir);
-
 	if (cdev->ops->clear_interrupts)
 		cdev->ops->clear_interrupts(cdev);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 92b2bd8628e6..ef39e8e527ab 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -99,6 +99,7 @@ struct m_can_classdev {
 	int pm_clock_support;
 	int pm_wake_source;
 	int is_peripheral;
+	bool irq_edge_triggered;
 
 	// Cached M_CAN_IE register content
 	u32 active_interrupts;
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d72fe771dfc7..9ad7419f88f8 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -127,6 +127,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	mcan_class->pm_clock_support = 1;
 	mcan_class->pm_wake_source = 0;
 	mcan_class->can.clock.freq = id->driver_data;
+	mcan_class->irq_edge_triggered = true;
 	mcan_class->ops = &m_can_pci_ops;
 
 	pci_set_drvdata(pci, mcan_class);
-- 
2.45.2



