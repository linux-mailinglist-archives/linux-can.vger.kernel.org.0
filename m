Return-Path: <linux-can+bounces-810-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB3911E0C
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13741C21020
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70669171679;
	Fri, 21 Jun 2024 08:02:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F9171099
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956935; cv=none; b=scDtHGP74FNhYCrgMvFcSIab0WU9uckV1UrlRs8BWarAKsX7jcjg6uMgjJSM73OD0UwgyNcQwbHMTtrbM/TZvlIuK9ij/Angp4TR7uxni7DzXW2z6PROrvxG84bqxeis152uJQg2vzSCuIwbjYCcC8ig1a5lJu8rygaryeHG+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956935; c=relaxed/simple;
	bh=dABXo7SHmdj7HKgpJPE9oV40sdRN5Kki6jCnw2IwbNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thLQRGKLZmLDDxfSrzF0t56bnyiQYZVee0gJOeXda4U7tRcllkgXTk8UG5R9B4mJ7jp9w21F0AE1/NH1p86CugThtLZ/JFsfu2uK/Y3tYkpOKRE/4u+WwxgBn78zJ5RlgympMF/kVF9IGDP5cHp3OvgdxS5VWOIGtRJKUrTcxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDm-00044j-Pr
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDi-003tJd-Qp
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 40F0C2EE408
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 879302EE3A5;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bbf46ed3;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/24] can: kvaser_pciefd: Group #defines together
Date: Fri, 21 Jun 2024 09:48:32 +0200
Message-ID: <20240621080201.305471-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
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

From: Martin Jocic <martin.jocic@kvaser.com>

Increases readability

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/20240614151524.2718287-2-martin.jocic@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 7b5028b67cd5..fa205091aafe 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -29,10 +29,10 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
 #define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
 #define KVASER_PCIEFD_DMA_COUNT 2U
-
 #define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
 
 #define KVASER_PCIEFD_VENDOR 0x1a07
+
 /* Altera based devices */
 #define KVASER_PCIEFD_4HS_DEVICE_ID 0x000d
 #define KVASER_PCIEFD_2HS_V2_DEVICE_ID 0x000e
-- 
2.43.0



