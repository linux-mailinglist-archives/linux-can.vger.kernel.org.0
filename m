Return-Path: <linux-can+bounces-7816-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xRmnBWyXKWoPaQMAu9opvQ
	(envelope-from <linux-can+bounces-7816-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 18:57:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912BB66BBEA
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 18:57:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C8rG811H;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7816-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7816-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B113062C0E
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697933A71B;
	Wed, 10 Jun 2026 16:51:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E833D4F0
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 16:51:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110306; cv=none; b=XMWo+FSfE6Hf/hfDUWQSH/ma9nYfKVlyH1wcokJ08zO5Wc98y/tePiRKSxtGJHzlqwrL95qtR1gpLNZ/BqWRnlyKtjNC9s7Z0SNuJ4ywjJun9/oMOZzXVcARjZJd7zQ8qDTVP+hB93rql+3U8TVJaTs1sBMa44chiMNRZOqxThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110306; c=relaxed/simple;
	bh=lTvcPkuoZdjmkRMF0r34vmhrfHfqOGIfG7RL9okueJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I3WRimR0gmgQLMc7RVO0XzMeHUeS5AVQqym8C7e/KRvQTbkVP/InbHbViwxQg2bEQLIWQamQi93esaqj5ew48PUuphsTZapDKyqunp6kn07pmxP0usihyzimkY0B9j9/eylFaZVFmY0pJce4GGALjyK2PCYCNiAWs6MEC2PsRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8rG811H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91F21F00898;
	Wed, 10 Jun 2026 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110305;
	bh=fftVxIYGGmwidQiL/cp7Uf1RikmaLSWFTO0RscAvkfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8rG811HFuCSy3qFZGinq9lZF6qB75hcNzTFDDc0t2w7pdeh0rNP2xBdhAahzNVd0
	 eRlnrZg8LzZpspYHzUfsItcM8RFNcagf6MrcipDfKjrYatHdsI83iOZIwg++PS8MAy
	 Nt2TDS/0L2eus7E6zYeYMvtUZ/eJ5C7d+Ph05WPMbvmPhARRsJdapZVnQ7OEprpWty
	 OEdKNDPFiCjdAdOgvSUlNZeEw8qXi3s/lbNFEMJreSwLAxRueU3ikG/efN19qx4J4L
	 Q/BNf0aXiVGi32KcGq5gYXL66WEotUQ2NB+mgYdsOAbaKhI4VoHBcIWHfSCeKeEY7U
	 BPjCeV+ULn6EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: bcm: use list_add_rcu() in bcm_[rx|tx]_setup()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260610163744.51980-2-socketcan@hartkopp.net>
References: <20260610163744.51980-2-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:51:44 +0000
Message-Id: <20260610165144.C91F21F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7816-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,hartkopp.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 912BB66BBEA

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race allowing transmission of unvalidated CAN frames with out=
-of-bounds lengths.
- [Medium] Missing RCU list traversal primitive for tx_ops in bcm_proc_show=
().
- [Medium] Unrecoverable state corruption upon validation failure during BC=
M operation update.
--

commit 6728a4ac4d52665b9a664d80e0c10b8ebce20e70
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: use list_add_rcu() in bcm_[rx|tx]_setup()

This patch moves the list_add_rcu() calls in bcm_tx_setup() and
bcm_rx_setup() to the end of the initialization code. This ensures the
bcm_op structure is fully initialized before it becomes visible to RCU
readers like bcm_proc_show().

Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..7215fa32832c8 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -930,6 +930,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head=
, struct msghdr *msg,
>  	struct bcm_sock *bo =3D bcm_sk(sk);
>  	struct bcm_op *op;
>  	struct canfd_frame *cf;
> +	bool add_op_to_list =3D false;
>  	unsigned int i;
>  	int err;

[Severity: High]
This is a pre-existing issue, but is it possible for an unvalidated
CAN frame to be transmitted here?

When updating an existing operation in bcm_tx_setup(), the user data is
copied directly into the active transmission buffer before validation:

    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    if (op->flags & CAN_FD_FRAME) {
        if (cf->len > 64)
            err =3D -EINVAL;
    }

Concurrently, the softirq timer bcm_tx_timeout_handler() could fire,
calling bcm_can_tx(), which fetches this frame and sends it without locks:

    skb_put_data(skb, cf, op->cfsiz);
    err =3D can_send(skb, 1);

Could a malicious user craft a frame with an out-of-bounds length
(e.g., cf->len =3D 255) that gets fetched and transmitted before
bcm_tx_setup() validates it and aborts? This could potentially cause
crashes or out-of-bounds memory reads in downstream CAN drivers.


[Severity: Medium]
This is a pre-existing issue, but does a failed validation leave the socket
in an unrecoverable corrupted state?

In both bcm_tx_setup() and bcm_rx_setup(), if an existing operation is being
updated and the validation fails after the memcpy_from_msg() block:

    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    if (err < 0)
        return err;

The function returns an error without reverting the changes to op->frames.
Because the timers might still be running for the active bcm_op, the socket
seems permanently stuck transmitting or filtering based on this partially
overwritten data.

[ ... ]
> @@ -1093,6 +1093,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  		op->flags |=3D TX_ANNOUNCE;
>  	}
> =20
> +	/* add this bcm_op to the list of the tx_ops? */
> +	if (add_op_to_list)
> +		list_add_rcu(&op->list, &bo->tx_ops);
> +

[Severity: Medium]
This is a pre-existing issue, but since we are now using list_add_rcu()
here, should the iteration in bcm_proc_show() also use the RCU primitive?

bcm_proc_show() traverses the bo->tx_ops list under rcu_read_lock(), but
currently uses the standard list macro:

    list_for_each_entry(op, &bo->tx_ops, list) {

Without list_for_each_entry_rcu(), it omits the necessary rcu_dereference()
calls and memory barriers. On weakly ordered architectures, couldn't this
lead to reading torn pointers or uninitialized memory of a newly inserted
bcm_op, potentially causing a crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610163744.5198=
0-2-socketcan@hartkopp.net?part=3D1

