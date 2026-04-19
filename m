Return-Path: <linux-can+bounces-7372-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDx1IwXk5GmGbgEAu9opvQ
	(envelope-from <linux-can+bounces-7372-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 16:17:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BF42453D
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 16:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62A8300E72D
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69F31D86DC;
	Sun, 19 Apr 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="dsG0RC7x"
X-Original-To: linux-can@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0B13B7A3;
	Sun, 19 Apr 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776608251; cv=pass; b=APe4xzWx5YVNnA3oPC4lJfKpxQW2rdAnhuTzZg8DUHsr8lsli/CcjR9ZuWNAUoRxoWMzhFiXaZYcNmYZaAhEkvyH7dAwoe+K6YoPjJQVNeoJUGhKdPPdyOTdzCWmzC6AGHjX/UH4U2xE8OL+Ttz3jb8tq19HYt6DfFr7QX2fXXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776608251; c=relaxed/simple;
	bh=sz5PVPJDw9XnkDdL+wJEQY4QQjYfpoB97SKETK5bf0w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CUzqfyfj5wIaJlkt+Zwsn9tywlbCOtXHzsgniGliDJ/bjvXjslWss1xY7XFKKDZ6r90mBcD2XJOuo01rQDD8HXpsv4LMxFI/WMkEj7wQaj2EPbl1tBeiBbwp6abvhOHWyXV1afY1AefYWfJ3sWpDecKRyY7zyjuhS4LSWeIT8NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=dsG0RC7x; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
ARC-Seal: i=1; d=cse.ust.hk; s=arccse; a=rsa-sha256; cv=none; t=1776607588;
	b=bwR3/A3KwPLg5IBPNZXnxEoIsDOaT2rRQ6r1KmFW5A8j2tQ+wU42F/N5Eh0FeYjuSyYv
	 Cm1GnGY+lcuJrYQKftA29OoBEL2uIDKaC28VpvLWb/9L6EPUEaoADxw0I94j9l0hWg6t6
	 SaNItQ85krfwvOqS2nJc5IZQJd7Tkib+eA=
ARC-Message-Signature: i=1; d=cse.ust.hk; s=arccse; a=rsa-sha256;
	c=relaxed/relaxed; t=1776607588;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=GReNcXQ9DGmsznAokrcHipOw4IOTqjHghfg0nC7diQc=;
	b=p/9L2J0n1jWegDqVNsAvdPBKfsdP3uFXA9zHyWm4CcxB9sMA973UIKoueQ6ki/oyelFJ
	 RcWp2z0o4Xs0bz8YB1l85QeQInsvRdKMlBexmKkk5G9aM+pHViUrbwLSml7gCMm1EFs2A
	 91p3LiF6vJJZJGCln1DY0hZIJzcMnQ4zvg=
ARC-Authentication-Results: i=1; cse.ust.hk; arc=none smtp.remote-ip=143.89.191.45
Received: from chcpu16 (191host045.mobilenet.cse.ust.hk [143.89.191.45])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 63JE6JVq152034
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 22:06:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1776607588;
	bh=GReNcXQ9DGmsznAokrcHipOw4IOTqjHghfg0nC7diQc=;
	h=Date:From:To:Cc:Subject:From;
	b=dsG0RC7xvXB88oPQzmZnnhww1IQ9wxfOYDiiZI3ObW54E1UZYq537zWfzLv3BE7F/
	 +i+iNIN5t8sVtWO5gmz5cE7cY94DcndJkfr/nd7Q53IrIGGdvbMAfdUhEZmM8YXPKN
	 9aTIzEQXe+9DGwpGU0rItHmO/5vI4sX0QbVww0no=
Date: Sun, 19 Apr 2026 22:06:14 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH net] can: j1939: fix lockless local-destination check
Message-ID: <20260419140614.GA4041240@chcpu16>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cse.ust.hk:?];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7372-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[cse.ust.hk : SPF/DKIM temp error,none];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sfual@cse.ust.hk,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_TEMPFAIL(0.00)[cse.ust.hk:s=cseusthk];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E07BF42453D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

j1939_priv.ents[].nusers is documented as protected by priv->lock, and
its updates already happen under that lock. j1939_can_recv() also reads
it under read_lock_bh(). However, j1939_session_skb_queue() and
j1939_tp_send() still read priv->ents[da].nusers without taking the
lock.

Those transport-side checks decide whether to set J1939_ECU_LOCAL_DST, so
they can race with j1939_local_ecu_get() and j1939_local_ecu_put() while
userspace is binding or releasing sockets concurrently with TP traffic.
This can misclassify TP/ETP sessions as local or remote and take the wrong
transport path.

Fix both transport paths by routing the destination-locality check through
a helper that reads ents[].nusers under read_lock_bh(&priv->lock).

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
 net/can/j1939/transport.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da7e..8a31cb23bc76d0 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -351,6 +351,18 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 	}
 }
 
+static bool j1939_address_is_local(struct j1939_priv *priv, u8 addr)
+{
+	bool local = false;
+
+	read_lock_bh(&priv->lock);
+	if (j1939_address_is_unicast(addr) && priv->ents[addr].nusers)
+		local = true;
+	read_unlock_bh(&priv->lock);
+
+	return local;
+}
+
 void j1939_session_skb_queue(struct j1939_session *session,
 			     struct sk_buff *skb)
 {
@@ -359,8 +371,7 @@ void j1939_session_skb_queue(struct j1939_session *session,
 
 	j1939_ac_fixup(priv, skb);
 
-	if (j1939_address_is_unicast(skcb->addr.da) &&
-	    priv->ents[skcb->addr.da].nusers)
+	if (j1939_address_is_local(priv, skcb->addr.da))
 		skcb->flags |= J1939_ECU_LOCAL_DST;
 
 	skcb->flags |= J1939_ECU_LOCAL_SRC;
@@ -2038,8 +2049,7 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		return ERR_PTR(ret);
 
 	/* fix DST flags, it may be used there soon */
-	if (j1939_address_is_unicast(skcb->addr.da) &&
-	    priv->ents[skcb->addr.da].nusers)
+	if (j1939_address_is_local(priv, skcb->addr.da))
 		skcb->flags |= J1939_ECU_LOCAL_DST;
 
 	/* src is always local, I'm sending ... */
-- 
2.25.1

