Return-Path: <linux-can+bounces-884-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63391C840
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 23:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09F5B20C59
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E280633;
	Fri, 28 Jun 2024 21:41:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D27F7FD
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610885; cv=none; b=aRTbvSBSdpBQAYifGja3SU/A1T49P9MU7FsZHYXg+b/nq7FLJ1K30WA86VgakX7Y5WNlx+dNEXelQ+Ty1s2reVUAxIrzfLABzWQIMP09dmLd47ElcS62Ow/+KviOtL4VTq+hb/8jPsvncp22hGHuIYSw6FdLLxRb0tprNysuTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610885; c=relaxed/simple;
	bh=OvmvoxTlE3ZJJWZzo5+0ZT6O7/7t8Xq/1c/0ZsEbLOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdN4rSNZOJsawYZtb6U0abSHHQPVf2KjzbTsQh6hlYiF/2PvT6G434tPdhajjvFW29BnOdwwATt+JoeO5xzMNyetWibHhf8wKLUB3tMllA15b1tK+aB1c+MAPQpywjLYq3t45teNXiPo5u+NBMEvZVyoVyuKvGnNOuFx82Nbd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLO-0001aq-1F
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLM-005h31-T7
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 90E302F60AC
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8842C2F6074;
	Fri, 28 Jun 2024 21:41:17 +0000 (UTC)
Received: from [10.11.86.119] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 856a58d8;
	Fri, 28 Jun 2024 21:41:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 28 Jun 2024 23:40:26 +0200
Subject: [PATCH v4 2/9] can: mcp251xfd: update errata references
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-mcp251xfd-workaround-erratum-6-v4-2-53586f168524@pengutronix.de>
References: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
In-Reply-To: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 =?utf-8?q?Stefan_Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=OvmvoxTlE3ZJJWZzo5+0ZT6O7/7t8Xq/1c/0ZsEbLOo=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmfy3vypUagknfl0R7JW2vb0VpABGVGpPBNHEes
 ez2hYBWlMOJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZn8t7wAKCRAoOKI+ei28
 b2msCACamUSbuAXN8c7Aum7ZFl5NqVnC007wtM8BzJr6qvj5TuPQl5JFDN7+/awObGPnG+VlAm1
 AP3//NFOybdfOak2R8f+fJUMtUCBhTYkYS1/jLumHi9ABOKFfUeP0ODqqd4r9AWFLqaJS5S2+Jd
 h96htHh1cFd/9kTtbVOlr/yl4za3pp82MPs4AV1Nov9W4d+hTNV1o2q0P0EXGrqJguJhPYXpaP4
 mK77yzd0eHK/1J9PovoiYXtWd6N7ss5vc28sYB0NfPoph4rjAjgU6MHWcZ+DAdsvNLuZTfHQU9Q
 NlAxvCL1ys7JmrF+xJf70vdRQ22/neQzoGLv7CbyilwcjVra
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Since the errata references have been added to the driver, new errata
sheets have been published. Update the references for the mcp2517fd
and mcp2518fd. For completeness add references for the mcp251863.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 61e749f97650..ce1610f240a4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1135,7 +1135,7 @@ mcp251xfd_handle_modif(const struct mcp251xfd_priv *priv, bool *set_normal_mode)
 		return 0;
 	}
 
-	/* According to MCP2517FD errata DS80000792B 1., during a TX
+	/* According to MCP2517FD errata DS80000792C 1., during a TX
 	 * MAB underflow, the controller will transition to Restricted
 	 * Operation Mode or Listen Only Mode (depending on SERR2LOM).
 	 *
@@ -1180,7 +1180,7 @@ static int mcp251xfd_handle_serrif(struct mcp251xfd_priv *priv)
 
 	/* TX MAB underflow
 	 *
-	 * According to MCP2517FD Errata DS80000792B 1. a TX MAB
+	 * According to MCP2517FD Errata DS80000792C 1. a TX MAB
 	 * underflow is indicated by SERRIF and MODIF.
 	 *
 	 * In addition to the effects mentioned in the Errata, there
@@ -1224,7 +1224,7 @@ static int mcp251xfd_handle_serrif(struct mcp251xfd_priv *priv)
 
 	/* RX MAB overflow
 	 *
-	 * According to MCP2517FD Errata DS80000792B 1. a RX MAB
+	 * According to MCP2517FD Errata DS80000792C 1. a RX MAB
 	 * overflow is indicated by SERRIF.
 	 *
 	 * In addition to the effects mentioned in the Errata, (most
@@ -1331,7 +1331,8 @@ mcp251xfd_handle_eccif(struct mcp251xfd_priv *priv, bool set_normal_mode)
 		return err;
 
 	/* Errata Reference:
-	 * mcp2517fd: DS80000789B, mcp2518fd: DS80000792C 2.
+	 * mcp2517fd: DS80000789C 3., mcp2518fd: DS80000792E 2.,
+	 * mcp251863: DS80000984A 2.
 	 *
 	 * ECC single error correction does not work in all cases:
 	 *
@@ -2095,7 +2096,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
 
 	/* Errata Reference:
-	 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789C 4.
+	 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789E 4.,
+	 * mcp251863: DS80000984A 4.
 	 *
 	 * The SPI can write corrupted data to the RAM at fast SPI
 	 * speeds:

-- 
2.43.0



