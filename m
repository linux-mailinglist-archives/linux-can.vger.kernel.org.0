Return-Path: <linux-can+bounces-1781-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849BA9B061B
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D8F2834EF
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929E212198;
	Fri, 25 Oct 2024 14:47:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805503B290
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867658; cv=none; b=aU1wVaz8ay/Nz8rt/2B1hfYJCQ4VPpUDZADeKrWXR4xQmdkXnUnPbWm3BBhjjzJUTohmLDUwaP/R4gsiCtMIpkarcDarSbcmzC6d3uRvoeZLxQfuon4CjEg2AL/5P4UfloHbL8DCg8Sbxzmu73MUWONwdniJ7+Zp8TP0j67IOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867658; c=relaxed/simple;
	bh=6YwKegnpwMlkce+A8tzgEAQWND4eqyOep74ce/8am10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=flzNNOx0HUMYaxAump5trsutuGxTFRhCDyIo45wzh8smy7pKU620EVmrWaiPVbTSnj2KryDIwbM/ioi1e0H2F4MRkOMsraMmbRrH9J8fcDutuED0z5FN7SKchToXd3WkNb094kNpuKnPO2AX7euLJsFk+3vnjeWJbRoc68BjQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4LbC-0000hy-Un
	for linux-can@vger.kernel.org; Fri, 25 Oct 2024 16:47:34 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4LbC-000Nun-2D
	for linux-can@vger.kernel.org;
	Fri, 25 Oct 2024 16:47:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5D9FE35EB80
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 14:47:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3AD6B35EB77;
	Fri, 25 Oct 2024 14:47:32 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b75e4293;
	Fri, 25 Oct 2024 14:47:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 25 Oct 2024 16:47:19 +0200
Subject: [PATCH can] can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing
 configuration when switching CAN modes
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-mcp251xfd-fix-coalesing-v1-1-9d11416de1df@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAHavG2cC/x2MWwqAIBAAryL73YLaC7pK9CG61kKpKEQQ3j3pc
 2BmXiiUmQos4oVMNxeOoYHqBNjDhJ2QXWPQUg9KKomXTXpUj3fo+UEbzUmFw46+n3s5Tc4NmqD
 VKVMT/vMK1gTYav0Ah+2cCG4AAAA=
X-Change-ID: 20241010-mcp251xfd-fix-coalesing-f373066dd42e
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2950; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=6YwKegnpwMlkce+A8tzgEAQWND4eqyOep74ce/8am10=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnG6+APmOzIpFu7mVzEWzfdERoWACNGIZbPKSmb
 7Rfjvf0RtmJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxuvgAAKCRAoOKI+ei28
 b9JGB/9415TnRd2nP4b1F9ld7bXPBD5mcCPrnZjUALn5Et0lzORblfBk6dCB5gBWhZAqGKmB9hJ
 ZcivmgNo0BgzISK7xSd8cu6kWUqK/VoX7geTASTzhdyH3kufioTp0YsQ8+7tjoTOAXlqpoUQE9N
 AgJkRUNtBUu4xOfojsenqyVpmHGD0hqzxGpkaXjgMLUVX2K4E5Rg1ojzj9TS9aMo8ASb/1h5x3E
 6kYT01M/M++Gv/4IC3o/qAPECFtByOLKD+4Ovdh13Ww0wi0a00mV9ucHyxYyYhp1+u5KYeYfokQ
 cmoCT76hvg6irc4F2dijXrJhAMgLDNba2wlS9P+v0tWkYEUj
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Since commit 50ea5449c563 ("can: mcp251xfd: fix ring configuration
when switching from CAN-CC to CAN-FD mode"), the current ring and
coalescing configuration is passed to can_ram_get_layout(). That fixed
the issue when switching between CAN-CC and CAN-FD mode with
configured ring (rx, tx) and/or coalescing parameters (rx-frames-irq,
tx-frames-irq).

However 50ea5449c563 ("can: mcp251xfd: fix ring configuration when
switching from CAN-CC to CAN-FD mode"), introduced a regression when
switching CAN modes with disabled coalescing configuration: Even if
the previous CAN mode has no coalescing configured, the new mode is
configured with active coalescing. This leads to delayed receiving of
CAN-FD frames.

This comes from the fact, that ethtool uses usecs = 0 and max_frames =
1 to disable coalescing, however the driver uses internally
priv->{rx,tx}_obj_num_coalesce_irq = 0 to indicate disabled
coalescing.

Fix the regression by assigning struct ethtool_coalesce
ec->{rx,tx}_max_coalesced_frames_irq = 1 if coalescing is disabled in
the driver as can_ram_get_layout() expects this.

Reported-by: https://github.com/vdh-robothania
Closes: https://github.com/raspberrypi/linux/issues/6407
Fixes: 50ea5449c563 ("can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index e684991fa3917d4f6b6ebda8329f72971237574e..7209a831f0f2089e409c6be635f0e5dc7b2271da 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2019, 2020, 2021 Pengutronix,
+// Copyright (c) 2019, 2020, 2021, 2024 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 // Based on:
@@ -483,9 +483,11 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		};
 		const struct ethtool_coalesce ec = {
 			.rx_coalesce_usecs_irq = priv->rx_coalesce_usecs_irq,
-			.rx_max_coalesced_frames_irq = priv->rx_obj_num_coalesce_irq,
+			.rx_max_coalesced_frames_irq = priv->rx_obj_num_coalesce_irq == 0 ?
+				1 : priv->rx_obj_num_coalesce_irq,
 			.tx_coalesce_usecs_irq = priv->tx_coalesce_usecs_irq,
-			.tx_max_coalesced_frames_irq = priv->tx_obj_num_coalesce_irq,
+			.tx_max_coalesced_frames_irq = priv->tx_obj_num_coalesce_irq == 0 ?
+				1 : priv->tx_obj_num_coalesce_irq,
 		};
 		struct can_ram_layout layout;
 

---
base-commit: 9efc44fb2dba6138b0575826319200049078679a
change-id: 20241010-mcp251xfd-fix-coalesing-f373066dd42e

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



