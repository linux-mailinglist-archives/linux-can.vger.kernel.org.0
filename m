Return-Path: <linux-can+bounces-1880-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C739BBE6C
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 21:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975331F22469
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB551D4600;
	Mon,  4 Nov 2024 20:01:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D61D359A
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750490; cv=none; b=uMFLjQk9PlSOMZEnB0mxxdJo+smStpLjy7ag8pO9O85Z9C3XhaDzIAMCOnJUcMnSx9voQD6GOZ2xwTG5gYUz8f/SnsnLfNcHw7Z55V6pprUuzPdoOJ733jmz5Z9Smf/ZFVx0NmJYewpErA+raXP0I3JKNy2AfqBazf9521C5zqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750490; c=relaxed/simple;
	bh=21LjG5D68Yz7L1/7+dWMezVD0OVIgGG0fLD3VYtxxkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws95eJE/JHWwyuUgf94yrA681l5YBWzSSmK2ylpw5o8LrOOHfGBrEjZ1+sXyV6fjD24CAfQxGlEUkq1trdSy2NSC7vC3V69zoWGwlcWEJ/U5Su7OfxVa4PO++UG4JFfSAi7Gth4HwNnWU05VrjZq2ySyrgH25GgkZcKc3stF7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GQ-0001a3-Ij
	for linux-can@vger.kernel.org; Mon, 04 Nov 2024 21:01:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GP-00225f-1A
	for linux-can@vger.kernel.org;
	Mon, 04 Nov 2024 21:01:25 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0C688367F9C
	for <linux-can@vger.kernel.org>; Mon, 04 Nov 2024 20:01:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9CF42367F68;
	Mon, 04 Nov 2024 20:01:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3004bb28;
	Mon, 4 Nov 2024 20:01:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jean Delvare <jdelvare@suse.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 6/8] can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST
Date: Mon,  4 Nov 2024 20:53:29 +0100
Message-ID: <20241104200120.393312-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104200120.393312-1-mkl@pengutronix.de>
References: <20241104200120.393312-1-mkl@pengutronix.de>
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

From: Jean Delvare <jdelvare@suse.de>

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), OF
can be enabled on all architectures. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20241022130439.70d016e9@endymion.delvare
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/Kconfig b/drivers/net/can/rockchip/Kconfig
index fd8d9f5eeaa4..d203c530551f 100644
--- a/drivers/net/can/rockchip/Kconfig
+++ b/drivers/net/can/rockchip/Kconfig
@@ -2,7 +2,7 @@
 
 config CAN_ROCKCHIP_CANFD
 	tristate "Rockchip CAN-FD controller"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select CAN_RX_OFFLOAD
 	help
-- 
2.45.2



