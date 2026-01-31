Return-Path: <linux-can+bounces-6426-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIH2F23WfWn/TwIAu9opvQ
	(envelope-from <linux-can+bounces-6426-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 11:16:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E5DC1876
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 11:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6958B301993A
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3B341650;
	Sat, 31 Jan 2026 10:15:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632E33D51B
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854533; cv=none; b=OF2wIOrqe+T0JGk97gXYGaA8/3xPD4vuQqkzkFdLFmyl81lvN357R2NTQm5+KuDbVLhFkTdT1dbYzIMlqF3ONXwvJgAXVxs8hfHZzpydBPT5wTTLPvZ8jFBH1DVciVrdJZ2VLxqJu0jWPBZ2UAKXuX1stfFynGgJ24t6cdqFu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854533; c=relaxed/simple;
	bh=TbdhSuiPtcgqPydjrYVAb8OcTaQTDVygDroRPJ+V64o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5fk3B1zNbT1GYsMwzx9kbKoGxFFwJcvQJcBGh4LenAy1zOHMeWiOYdAh7U7HShvSt0SHyEiGK36R5DjlCZ4oIswzgvHV9chPjd+Byzhjxb+7rB8pMNA+2SvUggdM4+X4UXD+YWwoU3t8C0O3ugHQSUhbpQD6+hp8o2jLw6nWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80e-0002SM-A1; Sat, 31 Jan 2026 11:15:20 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80e-003OWi-26;
	Sat, 31 Jan 2026 11:15:20 +0100
Received: from blackshift.org (unknown [IPv6:2001:67c:1810:f051:d04a:1c63:e2:421c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7BF044DC574;
	Sat, 31 Jan 2026 10:15:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH net-next 7/8] can: sja1000: sja1000_err(): make use of sja1000_get_berr_counter() to read error counters
Date: Sat, 31 Jan 2026 11:11:48 +0100
Message-ID: <20260131101512.1958907-8-mkl@pengutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-6426-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: D7E5DC1876
X-Rspamd-Action: no action

This is a preparation patch to make use of can_state_get_by_berr_counter()
which works on a struct can_berr_counter.

Reuse the existing function sja1000_get_berr_counter() to read the error
counters into a struct can_berr_counter.

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Link: https://patch.msgid.link/20260123-sja1000-state-handling-v2-1-687498087dad@pengutronix.de
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


