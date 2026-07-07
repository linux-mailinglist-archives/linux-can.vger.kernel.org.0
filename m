Return-Path: <linux-can+bounces-8069-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZXUaFffXTGrpqgEAu9opvQ
	(envelope-from <linux-can+bounces-8069-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:41:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D371A87F
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:41:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y0oj62nz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8069-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8069-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41F5301C3C2
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843AA3D904D;
	Tue,  7 Jul 2026 10:37:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3B3CF026
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 10:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420636; cv=none; b=a6IDe8VrfQcEfl/+06pnqhIXPzllUd2nwCj1W8+C36RoRUmHgtM7vHh+TZ9wufG6yZmNohaUEq9AyXFN42bKqKqRwySeMyI+VNPMMIcCYUtMPvNUFDDLLpMgKIjpe/AjxSZtCW9bRllmoDrk0rj/EB9Bez4w7G/okcW3ldUp1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420636; c=relaxed/simple;
	bh=OAcMJ5pIshBmGiJvWWCJnIYYmlmZqTHWKDm/msO7TZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EGRxQu86jAfX5Xn/CHPSjdGahazh4JOKJMw+vNmLzHEXl4WlallOxR7f78Xf+++iD37lJivtqM34JvBz65eS5VyWsrPqDG7DockQOLvtmHe2al4GegFy7hgYe978NM1WoEbnCsV9ppYgs8Lz35I3f0nfKhM/GNYmVCPOuGZ2OO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0oj62nz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6AB1F000E9;
	Tue,  7 Jul 2026 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420635;
	bh=bzeGEUhZPsj5uV51ISn8wDaV2BLtbx4sh0TzaUn4zvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y0oj62nzDl65AxIIWKQPpxPy7ezLjvumSXPPnNVeRrXQxsFk0VMzONZUEgz7AVJcB
	 X+152lVITWNvHpQrtpd3tdjvMheoY7X1B+7U/Jytj6vBSrc46138qk2wkmYwH3AZAO
	 ksyVEkDTIqSey11LD5ax6Rhs6SxS6q5REH/wj83LQ6RB/6X/Vcr4j6vY93xSu/gaVa
	 WWVQdvO++NIiDX3OOFMBY3/KVeKqw2l3biFqicDDh6ifSjVZ49wlQa9riZH74PSWXg
	 5iBBbRPG+SO+N5L5zv21UFP8k/L30A2k6n5aQ+j38bMKNMcugfRti2uo/Rkf+0qvnm
	 9KClfiTtzLRZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260707-bcm_fixes-v3-4-84600ca6d889@hartkopp.net>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-4-84600ca6d889@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:37:14 +0000
Message-Id: <20260707103714.9A6AB1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8069-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: E71D371A87F

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] A Time-Of-Check to Time-Of-Use (TOCTOU) race during statistics r=
eset can permanently break the invariant `frames_filtered <=3D frames_abs`.

Pre-existing issues:
- [High] Missing RCU publish/subscribe barriers for lockless list operation=
s, risking uninitialized memory reads in procfs.
--

--- Patch [4]: [PATCH v3 4/7] can: bcm: fix CAN frame rx/tx statistics ---
commit faeade145d2ba64627aca2f6af5f2b0b8ad0d933
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs. Use atomic operations with (signed) long data types to
access the statistics in the hot path.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fd548c6eaa913..0378e31ea10ed 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -280,7 +283,8 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  			seq_printf(m, "t2=3D%lld ",
>  				   (long long)ktime_to_us(op->kt_ival2));
> =20
> -		seq_printf(m, "# sent %ld\n", op->frames_abs);
> +		seq_printf(m, "# sent %ld\n",
> +			   atomic_long_read(&op->frames_abs));
>  	}

[Severity: High]
This is a pre-existing issue, but does this function safely traverse
the lockless tx_ops list?

bcm_proc_show() traverses bo->tx_ops via list_for_each_entry() instead of
list_for_each_entry_rcu(), which lacks the necessary subscribe barriers.

Additionally, neither bcm_tx_setup() nor bcm_rx_setup() use list_add_rcu()
when inserting into these lists:

bcm_tx_setup()
    list_add(&op->list, &bo->tx_ops);

bcm_rx_setup()
    list_add(&op->list, &bo->rx_ops);

Could reading /proc/net/can/bcm/<inode> while another thread concurrently
sets up a BCM message on the same socket result in traversing uninitialized
memory due to missing RCU publish/subscribe barriers?

>  	seq_putc(m, '\n');
> =20
> @@ -290,6 +294,15 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  }
>  #endif /* CONFIG_PROC_FS */
> =20
> +static void bcm_update_stats(struct bcm_op *op)
> +{
> +	/* prevent statistics overflow */
> +	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
> +		atomic_long_set(&op->frames_filtered, 0);
> +		atomic_long_set(&op->frames_abs, 0);
> +	}
> +}

[Severity: Medium]
Could this non-atomic reset allow other threads to interleave their
increments and permanently break the statistic invariant?

If Thread A hits the LONG_MAX / 100 threshold and begins resetting the stat=
s:

Thread A
bcm_update_stats()
    atomic_long_set(&op->frames_filtered, 0);
    atomic_long_set(&op->frames_abs, 0);

And Thread B is concurrently processing bcm_rx_changed():

Thread B
bcm_rx_changed()
    if (atomic_long_read(&op->frames_abs))
        atomic_long_inc(&op->frames_filtered);

If Thread B reads a non-zero frames_abs, then Thread A resets both to 0,
and finally Thread B increments frames_filtered, wouldn't frames_filtered
become 1 while frames_abs is 0?

This would leave frames_filtered greater than frames_abs, causing the procfs
output to display negative reduction percentages.

> +
>  /*
>   * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interfa=
ce
>   *              of the given bcm tx op
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v3-0-84600ca6d889@hartkopp.net?part=3D4

