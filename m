Return-Path: <linux-can+bounces-1581-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C1798AB56
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 19:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1441C2145D
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90171195980;
	Mon, 30 Sep 2024 17:46:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F45194C6A
	for <linux-can@vger.kernel.org>; Mon, 30 Sep 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718375; cv=none; b=ufsFkDPn4WL1NHxlvu+fFVbcCV93R7v7/3n533EvM1pQUBqCCp+SUvGUvvD049SUaS0cdtn7W0+AJxLlCVJhcJkXX/RihDGKmdS9+wSGc+sdWyb0OrUjME9ht8SfxIksv1XEvy0Rt1K9e8siDt4ugoBku0+N4At9SaLrJoqpkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718375; c=relaxed/simple;
	bh=ruyZ4LuCnuC4KtiwQ2V7atvLO/E534PBCUflofb8yQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QNZPp98eevDBxrP21vakVuIfiiE1OTHjKFbKklD7ZjmnFu/ega6ivKvjF4wSNDafaaOD5JC9QsjTDaV14xPDhI7o9YrpuL8sg6kg1UWaBoYOJTCAeE0di9LLYsH8ZR89K+po4OD8qe4E4SqUtSTduSULNkVA79T0fprQHCbbRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1svKTL-0003tP-1n
	for linux-can@vger.kernel.org; Mon, 30 Sep 2024 19:46:11 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1svKTK-002gVE-Kx
	for linux-can@vger.kernel.org; Mon, 30 Sep 2024 19:46:10 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 50A59346EAF
	for <linux-can@vger.kernel.org>; Mon, 30 Sep 2024 17:46:10 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AF24D346EA4;
	Mon, 30 Sep 2024 17:46:07 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f0b49870;
	Mon, 30 Sep 2024 17:46:06 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 30 Sep 2024 19:45:57 +0200
Subject: [PATCH] can: m_can: m_can_close(): don't call free_irq() for
 IRQ-less devices
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-m_can-cleanups-v1-1-001c579cdee4@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIANTj+mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS2MD3dz45MQ83eSc1MS80oJiXVPj5FQTI3OzNMMkQyWgpoKi1LTMCrC
 B0bG1tQDKS5JDYAAAAA==
X-Change-ID: 20240930-m_can-cleanups-53ce4276f1b1
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ruyZ4LuCnuC4KtiwQ2V7atvLO/E534PBCUflofb8yQs=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm+uPWW9RUq9xQO8h+UMwWfPID7oaGvrrEEVtUu
 3p4ZiuGs+qJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZvrj1gAKCRAoOKI+ei28
 b5M9CACdGlc/3EY7u77MqG7RlQoabWZOoa/MUV0QRcwFXblkYcRWIR3oAs+SSMifsPGzb0FL+I5
 lKcjat0ki8j5dLGqxe/+q/j7cUXzSvICWshHCXbIYHvTXGh0fctzhGKfedyM87iuVXeyl761MI3
 luiInIavXqJQx+ukolMZIHZNW1tRqqEj69NANY3Kln7SsXYBBaNgX35v/4kAIYv2IMDneTDGL9a
 BUPdtAmNLpojaIFPOklHyI18IsUGyF1A/z4iufiapdMCDW+6hYusNccOc2gKhOqzwC9pF/fqlMs
 96NmXVXJIdwttGwUNkoyl1XHjnSMgVmO68GEk09dalLaUIlw
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

In commit b382380c0d2d ("can: m_can: Add hrtimer to generate software
interrupt") support for IRQ-less devices was added. Instead of an
interrupt, the interrupt routine is called by a hrtimer-based polling
loop.

That patch forgot to change free_irq() to be only called for devices
with IRQs. Fix this, by calling free_irq() conditionally only if an
IRQ is available for the device (and thus has been requested
previously).

Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a978b960f1f1e1e8273216ff330ab789d0fd6d51..16e9e7d7527d9762d73a7ec47940c73c0976e05d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1765,7 +1765,8 @@ static int m_can_close(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	m_can_stop(dev);
-	free_irq(dev->irq, dev);
+	if (dev->irq)
+		free_irq(dev->irq, dev);
 
 	m_can_clean(dev);
 

---
base-commit: d505d3593b52b6c43507f119572409087416ba28
change-id: 20240930-m_can-cleanups-53ce4276f1b1

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



