Return-Path: <linux-can+bounces-1113-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A784947F3B
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D9C281B5F
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B210A15CD4E;
	Mon,  5 Aug 2024 16:23:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736915C133
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875018; cv=none; b=AFTE98g1WrgDlw35wJlFMELuB8Myc3dxyxR665TwHXX7dKUx+XcsSYSOvDLwtUEnUMm7cDPGZg04DtXBHq4YNV81sMvn1vcgP+3YrgLI5lIWiASbwaEl2CsPzhOjpxPi5bR8didIwmJi0lpbHMvFN4wX8DNbIftANBwoSAU5ahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875018; c=relaxed/simple;
	bh=PEMEOMWCp5/tFfsda7z8jK3ZnwSyWrntpuX+k3ze0FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuZyMDzTYiL3EJ6OOwobH+LU8TXITKVOkDc8AwH/A136Gfg31WVsdigx4iOpTAFov+PDTlf+XAKbWtj7mCIzcRJT0V9bAPb0lBYs3WPLlRJbRUcd8wBOLtP/FB2d/BUcRfjyAdlN9EMfnYEYKGHkDn+FG5WiBHShGsxmeHBvsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sb0Uh-00075E-4Z
	for linux-can@vger.kernel.org; Mon, 05 Aug 2024 18:23:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sb0Ug-004klG-Gf
	for linux-can@vger.kernel.org; Mon, 05 Aug 2024 18:23:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3A39C3173DC
	for <linux-can@vger.kernel.org>; Mon, 05 Aug 2024 16:23:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0592B3173C2;
	Mon, 05 Aug 2024 16:23:32 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1fd71a0e;
	Mon, 5 Aug 2024 16:23:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 05 Aug 2024 18:23:21 +0200
Subject: [PATCH 2/2] can: mcp251xfd: mcp251xfd_ring_init(): check
 TX-coalescing configuration
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-mcp251xfd-fix-ringconfig-v1-2-72086f0ca5ee@pengutronix.de>
References: <20240805-mcp251xfd-fix-ringconfig-v1-0-72086f0ca5ee@pengutronix.de>
In-Reply-To: <20240805-mcp251xfd-fix-ringconfig-v1-0-72086f0ca5ee@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=PEMEOMWCp5/tFfsda7z8jK3ZnwSyWrntpuX+k3ze0FQ=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmsPyAzhilXHlO6oxOzg0A8c9h0F9536GELXa1j
 3ycIzi8c4iJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZrD8gAAKCRAoOKI+ei28
 b3TZB/9JT0Tkb4c3aoQAdICWytGuvH79wIkROi1i/RfnZ5SYmhusvPgka+MsHSyWXT92THXmaR+
 FFhVmVlJoXQiOaABsI+IbotpeDTmXuzh8iUSQ/niavxiy5w9ugO13vUF9BGsuCH1Nqe5zT515Xv
 ev6eZIk721u0JDOBi9Y0cIQLPHiSLphuNnsxa/7KyqKZ3E0n+7kHNXfgDbXI+VBjhikv+aQNDSW
 wGF9zzMvmUvcoe4ZjJ3Bg/Nbl/HlntH6BOGPwdB9glP/kQQ3ChAdUCb/nYq5bBIhLIYXdW2xIHu
 JNtyPe/oPMD+5HYM8cQxhopuOr3yJ2V/0KQji9h99jj1bl/G
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

When changing the interface from CAN-CC to CAN-FD mode the old
coalescing parameters are re-used. This might cause problem, as the
configured parameters are too big for CAN-FD mode.

During testing an invalid TX coalescing configuration has been seen.
The problem should be been fixed in the previous patch, but add a
safeguard here to ensure that the number of TEF coalescing buffers (if
configured) is exactly the half of all TEF buffers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index f72582d4d3e8..83c18035b2a2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -290,7 +290,7 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	const struct mcp251xfd_rx_ring *rx_ring;
 	u16 base = 0, ram_used;
 	u8 fifo_nr = 1;
-	int i;
+	int err = 0, i;
 
 	netdev_reset_queue(priv->ndev);
 
@@ -386,10 +386,18 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 		netdev_err(priv->ndev,
 			   "Error during ring configuration, using more RAM (%u bytes) than available (%u bytes).\n",
 			   ram_used, MCP251XFD_RAM_SIZE);
-		return -ENOMEM;
+		err = -ENOMEM;
 	}
 
-	return 0;
+	if (priv->tx_obj_num_coalesce_irq &&
+	    priv->tx_obj_num_coalesce_irq * 2 != priv->tx->obj_num) {
+		netdev_err(priv->ndev,
+			   "Error during ring configuration, number of TEF coalescing buffers (%u) must be half of TEF buffers (%u).\n",
+			   priv->tx_obj_num_coalesce_irq, priv->tx->obj_num);
+		err = -EINVAL;
+	}
+
+	return err;
 }
 
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)

-- 
2.43.0



