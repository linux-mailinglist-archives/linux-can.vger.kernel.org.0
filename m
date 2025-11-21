Return-Path: <linux-can+bounces-5557-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B2EC78381
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E639733813
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F83396FE;
	Fri, 21 Nov 2025 09:30:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2C2D5937
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717456; cv=none; b=prFLWCUczKmDvnyp9hEE7QvTIs2loIKL73I7a/sGEvJeHXcICbS8D8jTAPAnwf37MwCU5DQ+iK8joaI/HS4qpSVuGliRO3m4vPPrsCGdEsmxOpKA4tqhTETyC1YIX4gakF+Nv6LN57EvrVaziyfhAwCli4we70Q2BMHohIK8boM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717456; c=relaxed/simple;
	bh=QSPptq2d7PCQbQMcbngp8F87nnzbNct6gc/5c3d3l14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3mrdSjeygMPlk4hjKFwfFJYoEkFxRynlO+75is6aENanTacj3KJkYOswoRy0VRWo8T8tw5pT8X64NfBHvJ+I31CaZ95oVjgbnOaj5AWKkUEv866EMMbYjbUJxjEX1Csvtg2It4zvtmiUeVfiIAv35FYQzvG76ZHciYK3XCNFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNTg-0004gX-EE; Fri, 21 Nov 2025 10:30:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNTf-001Yrg-3B;
	Fri, 21 Nov 2025 10:30:52 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B50EC4A4630;
	Fri, 21 Nov 2025 09:30:51 +0000 (UTC)
Date: Fri, 21 Nov 2025 10:30:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [canxl v4 16/17] can: dev: can_get_ctrlmode_str: use capitalized
 ctrlmode strings
Message-ID: <20251121-neon-wildebeest-of-contentment-fbad44-mkl@pengutronix.de>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-17-socketcan@hartkopp.net>
 <20251121-meticulous-authentic-hippo-a88adc-mkl@pengutronix.de>
 <c16bbec8-f4ad-4eb6-9e0f-362c3e6261df@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oxzrdw2bnwhgmmtz"
Content-Disposition: inline
In-Reply-To: <c16bbec8-f4ad-4eb6-9e0f-362c3e6261df@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--oxzrdw2bnwhgmmtz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [canxl v4 16/17] can: dev: can_get_ctrlmode_str: use capitalized
 ctrlmode strings
MIME-Version: 1.0

On 21.11.2025 10:19:39, Oliver Hartkopp wrote:
> > Here the prefix "XL-" is dropped. Was that intentional?
>
> Yes. The patches for iproute2-next and for the kernel are inconsistent.
>
> The command line (and its help text) uses:
>
> [ tms { on | off } ]
>
> The ctrlmode is named:
>
> CAN_CTRLMODE_XL_TMS
>
> And the output of 'ip -det -link show can0' currently prints:
>
> can <XL,XL-TMS> state STOPPED restart-ms 0
>
> Which needs to be changed to <XL,TMS> IMO.

That's iproute2, it can be patched later.

> I think 'tms' is better in the command line than xl-tms as it is clear th=
at
> tms only works with XL-only and if you try it otherwise you get an error.
>
> >>   	case CAN_CTRLMODE_3_SAMPLES:
> >> -		return "triple-sampling";
> >> +		return "TRIPLE-SAMPLING";
>
> There's not always a 1:1 name mapping.
>
> IMO CAN_CTRLMODE_XL_TMS together with "TMS" looks fine for the internal a=
nd
> external representation.
>
> > We should move this patch to the front, so that new members could be
> > added in uppercase from the beginning.
>
> This is a useless effort IMO.

It's really bad practice to change things in a series that has been
added in the same series. If you don't want to do it, I'll do that.

> When we decided to unify the capitalization as a clean-up four weeks later
> (what we did) than the patch sequence would look like this in the tree.

As long as you mean "upstream tree" - yes.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oxzrdw2bnwhgmmtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgMUYACgkQDHRl3/mQ
kZz+tgf+OgyMVIOWYaPmFXjiMzo1KXN89ysEVISdg+usVe2fiieVDJCGtBZ9tvh2
H+X1o5gJmIFEc+s/5Wko6gMez8Ld0iucEhwx/ipw51mKCuf7UJufCoBrXJYwDiAA
tKRd+RLYWYaEwCKYQK9qK4YDWIw5XtiLE1iGGzXwyqJuXcG13MQqjILBXHcregv5
0/tQeuO5LAHP1syub43STDjZhyh3Ur/R8jR1WWZi0LggEFE1DNB6tAWe+FN98VcT
Rq+82NBZb44crOqEj2PWGLiaUxw0osX36aISiWSvx1kxW9D/BesFuxxX6H7NXYK0
FKkxsG2R+9JBD3ogLN3rKqKKoHIJQw==
=1iV2
-----END PGP SIGNATURE-----

--oxzrdw2bnwhgmmtz--

