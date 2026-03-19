Return-Path: <linux-can+bounces-7165-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM/hFMocvGlEsQIAu9opvQ
	(envelope-from <linux-can+bounces-7165-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:56:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E912CE1DE
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30B6C30A02DE
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D763E8C4F;
	Thu, 19 Mar 2026 15:48:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5D3E51FA
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935282; cv=none; b=MH8GDNDvqma6OJrH4rcDRDVn/OleV0kri8fo4CBWv/jt5vJJdkkQJsL80ceAf668zn8/nkBVJy2h64TyjiHfhc7stUqetoGC4rTcA8EgLHGtV//JFYSsccZ59UuJmzmqKa5uQ+gJ5OAIhgz0rb921FojVr/ip56OebCfYZlsA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935282; c=relaxed/simple;
	bh=DV78igLEdcL3fhU070znmETO6O0WAIAmLjj2wcLCR0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tC2Wb5koxucbrscgfDeN0driD5/Pdx+SPFs9ksDfGUyBXd24WtcbMTgkoLCj4MEQlqilZRNTKb3YUcfhHrKmnC3FIhjBmUmsPPACEhvex8rXiBb6Dg86T3qE9fFPD8/h5RDeztj2UdJLwyodxHQA1khXfwiJ11Zo1JH1+WCrwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FbI-0002Tk-My; Thu, 19 Mar 2026 16:47:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FbH-0016Ev-3D;
	Thu, 19 Mar 2026 16:47:56 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ADD035086A1;
	Thu, 19 Mar 2026 15:47:55 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 16:47:45 +0100
Subject: [PATCH can v2 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-fix-can-gw-and-can-isotp-v2-2-c45d52c6d2d8@pengutronix.de>
References: <20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2d8@pengutronix.de>
In-Reply-To: <20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2d8@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, Ali Norouzi <ali.norouzi@keysight.com>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=EA3DkM8A44pm0XcFOAHKhKSbYfsdLH1qWFdWEtDwxUM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcI7UqdEbBT6Xw09+jCqd927ttgW/LRP9VN1rnl08XN
 a/4feevYkcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmknqA4X8ot/0LBoMVc9d7
 d05NMV68UODC4flq01fMmXTT8sCnH9X7Gf4pq/hpX+44LLfizYdjgh1FtvUFszOX7Nu36d/sbt8
 Loaq8AA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_FROM(0.00)[bounces-7165-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.964];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[keysight.com:email,pengutronix.de:email,pengutronix.de:mid,hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12E912CE1DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Oliver Hartkopp <socketcan@hartkopp.net>

isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
wait_event_interruptible() and then calls kfree(so->tx.buf).

If a signal interrupts the wait_event_interruptible() inside close()
while tx.state is ISOTP_SENDING, the loop exits early and release
proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
while sendmsg may still be reading so->tx.buf for the final CAN frame
in isotp_fill_dataframe().

The so->tx.buf can be allocated once when the standard tx.buf length needs
to be extended. Move the kfree() of this potentially extended tx.buf to
sk_destruct time when either isotp_sendmsg() and isotp_release() are done.

Fixes: 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu size")
Cc: stable@vger.kernel.org
Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index da3b72e7afcc..2770f43f4951 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1248,12 +1248,6 @@ static int isotp_release(struct socket *sock)
 	so->ifindex = 0;
 	so->bound = 0;
 
-	if (so->rx.buf != so->rx.sbuf)
-		kfree(so->rx.buf);
-
-	if (so->tx.buf != so->tx.sbuf)
-		kfree(so->tx.buf);
-
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -1622,6 +1616,21 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 	return NOTIFY_DONE;
 }
 
+static void isotp_sock_destruct(struct sock *sk)
+{
+	struct isotp_sock *so = isotp_sk(sk);
+
+	/* do the standard CAN sock destruct work */
+	can_sock_destruct(sk);
+
+	/* free potential extended PDU buffers */
+	if (so->rx.buf != so->rx.sbuf)
+		kfree(so->rx.buf);
+
+	if (so->tx.buf != so->tx.sbuf)
+		kfree(so->tx.buf);
+}
+
 static int isotp_init(struct sock *sk)
 {
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1666,6 +1675,9 @@ static int isotp_init(struct sock *sk)
 	list_add_tail(&so->notifier, &isotp_notifier_list);
 	spin_unlock(&isotp_notifier_lock);
 
+	/* re-assign default can_sock_destruct() reference */
+	sk->sk_destruct = isotp_sock_destruct;
+
 	return 0;
 }
 

-- 
2.53.0


