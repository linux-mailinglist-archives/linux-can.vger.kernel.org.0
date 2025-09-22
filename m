Return-Path: <linux-can+bounces-4780-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9010B8F9BB
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 10:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C7D3BCEF8
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3082765CA;
	Mon, 22 Sep 2025 08:42:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABFC120
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530552; cv=none; b=peK/O9voJWKtLjexpEl26XI3ZZ42aqDu0O0mRP8GBY3dL/0/+D4et5mg1iEpa+9aXXg8IGBlAEucXItQIDFU2o3sOMDHtzRTe41rckjgSXVweg6MivwU31PSy8jqNPqNkOEbbezkoiYYPdyy9Y8xC44EfxUwFEywE1Y9FfeztMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530552; c=relaxed/simple;
	bh=XN4/LFhbuMm965GkjELnsptjg7r/XfEoVb9AEC91U28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGMO2TlfvVMLVfaVEkh0/KQZMHOs3g3iMpGc6kkDsU132nTTYP5E3/3jTo6O1YUBG20StDCKiypQ1uUZTmYLeA1eL9YMnzCFnxWsHYxBhDyYDXfYhRZ5aoswzt/6/928gsc79sx4hp+JGsW+psCgp+BHLzjNBxQeLLCXvsRrdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0c7s-0003Gr-T4; Mon, 22 Sep 2025 10:42:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0c7s-002YsO-0C;
	Mon, 22 Sep 2025 10:42:24 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AD22D476BC6;
	Mon, 22 Sep 2025 08:42:23 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:42:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 0/3] iplink_can: fix checkpatch.pl warnings
Message-ID: <20250922-astute-impressive-skink-36e51a-mkl@pengutronix.de>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3xgujmcnlbrx335"
Content-Disposition: inline
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--x3xgujmcnlbrx335
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH iproute2-next 0/3] iplink_can: fix checkpatch.pl warnings
MIME-Version: 1.0

On 21.09.2025 16:32:29, Vincent Mailhol wrote:
> This is a clean up series which goes through all the checkpatch
> warnings on ip/iplink_can.c and fixes them one by one. By the end on
> this series, there is only one warning left:
>=20
>   WARNING: Prefer __printf(2, 0) over __attribute__((format(printf, 2, 0)=
))
>   #320: FILE: ip/iplink_can.c:320:
>   +static void __attribute__((format(printf, 2, 0)))
>=20
> Because iproute2 does not declare the __printf() macro, that last one
> can not be fixed.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

For the whole series:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x3xgujmcnlbrx335
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRC+sACgkQDHRl3/mQ
kZzBDAf9EL08OmO1nL09yIWV48Duc/h32BfHiB1PnGxkLuZzeIlcjordRFp13KL+
B0rm7+zaoKY0SV7yazUh4Hg5mWoAThE7pXFA8LIECmRLvv1yMhZEr3FRmSP27lKi
Q29lj7wSTOZ5jspbuytco0EpOOgTO0CYAGiugggYSRu2n/3jucMGws10cmcTjyVX
3UUzKGve/5IytVcQLMfILZfPHTjtvv5hOODvgcJos44+kf1rlF8RRbPq9iI1k27t
3l2jLmmKxJ1NGLR95yqR2mO0ZO7/woVlk8DIFBAQrcFD6AHY7UgXS2YVTv+VAZn5
TS1mQnGG3QHVTVwzi5bGooaotOT3YQ==
=i8s/
-----END PGP SIGNATURE-----

--x3xgujmcnlbrx335--

