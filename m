Return-Path: <linux-can+bounces-6662-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFASKdNmpWmx+wUAu9opvQ
	(envelope-from <linux-can+bounces-6662-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:30:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B54761D687E
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69899304FFB7
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B639527C;
	Mon,  2 Mar 2026 10:22:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6B396D2E
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446949; cv=none; b=GkIDJ6rhu6N6hX582qf4xV0Ws4F459MAndmz8G7Nx1wSMWcd7eqG8qGkcPCXhvvoeOZOVerpKTLStOUxN19kpGKHHVmRPlu+xZT7kouoqO+1GXAx+oKPZ+sfwWurGfCA0+KeRIbfJE5rgrHmr5/MWYxUqJVsqWPblcyZ76QC7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446949; c=relaxed/simple;
	bh=HqEwmNdhvFeVCl63tRY1xg9osz/QZ1wvY+jnLl5W5jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVg3xm6lS4w+BztlhUvF756MGC0mrndaq8dRnxEemu9lwg0F+wgeNOFM8Ia0POu1PB+czznwq2BO30LcuelRoFj8Z3+o4+LKvk5AHiKnw04jm0ITQKHv6MV+DCMwjLjpU6RTQrR3geXD0ffFn4AiWlPKgO+bcCzBLts1hbjRTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0Pv-00031d-LO; Mon, 02 Mar 2026 11:22:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0Pu-003MZA-0F;
	Mon, 02 Mar 2026 11:22:23 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 303A14F5068;
	Mon, 02 Mar 2026 10:22:23 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:22:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 3/3] can: statistics: add missing atomic access in hot
 path
Message-ID: <20260302-lovely-gainful-bullmastiff-d64e20-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
 <20260219-bcm_spin_lock_init-v3-3-c61026740d7b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ulqydq4vnegmly25"
Content-Disposition: inline
In-Reply-To: <20260219-bcm_spin_lock_init-v3-3-c61026740d7b@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6662-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.940];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,socketcan.hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,hartkopp.net:email]
X-Rspamd-Queue-Id: B54761D687E
X-Rspamd-Action: no action


--ulqydq4vnegmly25
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/3] can: statistics: add missing atomic access in hot
 path
MIME-Version: 1.0

The nipa/ai-review bot found these problems:

| https://netdev-ai.bots.linux.dev/ai-review.html?id=3D873e6dfb-7d8e-4f4d-9=
8ef-a89fcedb701a

commit 083c819fbd59ad774cbf0662b6530ae8cf926328
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: statistics: add missing atomic access in hot path

This patch converts the matches field in struct receiver from unsigned
long to atomic_long_t to fix a KCSAN race that was missed by commit
80b5f90158d1.

> diff --git a/net/can/af_can.h b/net/can/af_can.h
> --- a/net/can/af_can.h
> +++ b/net/can/af_can.h
> @@ -52,7 +52,7 @@ struct receiver {
>  	struct hlist_node list;
>  	canid_t can_id;
>  	canid_t mask;
> -	unsigned long matches;
> +	atomic_long_t matches;
>  	void (*func)(struct sk_buff *skb, void *data);
>  	void *data;
>  	char *ident;

With this type change, is can_print_rcvlist() in net/can/proc.c also
missing a conversion?  It still accesses r->matches directly:

net/can/proc.c:can_print_rcvlist() {
    ...
    seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
               r->func, r->data, r->matches, r->ident);
    ...
}

Should this be atomic_long_read(&r->matches) to match the other
conversion sites?

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ulqydq4vnegmly25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaVk2wAKCRDMOmT6rpmt
0hCPAP4ldtAYCFY8/gNMBEHzMyoTgLSZJ3vT2+GDitBCaLU9ygEArEDgUow8XNJt
kCSSSx5FIKDV5Qju/X40Z+RaslQ+4gg=
=UW4A
-----END PGP SIGNATURE-----

--ulqydq4vnegmly25--

