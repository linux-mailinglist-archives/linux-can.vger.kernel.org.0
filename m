Return-Path: <linux-can+bounces-7786-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9kjtDG5fKGqRCwMAu9opvQ
	(envelope-from <linux-can+bounces-7786-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:46:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD666366E
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:46:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gReJAfqm;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7786-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7786-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16F4130711AE
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39B93B27EC;
	Tue,  9 Jun 2026 18:45:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC835C1AD
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:45:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030729; cv=none; b=GDCjtZjJ1Swk/cYNRT6KCmh54Rlxi8uJNW8YuCMv8hYdxy8Lwel8fbrO0J/y2EwRn7Eg9yO+g6duz8+QyFAZT4EGLG6fOUuWNfh6/a8QUrcpD8xYsNbAwJ4g0IohqXsqufRsHej5s/Ja80ma8MNAsAD9XnHokOm78IEQH2tfaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030729; c=relaxed/simple;
	bh=MIkpfptD4EpWWJhNOCW/lvAPHQdk0wgELkoNH13xKqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CQDtLIh8GIymGL6AssPC6lS9May2zxSaqbWKNuAMQvVgVcQH1GXFamgr9UdbULDBJtfbGTA+8RGburM+Fe2jalLyl8483jAn9/Fi4PlKZSDDO1mjOl6DtZSdXKIOfLhGjqcGeUXo9dknAaZxKqombFJQwWzp4PzyTd2vYNSLZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gReJAfqm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405221F0089B;
	Tue,  9 Jun 2026 18:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030728;
	bh=AAxXG6dpJ2p4Ca4TunIrUJuGcGAdBddgHq/0KdYY2O0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gReJAfqmubj2VMFhipaEgw1Wx9pEku7t3k/ICLmODkWlScfTxt8U9vV4lOImegFzg
	 hxUNk9yNRvy/PItfOt6ofZxoSKqOG70eBByu0anEPaeHr1JAZZmTYWdF9I2FV/N1up
	 XfRpdW3gH0FEUFWAaguQFjrJ7wOz6yWAxVEugmd+k0DBk2m/koHZslgG77Whn08tvW
	 5kCMJwx6rBI12jfiIlOB0SBTEB/nQDylqU64pfc92MyU1Y60Wg/J9h9drdhVSfPiGd
	 PSw+ZCZxptD/c4cEb9LolVGwnlX2TuDlJAfaPmIMtssMJQHimYFfEU9sB18A/KcEuH
	 uEeO3avytsBdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] can: bcm: use atomic access in receive
 statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260522180758.51128-3-socketcan@hartkopp.net>
References: <20260522180758.51128-3-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:45:27 +0000
Message-Id: <20260609184528.405221F0089B@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-7786-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FFD666366E

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Converting `frames_filtered` to `atomic_long_t` introduces a sig=
ned integer overflow on 32-bit systems during procfs statistics calculation=
, producing bogus corrupted percentages.

Pre-existing issues:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `bcm_pro=
c_show()` can cause a division by zero and kernel panic due to multiple loc=
kless reads of `op->frames_abs`.
--

commit 6749d4fcb2595ae8bc232f3dd041a194ebd9a9f4
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: use atomic access in receive statistics

This commit modifies the CAN broadcast manager (bcm) protocol to use atomic
operations for rx statistics. This prevents a data race detected by KCSAN w=
hen
multiple CAN frames are processed simultaneously by different CPUs.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index dbdf5d4f4ed7b..8a2cb766603dc 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -228,7 +229,7 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  		unsigned long reduction;
> =20
>  		/* print only active entries & prevent division by zero */
> -		if (!op->frames_abs)
> +		if (!atomic_long_read(&op->frames_abs))
>  			continue;
> =20
>  		seq_printf(m, "rx_op: %03X %-5s ", op->can_id,

[ ... ]

> @@ -250,9 +251,12 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  				   (long long)ktime_to_us(op->kt_ival2));
> =20
>  		seq_printf(m, "# recv %ld (%ld) =3D> reduction: ",
> -			   op->frames_filtered, op->frames_abs);
> +			   atomic_long_read(&op->frames_filtered),
> +			   atomic_long_read(&op->frames_abs));
> =20
> -		reduction =3D 100 - (op->frames_filtered * 100) / op->frames_abs;
> +		reduction =3D 100 -
> +			(atomic_long_read(&op->frames_filtered) * 100) /
> +			atomic_long_read(&op->frames_abs);

[Severity: High]
This isn't a bug introduced by this patch, but does reading op->frames_abs
multiple times introduce a Time-of-Check to Time-of-Use race here?

bcm_proc_show() in net/can/bcm.c first ensures op->frames_abs is not zero.
However, concurrently, bcm_rx_changed() can hit the overflow threshold and
reset it:

net/can/bcm.c:bcm_rx_changed() {
    ...
	if (atomic_long_read(&op->frames_filtered) > ULONG_MAX / 100) {
		atomic_long_set(&op->frames_filtered, 0);
		atomic_long_set(&op->frames_abs, 0);
	}
    ...
}

If this reset occurs precisely between the initial non-zero check and the
division above, could the denominator evaluate to 0 and cause a divide-by-z=
ero
kernel panic?

Would it be safer to read the atomic values exactly once into local variabl=
es
at the beginning of the iteration?

[Severity: Medium]
Does changing the statistics variables to atomic_long_t introduce a signed
integer overflow on 32-bit systems?

atomic_long_read() returns a signed long. The expression
atomic_long_read(&op->frames_filtered) * 100 in bcm_proc_show() now evaluat=
es
using signed 32-bit integer arithmetic on 32-bit systems.

While the overflow prevention in bcm_rx_changed() caps frames_filtered at
ULONG_MAX / 100, multiplying by 100 when frames_filtered exceeds LONG_MAX /=
 100
will overflow the maximum positive value for a signed 32-bit integer.

Dividing this negative intermediate result by frames_abs yields a negative
number, which corrupts the final reduction percentage.

Should the reads be cast to unsigned long before the calculation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522180758.5112=
8-1-socketcan@hartkopp.net?part=3D2

