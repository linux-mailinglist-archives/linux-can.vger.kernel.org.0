Return-Path: <linux-can+bounces-1580-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF86A98AA4E
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 18:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A5C1F2223A
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C496194083;
	Mon, 30 Sep 2024 16:52:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34481925B8
	for <linux-can@vger.kernel.org>; Mon, 30 Sep 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715133; cv=none; b=qcFnvXpGZm06V9FJavpqH0AVoG57P6nkAUzK7RWaOVQ0Lxuy/JGw5p0u+1+KSMi4ohtvt7Sa1F9KW9463DSdIIBH+Alf7tZarKVxu7Z0/TfARkLs3XhQZzmRL+oTcqnqYTtyxmKK1VcF2TwmNEMzomLuzXHrKy6R5NTO6YgypnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715133; c=relaxed/simple;
	bh=b4jG5jfepBq5kPRJADJMJ4moTQg/F0vilLCvt+kSYsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAkHGtWa95msEitkDigHHv1iH829mGFO4+EAysHOTeteAX0Eh2BOkXgCXcQRoeCHCP1BZ4088y9Ng3QbbYWlGDX5EOpV1Cr8Mau1sM6RZca9qTLpiwHwRTD2HRkj1Qc8EwLE+aKq18Q1WvNd3pADfXGJe6kzOCmT704lyTuE9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1svJck-0000VS-JM; Mon, 30 Sep 2024 18:51:50 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1svJcj-002fuM-J1; Mon, 30 Sep 2024 18:51:49 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 33EB5346E15;
	Mon, 30 Sep 2024 16:51:49 +0000 (UTC)
Date: Mon, 30 Sep 2024 18:51:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: pierre-henry.moussay@microchip.com, Linux4Microchip@microchip.com, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 01/20] dt-bindings: can: mpfs: add PIC64GX CAN
 compatibility
Message-ID: <20240930-unyielding-hypersonic-marmot-7bf720-mkl@pengutronix.de>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-2-pierre-henry.moussay@microchip.com>
 <20240930-voracious-hypersonic-sambar-72a1c5-mkl@pengutronix.de>
 <20240930-skeletal-bolster-544f3a2b290a@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zdxv4cgborwrwqlm"
Content-Disposition: inline
In-Reply-To: <20240930-skeletal-bolster-544f3a2b290a@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zdxv4cgborwrwqlm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.09.2024 17:37:22, Conor Dooley wrote:
> On Mon, Sep 30, 2024 at 06:32:29PM +0200, Marc Kleine-Budde wrote:
> > On 30.09.2024 10:54:30, pierre-henry.moussay@microchip.com wrote:
> > > From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> > >=20
> > > PIC64GX CAN is compatible with the MPFS CAN, only add a fallback
> > >=20
> > > Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.c=
om>
> >=20
> > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >=20
> > Who is going to take this patch/series?
>=20
> Ideally you take this patch, and other subsystem maintainers take the
> ones relevant to their subsystem. And I guess, I take what is left over
> along with the dts patches.

Makes sense. Consider it applied to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zdxv4cgborwrwqlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb61yAACgkQKDiiPnot
vG8ikQgAlPCBr+HZlUczPrHGyPED8iTqJvYiS+OfZKtoDXIwin93VavN8tobss+8
m/27veo7QQ13j1ss5NuDAZg+ZcfwSffO7ZwkF8YymyJCNIK8cfBojJCs3To+gWLl
X12JvSFLUceKWx3fPE7+YPUtOO8uKmSx1tEMAOAjzK9H1ASUfIw1OaQhkY0BF7AC
oRG9dk+druUBEgQuAtF3mv4ix87m08XlaWd3ceJFqFWLhnubI2mEw7mMSqmxyKEQ
t+9ncwVF8z15AyhTyp34bVCkz55q7WC4t+qwgSTIgLhj4BZFjJZcKLmNhz0NsiTG
0jgMQh1QxhdOob6MppRYPfDzWgS3lg==
=ZzHq
-----END PGP SIGNATURE-----

--zdxv4cgborwrwqlm--

