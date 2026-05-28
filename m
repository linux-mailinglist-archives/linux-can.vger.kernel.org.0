Return-Path: <linux-can+bounces-7725-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJBgNlhDGGoEiAgAu9opvQ
	(envelope-from <linux-can+bounces-7725-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 15:30:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A12D5F2B9B
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A25E300C0D6
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2393EE1C7;
	Thu, 28 May 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pegeU1Mk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DED3E8343
	for <linux-can@vger.kernel.org>; Thu, 28 May 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974998; cv=none; b=qjMhrdte6gZY98h3vfkLdmRWi7/OAER0Xau00beb/80ilhC62Y0jx/0q+/cb3bntVcMQjb6fkyMFotfmEyd0NL+NcZQyUWqRJ9x93iM6INY2c+DKZ9ShrSJDA0RkgOmbdDI2M26LDFf14iQIMYoyZdcoY8GdOH770VqLxwuYwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974998; c=relaxed/simple;
	bh=XNnQVZfxi2P3fZljukpwXEVlZgMpLhjtAPozWaeQj3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYPppeQ8e06KhD5Z0yt1CMnVtxfpz5tdEhhcSzwm4CRJuGMRG5YadPRhiIEbYMaP3F7OGXD0xLkb1hk6KJ4c1oAY2uSyWndmn1Lz6cZeWfHeySexcZf5lTcJY6/W/HwyWoWrW5/tInJsEkY/LcgoP3tiyEXgKHD+wn6Aeg3k9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pegeU1Mk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49048e043e5so50969815e9.1
        for <linux-can@vger.kernel.org>; Thu, 28 May 2026 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779974995; x=1780579795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCXQegNTB+nVINOGNKfMUrvEbATtYHfPnRY5JjuHmaY=;
        b=pegeU1MkwVcT9uIBICu0vN1GGtXdM1bBGCVzHQ4PeCziG9hSqIcHCWVQT0nZEav4Kt
         1gcaj8vLRo53Gn2pzedvvQOWSXRWPP2GY4cJilvYWgt0YZOHURtXNntUTe9XF/EwTWYq
         2CnfsITsmg8myJK99SOZ9XiqGijTsTCrjwRnQdMLqv9p7eJ7LZqxX0pdV7GDB4QYNU1t
         Ly19bu749bPwPa95kx/FHnEwdCQQ+XslFMv0TEY5If7+bxfKG+muOpTElQEWTL8qOa4U
         /r4Qym0kLCloLMk/seh3GF2TkK6u90dZP2rYO7BwXtbtT0r6K6avgufK0Fk3iccqbW8k
         qQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974995; x=1780579795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCXQegNTB+nVINOGNKfMUrvEbATtYHfPnRY5JjuHmaY=;
        b=DvVD/JnhqFEgbaCKkkOanwwreQNVDnuNWuO6y8wwkHnWYLQYhY8ccctPpy0Bstf8sz
         fFVeG/edtHCHph/FsI2iBXIPlNg/DgdPraw3OlB947lXuhgSQwN86tg8P0wBGciLt8YI
         99J0jZ695LHjzJn0AokgUJlGvleoEhT/d75fDu/MSr3b9UYuETtvqqKlH+5/cbmn819l
         XtU+EmTs1yYrqt/TaynIuVvQn8v5KBooom4lau04YTZQFTqQykQAJOGod3E82w3c4AaF
         WnCB1kiCW2JHNR/kjcrxroV/8nXMZPZ0lqgXX20vB3Odo4CbC04NmH10pjldxVIXg4mI
         CLHA==
X-Forwarded-Encrypted: i=1; AFNElJ+0Y3bksT8n9gKLrlDORQGN+o4gFzpH2xsY16E8HZ1225ASwVgxZls6cZDvhjZekh5VepdcV/7lvdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiQMzxn3Yrwm64piFMMzw9cthr4HyjQcsXoaZRDIFzYKMtc3K
	+hGgOGp20tad94nK5qDJx3y2/tZQMESOBvlpT8bEN5RUAwvwR39Rf2HKqoDa3Vpb+GA=
X-Gm-Gg: Acq92OFvqsvWrRXYXImaATuZXrooHWxn1W5sZIKKSEAvbDfUDqm/02qMkO3azjmuyFR
	Xe1wU5cCfIWUStunZFE+vF5h0Wttp77MahfqLom5WijuLbNwL/yA9mdP1Rq1OwQ1VBgnNmnfbMJ
	J89puJhdNmGzQMnMkd1iUjiKgA+DN+M2M0YXOjAdUUrMfjmoD80dHEMXUfnujtBbTDhnU+0alXx
	YMCahPOiP84+KT2jh8UpkVFvHfffTvGhQHYt8c2ErL04HGd0fnq4ZC2g5nUFzJAmiXPDwSb5wk0
	o8WSX/Le6Fjh3HDKbT/xmmfO1B+cqXLWsN4ie9NNS2RVJny1Mf1UPT6EEulVq9ISflxCeJROEYo
	yNWhWFF5SlVvvokU4AW330OuxPIn66OjtWzf4TA5+P8dGnR6HAn/4UFxxPwPTwN3FEDRwtu0VSt
	6TPiBo4Ij+Ny/2U8jQfMXT9S9E1wxweGHS9Xu/AahzBsdVmpg2tVDEwewIs6es/RLLNq1wj+nBY
	a4VpjWWDDD1FCO6uJgvHIaX6w==
X-Received: by 2002:a05:600c:5298:b0:48e:7854:1608 with SMTP id 5b1f17b1804b1-490428dd523mr445577905e9.25.1779974995087;
        Thu, 28 May 2026 06:29:55 -0700 (PDT)
Received: from localhost (p200300f65f47db04e567da92d09b3dda.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e567:da92:d09b:3dda])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4908b573d1dsm24714265e9.1.2026.05.28.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:29:54 -0700 (PDT)
Date: Thu, 28 May 2026 15:29:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
Message-ID: <ahhCjFWJopFbFSg7@monoceros>
References: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
 <86caae65-e768-494b-8a75-f79ffcd2f5e4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t6cslezevnhpypcv"
