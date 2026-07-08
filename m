Return-Path: <linux-can+bounces-8162-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WXBUKmSMTmrdPAIAu9opvQ
	(envelope-from <linux-can+bounces-8162-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:44:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A57707294E7
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:44:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="UGn/gZtx";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8162-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8162-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3096300253E
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3E43849B;
	Wed,  8 Jul 2026 17:43:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60858242D9D
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 17:43:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532639; cv=none; b=ZyNdDo8SG30SVAIqD+GTHDICSIWWXPHyWw69fBb3bZagMBqAo2SkPH7IcyTTkK2Wu1px1MIDI8LNhLLHbKobrZGNs94uQdPZwg9w/J6SQXUzjP5mgM0sgZxk5Fnk+GEAnNqxitcl0XOy5ZL2rAcc5fkvwAPL6dzbvCJdxMIsKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532639; c=relaxed/simple;
	bh=XfFINSD55oc5QNMoCMKyPg7rpDHhik9NaeeM3ht0+B8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+4Vt+NoOxM3Hqghrc9aCtGdYAlBqyJiPKbGDGrEQ+xPQORiV/rWyNR7cuJuVZP8jqV9+MWhQD2pcyqjqVPnooJfE0Dfk9EksP5lQF/FnBBZhmVQ31b5zIiLzEBBm6Z5XzCMqSUi3JVEQqEKU/o63cxqX4xpd7G+j+Iu/ga7YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGn/gZtx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD82C1F000E9;
	Wed,  8 Jul 2026 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532638;
	bh=ELPGejXRJ/z8cLFIfn/xdsPmy4zVj3CUtjw7LV6zvRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGn/gZtxEYJQ0RA7N8na7FAOW57/VUKDNW4m3zZV4X/PuN9RJuKE2D9yJTF4+wD2I
	 9QNQDhiIAjKxLOKnHj9hiL5vAsdlbCSdyxmp8gziFCim7rHzU3U+IzuR8vlhN39Ai2
	 LkDtIvl1SsYh4abxei11Cstgf4oB4WoSIkysbVON5uCX5ORl24wkROn5zkovzVKKm4
	 I6qZrKsnyN7Nc4jUWlsDivATwMGId1MpuvvVxBonWPm6e8IYhrO/jUjvs2Kv5k/mvG
	 l0yFH9XQF0zNVElBEY5UAN0VT10/3atoNzi9cPR+UGqkzxcRZlZ5YoyEyLKj8dYvjK
	 Dl4ZVz49i9b8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/10] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260708-bcm_fixes-v8-2-8c2f5f3bc212@hartkopp.net>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
 <20260708-bcm_fixes-v8-2-8c2f5f3bc212@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:43:57 +0000
Message-Id: <20260708174357.AD82C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8162-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:email,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A57707294E7

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Data race between lockless /proc readers and socket list modif=
ication due to missing RCU protections.
--

--- Patch [2]: [PATCH v8 02/10] can: bcm: fix lockless bound/ifindex race a=
nd silent RX_SETUP failure ---
commit 2478889b563324c073bf7ec2b2aeeb796709e2ce
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

The patch fixes a race condition where lockless reads of bo->bound and
bo->ifindex could tear against concurrent locked updates. It also fixes a
silent failure in bcm_rx_setup() when the target device disappears.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
> =20
>  				op->rx_reg_dev =3D dev;
>  				dev_put(dev);
> +			} else {
> +				/* the requested device is gone - do not
> +				 * silently succeed without registering
> +				 */
> +				err =3D -ENODEV;
>  			}

[Severity: Critical]
This is a pre-existing issue, but does this code have a data race between
lockless /proc readers and socket list modifications?

In bcm_proc_show(), bo->rx_ops and bo->tx_ops are traversed locklessly under
rcu_read_lock(). However, bcm_rx_setup() and bcm_tx_setup() use the non-RCU
list_add() function to insert elements, omitting the required memory barrie=
r:

net/can/bcm.c:bcm_rx_setup() {
    ...
		/* add this bcm_op to the list of the rx_ops */
		list_add(&op->list, &bo->rx_ops);
    ...
}

net/can/bcm.c:bcm_tx_setup() {
    ...
		/* add this bcm_op to the list of the tx_ops */
		list_add(&op->list, &bo->tx_ops);
    ...
}

Additionally, while rx_ops is traversed with list_for_each_entry_rcu(), tx_=
ops
is traversed without RCU primitives entirely:

net/can/bcm.c:bcm_proc_show() {
    ...
	rcu_read_lock();

	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
    ...
	list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

Can an unprivileged local user trigger a kernel panic by opening the
/proc/net/can-bcm/<inode> file while concurrently adding operations via
RX_SETUP or TX_SETUP? Should list_add_rcu() and list_for_each_entry_rcu() be
used instead to ensure list integrity?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v8-0-8c2f5f3bc212@hartkopp.net?part=3D2

