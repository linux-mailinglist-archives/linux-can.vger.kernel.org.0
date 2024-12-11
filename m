Return-Path: <linux-can+bounces-2388-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2C9EC915
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2024 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C091883CBE
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2024 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86869236FB5;
	Wed, 11 Dec 2024 09:30:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F91236FB4
	for <linux-can@vger.kernel.org>; Wed, 11 Dec 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909454; cv=none; b=Qcpj7KIrkavcQlMnJfXdbFJlz5SFqeq8RU2/egH+VzAM1VRMF+PqobNiUdsC+UTPS70flx3iXtYkFatPCrq468TDO5DP+j9YYostC4Yue9e7AT1LoLauACyaVFPwfYM+TjY0Ra0Kp4g2Z33nbYZfx29ya31k00Hv7T+A5PLwm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909454; c=relaxed/simple;
	bh=jOVo7Q2WvVU03O0t+XqAud3SlqmO8KpGHBWCphWphkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJBA1eK7JK4uiA+NVIBcVIbp0INR2WMRnLxGnMmvTaRNEqBOawhjhx4HwSd/s2F0a1Hu+OuniDwSuHju6o5SKW1f8umxi+0B6sGioJ2igtR9oPIliplfs5o98nRoHzrmOuPzQpvS2yZG9Ad6gd4fOsmwxMteM3VWarl9oOU3ZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tLJ3P-0005yM-7S; Wed, 11 Dec 2024 10:30:47 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tLJ3N-002q3U-2f;
	Wed, 11 Dec 2024 10:30:46 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4C69738B60D;
	Wed, 11 Dec 2024 09:30:46 +0000 (UTC)
Date: Wed, 11 Dec 2024 10:30:45 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefano Offredi <stefano.offredi@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
Message-ID: <20241211-jolly-godlike-galago-708c52-mkl@pengutronix.de>
References: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
 <20241210-laughing-koel-of-nirvana-349f7e-mkl@pengutronix.de>
 <CAOv6HEC=FV1gGt17SQxWo9jTMkxhLHBmkPKAWDfg=EYGHpCfwg@mail.gmail.com>
 <20241210-watchful-kingfisher-of-focus-8bbf9f-mkl@pengutronix.de>
 <CAOv6HED6wuhUQcE36izZFWcjdsw0G=RUCLdnOJ1FKEj-e9dm_Q@mail.gmail.com>
 <20241210-gabby-augmented-mussel-8e3ea3-mkl@pengutronix.de>
 <CAOv6HECvDWOQMvvLi7ZQRsOMAQ83rUZUQoMM0Siym2nOEFq_fw@mail.gmail.com>
 <20241210-complex-impetuous-panther-fedb99-mkl@pengutronix.de>
 <CAOv6HEAxp303Y71XjNUaz5cVKriPLUS++0cHrm45248ORg=W1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5tro2bxuoidpgika"
Content-Disposition: inline
In-Reply-To: <CAOv6HEAxp303Y71XjNUaz5cVKriPLUS++0cHrm45248ORg=W1g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5tro2bxuoidpgika
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
MIME-Version: 1.0

On 10.12.2024 17:03:06, Stefano Offredi wrote:
> Il giorno mar 10 dic 2024 alle ore 16:28 Marc Kleine-Budde
> <mkl@pengutronix.de> ha scritto:
> >
> > On 10.12.2024 16:18:07, Stefano Offredi wrote:
> > > > > Even with those lines of code, If I print  spi->irq before the ca=
ll
> > > > > to request_threaded_irq() it keeps different error codes
> > > > > values (-19, -22, depending on whether I set the gpio controller
> > > > > values in ACPI table).
> > > >
> > > > Just to clarify: from the Linux point of view "rx-int" is a GPIO, n=
ot an
> > > > interrupt. It's connected to the "nINT1/GPIO1" pin of the mcp251xfd=
 and
> > > > this is optional. The IRQ which is available under spi->irq is conn=
ected
> > > > to the "nINT" pin of the mcp251xfd.
> > > >
> > > > > Even If I remove in ACPI table all the gpio references listed
> > > > > here below:
> > > > >
> > > > > - GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault...
> > > > > - Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }
> > > > >
> > > > > the spi->irq keeps error value -2.
> > > >
> > > > I suggest to first remove all "rx-int" related stuff from your ACPI
> > > > table and concentrate that "spi->irq" has a proper value.
> > > >
> > > > The relevant code is in acpi_status acpi_register_spi_device():
> > > >
> > > > | https://elixir.bootlin.com/linux/v5.15/source/drivers/spi/spi.c#L=
2294
> > > >
> > >
> > > Ok thanks I will investigate on it.
> > >
> > > Just to be sure, will the driver, if rx-int and interrupt logic is not
> >
> > "rx-int" is not used as an interrupt source. To keep things simple
> > forget about "rx-int" for now.
> >
> > > used, perform a polling on the spi bus to check for messages incoming
> > > on the can controller?
> >
> > No - polling is not implemented and makes IMHO no sense, as it's quite
> > some overhead.
> >
>=20
> Ok, now it's clear, rx-int (INT0) is not necessary,

If you use "rx-int" it would be connected to "nINT1/GPIO1" not "INT0"

> but nINT is necessary.

ACK

> I will investigate starting from acpi_register_spi_device.
> I think that the problem depends on the fact that my gpio controller is n=
ot
> described in the ACPI table, (is loaded as an external module after the b=
oot),
> and the reference from the ACPI mcp descriptor fails.
> Thanks again for your support. I'll be back when I have solved it.

If the GPIO controller is loaded late, you might run into the problem,
which this patch fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd24cfee7f63d6b44d45a67c5662bd1cc48e8b3ca

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5tro2bxuoidpgika
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdZW8IACgkQKDiiPnot
vG9POQf9HALQKvNBW81mFXFaD2IRHmI8pg0i0TDrISPlPt2Tz9cTHOYm7J+xneh6
r6IRpYO+00UE3SQ/CAXuyAGt8bBgHQB7k0MBLBRvC1uZQf3DqgcLxHSBt6FRty2t
QcElcA+8vPT5lJAMCzxTFyyANWNcV8iSKdgmWsuC5JUD80uoO/0UaNZiFb/hLuSk
CCBI9Zn3C7CVHVeDvEcaPFzCSf5tBcDf9MHECRjEoNyGCvsnUEr1nLcvlcHCXHFq
s5r6IUClATOjqFAe4PVRqwFKj/TMdpP+ijpK45IQLIPXdoypc6xXP73VT9vuCSGx
p7psU7wW4vxonzNImCIi36R9GM6FNQ==
=0I7+
-----END PGP SIGNATURE-----

--5tro2bxuoidpgika--

