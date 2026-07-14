Return-Path: <linux-can+bounces-8387-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6UXPHGIQVmrnygAAu9opvQ
	(envelope-from <linux-can+bounces-8387-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:33:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D316375372D
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RlecEvgL;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8387-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8387-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7061303ACC7
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC833655EA;
	Tue, 14 Jul 2026 10:33:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49541364949
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:33:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025182; cv=none; b=iAS2G72poNZgBzq2dDiSfMAf0U9Lfsr8n7+xCJudBO63ENh83pZJqBR0kj3X2x28IQ/xr7frYacHqRl/Tka0JfZ4kAY0nhnMwRCH0oUzerhopVzE+UT5Fy7QiY9CkX73YUEx42vjlBZoEjAB8GHxpRppuSXt3YvF/ksn6sfbJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025182; c=relaxed/simple;
	bh=Ra55QEotI1BfKgt76WAAF3Te2pMsRzKJlgkwOdliKuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qHDdB8aaeQdzR4Kw7gYHTigBSuB5RtFn+7WWVaedyt/a27wtWgu7OIeiFooYXdvWGYGvcttfkMWVRQV9M9h1fgg8+feO8X4AnpQHzSN9D9HlVjF/JcUufPop0qgcNzPFZzSlHV6UmL5/nMeD6h+q7OqhVs3c+6JXsiXDRvffsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlecEvgL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6391F000E9;
	Tue, 14 Jul 2026 10:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025180;
	bh=8m3B4GkzoSo2kWmb6czFj+zxJDgq7Gj5nydQPz2Qiew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RlecEvgLs6qasaI+xa/FcFsRO4Vu7DlVyE2LEewHrbGF3aCPHmPHZsUCLVLXRrDFq
	 emghlQKeFw+IqcfBjABRTqYqWg2DDzErgEcIdmYr32hKyykvcM7E/WwLHiWCTeLczZ
	 Q4hytR6Qfq5xAz1xy9sAMYF3tGtuUSrBiXh2ylfXROWCydi6frQRdB2IX2R4iODbNf
	 aH6Z9uJoHyPYJ8xcuAmvP+QerC+e16stj7b0BHS15xEorU+JMgq+oK4pmtv+iRkKfI
	 528zK06qeGaRepZJ1oGBqgm1fEQGHWKtTau0+mCtZwDU/kBEqmxTud6UeOyak62Atb
	 iF+nQ0ffTdnBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/11] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v13-4-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-4-fd667c61099a@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:33:00 +0000
Message-Id: <20260714103300.8B6391F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8387-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D316375372D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU list primitives lead to potential NULL pointer derefer=
ence or memory corruption during lockless /proc/net/can-bcm/... traversal.
--

--- Patch [4]: [PATCH v13 04/11] can: bcm: fix CAN frame rx/tx statistics -=
--
commit acb95cd7e83f916c374a2a2f75ed2b971c9fa9d5
Author: Oliver Hartkopp <socketcan@hartkopp.net>

    can: bcm: fix CAN frame rx/tx statistics

This commit fixes a data race detected by KCSAN when two CAN frames are
simultaneously received and processed by different CPUs. It transitions
the statistics counters to use atomic operations to prevent races.
Additionally, it simplifies overflow checks and consolidates rx statistics
updates into a single critical section.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..38c3f690c1cd0 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -229,10 +229,13 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
> =20
>  	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
> =20
> -		unsigned long reduction;
> +		long reduction, frames_filtered, frames_abs;
> +

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
This is a pre-existing issue, but while reviewing this code we noticed a
potential missing RCU primitive issue.

In bcm_proc_show(), the code traverses the bo->tx_ops list (which contains
the loop printing the tx stats above) using list_for_each_entry() instead
of list_for_each_entry_rcu(). This omits the READ_ONCE() dependency ordering
required for safe lockless traversal under rcu_read_lock().

Additionally, when adding to these lists in bcm_tx_setup() and
bcm_rx_setup(), the code uses the non-RCU list_add() primitive instead of
list_add_rcu(), which omits the required smp_store_release() semantics.

Since a user can repeatedly read the procfs file for a CAN_BCM socket while
another thread concurrently adds filters on the same socket, could this
expose lockless readers to uninitialized memory and lead to memory corrupti=
on
or wild pointer dereferences?

>  	seq_putc(m, '\n');

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v13-0-fd667c61099a@hartkopp.net?part=3D4

