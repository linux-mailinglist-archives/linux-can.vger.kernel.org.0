Return-Path: <linux-can+bounces-1463-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED9E973F0C
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 19:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D601F21B7C
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519E1B4C41;
	Tue, 10 Sep 2024 17:15:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18771B14EB
	for <linux-can@vger.kernel.org>; Tue, 10 Sep 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988543; cv=none; b=cSMmvxx6oDNJ10MKBS42DMc3lCJHbsZ4PMzKPLQCRviJ5noqDSgPV51Elf75ASbt9yFnLVJSC5OOOnVYh+iLZVqTvPMiNyvPtYjl7WfiAx/NH7HgH5pxRdeks3Uy5r+cSzamBVbgWYw6FxKoAfXhY8wq0fhVhjIiFGme1zu7flI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988543; c=relaxed/simple;
	bh=6eKnETgFCPGV1MbCuzFwJikTxGcfxpqLWif7+xttY94=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HIb7fOmq9b8TJn54dIod3HUhAT4750SgKWUqGTT6VcdVH7c/l8tO0TH65WtcK8m4qsa9vhAPTAd2dDE69APrb71H1vbD/qubQxx7VxbZ05Ir9wi2MvKAbifBkCDi3xJGBBDPIajKTNTGp112AjsrAC6Y4fyBQtnmdMmoc2LmRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1so4Sn-0005C6-WA
	for linux-can@vger.kernel.org; Tue, 10 Sep 2024 19:15:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1so4Sn-006wTq-CO
	for linux-can@vger.kernel.org; Tue, 10 Sep 2024 19:15:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 18F0F337A37
	for <linux-can@vger.kernel.org>; Tue, 10 Sep 2024 17:15:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AEAFA337A19;
	Tue, 10 Sep 2024 17:15:34 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 93b5036e;
	Tue, 10 Sep 2024 17:15:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can v3 0/2] can: m_can: fix struct
 net_device_ops::{open,stop} callbacks under high bus load
Date: Tue, 10 Sep 2024 19:15:27 +0200
Message-Id: <20240910-can-m_can-fix-ifup-v3-0-6c1720ba45ce@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALB+4GYC/31Py27DIBD8lYhzQbAQO/SUVLZvkapeq6iiGMeoN
 YvwQ6ki/3uJb730stLszM7s3Mnokncjed7dSXKLHz2GDOTTjtjehKujvs2YAAfFNdfUmkCHj8f
 s/I36bo60LLnkhTXKWEPyYUwuc5vpO8lKcsnLLuFApz45s/lV58Prm1Dnlz2AqHRVyVPZgJC8b
 kQhTk1ZN7qG4x8ZC2aIqRWKxYQtw3n6RvxiFodHau/HCdPP1mSBLfu/pxegnMKn3LsClOEHfYw
 uXOcpYfA31jpyWdf1F3d7P4IfAQAA
X-Change-ID: 20240909-can-m_can-fix-ifup-770306ca4aca
To: Jake Hamby <Jake.Hamby@Teledyne.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=6eKnETgFCPGV1MbCuzFwJikTxGcfxpqLWif7+xttY94=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm4H6x2qBr0jCp4C8FkJLUoNgYJ9LikitJAI/ES
 qVFaRm2dEmJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZuB+sQAKCRAoOKI+ei28
 b5bUB/0YNago1EtjMdA9T0wJdwAbu96GpN5DcQGlbEiCwQS3z218J9gZYbFFZ+8HHzbsgOQGgmk
 CigdSIzFKOU/GfnDC4aoCfoTFU06mHMjBPQfuXkCWmupFugwH0Smi9I3ACHuFx0weK2YVWPcO6u
 HcWi2rE/vQGirwPdJEubMq2yZeVc9ZpJsUPZyJ+l88SoLeQss6rTYZgXBUkPl7hmg3mxyIh/Be4
 AFuq53TQOByjGKuAo/doDB8W5+1g6ovMZ3efyC89O+a/oaWbDRBJFd4FIuy4aJGY6uFBd2LMiZz
 kOHoBSgck+T4hA7KgOJTrrUx/eeueoLzd0ZPt5rF6Juow6la
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Under high CAN-bus load the struct net_device_ops::{open,stop}
callbacks (m_can_open(), m_can_close()) don't properly start and
shutdown the device.

Fix the problems by re-arranging the order of functions in
m_can_open() and m_can_close().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v3:
- 1/2: m_can_close(), m_can_open(): move location of napi_disable(),
  call can_rx_offload_disable() for peripherals napi_disable()
  otherwise
- 1/2: add Signed-off-by: Jake Hamby <Jake.Hamby@Teledyne.com>
- Link to v2: https://patch.msgid.link/20240909-can-m_can-fix-ifup-v2-0-2b35e624a089@pengutronix.de

Changes in v2:
- 1/2: split timestamp wraparound changes into separate patch
- 1/2: added "Not-Signed-off-by: Hamby, Jake (US) <Jake.Hamby@Teledyne.com>"
- 2/2: new patch: fix order of clock shutdown
- Link to v1: https://patch.msgid.link/DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com

---
Jake Hamby (1):
      can: m_can: enable NAPI before enabling interrupts

Marc Kleine-Budde (1):
      can: m_can: m_can_close(): stop clocks after device has been shut down

 drivers/net/can/m_can/m_can.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 48aa361c5db0b380c2b75c24984c0d3e7c1e8c09
change-id: 20240909-can-m_can-fix-ifup-770306ca4aca

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



