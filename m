Return-Path: <linux-can+bounces-792-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A49910119
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA47B21AD7
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA419B3E1;
	Thu, 20 Jun 2024 10:05:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80402BAE2
	for <linux-can@vger.kernel.org>; Thu, 20 Jun 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877942; cv=none; b=k6Jx7n0ouxEzd1BKpb+iT3qxye/Fv3MQunIwcTy9SU9kFzhbSugXmWBAcYhsvzJX2dL3hHUUTTOculs/yhxTq/4hsU0OOAb8V/YgPPMvSNe3ZQD9/V5KdB/h1IYoBQojmR8bbvnP3yKoSHK+kBTACDhvBCbk9QL3UID2D/7DID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877942; c=relaxed/simple;
	bh=NlFmEdkSiDbRg9O1rHlSlNbNPawwqHyeB4eyje/e18A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4YwCPyewFRF3RIjhVS8fF3Bu20NYxvXH3xP03RCzrzGcwyGadh06iothePqBbaUlyjrTRIy2Qprzens2gdW8nNR4soT++DHKY7jE9sMht6vUi2TeHjLIk+Im1uFL+yOFcNQQ+gUbhyP0VMdNuvrKbRu+Vx5Wgca5hKs8dIhUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKEfe-0003N0-3N; Thu, 20 Jun 2024 12:05:34 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKEfd-003g4o-Gi; Thu, 20 Jun 2024 12:05:33 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3543B2ED872;
	Thu, 20 Jun 2024 10:05:33 +0000 (UTC)
Date: Thu, 20 Jun 2024 12:05:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH 2/2] can: kvaser_pciefd: Add MSI interrupts
Message-ID: <20240620-stylish-harrier-of-development-29f6c9-mkl@pengutronix.de>
References: <20240614152008.2730746-1-martin.jocic@kvaser.com>
 <20240614152008.2730746-3-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vkai6gt2xce4da7"
Content-Disposition: inline
In-Reply-To: <20240614152008.2730746-3-martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3vkai6gt2xce4da7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.06.2024 17:20:08, Martin Jocic wrote:
> Use MSI interrupts with fallback to legacy interrupts.

Thanks for your patches, but this fails to build on current net-next.

| drivers/net/can/kvaser_pciefd.c: In function =E2=80=98kvaser_pciefd_probe=
=E2=80=99:
| drivers/net/can/kvaser_pciefd.c:1777:54: error: =E2=80=98PCI_IRQ_LEGACY=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98NR=
_IRQS_LEGACY=E2=80=99?
|  1777 |         ret =3D pci_alloc_irq_vectors(pcie->pci, 1, 1, PCI_IRQ_LE=
GACY | PCI_IRQ_MSI);
|       |                                                      ^~~~~~~~~~~~=
~~
|       |                                                      NR_IRQS_LEGA=
CY
| drivers/net/can/kvaser_pciefd.c:1777:54: note: each undeclared identifier=
 is reported only once for each function it appears in

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3vkai6gt2xce4da7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZz/uoACgkQKDiiPnot
vG8LIgf/dp5+GAPX9ySBx6hNwMbqe0+seHs3jiG5cHY9odZ5Uu7AIZ9BEu36HwHS
ghW2l6OxH6hcqJwhEzk4ih2Y/qpYwxxGRUzQCKbRNXBu4UV7dOVNUkdy+zDiHVMV
dnWCOqP/o+ksemt5/5JYvgxu14KbZ2rURI7b8c1Oj3dzgKdPVZ+uvFHc20kbH2u7
XhfVOVoQK3byOfnFmX4HQYCQJtwtBwlhOW9eQMe0cK87uaVn0K1NrfAdK8Z8TVLa
1z7cJdfvFjN3wpDbgBDQ2yJ39WtTmX5sRyYBD5mtxuyxIiZUaxwkjvORSGIulMmb
fpWas2lM8yxQ8U3EgDACKKF5yZlfgA==
=vxXs
-----END PGP SIGNATURE-----

--3vkai6gt2xce4da7--

