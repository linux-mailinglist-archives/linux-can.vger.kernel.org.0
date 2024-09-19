Return-Path: <linux-can+bounces-1515-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F24697C89D
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 13:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D11F26633
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BACF19D8A9;
	Thu, 19 Sep 2024 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YnhkgPOC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hc6LgLd9"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35A19D09A;
	Thu, 19 Sep 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745286; cv=none; b=uFqlDKu1WjobeQw+8yC/3BZbuPuN29mQpZTy9j4v2V3aRWUYt0d6MJxGmggyIhFyItCxsFk8U2Pe5BMvZqZvO3ZYTmCVur2vwYYz1aGgCpp6QpQKHut8kD79Tp5DGnTH9WG+XS7KVF1Vk/I+JQ4x6CdtMcqAV0ZXwuyKpEChfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745286; c=relaxed/simple;
	bh=cKzUXBMP9VehwhFr06UK2lAVaz7tvHIM2Qaz8xG7PoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBjIUt8fn4fiU3udZMUJX/woPx0j2bVJigPdLVog+W8Vbrcvczryru+n70/O+G4nnEdLecL840h+T2BXZUnK6q21wbPEXRITd8mc8n3ctIS4635g3rBDFTG3fHuTpQ0gnkwJPOBiNfWyEg+X2NKJ/AbZS0mhv2zXPrcIQfeGVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YnhkgPOC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hc6LgLd9 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726745283; x=1758281283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lINmIHjvxhQs7AENiCWXeF3hOHhLu4x7Fu0GoAbZYbs=;
  b=YnhkgPOCiXu5XlJ/yLnzkeArwKuP6NmbLrh3MMtWg/EmBvzeCAyZbGqi
   LcUb5qcGroMaokQAZsn35W6PbGtohQwGREJg2b+pBnInh9eDrtJSx52mL
   JcgEjeIWxZlnh2+Q7agSl1t4N49CGsmQYBmxFy88sFg2rdgrkKtRZZasX
   eMMT3ZKB9pZalTKTM6R5lrpPvtuh1FSsM2BOJ1qE9d5nzWTYNOlQWNVcR
   gsVnt32nS7uS0KYWvdaGn3CdKw5XqVtXsI+14+LSprvJMy0trui4PB3k6
   5mpn1ZubihUvCJvGXBucxaTZtO21NS+t9dvvCPYcxZ49jEZLPkJUa40Hk
   w==;
X-CSE-ConnectionGUID: A5Gufbq5RS+iSVHVhTP34Q==
X-CSE-MsgGUID: sZjwhtoFSLWZrVAMqivX1Q==
X-IronPort-AV: E=Sophos;i="6.10,241,1719871200"; 
   d="scan'208";a="39024129"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Sep 2024 13:28:00 +0200
X-CheckPoint: {66EC0AC0-1E-C661815F-E221238E}
X-MAIL-CPID: B857DD0E7DE91C7858A551AC0ABE4933_1
X-Control-Analysis: str=0001.0A682F25.66EC0AC1.0055,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 876B916CDC0;
	Thu, 19 Sep 2024 13:27:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726745276;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lINmIHjvxhQs7AENiCWXeF3hOHhLu4x7Fu0GoAbZYbs=;
	b=hc6LgLd9G8cuOaDIFu+XMl0eVNYhQ3f6rAQvWSe1obibd7dhhEBUWu7zHrns8kKv5rpTv7
	wTdDiNz4lQ7GJ4o0SbVRykbEvo0jXc4SZemZ330xAFzcIk9E2fFLkKqf6sui9T2Fi/8CXn
	Uym3czgzmxARcDgQzGSyFfdTdvzNkCLPjxBbdqg5BWrce3YHG1hitNxVJ0qJ5jBAqW03Eo
	IYDKIsr/DW0dFYk7gBO4Tl+Z8jkb6gpUg63+gCdQPgcSEhUO1Cew1qiZj55SINe4oa1Ocy
	6kc2TlPtiyS3BQi64FRz2/K9uw50hpIg+iyE9/yA11P7bHIviebsHtDyxNLjnw==
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
Subject: [PATCH v2 2/2] can: m_can: fix missed interrupts with m_can_pci
Date: Thu, 19 Sep 2024 13:27:28 +0200
Message-ID: <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
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

To fix the issue, repeatedly read and acknowledge interrupts at the
start of the ISR until no interrupt flags are set, so the next incoming
interrupt will also result in an edge on the interrupt line.

Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart Lake")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: introduce flag is_edge_triggered, so we can avoid the loop on !m_can_pci

 drivers/net/can/m_can/m_can.c     | 21 ++++++++++++++++-----
 drivers/net/can/m_can/m_can.h     |  1 +
 drivers/net/can/m_can/m_can_pci.c |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 47481afb9add3..2e182c3c98fed 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1207,20 +1207,31 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 {
 	struct net_device *dev = cdev->net;
-	u32 ir;
+	u32 ir = 0, ir_read;
 	int ret;
 
 	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
 
-	ir = m_can_read(cdev, M_CAN_IR);
+	/* For m_can_pci, the interrupt line is interpreted as edge-triggered,
+	 * but the m_can controller generates them as level-triggered. We must
+	 * observe that IR is 0 at least once to be sure that the next
+	 * interrupt will generate an edge.
+	 */
+	while ((ir_read = m_can_read(cdev, M_CAN_IR)) != 0) {
+		ir |= ir_read;
+
+		/* ACK all irqs */
+		m_can_write(cdev, M_CAN_IR, ir);
+
+		if (!cdev->is_edge_triggered)
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
index 92b2bd8628e6b..8c17eb94d2f98 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -99,6 +99,7 @@ struct m_can_classdev {
 	int pm_clock_support;
 	int pm_wake_source;
 	int is_peripheral;
+	bool is_edge_triggered;
 
 	// Cached M_CAN_IE register content
 	u32 active_interrupts;
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d72fe771dfc7a..f98527981402a 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -127,6 +127,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	mcan_class->pm_clock_support = 1;
 	mcan_class->pm_wake_source = 0;
 	mcan_class->can.clock.freq = id->driver_data;
+	mcan_class->is_edge_triggered = true;
 	mcan_class->ops = &m_can_pci_ops;
 
 	pci_set_drvdata(pci, mcan_class);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


