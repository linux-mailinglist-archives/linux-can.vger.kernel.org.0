Return-Path: <linux-can+bounces-7661-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH91LdxQDGqTewUAu9opvQ
	(envelope-from <linux-can+bounces-7661-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 14:00:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC8157E36E
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 14:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E52DF301AAB1
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED132BF44;
	Tue, 19 May 2026 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Z7MSMpwj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bdo/qzE4"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F8370AFF
	for <linux-can@vger.kernel.org>; Tue, 19 May 2026 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191436; cv=pass; b=fW8z6lnT0XI8XeZ/STkp/+USEZpyFC+rDUoIgbB/1Thlk+5NCiAjY1lUFqgh+dkYdQBOLaa7T4hFynAuttosyjLPfe54Qugksxo6oSY85uNVKcPNfd8qnaOzI72tAAGtfW4uF+pDq57BaibdlSikzG4nuI9GB/i6nRNA76HDxnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191436; c=relaxed/simple;
	bh=I9tucM4F9Nl2fJIzShOORi5El4TeB7keTTM10/dPx1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhuTd2LmlKjo4lo0KVC0RttIiyCXfS7v8HuGQsnpUF0LE5hQu1wOoTmGbH3CUipYgIgzSEJyWkeNsiliGob4V2A+pwF4LDU/QJV43qoYZz9nGsPXrwEpuHuuXqam/sCNWWu5/qWj8z3dDAAtwAP6wugK2gskg/a5gK1NTCK6neM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Z7MSMpwj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bdo/qzE4; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779190696; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hl/GFXg6UdzcPOmBv6WEhiR4vhrFslQ8x3ng6paq59HhjhN8Cpu0E/fqmAjNLS6Bpv
    eeupNNJShEx2SrkjcWogZIvvwYA4RlMyEWKgDmq2kdcqcFeNl0dx/XKVX4lM6xJRcBlw
    Oy/pLdPWX/doXmD6gj2v/0U1XvjTQgkVKo1KQ8q96B9meoCvRLIjq7q9V691ZzfZgQZx
    kjZWM8LQbEdAS+gO2YoDwXLdz4okxAqC5Ts2lNC44prlwRMV7ybJIMpGMSsRvwPdwI+j
    JOlsmXQxLlnM0PNTKhpWOIDEzv5MCSPRpu6emTzA8Psy1a4nvQM+mT/FWgbAw7ollFja
    XPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779190696;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=SSeQLsjk/x1aNI3Wmwgw08gl7OanHpqGEQ+jUml0+qE=;
    b=ZyOFWZDUPvATtLIzYacJ5GAqXRPWXiNxZCuy70COFnyNqZixvWLERoUKnyfvQy+fvi
    oL5CbX6CvVqnK7QIoFRhhKspY83y2Lu9JJRbaMuVQ2zKZ0DDE/XYqm9hpcjxRp4unM70
    9Ow9qxV2MoN491JXIf3XG/1vvhUE4J4QGd/tGj89qakoOqj+7Wv2oAeLH4x4cO9cih/6
    RdJ60dB97+0m/8zBbIFaEDRxU7nHy6mJoD4f9kW0EyI3lTZ8i8swiYNmBskvqRRhRZVj
    8gxcEuxW8x54/reKlPRMr0+9DABBboTuOMJzLKcWzPf1kT51S8PK11LHjnbsk1cCtxIx
    BTcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779190696;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=SSeQLsjk/x1aNI3Wmwgw08gl7OanHpqGEQ+jUml0+qE=;
    b=Z7MSMpwjoqD5eDf6QsFLL8iTvkTHevz7Ai48JEqqNbKwQ/1DB3MgGjeh+9ozBqMuHO
    IqfdrIJwdHltntv9TZfr2+LeqXS2y5OgLxLUTs0i06fHSFvnTQ6P4MuFUkUfZYtLJtJl
    Cj2Tw36Xdpm4JhFF6mA+8GNKDbar/VObpMQrRFAJJF7iZBLoVCIL3pcBiKiRVjtJ0MiE
    gg9wfYTs22VHtTo2hSLoHSwSBV55HHv6jsRry4C3tYx6GcnB76g06Jc8UWGANnQGHRJY
    wJsCtSJedRJyLAdtmRmc7oFzfvfBRCW24laAFyg47KPr/3XYY1J+K6q0EAvUmgb7bUuw
    S7CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779190696;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=SSeQLsjk/x1aNI3Wmwgw08gl7OanHpqGEQ+jUml0+qE=;
    b=bdo/qzE4w8wJN9d3taok563yHI47L8t0xU2BZ44AOQ4e8cLw3VdrhQvlZoJQyapcb0
    3s2rvfBjpXftRtrEUdBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24JBcGGTx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 19 May 2026 13:38:16 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking RX_NO_AUTOTIMER
Date: Tue, 19 May 2026 13:38:05 +0200
Message-ID: <20260519113806.85456-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7661-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 5DC8157E36E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lee Jones <lee@kernel.org>

Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
synchronize_rcu()") removed the synchronize_rcu() call from
bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
timers from being rearmed during deletion.  However, it only applied
this check to op->timer via bcm_rx_starttimer().

It missed the fact that op->thrtimer can also be rearmed by an
in-flight bcm_rx_handler() (which runs as an RCU reader) via
bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
bcm_remove_op() has already cancelled it, leading to a use-after-free
when the timer fires on the deferred-freed struct bcm_op.

Address the omission by checking the RX_NO_AUTOTIMER flag
in bcm_rx_update_and_send() before starting op->thrtimer, effectively
preventing it from being rearmed concurrently with teardown.

[Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
removing the CAN filters following the bcm_delete_rx_op() approach.

Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.

Signed-off-by: Lee Jones <lee@kernel.org>
Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..abf7bd2c2e6f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -537,10 +537,16 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
 
 	/* with active throttling timer we are just done here */
 	if (hrtimer_active(&op->thrtimer))
 		return;
 
+	/* bcm_remove_op() may have cancelled thrtimer concurrently with this
+	 * RCU-protected handler; do not rearm it. Mirrors bcm_rx_starttimer().
+	 */
+	if (READ_ONCE(op->flags) & RX_NO_AUTOTIMER)
+		return;
+
 	/* first reception with enabled throttling mode */
 	if (!op->kt_lastmsg)
 		goto rx_changed_settime;
 
 	/* got a second frame inside a potential throttle period? */
@@ -603,11 +609,11 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
 /*
  * bcm_rx_starttimer - enable timeout monitoring for CAN frame reception
  */
 static void bcm_rx_starttimer(struct bcm_op *op)
 {
-	if (op->flags & RX_NO_AUTOTIMER)
+	if (READ_ONCE(op->flags) & RX_NO_AUTOTIMER)
 		return;
 
 	if (op->kt_ival1)
 		hrtimer_start(&op->timer, op->kt_ival1, HRTIMER_MODE_REL_SOFT);
 }
@@ -838,11 +844,11 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 	list_for_each_entry_safe(op, n, ops, list) {
 		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
 
 			/* disable automatic timer on frame reception */
-			op->flags |= RX_NO_AUTOTIMER;
+			WRITE_ONCE(op->flags, op->flags | RX_NO_AUTOTIMER);
 
 			/*
 			 * Don't care if we're bound or not (due to netdev
 			 * problems) can_rx_unregister() is always a save
 			 * thing to do here.
@@ -1618,10 +1624,14 @@ static int bcm_release(struct socket *sock)
 
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
 		bcm_remove_op(op);
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
+
+		/* disable automatic timer on frame reception */
+		WRITE_ONCE(op->flags, op->flags | RX_NO_AUTOTIMER);
+
 		/*
 		 * Don't care if we're bound or not (due to netdev problems)
 		 * can_rx_unregister() is always a save thing to do here.
 		 */
 		if (op->ifindex) {
-- 
2.53.0


