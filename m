Return-Path: <linux-can+bounces-805-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D0911E06
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B668CB24B98
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D421F171643;
	Fri, 21 Jun 2024 08:02:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7C17083B
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956933; cv=none; b=B3aJmaLMYQmXdRtX47CPt5/8lL4L+57HNgWQbhYpX3AFDa1N7/oZBwSHcjRBPPGWUIsEAK/lkQST05m62OsHk0oCb5fiZbjY+Pp+Y/PWG84uYbO8tlvZ5V6lKiXDFolFJv4On5w4zNp1PTyfqg2+8jfNcfA/XCpQ1reZ63rsZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956933; c=relaxed/simple;
	bh=yiD90I/Ocf1dLl7j2ithHU9pTuOCi+MNARJ0Y5wo1vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGRSSSuMfve43PrqWotHaqe7P++VfyolNBl2PthAleEFifXuniDv4frKlQxJpGLfFmXuFwgflgVyTaLiTqlbekPk4IjSS2oJ/dNQmwDVEiSELsnrN1aw0hLUX9AijkXz7kngArMhQ+u6e+H2fELB3LCDvbXN3yb12h8Y3yk9JX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDl-00040T-Sa
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDh-003tI6-NQ
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5A3712EE3E6
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 137462EE396;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id af85d136;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Harini T <harini.t@amd.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/24] can: xilinx_can: Document driver description to list all supported IPs
Date: Fri, 21 Jun 2024 09:48:26 +0200
Message-ID: <20240621080201.305471-7-mkl@pengutronix.de>
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

From: Harini T <harini.t@amd.com>

Xilinx CAN driver supports AXI CAN, AXI CANFD, CANPS and CANFD PS IPs.
Document all supported IPs in comment description.

Signed-off-by: Harini T <harini.t@amd.com>
Link: https://lore.kernel.org/all/20240503060553.8520-3-harini.t@amd.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index fae0120473f8..d944911d7f05 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2017 - 2018 Sandvik Mining and Construction Oy
  *
  * Description:
- * This driver is developed for Axi CAN IP and for Zynq CANPS Controller.
+ * This driver is developed for AXI CAN IP, AXI CANFD IP, CANPS and CANFD PS Controller.
  */
 
 #include <linux/bitfield.h>
-- 
2.43.0



