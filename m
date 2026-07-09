Return-Path: <linux-can+bounces-8233-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9RusLj7nT2rzpwIAu9opvQ
	(envelope-from <linux-can+bounces-8233-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:23:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE373438F
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:23:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P+EaK1t0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8233-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8233-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4D7F3037A5E
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116124DBD8C;
	Thu,  9 Jul 2026 18:23:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C14DBD6B
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621436; cv=none; b=C7VAN9PtGI13kkpIPpw6s8zXfS/QShnIW04Mz72psrNntDEStnvqGnzF1pMraA6Sdzz0Y6oHXkuvxx7xS8IVLUS/4Mne9dXq5qaqQtNl6Vd/oIYe9W+DD/hrNhXGixmf+JEmvUcBvzyFZ3cFcP5kjBXgF+MuQa3CN43dgps+Ixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621436; c=relaxed/simple;
	bh=XJkjgekzWfXkKXu78nPd5vEfBBI/IrzY6lwplmIA7DA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WXvdfsYTRqTDz+PbMaHbJ93CGbRidFcqqRU3ocF/OWd9gVI2fDm/PUuF4tDexjz7SvQDqPWaNdMmjMFI9tqixSc2wS3k61YwW5pGum6w+PfrWJc2L9pgU5o9PcewPTxZIjaGagWvPMsKifoTvjnlAtrQsPRdwZ2Ew25n3ryUVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+EaK1t0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328351F00A3A;
	Thu,  9 Jul 2026 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783621434;
	bh=VacfK80/gixQIAaZScbU5iTscSywqSECrR629QjgXoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+EaK1t0oh28jrFePNf4ADEAGErTeXm2Uyu2/2kjdig6OHCVoGjz/noecoguPn73m
	 zQIAZ0vRLCf5mA4g9K2/rVCyqTpe0A+HJy6smHvmoWbP8QbUqaBov3IMux6S3qe8i0
	 /iZA5lTfP8MYjf5e8Iitli1igqKSAQkFaAgPILV9ZkAfv0W0fx11lC6k6+HFywMwQx
	 qfsGPhJ+/ttG34CrITCA39bmkEcqM9U+KNgIbIaWcKu9KmJTJTrkgus2MC2xhy2I02
	 LnId1v17hlqql461dvGkJD6NAL5BMHl5SKdVoWvEfKbtMEOvvTcDNtV4T71thTBd5H
	 6a0vL/npvzAyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/11] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v11-4-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-4-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:23:53 +0000
Message-Id: <20260709182354.328351F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8233-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,hartkopp.net:email,lists.linux.dev:replyto,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64AE373438F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `frames_filtered` can exceed `frames_abs` when a throttle timer =
flushes multiple multiplex frames across a `frames_abs` reset, causing nega=
tive reduction percentages.
--

--- Patch [4]: [PATCH v11 04/11] can: bcm: fix CAN frame rx/tx statistics -=
--
commit 6e9ade605885c93bf1fc795169b773f4a95e422c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit fixes a KCSAN data race complaint in bcm_rx_handler() by
converting frames_abs and frames_filtered to atomic operations. It also
moves overflow updates into separate functions and aims to prevent
negative procfs reduction percentages.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..38c3f690c1cd0 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -290,6 +294,24 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  }
>  #endif /* CONFIG_PROC_FS */
> =20
> +static void bcm_update_rx_stats(struct bcm_op *op)
> +{
> +	/* prevent overflow of the reduction% calculation in bcm_proc_show() */
> +	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
> +		atomic_long_set(&op->frames_filtered, 0);
> +		atomic_long_set(&op->frames_abs, 0);
> +	}
> +}
> +
> +static void bcm_update_tx_stats(struct bcm_op *op)
> +{

[ ... ]

> @@ -497,12 +519,9 @@ static void bcm_rx_changed(struct bcm_op *op, struct=
 canfd_frame *data)
>  {
>  	struct bcm_msg_head head;
> =20
> -	/* update statistics */
> -	op->frames_filtered++;
> -
> -	/* prevent statistics overflow */
> -	if (op->frames_filtered > ULONG_MAX/100)
> -		op->frames_filtered =3D op->frames_abs =3D 0;
> +	/* update statistics (frames_filtered <=3D frames_abs) */
> +	if (atomic_long_read(&op->frames_abs))
> +		atomic_long_inc(&op->frames_filtered);

[Severity: Medium]
Could frames_filtered still exceed frames_abs here if a throttle timer flus=
hes
multiple multiplex frames right after a counter reset?

If frames_abs reaches the LONG_MAX / 100 limit, bcm_update_rx_stats() resets
both counters to 0. If a subsequent frame is received, frames_abs is
incremented to 1.

If an active throttle timer then expires, bcm_rx_thr_flush() iterates and
calls bcm_rx_changed() for previously throttled frames:

net/can/bcm.c:bcm_rx_thr_flush() {
        ...
        /* for MUX filter we start at index 1 */
        for (i =3D 1; i < op->nframes; i++)
                updated +=3D bcm_rx_do_flush(op, i);
        ...
}

Since frames_abs is non-zero (1), the check in bcm_rx_changed() evaluates to
true, and it will increment frames_filtered for each flushed frame.

Because bcm_rx_thr_flush() can process multiple frames at once,
frames_filtered could quickly become larger than frames_abs, which seems to
result in the negative procfs reduction percentages this patch intended to
prevent.

>  	/* this element is not throttled anymore */
>  	data->flags &=3D ~RX_THR;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D4

