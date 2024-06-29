Return-Path: <linux-can+bounces-900-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E991CC71
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 13:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0741C214E2
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78864548FD;
	Sat, 29 Jun 2024 11:40:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79904D8BB
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661226; cv=none; b=OLZZgaaPgAkfYbHcT4fo8wzFMHlICN8FW7amW5bPywSq1OclufGjD6QCgNAAufqqhDA8fKugm1FxvSqNu9RC6Grb+ov9/gZUuaUz/weKu7a/yQSzh8iSwcxrentzCw191+v7rKLkr4BCaN9zVjnoQh/0kluui2jbELz3enzFKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661226; c=relaxed/simple;
	bh=gcLBhe2adhkr1RK0jCeYp9xFNp8uV/m3PA/8S2t7o4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+lOuzI3lxQlY5Jj/c8j5zOQIdS8tlf3ygg7C90IxbTxicMxbRTA1K1dPjFj/iMBkN0emLK13VxSXmBRE+2AxRhQ9JvB2sQ847BsoZb/ErH+mxt4DUCIf7bnNxKORxDEtorAHBIbXedJpBquZGrNcd2KoKM0w605Zwe7O4IQ7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRK-000352-QR
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRJ-005pXw-O2
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 69FF22F6458
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 220A22F6438;
	Sat, 29 Jun 2024 11:40:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 342ebc67;
	Sat, 29 Jun 2024 11:40:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/14] can: m_can: Constify struct m_can_ops
Date: Sat, 29 Jun 2024 13:36:18 +0200
Message-ID: <20240629114017.1080160-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240629114017.1080160-1-mkl@pengutronix.de>
References: <20240629114017.1080160-1-mkl@pengutronix.de>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'struct m_can_ops' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4806	    520	      0	   5326	   14ce	drivers/net/can/m_can/m_can_pci.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   4862	    464	      0	   5326	   14ce	drivers/net/can/m_can/m_can_pci.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/all/a17b96d1be5341c11f263e1e45c9de1cb754e416.1719172843.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.h          | 2 +-
 drivers/net/can/m_can/m_can_pci.c      | 2 +-
 drivers/net/can/m_can/m_can_platform.c | 2 +-
 drivers/net/can/m_can/tcan4x5x-core.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 3a9edc292593..92b2bd8628e6 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -91,7 +91,7 @@ struct m_can_classdev {
 
 	ktime_t irq_timer_wait;
 
-	struct m_can_ops *ops;
+	const struct m_can_ops *ops;
 
 	int version;
 	u32 irqstatus;
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index 45400de4163d..d72fe771dfc7 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -77,7 +77,7 @@ static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
 	return 0;
 }
 
-static struct m_can_ops m_can_pci_ops = {
+static const struct m_can_ops m_can_pci_ops = {
 	.read_reg = iomap_read_reg,
 	.write_reg = iomap_write_reg,
 	.write_fifo = iomap_write_fifo,
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index df0367124b4c..983ab80260dd 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -68,7 +68,7 @@ static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
 	return 0;
 }
 
-static struct m_can_ops m_can_plat_ops = {
+static const struct m_can_ops m_can_plat_ops = {
 	.read_reg = iomap_read_reg,
 	.write_reg = iomap_write_reg,
 	.write_fifo = iomap_write_fifo,
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index d723206ac7c9..2f73bf3abad8 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -357,7 +357,7 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 	return 0;
 }
 
-static struct m_can_ops tcan4x5x_ops = {
+static const struct m_can_ops tcan4x5x_ops = {
 	.init = tcan4x5x_init,
 	.read_reg = tcan4x5x_read_reg,
 	.write_reg = tcan4x5x_write_reg,
-- 
2.43.0



