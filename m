Return-Path: <linux-can+bounces-4960-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F0B99067
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 11:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDD14A5ACC
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B452D5920;
	Wed, 24 Sep 2025 09:04:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609122D4B6D
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704660; cv=none; b=DDc8EVtSiFHdYX+rnnkLPrEWm8tWMrtjVX+KHa9kk6Dnz4J0S1+vUt8ZPwSHUr4UwUpcZ0xqEuEuBGhNoDKwvQQPmk0RC9QxvCNL91AuHUgF451pHBisUyhF1UEDhCjypoF2Oj/dW0xa5zFephhqAjzV9UbD7HCrp5wYxZAZyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704660; c=relaxed/simple;
	bh=r+LcEtvEAGXmmlvLm/COGVpP0/aeLqYmYcMIUDz8diY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv4JmxqdI1lJRpmBU11IIAnA4xSufGjCJ3NUVBRDXzSqs9H/JyuBpDbfNgPFBEqBUfNuiMPLcPp69BRTeacnslxjIqRT0TPeiRlOHEkr4RTjUiwYRdth1SarS+Wygv1NnGvTF+ENQHhLBWrdlYc6xwxRLBa0wAtrDfomtTtxft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1LPs-0001we-3V; Wed, 24 Sep 2025 11:04:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1LPo-000EHv-1z;
	Wed, 24 Sep 2025 11:03:56 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 418EA478AB9;
	Wed, 24 Sep 2025 09:03:56 +0000 (UTC)
Date: Wed, 24 Sep 2025 11:03:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Chen Yufeng <chenyufeng@iie.ac.cn>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH net 1/7] can: hi311x: fix null pointer dereference when
 resuming from sleep before interface was enabled: manual merge
Message-ID: <20250924-meteoric-spectral-wasp-e09db7-mkl@pengutronix.de>
References: <20250923073427.493034-1-mkl@pengutronix.de>
 <20250923073427.493034-2-mkl@pengutronix.de>
 <72ce7599-1b5b-464a-a5de-228ff9724701@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awlsuxnm5rqs3g2m"
Content-Disposition: inline
In-Reply-To: <72ce7599-1b5b-464a-a5de-228ff9724701@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--awlsuxnm5rqs3g2m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 1/7] can: hi311x: fix null pointer dereference when
 resuming from sleep before interface was enabled: manual merge
MIME-Version: 1.0

On 24.09.2025 09:53:42, Matthieu Baerts wrote:
> Hello,
>=20
> On 23/09/2025 08:32, Marc Kleine-Budde wrote:
> > From: Chen Yufeng <chenyufeng@iie.ac.cn>
> >=20
> > This issue is similar to the vulnerability in the `mcp251x` driver,
> > which was fixed in commit 03c427147b2d ("can: mcp251x: fix resume from
> > sleep before interface was brought up").
> >=20
> > In the `hi311x` driver, when the device resumes from sleep, the driver
> > schedules `priv->restart_work`. However, if the network interface was
> > not previously enabled, the `priv->wq` (workqueue) is not allocated and
> > initialized, leading to a null pointer dereference.
> >=20
> > To fix this, we move the allocation and initialization of the workqueue
> > from the `hi3110_open` function to the `hi3110_can_probe` function.
> > This ensures that the workqueue is properly initialized before it is
> > used during device resume. And added logic to destroy the workqueue
> > in the error handling paths of `hi3110_can_probe` and in the
> > `hi3110_can_remove` function to prevent resource leaks.
>=20
> FYI, we got a small conflict when merging 'net' in 'net-next' in the
> MPTCP tree due to this patch applied in 'net':

Thanks for the heads up!

>   6b6968084721 ("can: hi311x: fix null pointer dereference when resuming
> from sleep before interface was enabled")
>=20
> and this one from 'net-next':
>=20
>   27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users")
>=20
> ----- Generic Message -----
> The best is to avoid conflicts between 'net' and 'net-next' trees but if
> they cannot be avoided when preparing patches, a note about how to fix
> them is much appreciated.
> The conflict has been resolved on our side[1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.
> ---------------------------
>=20
> Regarding this conflict, I simply added "WQ_PERCPU" flag to
> alloc_workqueue() in hi3110_can_probe() -- the new location after the
> modification in 'net' -- instead of in hi3110_open().
>=20
> Rerere cache is available in [2].

Looks good to me!

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--awlsuxnm5rqs3g2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjTs/gACgkQDHRl3/mQ
kZyx0gf/UCZhfEACLYiv63jqN+8A/mY2yygku+FycTqj+0/Bi2uKkf/PyxAcwPdH
jwwt4ktOItNYyWxUraXwKi4dnb+i0Dx6VbK32v1VVUxZR+CBHzcE6Y4129x+Vz07
azgyXhEI+Z/1Nf9GGHFU7+n3SNlyqIr+eMUl4LQxPJAPv81uWh1yIJ1tDLSqPSUt
mj2d0z6ZURIOgzHqSGz/taF2GGBPXLVSFM3mWpIWNeWssaeICRuZUW27gMl7lZi2
2z9ZKRNBT6j2AHGIbNygM5ACKTOEzlVWhTnTAFlHGI5LqnWd151vAz9Cv/Cm/7AG
E6WU4e7bFXbBc9k/Zs4hLl3tZ92TvA==
=a1zX
-----END PGP SIGNATURE-----

--awlsuxnm5rqs3g2m--

