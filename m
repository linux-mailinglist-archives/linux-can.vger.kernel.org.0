Return-Path: <linux-can+bounces-2052-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBC19C867A
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1B61F22522
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CA11F756F;
	Thu, 14 Nov 2024 09:50:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544951DB95F
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577831; cv=none; b=KkTqmAD8zPFW39jUN6hfcMZ7W3hfmLmeyK6NE9I8w6vGIl/n6B1ftavYIjv38S3HzV4Gj12vh+4g8lsMBT3AW4RudP/3btlX5UwbYvOOqk3qZxphQC7q/yJrwdsg3qjLdw92tn3HllPLSVTvfmHz5UvaWbM4M4fZTnjywKk6BDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577831; c=relaxed/simple;
	bh=+k7u+P8eibwusFxT8ldXcAutkYTaVW+oHhYiJa7Ah2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXRVicJAMCjKZxWRmk0rYlID4Oin4ZrXh8Xjb1MJ75WIpnkf2wAtBRgkrgtyXPnCwBV4xXW3d/x3+45fcz6G/s+ESrmLB8ah8rHBYSsjJxarsebBznz2IWjSVhdoCsN+ev5yCQEZoaW2QzA3B78GgqLCKe/eH7ymwPThF80Sstg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBWUO-00069V-U2; Thu, 14 Nov 2024 10:50:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBWUM-000ijA-2R;
	Thu, 14 Nov 2024 10:50:10 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 68D54372F90;
	Thu, 14 Nov 2024 09:50:10 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:50:10 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Simon Horman <horms@kernel.org>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] can: m_can: add deinit callback
Message-ID: <20241114-optimal-literate-newt-a6ace7-mkl@pengutronix.de>
References: <20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com>
 <20241111-tcan-standby-v1-1-f9337ebaceea@geanix.com>
 <20241112144603.GR4507@kernel.org>
 <20241114-energetic-denim-chipmunk-577438-mkl@pengutronix.de>
 <cjg6hv4wspgiavym5g2mwrx4ranz4payml37fnhzupp2xvqc6f@ckmweysspqto>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zfbix6hpbtdjffy"
Content-Disposition: inline
In-Reply-To: <cjg6hv4wspgiavym5g2mwrx4ranz4payml37fnhzupp2xvqc6f@ckmweysspqto>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7zfbix6hpbtdjffy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] can: m_can: add deinit callback
MIME-Version: 1.0

On 14.11.2024 10:36:48, Sean Nyekjaer wrote:
> On Thu, Nov 14, 2024 at 10:34:23AM +0100, Marc Kleine-Budde wrote:
> > On 12.11.2024 14:46:03, Simon Horman wrote:
> > > On Mon, Nov 11, 2024 at 11:51:23AM +0100, Sean Nyekjaer wrote:
> > > > This is added in preparation for calling standby mode in the tcan4x=
5x
> > > > driver or other users of m_can.
> > > > For the tcan4x5x; If Vsup is 12V, standby mode will save 7-8mA, when
> > > > the interface is down.
> > > >=20
> > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > > ---
> > > >  drivers/net/can/m_can/m_can.c | 3 +++
> > > >  drivers/net/can/m_can/m_can.h | 1 +
> > > >  2 files changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/=
m_can.c
> > > > index a7b3bc439ae596527493a73d62b4b7a120ae4e49..a171ff860b7c6992846=
ae8d615640a40b623e0cb 100644
> > > > --- a/drivers/net/can/m_can/m_can.c
> > > > +++ b/drivers/net/can/m_can/m_can.c
> > > > @@ -1756,6 +1756,9 @@ static void m_can_stop(struct net_device *dev)
> > > > =20
> > > >  	/* set the state as STOPPED */
> > > >  	cdev->can.state =3D CAN_STATE_STOPPED;
> > > > +
> > > > +	if (cdev->ops->deinit)
> > > > +		cdev->ops->deinit(cdev);
> > >=20
> > > Hi Sean,
> > >=20
> > > Perhaps this implementation is in keeping with other m_can code, but
> > > I am wondering if either the return value of the callback be returned=
 to
> > > the caller, or the return type of the callback be changed to void?
> > >=20
> > > Similarly for calls to callbacks in in patch 3/3.
> >=20
> > please take care of errors/return values.
> >=20
>=20
> Will do.
> It's also missing for the init callback. Would you like this series to
> fix that?

If the patches don't conflict, please make it a separate patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7zfbix6hpbtdjffy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1x88ACgkQKDiiPnot
vG/Kxwf/fJlb/9WWhaKfa4QvyDHbJxW4P+FQekkElrHSRDiibms3OGOvKzmgPrcb
SU/OJAZ/y3p+1doX1K2V+Y2kFOm49x+egfdrk3V9XVXcoECe8yic7yk6y4GWVIdI
QSsiqk6NeU+GbxyoDK7xZX5CO0IBLeC0+gHJSBtVK8ImxT7IQoPsR0+QexCk6oJH
lXh946SEF1HNi04juAG7KiDUkKc92wQu4/pEQo1asqG1fVIorerr/j6FUnFbrkBc
tqSROOOP5nU9s69HfN9WBlRia6QUkG+qd7Y0axHyQwuee+Q/EgLhTiBJfaTaP6Y3
IBSgZomQ+l4tdIx7FDdJtPsRiniLaA==
=pNIA
-----END PGP SIGNATURE-----

--7zfbix6hpbtdjffy--

