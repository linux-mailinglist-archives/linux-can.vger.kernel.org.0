Return-Path: <linux-can+bounces-3520-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419FCAA74B1
	for <lists+linux-can@lfdr.de>; Fri,  2 May 2025 16:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A129169060
	for <lists+linux-can@lfdr.de>; Fri,  2 May 2025 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386842571C9;
	Fri,  2 May 2025 14:14:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250BA256C9F
	for <linux-can@vger.kernel.org>; Fri,  2 May 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195246; cv=none; b=kxySUthp6nhCT6z2tL7L3wxXnwUs3/a9Am44nYBqdBIC37d7ZesXYjWRwpRGeAjtHFFtmzed49VJlFkGMJWoht9LuGOlPh5hS86vgpaB44LMBt+YdpE0q0ZR4ZQejDBf/pg2b+cUKEVO5KNvwHnXUIjjiaILFMvNxHgXQ7sVqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195246; c=relaxed/simple;
	bh=Ti5fQqNL3/P0T43KCHmLdTJn2MrwLdnaKDWpyP6L+Yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ktb1G1QcVScj/V8zegmSu3iJWuCHYFrUcSGkMbysutR7RN4R3V55hG1VJFxU7oq//d18kOfsFP40nBYkIS2sCrl+8juvVzQTrtGR/zl+h5CEi8x3VP9ci4qRkzZOrLJLAKVVFhuk49cK9VFPmY6EXR8n65MbpmVfCNlVsdFkrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uAr9M-0000v8-5V
	for linux-can@vger.kernel.org; Fri, 02 May 2025 16:14:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uAr9L-000lQZ-26
	for linux-can@vger.kernel.org;
	Fri, 02 May 2025 16:13:59 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5673E4065C7
	for <linux-can@vger.kernel.org>; Fri, 02 May 2025 14:13:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id ABE3140659D;
	Fri, 02 May 2025 14:13:56 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 39826ef2;
	Fri, 2 May 2025 14:13:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 May 2025 16:13:44 +0200
Subject: [PATCH 1/3] can: mcp251xfd: mcp251xfd_remove(): fix order of
 unregistration calls
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-can-rx-offload-del-v1-1-59a9b131589d@pengutronix.de>
References: <20250502-can-rx-offload-del-v1-0-59a9b131589d@pengutronix.de>
In-Reply-To: <20250502-can-rx-offload-del-v1-0-59a9b131589d@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-048ad
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Ti5fQqNL3/P0T43KCHmLdTJn2MrwLdnaKDWpyP6L+Yc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoFNMbpz87OapaXKbWzF12J12gplVe/ENOKMJGg
 nwet94JJKqJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaBTTGwAKCRAMdGXf+ZCR
 nBROB/0Ze9IdyFTWggQdVTIu7SikDc1++C+nVmbgh321px4R70xNq4/ln8+Rw4sla7liUoPagWP
 3FJEAS1wj/DM70+eZB7scbK3ySgrZ0kAtGAi4Cp1oy/YW+alOVrPU2kNOZiYD1D71/9cBE1Cg59
 tbXpe4vM3sP5fqCdXwV2cbSP/v5pe4x/bselx2ooObNKZCHhWm++PFf6kBRghaTQ2CH+XHkI7ro
 aRaAC85CqcLwvt3sZ0R1cyuT3VYPUc8IjJdIFoLvGRizHX1wzxMAtYEv2QxS0tBDVQup/BCKqNn
 fkIQXk/hmhYmATC8GIzHfJmHn7bTGvWSdJSTyDNn+do/gu73
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

If a driver is removed, the driver framework invokes the driver's
remove callback. A CAN driver's remove function calls
unregister_candev(), which calls net_device_ops::ndo_stop further down
in the call stack for interfaces which are in the "up" state.

With the mcp251xfd driver the removal of the module causes the
following warning:

| WARNING: CPU: 0 PID: 352 at net/core/dev.c:7342 __netif_napi_del_locked+0xc8/0xd8

as can_rx_offload_del() deletes the NAPI, while it is still active,
because the interface is still up.

To fix the warning, first unregister the network interface, which
calls net_device_ops::ndo_stop, which disables the NAPI, and then call
can_rx_offload_del().

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3bc56517fe7a..dd0b3fb42f1b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2174,8 +2174,8 @@ static void mcp251xfd_remove(struct spi_device *spi)
 	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
 	struct net_device *ndev = priv->ndev;
 
-	can_rx_offload_del(&priv->offload);
 	mcp251xfd_unregister(priv);
+	can_rx_offload_del(&priv->offload);
 	spi->max_speed_hz = priv->spi_max_speed_hz_orig;
 	free_candev(ndev);
 }

-- 
2.47.2



