Return-Path: <linux-can+bounces-4177-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCC1B121C5
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA527B6900
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691FA2EE97B;
	Fri, 25 Jul 2025 16:16:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC32EE99C
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460205; cv=none; b=nUq/F89ZZkDJfl205AwSZvwGfwdHb3oc2FqziycUHumfT59cutiJXqJCRcGn9mklSniFbEtWpxULaaWeEsOA9q2jD3gPxsZWZf0DBAyLD/Df6lQPj+KaiMBj/13XglxiQvXGdDXYnMx48AVExy2JjUH1ox34RDmi34oS5jC6kKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460205; c=relaxed/simple;
	bh=kGlaH500j0KmhEN+sXUnBuJs+w5OcW3iZg132aVdcY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY7xwTQ9yWwhnJhvzgp3JQ6XLcVZVQLJfEEm3QRLqJjUNlBxTEaV4L0BESLJd3UmrA+OlWll7TjwkkVAiWDbGDDswu5a9HqUqTsoTqdauphh8t24vsPav1rlVizTyrYypDPZExi293NluUN07SRrDbRsxmYPKP/wRvMer6AVYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL68-0008WC-9J; Fri, 25 Jul 2025 18:16:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL67-00AFgl-3A;
	Fri, 25 Jul 2025 18:16:40 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6313B4499C6;
	Fri, 25 Jul 2025 16:16:39 +0000 (UTC)
Date: Fri, 25 Jul 2025 18:16:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 07/10] can: kvaser_pciefd: Add devlink support
Message-ID: <20250725-courageous-hedgehog-of-infinity-648c10-mkl@pengutronix.de>
References: <20250725123230.8-1-extja@kvaser.com>
 <20250725123230.8-8-extja@kvaser.com>
 <20250725-ingenious-labradoodle-of-action-d4dfb7-mkl@pengutronix.de>
 <6cbe9e11-a9b7-48f2-8b13-068fb9eec290@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="flgicfrrzkbwcxqi"
Content-Disposition: inline
In-Reply-To: <6cbe9e11-a9b7-48f2-8b13-068fb9eec290@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--flgicfrrzkbwcxqi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 07/10] can: kvaser_pciefd: Add devlink support
MIME-Version: 1.0

On 25.07.2025 15:50:41, Jimmy Assarsson wrote:
> > > @@ -1876,6 +1883,8 @@ static void kvaser_pciefd_remove(struct pci_dev=
 *pdev)
> > >   	for (i =3D 0; i < pcie->nr_channels; ++i)
> > >   		free_candev(pcie->can[i]->can.dev);
> > > +	devlink_unregister(priv_to_devlink(pcie));
> > > +	devlink_free(priv_to_devlink(pcie));
> > >   	pci_iounmap(pdev, pcie->reg_base);
> >                            ^^^^
> >=20
> > This smells like a use after free. Please call the cleanup function in
> > reverse order of allocation functions, i.e. move devlink_free() to the
> > end of this function.
> >=20
> > >   	pci_release_regions(pdev);
> > >   	pci_disable_device(pdev);
>=20
> I agree. Thanks for finding this!
> I've tested moving devlink_free() to the end of the function, without any
> issues.

Thanks.

> If you don't find any other problems, do you mind making this change befo=
re sending
> the PR? Otherwise I need to wait for the netdev 24h grace period, as Paolo
> pointed out [1], before sending v5.

No problem. I've fixed the patch while applying the whole series to
can-next and including it in my PR. Thanks for your big contribution!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--flgicfrrzkbwcxqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiDreMACgkQDHRl3/mQ
kZwrWAf9GlZnjnwMdj94rgPfikBzeVct+3fcktCJj+0Kh+cNLVutNgapnHL//0mw
1vqLxVSQG8Vt4DetfaYhefgYX7OGvt25BJVej21EXZGAthrtMihYivHKMwhUi9SH
0zJRdIGcduVfjrnYMKHboER4v8WQZKr16iS8MbPW2usbUdBN2VtTaud71gbVNd2H
lLupDH3G9NV7ZS2mo2wc/TeHaaPJp5Bt8PhLIhGTEImrMEW7PfkAeOjcB/up7L9O
V3AD9MewKYcMBILL4RAeGyFQG6Fg60WQ29s0cXhgixjBdfWLwiQ7DUubu2v+GflS
25omEuovK2grKDjmAaL01nmBeLtmdA==
=754d
-----END PGP SIGNATURE-----

--flgicfrrzkbwcxqi--

