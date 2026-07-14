Return-Path: <linux-can+bounces-8389-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ufc6ELIQVmrvygAAu9opvQ
	(envelope-from <linux-can+bounces-8389-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:34:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A3753746
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:34:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hn5P9A9n;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8389-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8389-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A8C43020BEA
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230A360EFC;
	Tue, 14 Jul 2026 10:34:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250017A300
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:34:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025264; cv=none; b=jYospSxmX5E1zM4cEYEXNwFJXytcGGqXz50MHxULu/Jx1+0zwRLam7tq4UUnN7BfaLyifihBCsD2SqTW8dAhl+WaOT8rVXhAb4tz6irID8MzPiMqLtnU1sOZ45ne23upPSCTsiDFAU1Rsj6zB0NloBheBqmorfx1WFOfcRmgWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025264; c=relaxed/simple;
	bh=aLeCLOLhRLMjbPKsFnDIegV9JvnUGcQY7O6HYyu9wvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kXceg6Y8+zZ33KXa0XK9H39vue3uKt705uqMsVDFk/ATWW84WD9BTEz1mu0Levx6/rWSLI3FnE5wISZG6QVKjg5kGRaJhbZPC9u8+XYGzTNtwR+eRcoVca6LjeCqy3VzJNYAEHrzqpEgW6Y4MGYkKUPTO+fYjPkC5N6h2hcPI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn5P9A9n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3A71F000E9;
	Tue, 14 Jul 2026 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025262;
	bh=PW8JghCaZD9tdfOum+63eoWQZljlN96X8Wfj8AnSNTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hn5P9A9nZT6/YOgJowMiZq6Gbit+GrRRnbyDHxOwYVQZ3PiehE6l/TjAExSoMWyOT
	 gUW4V8SNaHYXfPHYO5duDVlQQbRlnBqokuX3lBBcAVl63LCESUI0R+CeEH1feAagvQ
	 ruXI2aPFsNyYCor8rrBBcco6eLb9uG9fagqppKEVs0n2HYfLE64Pc8yaxtH8QbuKAU
	 PCMZBFDAEHppJwjpY2x2xJcrxuQpYLviX1jZEDL0lMvSpXipSOl6Sh3PVDTsCFwrLk
	 JhMklVmhf3j8ZxH7o69zUssnpLKCwkA5KB8KQBgFLQv71N4pLTLyEvwUHjZe1LPRU2
	 rCcqjTV+sjaoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/11] can: bcm: extend bcm_tx_lock usage for data
 and timer updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v13-6-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-6-fd667c61099a@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:34:21 +0000
Message-Id: <20260714103422.2E3A71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8389-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C06A3753746

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Torn reads of ival1, ival2, and count lead to corrupted TX_EXPIRED=
 API notifications.
--

--- Patch [6]: [PATCH v13 06/11] can: bcm: extend bcm_tx_lock usage for dat=
a and timer updates ---
commit 69a20e6fcc24540387b82e9501090dfb55f155cf
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: extend bcm_tx_lock usage for data and timer updates
   =20
Stage new CAN frame content for an existing tx op into a kmalloc()'d
buffer and validate it there, mirroring the approach already used in
bcm_rx_setup(). Only copy the validated data into op->frames while
holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
can no longer observe a partially updated or unvalidated frame.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 940cd9df1cca3..18601d6fdf763 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -486,8 +492,17 @@ static enum hrtimer_restart bcm_tx_timeout_handler(s=
truct hrtimer *hrtimer)
>  {
>  	struct bcm_op *op =3D container_of(hrtimer, struct bcm_op, timer);
>  	struct bcm_msg_head msg_head;
> +	bool tx_ival1, tx_ival2;
> =20
> -	if (op->kt_ival1 && (op->count > 0)) {
> +	/* snapshot kt_ival1/kt_ival2/count under lock to avoid torn
> +	 * ktime_t reads racing with concurrent bcm_tx_setup() updates
> +	 */
> +	spin_lock_bh(&op->bcm_tx_lock);
> +	tx_ival1 =3D op->kt_ival1 && (op->count > 0);
> +	tx_ival2 =3D !!op->kt_ival2;
> +	spin_unlock_bh(&op->bcm_tx_lock);
> +
> +	if (tx_ival1) {
>  		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {
> =20

[Severity: High]
This isn't a bug introduced by this patch, but the lockless read of
op->count here can see a newly written value after bcm_can_tx() drops the
lock.

If bcm_tx_setup() runs concurrently via sendmsg() and mutates op->count,
could this condition falsely fail and drop the TX_EXPIRED event?

Additionally, in the lines immediately following this (when setting up
msg_head), op->ival1, op->ival2, and op->count are read locklessly:

			msg_head.count   =3D op->count;
			msg_head.ival1   =3D op->ival1;
			msg_head.ival2   =3D op->ival2;

Since bcm_tx_setup() modifies these multi-word structures under
op->bcm_tx_lock, does this lockless read risk tearing the tv_sec and
tv_usec halves on 32-bit systems, sending corrupted timevals to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v13-0-fd667c61099a@hartkopp.net?part=3D6

