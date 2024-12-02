Return-Path: <linux-can+bounces-2309-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AF9DFCB5
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E52E16404F
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F701FAC45;
	Mon,  2 Dec 2024 09:00:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AF1FAC25
	for <linux-can@vger.kernel.org>; Mon,  2 Dec 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130056; cv=none; b=RVQ8yup0tOEmhkN26ZwnNpuUzOxt8MKjJIMOf2Y4QA7XCVSKi07x4yFjxjcqypN0Xx2Cusxg4xYhM1iygUVomKxngiN2+1apOtB3AJakxg4rgoVklAHBgEbE5K9uI64PMbt6HU3sciXXOZB65NnTDZjeLPrsHC8AL5AJrzUVdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130056; c=relaxed/simple;
	bh=p7awPQ9JQQkWRCwMOxdTdFRuiWt5WxjlZtb82lC0anA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5eANH4UB0Sdeanh21b5AZFPmMCvW77MltUoVmLgIjtbSXO8aPms8hgaNrrSaCp7HJd2mdPLv9xQyZOor0XEnFsdPtnHSd/ngu0DwUYYD/YoFVaVVooQnyh+vW9zCcpXCRDi+yIF2Hj0906GVLXLtyh9f4+fG180WY0wjKuaLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IW-0007hL-3W
	for linux-can@vger.kernel.org; Mon, 02 Dec 2024 10:00:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IS-001Gbz-1F
	for linux-can@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:49 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C44A5383396
	for <linux-can@vger.kernel.org>; Mon, 02 Dec 2024 09:00:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E5CD538333B;
	Mon, 02 Dec 2024 09:00:45 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4d0dd13f;
	Mon, 2 Dec 2024 09:00:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 13/15] can: f81604: f81604_handle_can_bus_errors(): fix {rx,tx}_errors statistics
Date: Mon,  2 Dec 2024 09:55:47 +0100
Message-ID: <20241202090040.1110280-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202090040.1110280-1-mkl@pengutronix.de>
References: <20241202090040.1110280-1-mkl@pengutronix.de>
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

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

The f81604_handle_can_bus_errors() function only incremented the receive
error counter and never the transmit error counter, even if the ECC_DIR
flag reported that an error had occurred during transmission.

Increment the receive/transmit error counter based on the value of the
ECC_DIR flag.

Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20241122221650.633981-13-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/f81604.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index bc0c8903fe77..e0cfa1460b0b 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -526,7 +526,6 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 		netdev_dbg(netdev, "bus error interrupt\n");
 
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		if (skb) {
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
@@ -548,10 +547,15 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 
 			/* set error location */
 			cf->data[3] = data->ecc & F81604_SJA1000_ECC_SEG;
+		}
 
-			/* Error occurred during transmission? */
-			if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0)
+		/* Error occurred during transmission? */
+		if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0) {
+			stats->tx_errors++;
+			if (skb)
 				cf->data[2] |= CAN_ERR_PROT_TX;
+		} else {
+			stats->rx_errors++;
 		}
 
 		set_bit(F81604_CLEAR_ECC, &priv->clear_flags);
-- 
2.45.2



