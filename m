Return-Path: <linux-can+bounces-815-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F062911E19
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF321C2115A
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FDE172763;
	Fri, 21 Jun 2024 08:02:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D59171668
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956938; cv=none; b=XbNO+5Jjwn5g+oin8MwcGKT9RwqEsMdrwYNkhMEpcRhGBzRw8HGng/M6014e/idccCdOLcMXqx+ZED2B0TYU+NP6ICslQ8x/Y+kNiah6b2WoJz10oV9AkSxkJhRNiaMdQ/ws0EolXsu06Qbqp9Qk5wx6PddPkMkPwPVrjytii9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956938; c=relaxed/simple;
	bh=mDqk1dl5NFsNmrpUJgXabP5bUFYZsvUH02hIXQJwZ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZKyobEWXgnuO5OnGR7K8TyuYt3VTjSB0pUUmu+Rq7OwU3in7IJbrTxE/ORX2qYj9HS5mdAS905umC1Bj6ZA7LRzclJsqzyQ1w+tJ4bWbXRD4J3Sn8xwlqnjMG4XFezV/7p0LDJVVsHo3BTP6ZYtW9mfZjXA4blkDDMmVD6vtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDo-00046w-DD
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDk-003tMp-An
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E5E402EE447
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5EB992EE3C2;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1ce5fce1;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 22/24] can: mcp251x: simplify with spi_get_device_match_data()
Date: Fri, 21 Jun 2024 09:48:42 +0200
Message-ID: <20240621080201.305471-23-mkl@pengutronix.de>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/20240606142424.129709-2-krzysztof.kozlowski@linaro.org
[mkl: add intermediate cast to uintptr_t]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 643974b3f329..3b8736ff0345 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1300,7 +1300,6 @@ MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
 
 static int mcp251x_can_probe(struct spi_device *spi)
 {
-	const void *match = device_get_match_data(&spi->dev);
 	struct net_device *net;
 	struct mcp251x_priv *priv;
 	struct clk *clk;
@@ -1338,10 +1337,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	priv->can.clock.freq = freq / 2;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
 		CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
-	if (match)
-		priv->model = (enum mcp251x_model)(uintptr_t)match;
-	else
-		priv->model = spi_get_device_id(spi)->driver_data;
+	priv->model = (enum mcp251x_model)(uintptr_t)spi_get_device_match_data(spi);
 	priv->net = net;
 	priv->clk = clk;
 
-- 
2.43.0



