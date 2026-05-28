Return-Path: <linux-can+bounces-7721-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J6lN50hGGocdggAu9opvQ
	(envelope-from <linux-can+bounces-7721-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 13:06:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 463275F10C8
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 13:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CEB030F38D5
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA153DD503;
	Thu, 28 May 2026 11:00:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCC3C553A
	for <linux-can@vger.kernel.org>; Thu, 28 May 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966036; cv=none; b=cMduGpmhv1ve2mKIx2QNjXgQyCOPQkhzmXpUgATv3qsJM8fVOQ2tIbXAf1VgZBqZdZS/NA8gJsmdsGnqSq9MqfyzFbmrgSp4MhXx0kcoQzAbyQM3SbJETNGGteBh0l8197dkhJcYXEIMDIYQCaG1oBqzeHM4p4LHNkVfjxGhhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966036; c=relaxed/simple;
	bh=UWYu0HVr70jAB9GDSzDBc6rf8ZcRL/RS6wmYFNregkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwajvI8nCqcIQ0sG58q9vQm4H8Ry0HCdBiXJKNMX883askMVoqg0KrKMhyHJQqF/Wx3zXA5KJX7SW3Q8jRoNmueni1AF2yY+RCmPMbiTrAoeNkSamhPTAtZ3ZIRZpYRKrbVWXln09iF63BRw+cIf5tFOSyf6JKCKsGlxdeyLJnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wSYTJ-0002PZ-5w; Thu, 28 May 2026 13:00:17 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wSYTI-002G7H-1j;
	Thu, 28 May 2026 13:00:17 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C6725543AFB;
	Thu, 28 May 2026 11:00:16 +0000 (UTC)
Date: Thu, 28 May 2026 13:00:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
Message-ID: <20260528-fluorescent-sage-ladybug-43261b-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikkdziiqy6cx33j3"
Content-Disposition: inline
In-Reply-To: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7721-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 463275F10C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ikkdziiqy6cx33j3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
MIME-Version: 1.0

On 28.05.2026 11:45:39, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> No function in the flexcan driver ever accesses the .driver_data member
> of its .id_table array as device_get_match_data() returns NULL for
> non-of platform devices. So drop that unused assignment.
>
> While touching that array, drop the trailing comma after the terminator
> entry.

Does this mean that commit 5e6c3454b405 ("net: can: Use
device_get_match_data()") introduced a regression?

Marc

>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
> Hello,
>
> I found this patch opportunity while working on a cleanup quest that has
> unifying platform_device_id arrays as first step.
>
> Best regards
> Uwe
>  drivers/net/can/flexcan/flexcan-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503f..1871def90fe3 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2077,10 +2077,9 @@ MODULE_DEVICE_TABLE(of, flexcan_of_match);
>  static const struct platform_device_id flexcan_id_table[] =3D {
>  	{
>  		.name =3D "flexcan-mcf5441x",
> -		.driver_data =3D (kernel_ulong_t)&fsl_mcf5441x_devtype_data,
>  	}, {
>  		/* sentinel */
> -	},
> +	}
>  };
>  MODULE_DEVICE_TABLE(platform, flexcan_id_table);
>
>
> base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
> --
> 2.47.3
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ikkdziiqy6cx33j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCahggPAAKCRDMOmT6rpmt
0iT6AP9rg/NKsoWmpW2p3m/bppGBjKXNH6fYgP0aVCh2bFHtPgEA669ZIjbemAgw
SzKhE5PT3w8hzNGTJWl5iqKfxJvLOAo=
=kYpe
-----END PGP SIGNATURE-----

--ikkdziiqy6cx33j3--

