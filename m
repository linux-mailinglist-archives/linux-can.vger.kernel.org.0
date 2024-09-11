Return-Path: <linux-can+bounces-1476-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88C974D85
	for <lists+linux-can@lfdr.de>; Wed, 11 Sep 2024 10:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE4E1C250A2
	for <lists+linux-can@lfdr.de>; Wed, 11 Sep 2024 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E15154BE4;
	Wed, 11 Sep 2024 08:51:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C814B960
	for <linux-can@vger.kernel.org>; Wed, 11 Sep 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044701; cv=none; b=lqV3ibfRdSjvWZr7IMcYzKIAUjvVcAuqzNN+6hm38OKsZzUELcO7S60MHUyBdLPYRXq80Yv+u/b5MRymrtjiv5LWBq6kHju33Yv0Ip1MmoNU7I1tPbD/eBQbuLCHp1MVfXsZaNLcJ/ilvw3xar+L3K/EwFA569v/c8MzZ2htyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044701; c=relaxed/simple;
	bh=UpX/Ypj/LsvICi5sJpIThh5Z3znBn+6SGKm9oQeNnCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DACqdQaop81gRHPNX6RZ8MykZ3Pio6e2iOXpawRE4jRHiYxPExyYI42EwQFBc6bxZ0Rrfp2wgsSCJwEAS+qcKidvpVbi58cOmVFO66vHOX8wGBukxG5fGn1Sxcn62UpRGWJKC2gxEEazAs49DVxABieYHV0D38c5RFfHnOMgYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soJ4c-0005at-0Q
	for linux-can@vger.kernel.org; Wed, 11 Sep 2024 10:51:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soJ4b-00766Y-JQ
	for linux-can@vger.kernel.org; Wed, 11 Sep 2024 10:51:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 43BC7338194
	for <linux-can@vger.kernel.org>; Wed, 11 Sep 2024 08:51:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2612F33818B;
	Wed, 11 Sep 2024 08:51:35 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d96d89aa;
	Wed, 11 Sep 2024 08:51:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 11 Sep 2024 10:51:30 +0200
Subject: [PATCH] can: m_can: m_can_chip_config(): mask timestamp wraparound
 IRQ
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-can-m_can-mask-timestamp-wraparound-irq-v1-1-0155b70dc827@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIABJa4WYC/x2NywrCMBAAf6Xs2YUkVlF/RUTWZNVFkqa79QGl/
 27oZWAuMzMYq7DBqZtB+SMmQ2niNx3EJ5UHo6TmEFzo3dF7jFQwX1eSvXCSzDZRrvhVqqTDuyQ
 UHTFtKeyj6w+3XYJWq8p3+a2n82VZ/rBM1A15AAAA
X-Change-ID: 20240911-can-m_can-mask-timestamp-wraparound-irq-d3a26c048b5d
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jake Hamby <Jake.Hamby@Teledyne.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=DKq5RRZE6rNCXS6lWV7Nl0shThePckArACpC86ox004=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm4VoTvcq5yFs0zgIL9NmNQnc4kLwOU7k5UmjAV
 Y9YuRjqquSJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZuFaEwAKCRAoOKI+ei28
 b/yLCACCnLhTA69iLmUao9WSyWl7UhUaGBG+qFpNBPKjSb3lmkpXovSNmxoY1LOxcSnpzde7Jzr
 Roz33x+Td5bdbBm+CRkSSAItzCKSLR/H397B0BLe0KdBjfMv7BeQchPg7QymKdUt+kpOI47L84+
 1ym2nGcaM/Fmv3Gr7XaIoyFVM8SKCApSp3sPDGqmZutIp6+J2hXqTM9veSC5Z5wqlxUaT9Y8Vu1
 /plpq/pU7NLWzCA6UAsOek4rUQyLYUTPS5SLLHl8Ljk1N6lKu3YpiXy76H0v7CrF4s3jxuD0urc
 IE0tdsk65xCW7/Jr2doXEomwXtpnXwv9yHNQ+Gf3kipGgrwp
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Jake Hamby <Jake.Hamby@Teledyne.com>

On the Microchip SAMA7G54 MPU the IR_TSW (timestamp wraparound) fires
at about 1 Hz, but the driver doesn't care about it. Add it to the
list of interrupts to disable in m_can_chip_config to reduce unneeded
wakeups.

Signed-off-by: Jake Hamby <Jake.Hamby@Teledyne.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

this hunk was originally part of Jake's original patch

| https://patch.msgid.link/DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com

I've split it into a separate patch.

regards,
Marc
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 012c3d22b01dd3d8558f2a40448770ca1da1aa1e..a7b3bc439ae596527493a73d62b4b7a120ae4e49 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1434,7 +1434,8 @@ static int m_can_chip_config(struct net_device *dev)
 
 	/* Disable unused interrupts */
 	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
-			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
+			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F |
+			IR_TSW);
 
 	err = m_can_config_enable(cdev);
 	if (err)

---
base-commit: f3b6129b7d252b2fbdcac2e0005abc6804dc287c
change-id: 20240911-can-m_can-mask-timestamp-wraparound-irq-d3a26c048b5d

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



