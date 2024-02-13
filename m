Return-Path: <linux-can+bounces-257-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48802852F87
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 12:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F451F2368A
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D989843AC8;
	Tue, 13 Feb 2024 11:34:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975C38FB9
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824093; cv=none; b=RLO2/b+q7Ks4ptW0X6f4k00UtuvdW+fNt6ObfSLuOMiYiGnJwrZyOxRrP+MVpzQqaMBXqMthYnM0OrVAUlx2lbA0pC7LPoT1FhNzog/WMQjt7iKhoWrgbVzgTHfNOcI4ShXJUHYA4XcA3CONs/SitagMrziCcCPjhbig3xrKX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824093; c=relaxed/simple;
	bh=PvV0Ohyc+SbJxCrpAOFZL6p/vesMLdOlDhWi1TlUcsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFsxQLhN4Fl64fpbpopwbDZBHX9+2eFIr+MX1RBMZJ9Hd5CfbEIg3uTsAe/lhS3PlPcmffatOoQ7YfpElBpKSEKk0ehbKEpZXimJCjz2bZsMR/Q9LH0+LpXcA3VXEVZe2+HVbWk5matVh1WnRnHVRn4Ub9PnpyDtTOcuks7jpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3o-0001BL-D5
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:48 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3k-000TXG-El
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:44 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1F9F728D6D6
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0681A28D688;
	Tue, 13 Feb 2024 11:34:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3f03e662;
	Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH net-next 23/23] MAINTAINERS: can: xilinx_can: remove Naga Sureshkumar Relli
Date: Tue, 13 Feb 2024 12:25:26 +0100
Message-ID: <20240213113437.1884372-24-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
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

Mails to naga.sureshkumar.relli@xilinx.com are bouncing due to a mail
loop. Seems Naga Sureshkumar Relli has left the company.

Remove Naga Sureshkumar Relli from the xilinx_can driver.

Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Link: https://lore.kernel.org/all/20240213-xilinx_can-v1-1-79820de803ea@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5a17a463685..1da02866febe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24140,7 +24140,6 @@ F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
 XILINX CAN DRIVER
 M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
-R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
-- 
2.43.0



