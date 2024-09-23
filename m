Return-Path: <linux-can+bounces-1546-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873597EE42
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 17:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F36EB219BA
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65819D885;
	Mon, 23 Sep 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="U2i8uGKE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bfSMsaJS"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0278F5E;
	Mon, 23 Sep 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105570; cv=none; b=GdLsHlLTUqB5vYkPy7yz8emb/sWFT0K/Fjdi46tcOgM0jDZ+ii7Ma6hAYsmAduE7DwcPjTWWJfDSeyTSxegP0vFVl1I/UXJgxBIGjI+nIFHxN2K5apOzsPKGPZi7Rwhe0Nmbcfz0ELDw1B5oStP9WBRIJNj5LAG47sPiiA5hBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105570; c=relaxed/simple;
	bh=er20S1uhcEq3uJ8/+Dqi7Inul3TmcahvkJ2tyCtpMcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ia18wQHgCTQ68v6Ct+wzh8+8abc126poCHX1/jGwr7ulP8bGs9haXSepcX80+dYzY8Wu55IVHyKl3c/TSJoOW1ZUQUmMWDzkNu7JOxfop+X7kfb96nuyhDfhLlm/bX2z/KDWAyteXhhE5FVhECnypd7ZKjofkSft+acQsO6/pnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=U2i8uGKE; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bfSMsaJS reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727105568; x=1758641568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aGPmZ1mY8PDbyFdZ4tQucNYx50+OM/sBRnttX9nedtY=;
  b=U2i8uGKE2GRJ8w1KrLyuAUySGNNm9LVagkjsnGDCRLR5p7K93OgGrwcW
   P1+v++7qUUTE7ZHckn9O648R0SiZfC4MjS4Cy6k0TIRalOJiynnhjEQ5w
   mkXAGRpfm9Ig8XnzdWk/IvXDzNnMxXQ9hVhR1Zkg3uUgwbgf8zL45WLoH
   ksRTT29wR8wEEjAhVZ00w12dFcyBgoO+zjhr6IwE3EcgV5kn8wfIbVDZV
   QYAipPsvm3ca9NaN99+KVB9esBdxJQ+7TbT2/0bxEuFAjQ5uvCrhSigSZ
   6BOT29jAII6ehlQWaGZ25OQE1YFATBB7ZH2MB9NvMfAEUpOMqv076l+/7
   w==;
X-CSE-ConnectionGUID: g5rP32heRy6l/nPelGSoEQ==
X-CSE-MsgGUID: mKq6hEaNQmu8Em+xVE7VfA==
X-IronPort-AV: E=Sophos;i="6.10,251,1719871200"; 
   d="scan'208";a="39075278"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Sep 2024 17:32:45 +0200
X-CheckPoint: {66F18A1D-5-D1F0B501-D0091591}
X-MAIL-CPID: 24844F0DCA8AEA31555A2763232DF8DA_0
X-Control-Analysis: str=0001.0A682F22.66F18A1D.00AE,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F39C516E9F7;
	Mon, 23 Sep 2024 17:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727105560;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aGPmZ1mY8PDbyFdZ4tQucNYx50+OM/sBRnttX9nedtY=;
	b=bfSMsaJSZRnK8PQx2a0mOt71InuIWpELmh/VrFq2S4vHKvM020dLKyb7gzRJ8AkxkD3pOG
	Dh8g1ceBR3YVu+he9JoKG5z5waHjbi13mA18vRRwal8mWB47/n7m1JdiNK4Vj5keyDOtYZ
	zQ+gyh01u6tO7xL4h1isP4EJHOk6UlcTucsWkVNQRBfyNj+eoBHc0qYYRwDi3Z4vMnEaG4
	w2GwiwkjjGHtRQVLyIeG2duAPKcIHcRFkXEa1aHIe/Ltp/0M7r2LqapKz9TUd609xLVaTm
	lmu7UBTm/i+Bv1QBRb9gyrRrPLZJO+qedZl5YHyVfvbB51tpzRgkrsU8DSBMlw==
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
Subject: [PATCH v3 2/2] can: m_can: fix missed interrupts with m_can_pci
Date: Mon, 23 Sep 2024 17:32:16 +0200
Message-ID: <4715d1cfed61d74d08dcc6a27085f43092da9412.1727092909.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>
References: <ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>
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
v3:
- rename flag to irq_edge_triggered
- update comment to describe the issue more generically as one of systems with
  edge-triggered interrupt line. m_can_pci is mentioned as an example, as it
  is the only m_can variant that currently sets the irq_edge_triggered flag.

 drivers/net/can/m_can/m_can.c     | 22 +++++++++++++++++-----
 drivers/net/can/m_can/m_can.h     |  1 +
 drivers/net/can/m_can/m_can_pci.c |  1 +
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c85ac1b15f723..24e348f677714 100644
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
+	 * edge-triggered (for example with m_can_pci).
+	 * We must observe that IR is 0 at least once to be sure that the next
+	 * interrupt will generate an edge.
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

