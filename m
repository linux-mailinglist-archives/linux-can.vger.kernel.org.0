Return-Path: <linux-can+bounces-6429-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJQXMdLWfWkJUAIAu9opvQ
	(envelope-from <linux-can+bounces-6429-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 11:17:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE78C18AF
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 11:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72713303D2DB
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC26D346AEB;
	Sat, 31 Jan 2026 10:15:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3134320D
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854535; cv=none; b=uwwj79wih+nzNirB7cyfMp3Bx28b4+OlTTBQp3cVZM3oznTiKSu8lg5iNNixp3fBRbkZdmqVMioTzYOAvXgrjmPSz+WpAq5SxvBn+M0kbYikOwiO/HIfNMHlTJ7Jy362k1Jz7tOkCCCTanC96M5ufrlRM0rAquV/JoREWgbdclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854535; c=relaxed/simple;
	bh=yJEM19TKPK8Lkj2rFjErC95dTA2VwhZ8bpyLwZHtoXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXhzuVVgAYqZ1PWN0XkOeJh+4QXKwWiQPensLdMuGx2Sn7DMVaLHMhSN2UlKubDgOg7hG25w4nzn1QaVXAzTjw/RnKvB0LT5YZM9xvKy5D8z7a1wIrPl5JKIqoX1D5Y+4t8x6YECESry2wff//cRzN4pUtulTaQRlM7K8uaB9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80f-0002Sz-Ou; Sat, 31 Jan 2026 11:15:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80f-003OWn-1Y;
	Sat, 31 Jan 2026 11:15:20 +0100
Received: from blackshift.org (unknown [IPv6:2001:67c:1810:f051:d04a:1c63:e2:421c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E0CDF4DC575;
	Sat, 31 Jan 2026 10:15:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Michael Tretter <m.tretter@pengutronix.de>,
	Achim Baumgartner <abaumgartner@topcon.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 8/8] can: sja1000: sja1000_err(): use error counter for error state
Date: Sat, 31 Jan 2026 11:11:49 +0100
Message-ID: <20260131101512.1958907-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131101512.1958907-1-mkl@pengutronix.de>
References: <20260131101512.1958907-1-mkl@pengutronix.de>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-6429-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AE78C18AF
X-Rspamd-Action: no action

From: Michael Tretter <m.tretter@pengutronix.de>

The CAN controller sends the EPI interrupt whenever it reaches the error
passive status or enters the error active status from the error passive
status.

Instead of keeping track of the controller status in the driver, read the
txerr and rxerr counters and use can_state_get_by_berr_counter() to
determine the state of the CAN controller.

Suggested-by: Achim Baumgartner <abaumgartner@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Link: https://patch.msgid.link/20260123-sja1000-state-handling-v2-2-687498087dad@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 33 +++++++------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ae3244b63b65..67fccc15ed20 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -407,10 +407,9 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
+	enum can_state state, rx_state, tx_state;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	enum can_state state = priv->can.state;
-	enum can_state rx_state, tx_state;
 	struct can_berr_counter bec;
 	uint8_t ecc, alc;
 	int ret = 0;
@@ -418,6 +417,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	skb = alloc_can_err_skb(dev, &cf);
 
 	sja1000_get_berr_counter(dev, &bec);
+	can_state_get_by_berr_counter(dev, &bec, &tx_state, &rx_state);
+
+	if (status & SR_BS)
+		rx_state = CAN_STATE_BUS_OFF;
+
+	state = max(tx_state, rx_state);
 
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
@@ -440,18 +445,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		if (priv->flags & SJA1000_QUIRK_RESET_ON_OVERRUN)
 			ret = IRQ_WAKE_THREAD;
 	}
-
-	if (isrc & IRQ_EI) {
-		/* error warning interrupt */
-		netdev_dbg(dev, "error warning interrupt\n");
-
-		if (status & SR_BS)
-			state = CAN_STATE_BUS_OFF;
-		else if (status & SR_ES)
-			state = CAN_STATE_ERROR_WARNING;
-		else
-			state = CAN_STATE_ERROR_ACTIVE;
-	}
 	if (state != CAN_STATE_BUS_OFF && skb) {
 		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = bec.txerr;
@@ -493,15 +486,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			stats->rx_errors++;
 		}
 	}
-	if (isrc & IRQ_EPI) {
-		/* error passive interrupt */
-		netdev_dbg(dev, "error passive interrupt\n");
-
-		if (state == CAN_STATE_ERROR_PASSIVE)
-			state = CAN_STATE_ERROR_WARNING;
-		else
-			state = CAN_STATE_ERROR_PASSIVE;
-	}
 	if (isrc & IRQ_ALI) {
 		/* arbitration lost interrupt */
 		netdev_dbg(dev, "arbitration lost interrupt\n");
@@ -514,9 +498,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	}
 
 	if (state != priv->can.state) {
-		tx_state = bec.txerr >= bec.rxerr ? state : 0;
-		rx_state = bec.txerr <= bec.rxerr ? state : 0;
-
 		can_change_state(dev, cf, tx_state, rx_state);
 
 		if(state == CAN_STATE_BUS_OFF)
-- 
2.51.0