Content-Disposition: inline
In-Reply-To: <86caae65-e768-494b-8a75-f79ffcd2f5e4@kernel.org>
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7725-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,baylibre.com:email,baylibre.com:dkim]
X-Rspamd-Queue-Id: 9A12D5F2B9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--t6cslezevnhpypcv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
MIME-Version: 1.0

Hello Vincent,

On Thu, May 28, 2026 at 01:02:20PM +0200, Vincent Mailhol wrote:
> On 28/05/2026 at 11:45, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > No function in the flexcan driver ever accesses the .driver_data member
> > of its .id_table array as device_get_match_data() returns NULL for
> > non-of platform devices. So drop that unused assignment.
> >=20
> > While touching that array, drop the trailing comma after the terminator
> > entry.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> > Hello,
> >=20
> > I found this patch opportunity while working on a cleanup quest that has
> > unifying platform_device_id arrays as first step.
> >=20
> > Best regards
> > Uwe
> >  drivers/net/can/flexcan/flexcan-core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/f=
lexcan/flexcan-core.c
> > index f5d22c61503f..1871def90fe3 100644
> > --- a/drivers/net/can/flexcan/flexcan-core.c
> > +++ b/drivers/net/can/flexcan/flexcan-core.c
> > @@ -2077,10 +2077,9 @@ MODULE_DEVICE_TABLE(of, flexcan_of_match);
> >  static const struct platform_device_id flexcan_id_table[] =3D {
> >  	{
> >  		.name =3D "flexcan-mcf5441x",
> > -		.driver_data =3D (kernel_ulong_t)&fsl_mcf5441x_devtype_data,
>=20
> But now, fsl_mcf5441x_devtype_data becomes unused, right? Should this
> also be dropped?

Indeed. I would have expected that this results in a compiler warning,
but there isn't one for me and I expected that the struct is still
referenced in flexcan_of_match[] but obviously didn't check.

I'll wait with a v2 until the discussion in the neighbour thread in
reply to Marc's review ends.

Best regards
Uwe

--t6cslezevnhpypcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoYQ08ACgkQj4D7WH0S
/k6ebwf9Hp0mS55KJ2SPFpKPKwFLOvgU4aNzVxsoNP0gVIOpOuAyjIhbfdvCl5Gj
WlWg8wjBkcEVQv59iLdGvC5muVwcTrm9iSHvmSvr70ts1DwaGp55YDSxcLnZju4J
eRcWHe1pC9WSGvloDNOK/WIkdUgaE7Ougr7xNLUxan9M3rAkBEzsr49NnhTGWTZq
spMi4iSI8D+HUeyXOSiYnHhS5/N2NrWKPk91CGBCzXxvYRZYqWjJAmEZz5sQ2fY2
Q3eDpjOc+2S4WoeTushQgLbBqnqx+w7abfHCC/cBhssoc5bu6t+VztzkEG0+m52Y
6nM5jHdvh1o7aiJC04cOVQJo3KdXcA==
=y3I5
-----END PGP SIGNATURE-----

--t6cslezevnhpypcv--

