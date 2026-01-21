Return-Path: <linux-can+bounces-6249-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHo/Lgj6cGmgbAAAu9opvQ
	(envelope-from <linux-can+bounces-6249-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 17:08:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B10B59B1F
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14EFEA4DA08
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259633B6EB;
	Wed, 21 Jan 2026 14:37:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BF339873
	for <linux-can@vger.kernel.org>; Wed, 21 Jan 2026 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006239; cv=none; b=UGeF5UfS8JqLc1FzhEXLbyGpJWGN7dSmD0VVwV3PTr9fSMbOUOX81webEBV3T5vIlfiSEKy1y09H3tWSyNejGX815qfpyQiAENNQytLGZzitOt5/w6CtjXifcsFFYBLymUvY0r63M/t5F650sSqTLD5djFyHjOVMO+qsnkS/+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006239; c=relaxed/simple;
	bh=fh4ulMK2PgnUeptZbE85iEPgqObf9eaOvEVm7b8UyUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PucXi+HJ8dtPSj/uKBRVDXIroKknssYYgJb/q8pOxjeYf7VxmE6/qZuQyhPn7/ZG2lYYscxRSitoh/VoDEROEDS8CPG1XDk9DlojgfB8CliBAFLFWE4KG2B0lycjxPoh9NzxYUaP3mavSYXej+U1THpz0+Xi5l7U8DR002qfoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1viZKR-00035b-By; Wed, 21 Jan 2026 15:37:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1viZKR-001ljq-06;
	Wed, 21 Jan 2026 15:37:02 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 101AB4D4DCD;
	Wed, 21 Jan 2026 14:37:02 +0000 (UTC)
Date: Wed, 21 Jan 2026 15:37:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, davem@davemloft.net
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
Message-ID: <20260121-illegal-impetuous-honeybee-e6ef40-mkl@pengutronix.de>
References: <20260112150908.5815-1-socketcan@hartkopp.net>
 <a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
 <f2d293c1-bc6a-4130-b544-2216ec0b0590@hartkopp.net>
 <20260117091543.7881db1a@kernel.org>
 <dfbcab83-095d-4ed1-ae98-baada95d4cad@hartkopp.net>
 <39794159-c0cc-498b-a162-44e77b6c371a@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7kgznvc7dv3723j"
Content-Disposition: inline
In-Reply-To: <39794159-c0cc-498b-a162-44e77b6c371a@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.36 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-6249-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 2B10B59B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--x7kgznvc7dv3723j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
MIME-Version: 1.0

On 21.01.2026 13:55:47, Oliver Hartkopp wrote:
> I'm not sure how intense you followed my discussion with Jakub and Paolo
> about my attempt to move the CAN skb specifc content (8 bytes) away from =
the
> problematic skb->head reference an hold it directly in struct sk_buff?
>
> Meanwhile I sent a v2 patch set which has been dropped from netdev patchw=
ork
> because of its can-next mail subject:
>
> https://lore.kernel.org/linux-can/20260117132824.3649-1-socketcan@hartkop=
p.net/
>
> I've been running the patches for quite a while now and feel very confide=
nt
> that the solution is very efficient and safe for either CAN skbs and non-=
CAN
> skbs.
>
> To be more clear in the struct sk_buff changes I would change the comments
> in my next respin like this:
>
> 	union {
> 		/* skb->encapsulation =3D true */
> 		struct {
> 			/* eth/ip encapsulation / tunneling */
> 			union {
> 				__be16	inner_protocol;
> 				__u8	inner_ipproto;
> 			};
>
> 			__u16	inner_transport_header;
> 			__u16	inner_network_header;
> 			__u16	inner_mac_header;
> 		};
>
> 		/* skb->encapsulation =3D false */
> #if IS_ENABLED(CONFIG_CAN)
> 		struct {
> 			/* CAN skb content (ETH_P_CAN*) */
> 			int	can_iif;
> 			__u16	can_framelen;
> 			__u16	can_gw_hops;
> 		};
> #endif
> 	};
>
> And I wonder if it would make sense to add a WARN_ON_ONCE() in can_rcv() =
and
> friends?
>
> What is your opinion about the patch set?

We have to convince the netdev people why we cannot use metadata_dst or
skb extentions but put things in other more os less arbitrary places.

> Should I make it a net-next patch set to restart the discussion there?

Rather continue the discussion :)

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x7kgznvc7dv3723j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlw5IoACgkQDHRl3/mQ
kZzyCgf/U8Av7tRJ6ot+U/xBySvEwle2DDU5f2VyH6HcW5dHFQGwbl+XPkfRDlt9
f8uPe13T2QjkZc+rPxut/WgrCs/plJE9TBCvp09OG+Ww7sQgtUdV/Er+gc4ZwaCu
5cvkbAZEecLQJYzqHvnetluRW/6UtYKL3btP0KQj8Fd8VxMD9VQVd+rQ84s913nI
I7lemUQ6j/ODEDVdJBERpQ6P4cQRT7Gb6XJGbR4DJWKKiycqQZ6sRhWwoFai4S2H
YNdn2iLnkokFZZm0pNeGoi5o0l0Zn/Apa4itZ5EHjoMF0ES73Y4fC7zfN2N1590k
cO4GNWY5Nr3tvFTm/ZKWjn+PJzLCkw==
=ah/k
-----END PGP SIGNATURE-----

--x7kgznvc7dv3723j--

