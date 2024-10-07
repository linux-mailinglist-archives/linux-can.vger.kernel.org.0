Return-Path: <linux-can+bounces-1596-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ACD9926F0
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 10:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB11AB2297D
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF318BC31;
	Mon,  7 Oct 2024 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Fz6LWzd+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Yvtf+tpU"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7A188703;
	Mon,  7 Oct 2024 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289481; cv=none; b=dPdcj+FfZvu/x4315PMHYD/keL9q+OyTaJuw401kVQgDHYwmZ6Yn+w/uK5E0jNrrW2QYFZWay7ds5XTuH43C83+etxtJhCVCCuqru50MLlso4IuBRgn5DY6o+Bwd5h8pCr4dahWU9UWGux+hayxYRD19vSXsH1X1G6YNr85jrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289481; c=relaxed/simple;
	bh=uAWY5GeBU1LHEXd3tdVJsfzxjfC5n+KBX+GF3q4EYh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DESJBSH7uUdzHKwUoFu1htJNxLHAPeeR8O8u2hR5fGRK5bPYtIgFKNo5k+mEJOUGwbTXhXTXDIgf4WIhIg3o3vKtvR7fvOrVyHQJr0lJktlzGEXHlvj9atAoZRFhH1DjcXbquNU8KjhxVuny8r2bCUv7dZQNAm9KmBvgDFQp2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Fz6LWzd+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Yvtf+tpU reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1728289478; x=1759825478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PPDCreN8S5FVeojCwGe3k4aj+6euS02xfPX/V6waND4=;
  b=Fz6LWzd+X6aTp4fJanR+tuiq8JX416ntwUpvCg5ZKT6lKK39E9ZV14kG
   /fKauZbAQ60fo2iEsjbO1gQhBR7jfG4oIT0FK3LUma/JphAXFNaF8qDKU
   ONNgHQOU/hA6Z/dnmyqi5l8WmYm356ESibjyVwqIXTxCyC1LeU0svLXvC
   rGsVTLi3KSgykm7avmJEpJ6LULyV1vSGnBueiMYr5BBAZyDsGY2pf0hmL
   H44vxBgvRsmM9UM0ISD5wY389LEWHFFbDBak+1Zh6XeVpc4emk9Z6MQJW
   oPvzfg0kgRh60V+hG4/w5bmcAbNf2SzMAqct6D4gS7w5u33TzQRAFmhJx
   A==;
X-CSE-ConnectionGUID: nys4hkqWSYqSH6CyI/oXiA==
X-CSE-MsgGUID: uRnEfY3mT9eqxrnTnlCmvw==
X-IronPort-AV: E=Sophos;i="6.11,183,1725314400"; 
   d="scan'208";a="39298937"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Oct 2024 10:24:35 +0200
X-CheckPoint: {67039AC3-27-F5F7BCAD-D99768E6}
X-MAIL-CPID: CD52C37E9DB2573E7B755B6C0D9C85D7_3
X-Control-Analysis: str=0001.0A682F26.67039AC4.001C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2DAA16BDE5;
	Mon,  7 Oct 2024 10:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1728289471;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PPDCreN8S5FVeojCwGe3k4aj+6euS02xfPX/V6waND4=;
	b=Yvtf+tpU2ex4B8yuF+29woyM81KNY6dg0S847anb9qxZhPUUcTx5vaomi21ol+jrkBG3+3
	bXA5eRrXqeBTF1SAUjbt1F1ivkE63WqTItRKjfnpJ6wZZwfm+rwb8ftTQLPGeswkp+0HrM
	j1FikjW5m3uFWacG0bn2lBu7NDXNaQ4Zq8weEdVu7DPJ3xT9qyFI8ny+VgI7qV/oHIwrrl
	bvaVxs3HFekhgJLe/ecHU2qQHDuNBS0p8miFOHj7g+0yCTXYMSTJHbwbKc8++6lQlg2Sk8
	7bdY51OwmnTgQr+Kuzv+we6coqjr+Y3Vnx+AGOsWEugu1k17cfEfQ0aYnKyO9Q==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	"Felipe Balbi (Intel)" <balbi@kernel.org>,
	Raymond Tan <raymond.tan@intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v4 2/2] can: m_can: fix missed interrupts with m_can_pci
Date: Mon,  7 Oct 2024 10:23:59 +0200
Message-ID: <fdf0439c51bcb3a46c21e9fb21c7f1d06363be84.1728288535.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com>
References: <e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

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
---

As noted in the updated commit description, this patch either doesn't
fix the issue completely, or there is a different issue with the same
symptoms lurking in the driver. I think it would still be a good idea to
merge this patch, as it does significantly improve the situation with
m_can_pci (completely fixing the reproducer.)

Our customer who reported the issue to us seems to have found a way to work
around the remaining issue by combining this patch with some change in
their userspace application (using one socket per destination address
instead of sharing a single socket for the whole application), but I
have no idea how that would even affect the behavior except for subtle
timing differences. Having a workaround unfortunately also means that we
currently can't afford to put more effort into the analysis of the
remaining issue.


v2: introduce flag is_edge_triggered, so we can avoid the loop on !m_can_pci
v3:
- rename flag to irq_edge_triggered
- update comment to describe the issue more generically as one of systems with
  edge-triggered interrupt line. m_can_pci is mentioned as an example, as it
  is the only m_can variant that currently sets the irq_edge_triggered flag.
v4:
- update comment as suggested by Markus
- add Reviewed-by
- extend commit description with reproducer and recent updates


 drivers/net/can/m_can/m_can.c     | 22 +++++++++++++++++-----
 drivers/net/can/m_can/m_can.h     |  1 +
 drivers/net/can/m_can/m_can_pci.c |  1 +
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c85ac1b15f723..5dfadecc427a3 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1207,20 +1207,32 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
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
index 92b2bd8628e6b..ef39e8e527ab6 100644
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
index d72fe771dfc7a..9ad7419f88f83 100644
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
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


