Return-Path: <linux-can+bounces-6678-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPnPLw6vpWleEQAAu9opvQ
	(envelope-from <linux-can+bounces-6678-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:38:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E38651DBFC1
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C735C305FF1B
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB8413239;
	Mon,  2 Mar 2026 15:28:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C28411624
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465293; cv=none; b=DRB1ByqTxyRNgYdDVFe6rcLahqsCm4kx2tuIEk52PtkdMqgyvB2iTUpMsXKJHqGq3RkNMiIBth8RU1PVaEDDjCHvJLWFuUyp086VY1hWLpPeKEb92d4jd4cZHcXDwbp6hN/kbu9SwdIoJscHadf3fd6K1BOAf3kK1XIZOdqKr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465293; c=relaxed/simple;
	bh=eESALG8Vhe6eR2lflGD4lx4FYXngsDPD93CNWqujpqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwrL/iDJvKAWha6P8lb0henTkE6CW7cvMh5de17S0OESUy+TTatv2uphQJ6C16mhCloBZVtkJa3magfocqx8h7kvweXjKzMEPyhTDOFAEl7t7RWoM0TyWh+dnHaYBlSN36zMp7wWS/+KUeN+QqvN2dJBn3dcgKJubCK89SH1b14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Be-0004kJ-Oc; Mon, 02 Mar 2026 16:27:58 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bc-003P0a-1O;
	Mon, 02 Mar 2026 16:27:57 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7E2494F546B;
	Mon, 02 Mar 2026 15:27:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 02/12] can: dummy_can: dummy_can_init(): fix packet statistics
Date: Mon,  2 Mar 2026 16:16:08 +0100
Message-ID: <20260302152755.1700177-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302152755.1700177-1-mkl@pengutronix.de>
References: <20260302152755.1700177-1-mkl@pengutronix.de>
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
X-Rspamd-Queue-Id: E38651DBFC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-6678-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,pengutronix.de:mid,pengutronix.de:email,hartkopp.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

The former implementation was only counting the tx_packets value but not
the tx_bytes as the skb was dropped on driver layer.

Enable CAN echo support (IFF_ECHO) in dummy_can_init(), which activates the
code for setting and retrieving the echo SKB and counts the tx_bytes
correctly.

Fixes: 816cf430e84b ("can: add dummy_can driver")
Cc: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260126104540.21024-1-socketcan@hartkopp.net
[mkl: make commit message imperative]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dummy_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
index 41953655e3d3..cd23de488edc 100644
--- a/drivers/net/can/dummy_can.c
+++ b/drivers/net/can/dummy_can.c
@@ -241,6 +241,7 @@ static int __init dummy_can_init(void)
 
 	dev->netdev_ops = &dummy_can_netdev_ops;
 	dev->ethtool_ops = &dummy_can_ethtool_ops;
+	dev->flags |= IFF_ECHO; /* enable echo handling */
 	priv = netdev_priv(dev);
 	priv->can.bittiming_const = &dummy_can_bittiming_const;
 	priv->can.bitrate_max = 20 * MEGA /* BPS */;
-- 
2.51.0


