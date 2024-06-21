Return-Path: <linux-can+bounces-836-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E32C912082
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203161F217CA
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D916E884;
	Fri, 21 Jun 2024 09:27:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9616E86E
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962074; cv=none; b=bWjGXUcubsDiVatdckcTbPmMIMzURYpnsYhlFjKYf9LD3iRAKXc/yvQ/cIOW3RtnzSJ/Phkagn9FQ4CWHOBmYgzXbq1QntP+Dk4NkKsXpkJ7rdTXwPSXGX71uABvu3IKD5GK5pbnKIXUqgin/M1MsCD9NXtZLL40eshhVoChw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962074; c=relaxed/simple;
	bh=XPVqLXBjRbX6zmVsamzyStzHTDt/4Iw9ic3xg13Y2YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al7OrQSBDLoIdqZ08YVnBLBAs9QhRb2slBlJaPmgE/Gm+3PPtvSoR9TbFWFVvyhGmjVb/32U1Rz5iitGn9SihMdMRGRNe0CqeFQOrrz3sJsXrA8nM5Wodj02aMfyvssKwLjRuAz0syizO6eVDq8sYjDij1cl/CkgadH2qh3EBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKaYV-00046T-9z; Fri, 21 Jun 2024 11:27:39 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKaYS-003uQ1-5k; Fri, 21 Jun 2024 11:27:36 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C68242EE620;
	Fri, 21 Jun 2024 09:27:35 +0000 (UTC)
Date: Fri, 21 Jun 2024 11:27:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] can: m_can: don't enable transceiver when probing
Message-ID: <20240621-witty-alluring-fossa-9e37f9-mkl@pengutronix.de>
References: <20240607105210.155435-1-martin@geanix.com>
 <20240621091908.juhoeb7zfo4zhsga@maili.marvell.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mcjbhrho3r27sp2u"
Content-Disposition: inline
In-Reply-To: <20240621091908.juhoeb7zfo4zhsga@maili.marvell.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mcjbhrho3r27sp2u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2024 14:49:08, Ratheesh Kannoth wrote:
> On 2024-06-07 at 16:22:08, Martin Hundeb=C3=B8ll (martin@geanix.com) wrot=
e:
> >
> > -		usleep_range(1, 5);
> > +	/* Then clear the it again. */
> > +	ret =3D m_can_cccr_update_bits(cdev, CCCR_NISO, 0);
> > +	if (ret) {
> > +		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
> > +		return ret;
> >  	}
> >
> > -	/* Clear NISO */
> > -	cccr_reg &=3D ~(CCCR_NISO);
> > -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> > +	ret =3D m_can_config_disable(cdev);
> > +	if (ret)
> > +		return ret;

> if ret !=3D 0, then the function returns "true", right ?
> as indicated by the below comment. But as i understand,
> this is an error case and should return "false"

AFAICS: This patch changes the return type to int. It Returns 1 if the
bit is writable, 0 if it is not, or negative on error. The caller has
been adopted, too.

Marc

> > -	/* return false if time out (-ETIMEDOUT), else return true */
> > -	return !niso_timeout;
> > +	return niso =3D=3D 0;
> >  }
> >
> >
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mcjbhrho3r27sp2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1R4UACgkQKDiiPnot
vG+28wf/d5kXtMlXaOEhuyIXDMaOXqm4lwP+EK8zYKu42idpOsv2mAt2y8BEt4PN
a59OGCt4bMxoA9/60H68sBTM4e8EOw0oDPP3cdNjjE2O5md3NTr9rlfQRAdEfPAE
4p1Oe2p2ElTHL0yTFWDB5aeBus2Gtobivn133U7QgNxksk2ZDA4646O7AkSmiWsx
xTBQqSICxbTBYHQo4aMbVGHTBjJBcaW4zLL2G5KnPGQ+KEsID7F1KYDPoIPDQ+PO
RmRaCjjkUVV3bo9DtFVhLHLykR6w+2q2+WVtYUSFR4ZmnlDC+OgETs/x5tFYvSqO
bU81RwFRYdXVwQwM09QhkcvziakOsQ==
=YXVm
-----END PGP SIGNATURE-----

--mcjbhrho3r27sp2u--

