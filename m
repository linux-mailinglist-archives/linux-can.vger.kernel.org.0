Return-Path: <linux-can+bounces-8301-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9LbjDrQkUWqx/wIAu9opvQ
	(envelope-from <linux-can+bounces-8301-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 18:58:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B69EC73CD04
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 18:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=tbK+nAzg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8301-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8301-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 073CA30691A1
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E143E48A;
	Fri, 10 Jul 2026 16:47:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664A43D4F4
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 16:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702073; cv=none; b=PhjwNqh230eYCmS4T8OqrBjrTDi3C0wmdxyqqd//75VvBACZG+ttB+YoGiXtSD3PJyhKmtNqzP5faMvA4SvUJhWceBW+7inFETLMV0/IkxyopbWiWB9qqaRtZKi1yjHezF4TcD2Mjp4kGFsTm6M6zLdshREfEJIKOOh7g0Pc+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702073; c=relaxed/simple;
	bh=QIVVJ3xPl5t6i2QKFLQ+uM6jU813WstzCDRFzTXZuFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a32R1y4Tc9rlGrUb/BvfnQESDa9lxEYTGcOuwxIGPOU7JbOdh/w/gL2sk+PgvImHD26+VKvCuDCF8vIHQS1VrB1ij1/lcjWYq8X67PFKpD8g+h4JxrtfRISQfz93mBEAXvVn2JzQID1uSMGoISqHUjXIVwkJImgDtYCib66qohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbK+nAzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2908C2BCF7;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783702071;
	bh=QIVVJ3xPl5t6i2QKFLQ+uM6jU813WstzCDRFzTXZuFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tbK+nAzgtOxrNsGDsEYgkZ5IV9WwRwRA/mvci4KHUG9ZewRymyqjHB9lYOh5I/eQw
	 YenmogCZ/qXkDddlOrtKqoe7MoqT5aznjL+E3FG8c0T7kJp/K6ktX6YxsL/ZP2pRZ3
	 3KLK899BUwLhrYhpl/QP6A+Pb9HDpcV7fgrDHLZ9Fk4b6OjiOzez49CJ0rRHm5cSca
	 RlVC+zdpmQ8uXk+wV75I2zk1cBOlmPHfecSc4VL/64uHfxhkmuzdWW1wOC5dIrG9gV
	 ieCoSLh9LQ+YKM3kZtH/2Z9JNDa2MuLeYws3/jn86yQ2vjdGwD/hwFRJJlZSkXUWb6
	 fSoaqx5XhcVdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A0C4450D;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Fri, 10 Jul 2026 18:47:44 +0200
Subject: [PATCH v5 3/4] can: isotp: fix race between RX timer and
 consecutive frame reception
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-isotp-fixes-v5-3-15174d82d6f1@hartkopp.net>
References: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702070; l=1756;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ZtDFm0eMta+8u2hxg7eL80U5RKwqAeV4A09IBs3aU1Y=;
 b=NBZ8tfJPnfkpR3s5HTGnJgJZm+54yAWYEjswCX9smXx1SdLZ0A/ja7TykZjLlcc24IDf3UTXr
 WiOqmIxdWyRA33RCTYWmAlS/EHcOMBBqU4ofdaku3WqvXl17jaK56bF
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8301-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B69EC73CD04

From: Oliver Hartkopp <socketcan@hartkopp.net>

When receiving a Consecutive Frame (CF), hrtimer_cancel() is called to stop
the RX timer. However, if the timer handler (isotp_rx_timer_handler) has
already fired and is running concurrently on another CPU, hrtimer_cancel()
will wait for it to finish.

By the time it returns, the timer handler might have already reported an
ETIMEDOUT error and reset the RX state machine. If we blindly continue
processing the CF, we corrupt the newly reset or idle state.

Fix this by verifying that the state is still ISOTP_WAIT_DATA after
canceling the hrtimer. If it changed, the reception has already timed out,
so we drop the frame.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index e7597ca3e140..c0edbd35516c 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -575,10 +575,18 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		so->lastrxcf_tstamp = skb->tstamp;
 	}
 
 	hrtimer_cancel(&so->rxtimer);
 
+	/* isotp_rx_timer_handler() may have raced us for so->rx.state
+	 * while hrtimer_cancel() above waited for it to finish, already
+	 * reporting ETIMEDOUT and resetting the reception; don't process
+	 * this CF into a reassembly that has already been given up on.
+	 */
+	if (so->rx.state != ISOTP_WAIT_DATA)
+		return 1;
+
 	/* CFs are never longer than the FF */
 	if (cf->len > so->rx.ll_dl)
 		return 1;
 
 	/* CFs have usually the LL_DL length */

-- 
2.53.0



