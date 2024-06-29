Return-Path: <linux-can+bounces-906-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB491CC7D
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 13:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAFB1F224E1
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9AF74418;
	Sat, 29 Jun 2024 11:40:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516158ADB
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661229; cv=none; b=DxO0WXEyr2KmXSZvLtzhlVHqjJgGEiRt2x92uvR2uGr0EMm7O4IY1fJSJbnfeiw3WfOMc1fHb7rSnKjsFz6wl+S++jf5xDRfIyMkIYc8wTmmj9wEXxMzu50YcjP5mg2VKh7ZshMZDBCR1kTjhZ+Hxre4Jp6iBKnnOxqGm1DYo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661229; c=relaxed/simple;
	bh=uNrHb/7z/k6IG+yWTjuG3N0oLWxbe/A4syfVIUoUYrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=regnmo/wSKPi+//BPl63dI0DjHVYEV/VAf8qayouEH3eDAEAWrBzpQGvQLonN9uDBPVRUfvWPbuMHza3LidZzEAZ2q3AoJota3VrXdq3u7Sqpr6cyjAwF9Km2mNRx6/Hir4r0jCdi0JjhQ1pzeyD33RCrzJZSWcBzPQKxasoADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRN-00038E-K4
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRL-005paI-8H
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E2E752F648A
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C7FDE2F6449;
	Sat, 29 Jun 2024 11:40:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id df721be0;
	Sat, 29 Jun 2024 11:40:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/14] can: mcp251xfd: update errata references
Date: Sat, 29 Jun 2024 13:36:21 +0200
Message-ID: <20240629114017.1080160-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240629114017.1080160-1-mkl@pengutronix.de>
References: <20240629114017.1080160-1-mkl@pengutronix.de>
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



