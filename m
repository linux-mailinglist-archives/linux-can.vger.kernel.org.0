Return-Path: <linux-can+bounces-5504-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 491F6C711D8
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 709E434EE94
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D92E7178;
	Wed, 19 Nov 2025 21:09:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50812245012
	for <linux-can@vger.kernel.org>; Wed, 19 Nov 2025 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586548; cv=none; b=OsvnL1v09SXMOfxNiVuFaJGzlsmgHLTmpPV/Nk1OcLq3C63L6wkLwL12C08wgRPtqu2As8rxiN/QiPzcprFYWyjPe4rZIWO5OXM7tTY305F7bi8ftbs0LmiH75/Pwf5vmTlEpxXrj8OgOP4LoPnH0AFFFau8jBuSbrzlJGFkx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586548; c=relaxed/simple;
	bh=+wHZ8kndg+X7R6h10C6p1ojqPx/Q4+5yOdi0FqARBas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k84hISZVcqgu4K5zvgTauHQT7svNupf5Px5eaYb9RXENgYDLtyybrhpamNzvglRQ0RJbEdzT3id8ZJTRWa77VXvN29hROOla91ieK+7BcBX+MziizplPKFKMyDvPENR8pv58WRiuGBqCIcFD6cU6Bu9YhLrs9c+Fwr+2Pu7XeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vLpQ7-0001ou-Bi; Wed, 19 Nov 2025 22:08:55 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vLpQ6-001JPm-2X;
	Wed, 19 Nov 2025 22:08:54 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 81DC74A331D;
	Wed, 19 Nov 2025 21:08:54 +0000 (UTC)
Date: Wed, 19 Nov 2025 22:08:52 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, linux-can@vger.kernel.org
Subject: Re: Mainlining of [canxl v2 00/15] CAN XL support for review (full
 series)
Message-ID: <20251119-hypersonic-mamba-of-abundance-0c3f95-mkl@pengutronix.de>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <cedee756-ae5b-456c-96b0-9263177a647a@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wd4vx5bx5gcyvz6p"
Content-Disposition: inline
In-Reply-To: <cedee756-ae5b-456c-96b0-9263177a647a@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wd4vx5bx5gcyvz6p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Mainlining of [canxl v2 00/15] CAN XL support for review (full
 series)
MIME-Version: 1.0

On 19.11.2025 19:17:05, Oliver Hartkopp wrote:
> Hello Marc/Vincent/St=C3=A9phane!
>
> We are right before Linux 6.18-rc7 and I would like to have the CAN XL
> support ready for the 6.19 merge window.
>
> Unfortunately the reaction time and feedback from Vincent is currently ve=
ry
> intermittent. This is no criticism but risky for catching the 6.19 merge
> window.
>
> This v2 patch set is feature complete and tested.
>
> Finalized discussions (code complete in v2 patch set and tested):
> - make RESTRICTED a normal ctrlmode_supported option
> - make TMS a normal ctrlmode_supported option
> - omit CAN_CTRLMODE_XL_ERR_SIGNAL in netlink API
>
> Open discussions / review results:
> - not removing "const" in can_update_sample_point()
> - have the ctrlmode names in ip feedback messages capitalized
> - increase the resolution to two decimal places in can_calc_bittiming()
> - can_calc_pwm() has no return value (kernel test robot report)
>
> The latter are tiny fixes and beautifications that potentially can also be
> done after the merge window.
>
> Therefore I would propose to mainline the current v2 patch set right now =
and
> see what we can improve until the merge window closes.
>
> @Vincent: If you are currently busy I can offer to work on the open points
> for you. So it would just be a review-job for you and I would send a v3
> patch set until Friday (latest).

It's probably a week or so until the last PR to net-next.

For the next iteration of the series, please include you S-o-b,
otherwise I cannot take it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wd4vx5bx5gcyvz6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkeMeEACgkQDHRl3/mQ
kZy75QgAsEjvYPi5TW4HOwQHOBEJNVHhnjvAreyMz6r8V0cvwSdnays9LmTfGuEq
uK5oM4qrmsp+/zkC3Mk6R8Zv4uVSMXNQ044P3FfasGMMdh9SnCCIndyeU0kCWV0Z
yIekTLzPjxv8t1ix0tqlrITiU0cyuPWL+Chv6usMplp45z+LLTET80RyEhcY4ixw
KNi+4eZeZjnkxXfrS+E2o7MF0nCymqUy4WAmvnTOSl7mh0PJdhfT07pod0v+7L15
6GW+bjTGYzHY5DDDrX8QPLdvd8sadGtjfv24Tn0HG8ss4DN7gUNLuBkemm7FlklM
ay8KQlsAlzhg10f1pIFl47JFZj980Q==
=t9zW
-----END PGP SIGNATURE-----

--wd4vx5bx5gcyvz6p--

