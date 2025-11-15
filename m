Return-Path: <linux-can+bounces-5416-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E87C6049D
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 13:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3619353561
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E623D288;
	Sat, 15 Nov 2025 12:19:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EA23817F
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209182; cv=none; b=mE+BtBikL9xFs7ZJgG33v4qqSh/6Xz3q7YxXY9nr07gkUkh3MvnvjmoPmeDMUczooD4Tkum0fFXBK00V5TpSBep4XMjqJPA0aPHSGSdsi7mke0xbeA2fIpEzZQLUZTnsD4AM6Zignyrd0YQPInQPHpn+OxLjVgvvs+ho7IYOAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209182; c=relaxed/simple;
	bh=BIoywaodL7hAJesJOMmcLwgutv/JKjju1Qd2nX8pvd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TspLsefnDpqpcZALUfreA2sz8sbdnMxuRaYnkcO4ZDYIKUaX/prhFd6my2NaA7YXnMmNf9tTt7E1JHgv57RLrDZG5csTINnXBAWS589bgxxlfEEl0zOyA/8rOSK2Vp3i977jxdTHVdEf1TJnndDUTZh2NWEdAaUQ26eK3Fzzjmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKFFa-0006FS-Rr; Sat, 15 Nov 2025 13:19:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKFFa-000aNX-1W;
	Sat, 15 Nov 2025 13:19:30 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 32B9549FDA6;
	Sat, 15 Nov 2025 12:19:30 +0000 (UTC)
Date: Sat, 15 Nov 2025 13:19:28 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
Message-ID: <20251115-devout-alligator-of-witchcraft-656ceb-mkl@pengutronix.de>
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
 <20251102-pwm_sample_point-v1-1-3bbea180f59e@kernel.org>
 <20251112-remarkable-puzzling-fox-3b3202-mkl@pengutronix.de>
 <a84c66ff-c5ad-418e-afb6-31f114eda17c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kqjr7tgkyhqfx7br"
Content-Disposition: inline
In-Reply-To: <a84c66ff-c5ad-418e-afb6-31f114eda17c@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kqjr7tgkyhqfx7br
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
MIME-Version: 1.0

On 15.11.2025 12:14:31, Vincent Mailhol wrote:
> >> ---
> >>  drivers/net/can/dev/calc_bittiming.c | 30 ++++++++++++++-------------=
---
> >>  1 file changed, 14 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/de=
v/calc_bittiming.c
> >> index 268ec6fa7c49..222117596704 100644
> >> --- a/drivers/net/can/dev/calc_bittiming.c
> >> +++ b/drivers/net/can/dev/calc_bittiming.c
> >> @@ -24,7 +24,7 @@
> >>   */
> >>  static int
> >>  can_update_sample_point(const struct can_bittiming_const *btc,
> >> -			const unsigned int sample_point_nominal, const unsigned int tseg,
> >> +			unsigned int sp_origin, unsigned int tseg,
> >
> > Please don't remove the "const".
>
> I always considered it silly to tag a scalar parameter as const. Because C
> passes the function argument by value, it is pretty meaningless. But I gu=
ess
> this change is out of scope. I will restore this in the next version.

Here they are both the reference values in the right format. I know I
don't want to change them. So I've marked them as const, to document
this.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kqjr7tgkyhqfx7br
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkYb8wACgkQDHRl3/mQ
kZwnnQgAhpOuekh1YBp3Y+P9WCGSq21n1rK77a/Csx8RY1+jKG4aaDIvmWJwV+3x
zmd/cU2J69Gt1NJqNBoJEhmBZekEzR/i2lt+5A1ja9tP/SoIyoKw6c1OUDauWySw
cH6gafj5cQkI0Gtl1ZdDu7vl8RrB5Sbrt3azNjfJWI8JDcZ0ya+JhGZae6OLT2AY
VO6XR2jYNA7GlI+ZiAJ8s2HQ2d5CyqLoLUnQBCyQGObvGY+gLwgJWXvVTYzIljnb
Nvt6f6HVT71LbFK28DiRAl/SVkauokzDtOY3aApwiK5GP8qStUm/0AuFVcljulDX
m56Y4qR3tmoW97RI9pKckGYPgazNCg==
=JoDe
-----END PGP SIGNATURE-----

--kqjr7tgkyhqfx7br--

