Return-Path: <linux-can+bounces-7791-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /6LxB1thKGr/CwMAu9opvQ
	(envelope-from <linux-can+bounces-7791-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:54:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84F66370E
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:54:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j5rFnmJT;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7791-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7791-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74B1A3044F36
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED4343894;
	Tue,  9 Jun 2026 18:52:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777043CED8
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:52:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031179; cv=none; b=pru/QuFmGNtLXIVYnC09R76NpVE+0ppwjJgwziaMAVrVpjZg+g0dDRKjYOXrTa1n+kGheEIhXzYWNTju0I81UpigvrMMTC5V+htoPZUxPLryLMdQIRwlU//4N5RCRcJLuS40WpiaWeZ4X1UQuT2Iz9LZ84sjDA4KWNfBHJyrYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031179; c=relaxed/simple;
	bh=Lw2oBkK+qCGPuPFQ+52aZKFhtJHf0p8zhbWtg5j4J7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T5+G986FPksu/oe0+PK6Wk+NPgdiHS+HknT7+Bcd/4ZdAl7uWt+I8wIyRc2CcbYCBiOffrjXHpT7s92tgPT1symXFB7eaoZ/IuvJw9HiGalY5CxRJS0GUdfswDMjGfGJrnl6xsV5Th5TgibiXICCWQskTdrA0Kh8heLDCYHVpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5rFnmJT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3E41F00898;
	Tue,  9 Jun 2026 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031178;
	bh=Edv/RT4New3uOgDAU91DTfxC23Qwbv8EfALWXHeqgAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5rFnmJT2VAwRhecyABRvarJAE/kXRkLsYjmxAmRtRozCzq/lLDZWWX6VMpVsuON2
	 JbDxssPI0dd+Ig5xAu3qBlieuB54brmCTREY8F1eNIZbkEZ4kKRdEfVO0a2lYJ5z85
	 O1ERfRCVJAB662ok7mj6KCydYe9zZdMGg6qntci2YbAjp6t8LnJC+QyPNRKaqU2Pn+
	 8DZaf8UCYUGX9sIUAAOcIr/EQMg1l/qI24nj8WN2vwmURaP1B30/pVjzOkOVn8LEVc
	 nyrMVaRixWEy2tf/wzi42gk4+kEqd9P1WUh5oq8TO5JoxXxs1qxXjBn1pekQlcGvmu
	 wK4dmIbkwsVNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can] can: bcm: add synchronize_rcu() in
 bcm_delete_rx_op() to fix UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenghang Xiao" <kipreyyy@gmail.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260526102349.94074-1-kipreyyy@gmail.com>
References: <20260526102349.94074-1-kipreyyy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:52:57 +0000
Message-Id: <20260609185258.4F3E41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kipreyyy@gmail.com,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:socketcan@hartkopp.net,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7791-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D84F66370E

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Skipping `bcm_rx_unreg()` when `dev_get_by_index()` returns NULL l=
eaves the CAN receiver registered in the core, leading to a memory leak and=
 Use-After-Free.
- [High] Incorrect list primitives used for RCU-traversed lists (`rx_ops` a=
nd `tx_ops`), leading to list corruption and crashes.
- [High] Concurrent modification of an existing RX operation in `bcm_rx_set=
up()` races with `bcm_rx_handler()`, allowing readers to see partially-writ=
ten data.
--

commit 27083d45b99681b318907aa96e90787a12c08a58
Author: Zhenghang Xiao <kipreyyy@gmail.com>

can: bcm: add synchronize_rcu() in bcm_delete_rx_op() to fix UAF

This commit adds synchronize_rcu() in bcm_delete_rx_op() before
bcm_remove_op() to ensure all in-flight handlers complete before timers
are cancelled. This prevents a use-after-free where a timer could be
re-armed by a concurrent bcm_rx_handler after being cancelled.

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchroniz=
e_rcu()")

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..ae083f59a9ef5 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -870,6 +870,7 @@ static int bcm_delete_rx_op(struct list_head *ops, st=
ruct bcm_msg_head *mh,
>  						  bcm_rx_handler, op);
> =20
>  			list_del_rcu(&op->list);

[Severity: High]
This isn't a bug introduced by this patch, but looking at the code just
above this addition in bcm_delete_rx_op():

    dev =3D dev_get_by_index(sock_net(op->sk), op->ifindex);
    if (dev) {
            bcm_rx_unreg(dev, op);
            dev_put(dev);
    }

During device unregistration, unlist_netdevice() makes dev_get_by_index()
return NULL before the NETDEV_UNREGISTER notifier is dispatched.

If user space concurrently closes the socket in bcm_release() or deletes
the RX filter in bcm_delete_rx_op(), these functions check
dev_get_by_index(), see NULL, and bypass calling bcm_rx_unreg().

Does this leave the CAN receiver registered in the core, leaking the
struct receiver and causing a use-after-free when queued frames process
the already freed op pointer?

> +			synchronize_rcu();
>  			bcm_remove_op(op);
>  			return 1; /* done */
>  		}

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with the
list primitives used for rx_ops and tx_ops in net/can/bcm.c.

In bcm_rx_setup() and bcm_tx_setup(), the code uses list_add():

    list_add(&op->list, &bo->tx_ops);

However, in bcm_proc_show(), the tx_ops list is traversed locklessly:

    list_for_each_entry(op, &bo->tx_ops, list) {

Because list_add() lacks the smp_store_release() memory barriers of
list_add_rcu(), and the traversal doesn't use list_for_each_entry_rcu(),
could this result in readers seeing partially initialized list pointers
and dereferencing a NULL pointer on weakly ordered architectures?

[Severity: High]
This is another pre-existing issue, but there appears to be a race
condition between bcm_rx_setup() and bcm_rx_handler() in net/can/bcm.c.

When bcm_rx_setup() updates an existing RX operation under lock_sock(sk),
it modifies the frames locklessly:

    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    if (err < 0)
            return err;
    memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
    op->nframes =3D msg_head->nframes;

Meanwhile, bcm_rx_handler() accesses these fields in softirq context:

    for (i =3D 1; i < op->nframes; i++) {
            if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
                (get_u64(op->frames, 0) &
                 get_u64(op->frames + op->cfsiz * i, 0))) {

Since memcpy_from_msg() can sleep on page faults, could bcm_rx_handler()
read torn or partially overwritten CAN filters, leading to incorrect
message delivery or spurious timer scheduling?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526102349.9407=
4-1-kipreyyy@gmail.com?part=3D1

