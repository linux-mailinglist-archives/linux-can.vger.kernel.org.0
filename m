Return-Path: <linux-can+bounces-4005-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DFB06D78
	for <lists+linux-can@lfdr.de>; Wed, 16 Jul 2025 07:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895B75601C0
	for <lists+linux-can@lfdr.de>; Wed, 16 Jul 2025 05:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06AA2E7F0D;
	Wed, 16 Jul 2025 05:55:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4817D2
	for <linux-can@vger.kernel.org>; Wed, 16 Jul 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645341; cv=none; b=u9e+kkHS2b96bmdZriRe/k/a0WcSY5Y3G2zlUSRhgMW6g+GFaV0gfy4VnebIolfcvc/sEd99eS553cWiHcYLIQCETW/OYecFBrXoEDPGSpR/4q1wCy8C0+ZkmfrHgmsC/z1MOi8S+JfMrcepBjbbb3XlapPayLL4lYWTU1PsGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645341; c=relaxed/simple;
	bh=DLu47Sws4affwsWQ7hPDxhVZT/7Eg7SpKUcr9nfWTIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbNMRecb8qYoUcOHB7xmSwcxv+y5xglq5nsfXePPu1cVEnnfun4H3NdYnazCjz3rX419joMKc2N9kk8VfF6XVGAuA75XJyI7bfUu+g77cVom5w9qxBEkARtX0PXdvFYUtTslTTu//MEpWx97BMFH085NSoCoKah9/TjIVkUtWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubv78-0001BD-Hg; Wed, 16 Jul 2025 07:55:34 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubv78-008h77-0g;
	Wed, 16 Jul 2025 07:55:34 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 976C7442A70;
	Wed, 16 Jul 2025 05:55:33 +0000 (UTC)
Date: Wed, 16 Jul 2025 07:55:32 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: mailhol.vincent@wanadoo.fr, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
Message-ID: <20250716-godlike-organic-pudu-53deda-mkl@pengutronix.de>
References: <20250714175520.307467-1-andrey.lalaev@gmail.com>
 <20250715-almond-zebra-of-perception-9d2e6c-mkl@pengutronix.de>
 <b8221fe9-a167-4bcc-81bf-fb793712b48e@gmail.com>
 <20250715-smart-ultra-avocet-d7937a-mkl@pengutronix.de>
 <988d9355-2243-4187-b4ab-78652a1fb008@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2noy5ddnmfxmu77"
Content-Disposition: inline
In-Reply-To: <988d9355-2243-4187-b4ab-78652a1fb008@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--s2noy5ddnmfxmu77
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
MIME-Version: 1.0

On 16.07.2025 07:45:08, Andrei Lalaev wrote:
> On 15.07.2025 16:29, Marc Kleine-Budde wrote:
> > On 15.07.2025 16:24:22, Andrei Lalaev wrote:
> >> I was also surprised because this callback isn't marked as mandatory
> >> and that there are no additional checks.
> >>
> >>>
> >>> What about this fix?
> >>>
> >>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netl=
ink.c
> >>> index 13826e8a707b..94603c9eb4aa 100644
> >>> --- a/drivers/net/can/dev/netlink.c
> >>> +++ b/drivers/net/can/dev/netlink.c
> >>> @@ -285,6 +285,12 @@ static int can_changelink(struct net_device *dev=
, struct nlattr *tb[],
> >>>          }
> >>> =20
> >>>          if (data[IFLA_CAN_RESTART_MS]) {
> >>> +                if (!priv->do_set_mode) {
> >>> +                        NL_SET_ERR_MSG(extack,
> >>> +                                       "device doesn't support resta=
rt from Bus Off");
> >>> +                        return -EOPNOTSUPP;
> >>> +                }
> >>> +
> >>>                  /* Do not allow changing restart delay while running=
 */
> >>>                  if (dev->flags & IFF_UP)
> >>>                          return -EBUSY;
> >>> @@ -292,6 +298,12 @@ static int can_changelink(struct net_device *dev=
, struct nlattr *tb[],
> >>>          }
> >>> =20
> >>>          if (data[IFLA_CAN_RESTART]) {
> >>> +                if (!priv->do_set_mode) {
> >>> +                        NL_SET_ERR_MSG(extack,
> >>> +                                       "device doesn't support resta=
rt from Bus Off");
> >>> +                        return -EOPNOTSUPP;
> >>> +                }
> >>> +
> >>>                  /* Do not allow a restart while not running */
> >>>                  if (!(dev->flags & IFF_UP))
> >>>                          return -EINVAL;
> >>
> >> Thanks for the patch. As expected, it fixes the kernel OOPS,
> >> but the interface never leaves the BUS_OFF state.
> >=20
> > Which device and which firmware are you using?
> >=20
> > The gs_usb/candlelight interface is un(der)defined when it comes to
> > bus-off handling.
> >=20
> > I think the original candlelight with the stm32f072 does auto bus-off
> > recovery. Not sure about the candlelight on stm32g0b1.
>=20
> Sorry, my bad for not mentioning it earlier. I have several USB-CAN adapt=
ers:
>   - two are based on STM32F072 (not original CandleLight, but using the s=
ame FW)
>   - one is a original CandleLightFD on STM32G0B1, that I used for testing
>=20
> And all of them behave exactly as you described:
>   - both STM32F072-based automatically recover from BUS_OFF and I see
>     it in `ip -details link show can0`
>   - STM32G0B1-based doesn't recover and I have to down/up interface to re=
store it
>=20
> Since this is expected behavior and no kernel OOPS occurs,
> I will switch to your patch.

At least the behavior can be explained, it's not expected, though :) I
think we have to fix the stm32g0b1 firmware to auto recover from bus
off...and in the long term, extend the candlelight firmware, the USB
protocol and the Linux driver to support proper Bus-Off handling.

> Thanks a lot for the patch and your help!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s2noy5ddnmfxmu77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh3PqsACgkQDHRl3/mQ
kZyrSAf/fxtCelkig39kyxZMYhttLOpJjMKbC3cJDEmx+f9E+dq0I5GMcnX/TCAg
4eucQduA1M/ptmdG3hmvKFCdni2YqnXw4AMuYTj1z5RVEeNor0bjBTJg0ImFry+v
8aBSnkz/Cud/OAyAtMGdiu8diUNpfqvXle/JB4UKMBuHMoWpZjVnrnDwLI2gsPfH
Q3R8bZjogD6NBNfaAImbqfjX5XP1SLuzfkiBIFHSu0kIYjevl8ix5H9LPNPjbiwN
cfSZNyXa59U93denBVUHyhfQnhZ+j0FmcB+d8wQRIkXuw8J9H0KYjQ+r0iSsta/Z
qP1aSbgDaIlpoX4kRPk40PkZ49nkOw==
=scm/
-----END PGP SIGNATURE-----

--s2noy5ddnmfxmu77--

