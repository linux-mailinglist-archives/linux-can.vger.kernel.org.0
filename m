Return-Path: <linux-can+bounces-7715-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD48EqY6F2qg9wcAu9opvQ
	(envelope-from <linux-can+bounces-7715-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 20:40:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A072E5E9243
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E863730AC635
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 18:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3E3F58FB;
	Wed, 27 May 2026 18:38:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367633839A5
	for <linux-can@vger.kernel.org>; Wed, 27 May 2026 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907105; cv=none; b=DJMkCHkYgtEOBTht1YscNw5rfT0Bbai2/gaDi9f9Jb7t+rASXtuKlQtRu6oP2hUJlYuftvZJMDmar3Ezh8TGEhxcXkhkWjCMMuASIfXfEtvPSJc97mh83trd+KglUZkp+OCc9pA1O/EtyK5/eJdPtqaAwSX2xYVXT41VyIopRbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907105; c=relaxed/simple;
	bh=+rY5JxyaswfuKPLhtbhWXEl7hxZSy5HpjhYXy89VLVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7DDOxmg/Op0OTiSSxHLySBuSpYzTADjCQU/j8ApJc9FVahXEdzCkjEHt/6xeLMYDNGMsweh9xNgOhmVZsUOQjWNZ4Vw1phsZU0bZE0M03rzvtrHcPQ3qA9PEFcCLGPsx69g43qHJPqYC6GaGBrI1P4YV4tT1lpwGzcdbEKRwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wSJ8t-0003yB-I0; Wed, 27 May 2026 20:38:11 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wSJ8s-0029Pm-0e;
	Wed, 27 May 2026 20:38:10 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 686E8543417;
	Wed, 27 May 2026 18:38:10 +0000 (UTC)
Date: Wed, 27 May 2026 20:38:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrei VOLKOV <andrey.volkov@munic.io>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>, 
	=?utf-8?B?TWF0ecOhxaE=?= Bobek <matyas.bobek@gmail.com>, Matyas Bobek <bobekmat@fel.cvut.cz>, qemu-devel@nongnu.org, 
	qemu-arm@nongnu.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Nikita Ostrenkov <n.ostrenkov@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
	Peter Maydell <peter.maydell@linaro.org>, linux-can@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Message-ID: <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
 <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
 <202605271738.21722.pisa@fel.cvut.cz>
 <20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de>
 <07cc057c-61b3-4744-96fa-1d792989cb4c@munic.io>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="atpbtn3n6tirqloc"
Content-Disposition: inline
In-Reply-To: <07cc057c-61b3-4744-96fa-1d792989cb4c@munic.io>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[fel.cvut.cz,gmail.com,nongnu.org,hartkopp.net,redhat.com,linaro.org,vger.kernel.org,pengutronix.de,protonic.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7715-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:url,pengutronix.de:mid,munic.io:email]
X-Rspamd-Queue-Id: A072E5E9243
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--atpbtn3n6tirqloc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
MIME-Version: 1.0

On 27.05.2026 18:25:37, Andrei VOLKOV wrote:
> As the original author, I have no objection to reusing (my part of) the
> header under GPL-2.0-or-later. The reason it was not done that way in
> 2005/2006 is simple: only GPLv2 existed at the time.
>
> All the more so since, as already noted, the code in question is essentia=
lly
> a direct transcription of offsets and bit-fields from the Freescale/NXP
> datasheets, which leaves very little room for a meaningful copyright claim
> in the first place.
>
> Personally, I would prefer that this code not be rewritten and be kept as
> is, to avoid introducing subtle bugs in QEMU later on.
> That said, @Sascha and @David may have a different opinion.
>
> PS: andrey.volkov@munic.io is my correct current work address, but I would
> prefer to use my personal one for this discussion.

I've added David on Cc and given them a short overview of this
discussion and linked this thread.

I'll agree to re-license the register definitions of the flexcan driver
to GPL-2.0-or-later. I'll poke Sasha tomorrow.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--atpbtn3n6tirqloc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCahc6DwAKCRDMOmT6rpmt
0u1LAP4mKlohHsTnebe9lwIIQq740qUWQ2hmO6lSb1j9V6GRLgEAo+gKM46vzADI
CgsMBEFiTs5OTFOa+WFu75HOsWzUzAo=
=W1/F
-----END PGP SIGNATURE-----

--atpbtn3n6tirqloc--

