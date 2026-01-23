Return-Path: <linux-can+bounces-6274-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NBEBTdMc2lDugAAu9opvQ
	(envelope-from <linux-can+bounces-6274-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 11:23:51 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B56E74484
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 11:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D16913261103
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0C3341077;
	Fri, 23 Jan 2026 10:16:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777C30CDB1
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163405; cv=none; b=f124dbMc8L3gpxdZMldYEQ3ukb4aWVMbtcTOWbymMlHpI9ik0mFBpS0CJUJlubMupHJudcLj602GNGLwlKKYjGPgyu8IFiGMIQFJueUrtriR88hQ9Cx3S+eyniywWfEJcsEPqMZIHAUtuKg4o1Qb05D1XxinIHDHqCyVEIEmVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163405; c=relaxed/simple;
	bh=sSs60YgQd07lmmx5wE4IWKvfl1tMDMVLLadVL6NYN8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drm1gy3/sFxZ/F2Czbl7++72CqR3QRi8FhfI3MAVjkVe+FPnuEkqEBijRPrAbQ4Fcqp5Cn38/uuup1idvhuX9Hr/QmJkHARl9+oainhNyF1teoey0DVcUw0IfS2mQsZRI5tAF/w3XFXOtYguJwUzrlvh9Dt4ERlpWObA8YYhQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjEDX-0006FX-4L; Fri, 23 Jan 2026 11:16:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjEDX-0024il-1I;
	Fri, 23 Jan 2026 11:16:38 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8247F4D6BC9;
	Fri, 23 Jan 2026 10:16:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 23 Jan 2026 11:16:26 +0100
Subject: [PATCH can-next v2 1/2] can: sja1000: sja1000_err(): make use of
 sja1000_get_berr_counter() to read error counters
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-sja1000-state-handling-v2-1-687498087dad@pengutronix.de>
References: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
In-Reply-To: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Michael Tretter <m.tretter@pengutronix.de>
Cc: Achim Baumgartner <abaumgartner@topcon.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=sSs60YgQd07lmmx5wE4IWKvfl1tMDMVLLadVL6NYN8Y=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpc0p/IYCFPH9YYIW6FL+6adLpgoLWpouoRbURh
 kv/EDjb19CJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaXNKfwAKCRAMdGXf+ZCR
 nDxPCAC3hkiN9C5o6PC7tE4DGciSjdJ2wI66MHYUJCzeuivusXa3kY5Ri9HQ/q6I0HIrGBO42J0
 mDpTj/qiTwEpokiov2r3EzC8RQ9KJui0LfI+wnm2nwRsONG8QzPpiGqats8JGMH/i4lollHiy0c
 u8kloW/aBKEmNWBgizO91BP1ggHO/yIauJdSmYGGmEw2OVk0qMcxKJf8zpQqyVzEL7pNgbQSB+/
 LAFx5Rc91NZpwwOb7VfuxjP3Y0IvrI+t2TrZh0TAwPUKjT4K+nzPeHiHj7HCKkh0O6yWF8B6/Vl
 9g4J9WUwIQof8Uyh4atCnubTKvpfQgdAOT9B4ILti62H/Q7S
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-6274-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B56E74484
X-Rspamd-Action: no action

This is a preparation patch to make use of can_state_get_by_berr_counter()
which works on a struct can_berr_counter.

Reuse the existing function sja1000_get_berr_counter() to read the error
counters into a struct can_berr_counter.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index a8fa0d6516b9..ae3244b63b65 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -411,14 +411,13 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	struct sk_buff *skb;
 	enum can_state state = priv->can.state;
 	enum can_state rx_state, tx_state;
-	unsigned int rxerr, txerr;
+	struct can_berr_counter bec;
 	uint8_t ecc, alc;
 	int ret = 0;
 
 	skb = alloc_can_err_skb(dev, &cf);
 
-	txerr = priv->read_reg(priv, SJA1000_TXERR);
-	rxerr = priv->read_reg(priv, SJA1000_RXERR);
+	sja1000_get_berr_counter(dev, &bec);
 
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
@@ -455,8 +454,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	}
 	if (state != CAN_STATE_BUS_OFF && skb) {
 		cf->can_id |= CAN_ERR_CNT;
-		cf->data[6] = txerr;
-		cf->data[7] = rxerr;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
 	}
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
@@ -515,8 +514,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	}
 
 	if (state != priv->can.state) {
-		tx_state = txerr >= rxerr ? state : 0;
-		rx_state = txerr <= rxerr ? state : 0;
+		tx_state = bec.txerr >= bec.rxerr ? state : 0;
+		rx_state = bec.txerr <= bec.rxerr ? state : 0;
 
 		can_change_state(dev, cf, tx_state, rx_state);
 

-- 
2.51.0


