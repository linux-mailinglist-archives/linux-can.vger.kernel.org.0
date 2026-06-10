Return-Path: <linux-can+bounces-7814-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GWyXJhmVKWpWaAMAu9opvQ
	(envelope-from <linux-can+bounces-7814-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 18:47:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6F866BA74
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 18:47:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=fN0YnURR;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b="Vcy1/ZmX";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7814-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7814-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 072EF305B235
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF8633D6CA;
	Wed, 10 Jun 2026 16:38:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F933344A
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 16:38:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109504; cv=pass; b=Rw28nEyi4b13p9prIakw0yV8NdZQTEHhRYquLmgcyNLrLCoYnAiSM8AmbirQu7S+/UGbj0WizkBDZT9mHXJGRodYSqqd6quLn9VXaxzAi8N33F5UH+TdOMfE/8pRwwz5ft9BBeOLKhvVyozi2gJ0sMfFxYtemYs46ACnL0g5nyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109504; c=relaxed/simple;
	bh=aCSBqIFmOS+0t1PvbmHCMB6+khCj3ctP2l9Onk0vNS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0E+e+UMtBmZnwubIWv7PAOrI3qndUjYajFriEkZOu2gHcxuGeRDcFo8F4myzo1oAvSpKcCVKHKUOJfx8AeWgKuCkakMm5XGMiZ18OFVLkdCEOaxks3vPOdYgZB1iBwa71bDkuf/C1tq3w/9pSS1hrZCm68yrjVnCS9yCsPbWQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fN0YnURR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Vcy1/ZmX; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal: i=1; a=rsa-sha256; t=1781109489; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=k8eYWcOF2E4f8vQahyfSBQhZAkkCUWVtn/ddqL2RUiPbqknnq42CeSNvrwPWIWwLcf
    joLpgBRP/J8XJG1EKWFwDr3G7toqP8K7qeNV6GMTf5r2IKJc5Y/Dvzcs4ZRslQpBimZV
    orni/Dhg1XLq7zYIwFjN4f4FOQysSXBVsOIvkAgZDBUuWNExvmF9Qqu6diCiZ52s2J7S
    St337bLhyeNMMKjm0KUO/WTwgdxRJiC47/xpIqn3o0xvIvbsReRTL3zxDn7bjRvcFugI
    pNYFgTwXYa1e5RXSB00NXqUnnFj2X7upR5RlozIm9UM55SLdRhBL28+9syEw0CYI/UD8
    sqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781109489;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YGa0+GcGPpO532H5Nd3/Pe429emU/ohbvkYX9EZDdTo=;
    b=RPbbm2JUeB8C07aR0LOKigYA3GiAJ9shPwMIh5kC5L4yOeGoGciD4snT5ZSwJUjqvq
    ZTrO8w/TSSIR36wzvG7n2ocp8wSMPtll9yt5zx57EvNqWZxk5wQog5OF8cyTmIBk70FP
    1zeDk5v90oGMwFDi/XHkR+xzzvk3VWpIT9DxTSvA+YexCq+LKWAimCLSsuMenh8xJDAy
    0asmp2XWNGTaLFrJkb4u2cOS2PH0vt/Q1jHgq0GYQ0+ZFGyyrvGY4LBJDbSx14fk5i5K
    X6H2thXnXz7y17eI1Mt4R+MT1ZoKbTMsipEIKAbZJoRxKdBuoETw0QZo8cb/4P5Y/3VR
    n55w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781109489;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YGa0+GcGPpO532H5Nd3/Pe429emU/ohbvkYX9EZDdTo=;
    b=fN0YnURRckULG5s0CXARezmMGUSXUHZASwf9IhMkrhGe6igRwxPw4WPkxQOEmEnhsR
    RPMdLYfibzehEJBWFbe8QR7rXu/GPGa/7v8SnfCaF3mry/dxvVgI1cGgUncU8TFgk66b
    5V3BbjKIP012E2+5nT36UVy4yldnL/MXps9mqHJM5czbMlirOfrYxD7enk7SKiH8/SQx
    tMnDWWLOsiFa4W0cwanhmJD38tJAXqjtM2sio6iEKxy72/iJTLSrwoCaiO6rJPFJtww4
    blQ0zTqnzeEPER16wjd57o1qBKWMK9F3nGObVVQeBKD4sRiDVyjtMykp0AaSIY5uGq1p
    pKwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781109489;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YGa0+GcGPpO532H5Nd3/Pe429emU/ohbvkYX9EZDdTo=;
    b=Vcy1/ZmXs67DV+KTTq1DH19oj0ETUnE5thI4jgtwBfeUqZKiRZ6acVX2UPfp/uJPod
    5QkLOpBzO89njkNbp0BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25AGc9rfo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jun 2026 18:38:09 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH] can: bcm: use list_add_rcu() in bcm_[rx|tx]_setup()
Date: Wed, 10 Jun 2026 18:37:44 +0200
Message-ID: <20260610163744.51980-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610163744.51980-1-socketcan@hartkopp.net>
References: <20260610163744.51980-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7814-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:sashiko-reviews@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B6F866BA74

sashiko-bot remarked the missing use of list_add_rcu() in
bcm_[rx|tx]_setup() to have a proper initialized bcm_op structure
when bcm_proc_show() traverses the bcm_op's under rcu_read_lock().

To cover all initial settings of the bcm_op's the list_add_rcu() calls
are moved to the end of the setup code.

Reported-by: sashiko-reviews@lists.linux.dev
Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.kernel.org/
Fixes: dac5e6249159 ("can: bcm: add missing rcu read protection for procfs content")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index e5db4dca8d5a..76d1e067e156 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -954,10 +954,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			int ifindex, struct sock *sk)
 {
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	struct canfd_frame *cf;
+	bool add_op_to_list = false;
 	unsigned int i;
 	int err;
 
 	/* we need a real device to send frames */
 	if (!ifindex)
@@ -1094,12 +1095,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* currently unused in tx_ops */
 		hrtimer_setup(&op->thrtimer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 
-		/* add this bcm_op to the list of the tx_ops */
-		list_add(&op->list, &bo->tx_ops);
+		add_op_to_list = true;
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
 	if (op->flags & SETTIMER) {
 		/* set timer values */
@@ -1117,10 +1117,14 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		hrtimer_cancel(&op->timer);
 		/* spec: send CAN frame when starting timer */
 		op->flags |= TX_ANNOUNCE;
 	}
 
+	/* add this bcm_op to the list of the tx_ops? */
+	if (add_op_to_list)
+		list_add_rcu(&op->list, &bo->tx_ops);
+
 	if (op->flags & TX_ANNOUNCE)
 		bcm_can_tx(op);
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
@@ -1278,13 +1282,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		hrtimer_setup(&op->timer, bcm_rx_timeout_handler, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 		hrtimer_setup(&op->thrtimer, bcm_rx_thr_handler, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 
-		/* add this bcm_op to the list of the rx_ops */
-		list_add(&op->list, &bo->rx_ops);
-
 		/* call can_rx_register() */
 		do_rx_register = 1;
 
 	} /* if ((op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex))) */
 
@@ -1359,14 +1360,16 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}
+
+		/* add this bcm_op to the list of the rx_ops */
+		list_add_rcu(&op->list, &bo->rx_ops);
 	}
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
 }
 
-- 
2.53.0


