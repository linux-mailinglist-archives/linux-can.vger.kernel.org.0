Return-Path: <linux-can+bounces-8227-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xH5GNz/mT2q5pwIAu9opvQ
	(envelope-from <linux-can+bounces-8227-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:19:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200D73431D
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T6m5FBHI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8227-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8227-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5471F302F993
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805DE3A2E28;
	Thu,  9 Jul 2026 18:18:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D804DB546
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:18:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621088; cv=none; b=MAwBniyxn16lJMuwA6R1evQALTir4WYiObGgL203BKDEX0yenZUF5cY+h20UzivZkgcVruGttIAjFVHFrPbJMPC7lxpxpEZBGmHXQs1/tmQZrcw3Dwf1AfWYQ7KJ310qIMIhAoTnEERA1X0Zi7bWvZ51WfhB+h4cH3uj6quKe4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621088; c=relaxed/simple;
	bh=fvVxNCCR5kk2RgUfd6h83AJQB/aYCwHeqZF9yV77X8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WKa8U0wOtRV9ocyynL3CuL2FX0759uW6AtiKalYwEHsPKkiio9aaLKCNIWgF09Lu124jQBjXdpSeIeBUNBH8ovUiS1IJnuzMpWFkTB4MiSFH3U0MNvplvPKKy97Dk0k+LuKLDAEf8VeTqsdOqOaBJshyyrSfEKnzVMOgPFlsmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6m5FBHI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2911F000E9;
	Thu,  9 Jul 2026 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783621087;
	bh=snbr7FaaBv28Oey30e3pRhIUR+OOZ0wJ/eb4CuPscic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T6m5FBHIFswOyFjWft3oMsSkgvxhwk+sUTLWhLT0D3fTl/6M41KE3IO2UZpdXY8Na
	 dbSr6PWvpx+E+B+D3QRsK/5Bm6tEgrHF54egVC7acgYdFI2QdaPfQ6ysriIqgsa5Fs
	 10RIbquor1DNNNsqQkiQA8j9GQnNQwANFtYQ+Mr8rvsZn2t7wAr2SRVvy5rh6Q4hT3
	 BxP9FXBracO3xbHPw5+YIuSl9rPQX9H3xZJHlWHgRZ7dclyc/URPxGfsBEguopTV6F
	 LvKALF0XoM99ZQ1o2rJmtdfGG+/RKWiYZ0dal+2DbRjSfDo4303jI5lDSGyywBQ1VG
	 tezFSf7qMQErw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/11] can: bcm: add locking when updating filter
 and timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v11-3-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-3-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:18:06 +0000
Message-Id: <20260709181806.DB2911F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8227-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3200D73431D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TX path directly overwrites active CAN frames via `memcpy_from_msg=
()` without a staging buffer or write-side lock, rendering the read-side lo=
ck useless and allowing torn frames or arbitrary `can_id` injection.
--

--- Patch [3]: [PATCH v11 03/11] can: bcm: add locking when updating filter=
 and timer values ---
commit e17f7ae3aed2616decbe79bc147ce9802da8e284
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This commit adds locking to protect timer and filter data updates in
bcm_rx_setup() against concurrent execution of RX handlers. It also adds a
lock-protected snapshot of the currframe in bcm_can_tx() to avoid partial
overwrites by content updates in bcm_tx_setup().

Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE=
@google.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..af4bb4182bc29 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -293,22 +294,26 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
>   * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interfa=
ce
>   *              of the given bcm tx op
>   */
> -static void bcm_can_tx(struct bcm_op *op)
> +static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
>  {
[ ... ]
> -	/* read currframe under lock protection */
> -	spin_lock_bh(&op->bcm_tx_lock);
> -	cf =3D op->frames + op->cfsiz * op->currframe;
> -	spin_unlock_bh(&op->bcm_tx_lock);
> +	if (!cf) {
> +		/* read currframe under lock protection */
> +		spin_lock_bh(&op->bcm_tx_lock);
> +		memcpy(&cframe, op->frames + op->cfsiz * op->currframe,
> +		       op->cfsiz);
> +		cf =3D &cframe;
> +		spin_unlock_bh(&op->bcm_tx_lock);
> +	}

[Severity: High]
This is a pre-existing issue, but does this read-side snapshot actually
provide protection against partial overwrites from bcm_tx_setup()?

When updating an existing TX operation, bcm_tx_setup() directly overwrites
op->frames using the sleepable memcpy_from_msg() without holding
bcm_tx_lock or using a staging buffer:

net/can/bcm.c:bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
    if (msg_head->flags & TX_CP_CAN_ID) {
        /* copy can_id into frame */
        cf->can_id =3D msg_head->can_id;
    }
    ...
}

Because the write-side completely ignores the lock, could a concurrent
timer still transmit torn CAN frames?

If TX_CP_CAN_ID is used, could the frame be transmitted after the user
payload is copied but before the enforced can_id is applied, allowing
unprivileged users to bypass ID enforcement and inject arbitrary CAN IDs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D3

