Return-Path: <linux-can+bounces-7822-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kZB1O92gKWq0awMAu9opvQ
	(envelope-from <linux-can+bounces-7822-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:37:34 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E066BFFF
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=EHo4M2qj;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7822-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7822-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0EB32714F9
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4305347536;
	Wed, 10 Jun 2026 17:27:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C7342C8B
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 17:27:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112454; cv=none; b=IJbmG8Ag3vCEuLQgJ6FBSscs4P5W7oKPRCSs9XKMU2tCNVoDBtorvSJv5nTLWhWqXj4LRQqNavbvCiZUgVN0wPh+Bczq9pEV2rzE8qnkb69hYN2wOngUkH2Fgkya1Daoxeg6HFbmfIDHG4hk82M4GTkXz48xMBgA7RhvzF4X4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112454; c=relaxed/simple;
	bh=kzErf+z7JSp8P7msfJBxTyBqs3Tz4zofU5rff5W0bhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hclYuhUN0jCva1lg6V2+RYpB8xH41eOFUDfWpOnreOPI+XJMLuKstf+zVS4mkLSQWcJ77+eSFscUIGPN5jIcdkWegWjKnZMmzDpFHkeN+G9EwbAiaBAzXPD+UYxBOFy1Hd0uxp3/mVxJbWP4hhJjNiQj5neb9PjCa/rCkMS44aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EHo4M2qj; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so5341100f8f.2
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781112451; x=1781717251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzErf+z7JSp8P7msfJBxTyBqs3Tz4zofU5rff5W0bhY=;
        b=EHo4M2qjxGrZ2NUVrsanfw4tDu+UR3Df+TuPdqWA/AZap5BweSbOe9mDvtzcH3Gt52
         4/UU3iYp/Ilc+W/MOvCqyMxBHZ1kbq0osPLXTtNpMZCH9wcKdrTfBXzS8q1cVcZJCMWo
         fwKgQTHRk40XO/Lj0LRHdAofQiqXNNKiBOqZkw3ye4Fq7+sFhnqJLvpHW+ONOm/u3B7h
         i1Zlp/cRkjOQIqLGINoB4ZiOJk5GtpOieMIg2zKtT4iHN2X+AG2edbhpDGGhZC4ufJxe
         CtNO97uAMEmCWoObwIlY86vyzeD1hgHBCQDSju3JGk5A/sp64Xrkmk6wde6T9mLkYDDz
         xfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112451; x=1781717251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzErf+z7JSp8P7msfJBxTyBqs3Tz4zofU5rff5W0bhY=;
        b=Tv5Mg6JEALaq2myi0B4J+vfyhQWqL607YS8FtCj49uT/nXlfCMMj2xGh6w1TIanG0i
         GLtTk75uMoR56McSEcIkvvDpjI+oFLy1U2M6/WgtH1dCFj0bEJUQriM9W9mJyJfIipAk
         OSJZOUEwwOcBp3+ZD/Eco5y6KQUk7twGFiYda+MJZcb/rWtIdr5gWw6a0Ka2T9xik0Ho
         antXjK8E/rfJvTvJ0t0H0OaQb0wYXWHrbyKRbdhiptBFlzn27CHFOat/soXng0fbToXA
         ekwSJOZs/zH/n/VXdfYpEkeWa2zKEPh6ata4xFBE4glnEwB1IqIujLjQg4BzmjAJdGQw
         3zaw==
X-Forwarded-Encrypted: i=1; AFNElJ/jkUo6hikl846xUGt4fTHG7rs4e0jkt1lDAXojFgT/ywi3wspmeN+Q1DC+6emefLeEpbYyIy/bzV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA7ZH/kSVgxWugt9MmKWdHcWvIlJwOZbceFuMvpf+Fm8zW3KF2
	uvqc4HMxbd+zXItx2NFRhT6pCbyCN4tQ3natgH9962v2k5rSeKy68H6bCA7q6gxD4+QrpCEV8R4
	u58ADMak=
X-Gm-Gg: Acq92OFSP9pb3fv2PmrPFs5oDcNjw2OX3/CcEjJEMpHLoj+8OAVKeG8xFSuczMG7NNz
	8g3WrRdspwKIxtgJrj7gcIJ2TN4tvWZg6OVMN6CP4DATScmNyLALm7zg78RmIyE9z4tWh079yRP
	pc5M2pTTUU5PaR2SuEc99ujkpE/nC2q96oXGVMYplacKdBt3PSi/nU+Gf7ORH3+kv4A1T1FPs4q
	mh7ZLSyjruJij3DaNfUxlLvDRTvbuIbiTXXIhzlEir4HSlWHDgVapyeWJoJqyGpqI+3a7dHAmvC
	fI8EnqUFzQb6LwfMTf0i1/23W4dmJJ9p9LGL6FIGvXcdTSrduzjSUj+LGkZCCmVAzlcGit02oYv
	J07dHiCxtwkiXmBokVw88gh/qYvqsruv++jrNWIn65Fi+4KfyC1FiQfzELhO2NWmrNtCyXxV5g6
	4r0wJ8JDLnhtTElHV1v5Le9AKe/6NX5CJAS30AWFgfPXdZ5BHDUOu+W4T5R9lH+G8nG5ktInMx4
	jCJf7KiqLfLvL4cs+OP2qxFAg==
X-Received: by 2002:a05:6000:29d6:b0:45e:e509:d2fa with SMTP id ffacd0b85a97d-460302dc8cemr29014867f8f.3.1781112451467;
        Wed, 10 Jun 2026 10:27:31 -0700 (PDT)
Received: from localhost (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f34413csm72375859f8f.21.2026.06.10.10.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:27:30 -0700 (PDT)
Date: Wed, 10 Jun 2026 19:27:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
Message-ID: <aimeLxHiQ74wwlR3@monoceros>
References: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
 <20260528-fluorescent-sage-ladybug-43261b-mkl@pengutronix.de>
 <ahhAhZ76nLc-eZg8@monoceros>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="va5ro6u5yud5cge3"
Content-Disposition: inline
In-Reply-To: <ahhAhZ76nLc-eZg8@monoceros>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:robh@kernel.org,m:geert@linux-m68k.org,m:linux-m68k@lists.linux-m68k.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-7822-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,monoceros:mid,baylibre.com:dkim,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 817E066BFFF


--va5ro6u5yud5cge3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
MIME-Version: 1.0

Hey Marc,

On Thu, May 28, 2026 at 03:26:29PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> On Thu, May 28, 2026 at 01:00:15PM +0200, Marc Kleine-Budde wrote:
> > On 28.05.2026 11:45:39, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > > No function in the flexcan driver ever accesses the .driver_data memb=
er
> > > of its .id_table array as device_get_match_data() returns NULL for
> > > non-of platform devices. So drop that unused assignment.
> > >
> > > While touching that array, drop the trailing comma after the terminat=
or
> > > entry.
> >=20
> > Does this mean that commit 5e6c3454b405 ("net: can: Use
> > device_get_match_data()") introduced a regression?
>=20
> Yes, I'd claim that this commit introduces a null pointer exception when
> mcf_flexcan0 (defined in arch/m68k/coldfire/device.c) probes.

I wonder what your plan is here. Should I send a v2 that also drops the
unused variable that I missed in my v1, or do you want this NPE
addressed first?

Best regards
Uwe

--va5ro6u5yud5cge3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopnn0ACgkQj4D7WH0S
/k6vGAf+P07h8wiZcTaqCGFDv3/2aYJax+UlwADLeBRQ17i1kGZEG57kJGO/DtG3
AJ3UwGF1EmwGKsZe0o1RY2aslrGi/H+9/YoB6DmZVyG+tox+0yvi4bM18XZOyllV
mklJFAB1Zm7Lbavlmq7U0WsaQ5JcNIOn5VvRTBuJsyGluJfMHr+F0n8qrzqEtMYY
XR/+Iaexegpe75VAXdLqPnlKPC6FzStBYkOWr1jLgIKJj5BrvXmlkAoL90+4yiJy
zv4gtclllsXd5q8/Btjclk5kPNVk1HYYVVVZDPRZ1VXeWg4zK5E8a8Gktu8SHbri
co1ZFXcx/TxF9w1oYwXWBdkD4jWZ3A==
=yx/5
-----END PGP SIGNATURE-----

--va5ro6u5yud5cge3--

