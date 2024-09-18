Return-Path: <linux-can+bounces-1510-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A897BDEE
	for <lists+linux-can@lfdr.de>; Wed, 18 Sep 2024 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0433E1C20ABF
	for <lists+linux-can@lfdr.de>; Wed, 18 Sep 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5703C18DF65;
	Wed, 18 Sep 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="H3e/5vnn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cWr7Q6i+"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6B18C329;
	Wed, 18 Sep 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726669464; cv=none; b=X3SSEkPY79djdecU75TMVTpIEBYKfMMnvcvmAB7sADQPBO4JjWDSOMKl4eJb+E8SfNqFPCF6TazlmzppHZp0DV0y4+88+42QndcW91sUpadqQBfaCSOqCF6bJZW4l2cQLgsIb8QMahXMp17iOQN9w1DqttpGM5EjAGVEB18cyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726669464; c=relaxed/simple;
	bh=YNvCY+Zx7wxVlO31Wwd1KwGz+kp+q3JhVEx2vhvuT6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChrDnE45lVdkaA8WzDTlJhhGLLdZdxF4l8N4D1ho05Mkvy27QF/MLqiBpHjYxd0NJPOAFPX3rRcZa0ITGddaciKD22oP8ssSgZFNcYtzcWuvXg/w2IMAmleFcaE3dFn44XWKsNZ24sR5Td0kPQOy3MLwHMJLWIMPu2UlvJIIFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=H3e/5vnn; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cWr7Q6i+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726669461; x=1758205461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PWE1WWddBGYrp5zOkYncT1llF5E7qQs91V7SUqTNMuM=;
  b=H3e/5vnn3IxDGNJxmUrqM3kONMZzAa/g/5IawGZQL33+iIsUHjGlOGcZ
   wNM4N61jVb+J4XTKev8YbB6Fpmrcf0eaZZUJYt468xadZLbQgBf+Oljr6
   ORDJPBQyyIP+wqY0NAdzbOyIudS4j/AKyu6tMGp7+3banjuEMqi7EZyu5
   +jGL+WWeGqHnG9ur0oN0Sj2A4hyakwigbNl/6tEiyjhvr1qNTx0nFsBOy
   xBaOeLc5zQvhdcQZoUjOtMVFbMd4pVQCBh6CvfAuqd+bQwAx2i0zt2dt5
   2BibAUjixt570ztQ+j3ORHPAUjsaEQ+j0goFynncnAw+RXfCi5Qt3mffP
   w==;
X-CSE-ConnectionGUID: SwL9JRFXRIywpb+zoQR9hw==
X-CSE-MsgGUID: gfa066qPS5+sxdx/r34CnQ==
X-IronPort-AV: E=Sophos;i="6.10,239,1719871200"; 
   d="scan'208";a="39006265"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Sep 2024 16:23:09 +0200
X-CheckPoint: {66EAE24D-D-E520F13A-D17B83D9}
X-MAIL-CPID: CF6739CD121BEEE37E9C54A24A4BBD1B_2
X-Control-Analysis: str=0001.0A782F1F.66EAE24D.009B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2BFC16CB96;
	Wed, 18 Sep 2024 16:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726669384;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PWE1WWddBGYrp5zOkYncT1llF5E7qQs91V7SUqTNMuM=;
	b=cWr7Q6i+NUL+PAVIJri7DcrBrlSnjTPFYuFcN5jOLNZQfE2yoTOM06AVZfqlti0FESijGf
	xowKEm+3DsnSmU9wearGNW7PlIRQ+QtLQsQuuuLtwmvZ3WAegmh0bCTcdyvoWuaUgrGSpR
	OxJVIaqh7T6pH5tun8I2Rj2yx76Bs5Ocj5MX1Cf6vhikyrIJnKWqLVD987sZgP9YHTVlMD
	9GYdOqxBOQAQXq/Q7hFwBHhTmsrile+Sj3seXe0Cf4LPVQRwddmi9EItDhWTlTwOTTeLf3
	rJSn/0cTlYneG1QS7bbT2eAr2P3cOYIOEkbc/4ogCxN7oKfcQ3U8A7M3YEeM1g==
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
Subject: [PATCH 2/2] can: m_can: fix missed interrupts with m_can_pci
Date: Wed, 18 Sep 2024 16:21:54 +0200
Message-ID: <f6155510fbea33b0e18030a147b87c04395f7394.1726669005.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726669005.git.matthias.schiffer@ew.tq-group.com>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726669005.git.matthias.schiffer@ew.tq-group.com>
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
 drivers/net/can/m_can/m_can.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 47481afb9add3..363732517c3c5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1207,20 +1207,28 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
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
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


