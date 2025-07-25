Return-Path: <linux-can+bounces-4156-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E5BB1218B
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2396FAC6528
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1E32EF2AF;
	Fri, 25 Jul 2025 16:13:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F62EF295
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460018; cv=none; b=Y9NKVSl1YnnU8H+YSI5TbZVAwpVU8HHEBz6M+JknAANIgC5OqUiWiT5H5PSg80S5NggSsVEHFSvjfxEeB9QfPgkivLH5539hxYpVDL8DT3O4MFXq0Mkbl7qRRhvu8dIjzSLjI/C6+dx2pwjhxA8bRh3daSrtla8O0/KNeFRuzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460018; c=relaxed/simple;
	bh=di/y1ujHcckq1+9t7FFelcdoI8xdT4ldZBty9k1c+D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfDs2tG/uvo/vs/yme7LRkrsnVvX9wreKJULRnlt5+oCLc/mOoJTcY9oyu6K5vm7MZLUOby5bcBvip3puRxq+nkNt9FPFTq49GtM8gtDkVVQTj+CkGtRXvASWby6tsSzStJWJQ83IcV4sWT0Y4jglg0BBGQ3fvHIjKXz62DZHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL39-0006bW-3m
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:35 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL37-00AFX5-01
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:33 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8C20A449865
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F412444980C;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 649cccf0;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Randy Dunlap <rdunlap@infradead.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/27] can: tscan1: CAN_TSCAN1 can depend on PC104
Date: Fri, 25 Jul 2025 18:05:15 +0200
Message-ID: <20250725161327.4165174-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

From: Randy Dunlap <rdunlap@infradead.org>

Add a dependency on PC104 to limit (restrict) this driver kconfig
prompt to kernel configs that have PC104 set.

Add COMPILE_TEST as a possibility for more complete build coverage.
I tested this build config on x86_64 5 times without problems.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250721002823.3548945-1-rdunlap@infradead.org
[mkl: fix conflict, remove Fixes: tag]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index ba16d7bc09ef..e061e35769bf 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
-	depends on ISA || (COMPILE_TEST && HAS_IOPORT)
+	depends on (ISA && PC104) || (COMPILE_TEST && HAS_IOPORT)
 	help
 	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
 	  https://www.embeddedts.com/products/TS-CAN1
-- 
2.47.2



