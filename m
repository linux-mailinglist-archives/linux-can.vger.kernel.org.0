Return-Path: <linux-can+bounces-6674-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJoFJMytpWleEQAAu9opvQ
	(envelope-from <linux-can+bounces-6674-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:33:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D134A1DBE82
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 196D9303D728
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A73FB06B;
	Mon,  2 Mar 2026 15:28:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312740F8D8
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465287; cv=none; b=GAgW/5nHBG39jMigF8daj3k+KXDRPfxTFIi3n6GuGGscTXT/UonSuL3xKxk9/SzBPSSxMCdSiJSyEkPB7EsLWD/3b0NyASNwGC6RHbAUY3119wE496YatMGSNVskpokNTLmFEF/oef7Fs9zrH9yy5L02x2b5hoLZLmOAaiRPWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465287; c=relaxed/simple;
	bh=X9u3E5XH1NT5ojXk3VDLa4paTMladaDW2C5ixjXM96Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/9pIT66Krrxg2MTTYCmJvnhXVYW5Ij8QGmUlZ3pfsviZXzpadfcpOBgnM/5DIVY2GUMV6GG7YvcDO7Fe9tcxYzR7UCIO8FyQrJUICEgSVqs8Z0oyi3tagJmsfbjuAH63jTsXrKEC8sbutEsJFknmk6zlfJO/n8Vw71RywPZgpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Be-0004kI-TB; Mon, 02 Mar 2026 16:27:58 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bc-003P0Z-1D;
	Mon, 02 Mar 2026 16:27:57 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 712B44F546A;
	Mon, 02 Mar 2026 15:27:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 01/12] can: bcm: fix locking for bcm_op runtime updates
Date: Mon,  2 Mar 2026 16:16:07 +0100
Message-ID: <20260302152755.1700177-2-mkl@pengutronix.de>
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
X-Rspamd-Queue-Id: D134A1DBE82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6674-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,5b11eccc403dd1cea9f8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

Commit c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
added a locking for some variables that can be modified at runtime when
updating the sending bcm_op with a new TX_SETUP command in bcm_tx_setup().

Usually the RX_SETUP only handles and filters incoming traffic with one
exception: When the RX_RTR_FRAME flag is set a predefined CAN frame is
sent when a specific RTR frame is received. Therefore the rx bcm_op uses
bcm_can_tx() which uses the bcm_tx_lock that was only initialized in
bcm_tx_setup(). Add the missing spin_lock_init() when allocating the
bcm_op in bcm_rx_setup() to handle the RTR case properly.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Reported-by: syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/699466e4.a70a0220.2c38d7.00ff.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index b7324e9c955b..fd9fa072881e 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1176,6 +1176,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (!op)
 			return -ENOMEM;
 
+		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);

base-commit: 9439a661c2e80485406ce2c90b107ca17858382d
-- 
2.51.0


