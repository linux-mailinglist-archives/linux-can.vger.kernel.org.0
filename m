Return-Path: <linux-can+bounces-2304-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B766C9DFC97
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 10:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B88281DE7
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4F1FAC49;
	Mon,  2 Dec 2024 09:00:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03C1FA27F
	for <linux-can@vger.kernel.org>; Mon,  2 Dec 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130055; cv=none; b=C1088m7Rox5d3Tyad2xUMyanCpVbepQ+P0tumLGNZpbeI65k69D01eooiJYVWCZ+2/9Ktkh9CeiFI0ftLbYSLs9q8BmyXVX1dVfMpoV5wOo1txx+KpbD0tXe/eu+/ojnkF503CL/g1Ox4CQ492ym1pNzznZiZrXdaymXeitgxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130055; c=relaxed/simple;
	bh=dRNkCEDrD0dyT0vw+xXw/40K2d0o47l4Jw3PNM/LvkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWMtg743KfdTTRlKWlE08hG1pvqNLgTDRKJ6sgAHFAaE4BU/4HMiYucVjvFekHZA6vh/om6Hn0NZ/yFyrZ2KCwp2mF8TywdnE8dZCZBxSoWAscv/9JoidVjnncMeH9kwl+6Eh6ugFlWL8LZLoZkRHlBRrqN7zX/mjntejD5pS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IV-0007gf-Ck
	for linux-can@vger.kernel.org; Mon, 02 Dec 2024 10:00:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IS-001GbJ-07
	for linux-can@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:48 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 71E4538338C
	for <linux-can@vger.kernel.org>; Mon, 02 Dec 2024 09:00:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 44574383329;
	Mon, 02 Dec 2024 09:00:45 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 544f4901;
	Mon, 2 Dec 2024 09:00:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marek Vasut <marex@denx.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/15] can: ifi_canfd: ifi_canfd_handle_lec_err(): fix {rx,tx}_errors statistics
Date: Mon,  2 Dec 2024 09:55:42 +0100
Message-ID: <20241202090040.1110280-9-mkl@pengutronix.de>
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

The ifi_canfd_handle_lec_err() function was incorrectly incrementing only
the receive error counter, even in cases of bit or acknowledgment errors
that occur during transmission.

Fix the issue by incrementing the appropriate counter based on the
type of error.

Fixes: 5bbd655a8bd0 ("can: ifi: Add more detailed error reporting")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Link: https://patch.msgid.link/20241122221650.633981-8-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 58 ++++++++++++++++++---------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index d32b10900d2f..c86b57d47085 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -390,36 +390,55 @@ static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 		return 0;
 
 	priv->can.can_stats.bus_error++;
-	stats->rx_errors++;
 
 	/* Propagate the error condition to the CAN stack. */
 	skb = alloc_can_err_skb(ndev, &cf);
-	if (unlikely(!skb))
-		return 0;
 
 	/* Read the error counter register and check for new errors. */
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	if (likely(skb))
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
+	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST) {
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST)
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST) {
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST) {
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT0;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST) {
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT1;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST) {
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST)
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST) {
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST) {
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_FORM;
+	}
 
 	/* Reset the error counter, ack the IRQ and re-enable the counter. */
 	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
@@ -427,6 +446,9 @@ static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 	       priv->base + IFI_CANFD_INTERRUPT);
 	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);
 
+	if (unlikely(!skb))
+		return 0;
+
 	netif_receive_skb(skb);
 
 	return 1;
-- 
2.45.2



