Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56BB380B3B
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 16:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhENONw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhENONv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 10:13:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F30EC061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:12:40 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhYYQ-0000W9-Si; Fri, 14 May 2021 16:12:38 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 08066624406;
        Fri, 14 May 2021 14:12:37 +0000 (UTC)
Date:   Fri, 14 May 2021 16:12:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
 <20210514131049.yluxu3cxaspeptvb@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nibbad2xacefy4to"
Content-Disposition: inline
In-Reply-To: <20210514131049.yluxu3cxaspeptvb@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--nibbad2xacefy4to
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 14:10:49, Torin Cooper-Bennun wrote:
> On Fri, May 14, 2021 at 02:34:17PM +0200, Marc Kleine-Budde wrote:
> > On 14.05.2021 13:19:43, Torin Cooper-Bennun wrote:
> > > Using the TCAN4550, I've had occasions where the m_can driver has fal=
len
> > > over with the "nobody cared" message -- the ISR has returned IRQ_NONE
> > > upon "99,900 of the previous 100,000 interrupts" (see
> > > kernel/irq/spurious.c, __report_bad_irq()).
> > >=20
> > > While such high numbers certainly indicate some kind of fault,
> > > presently, device-specific interrupts are totally ignored -- it may be
> > > that such a fault can be handled with a device-specific action.
> >=20
> > Do you know why the tcan4x5x specific interrupts are enabled in the
> > first place? If no-one is handling them, just mask/disable/etc then....
>=20
> The TCAN4550 has interrupts that cannot be disabled or masked, including
> those for faults involving SPI, power, and transceiver issues (e.g. CAN
> stuck dominant).

Ah, ok. Do they need any handling/acknowledge? You only read TCAN4X5X_INT_F=
LAGS, are
those clear-or-read?

> > > Comments are welcome. One thing right off the bat: I'm not sure wheth=
er
> > > the new callback should be added alongside clear_interrupts, or if it
> > > should replace it.
> >=20
> > I don't see why we need two callbacks from the generic interrupt
> > handler, one should be enough.
>=20
> Fair enough, and it makes sense to always clear the device-specific
> interrupts when handling them anyway.

ACK - and return irqreturn_t.

> tcan4x5x needs some cleanup re interrupt init/handling/clearing anyway,
> so I'll incorporate that next time!

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nibbad2xacefy4to
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCehVIACgkQqclaivrt
76m6GAgAphn9C71X5UxFL9JBmhWNlymlO36xXCr8O1BsbYF7K4AamQwDaErLYWA/
xXLSqhHNbThfxd/+Zly3qTXbpf/l/wK1iZAVpMDlmoKrs3kGxD7e/OXkxzoHko7V
p6HN6QuWfvPUzaIjfo0/u1wJio4gZUrWMD+llD7XOWtsV7wLhUx0C1OCv4m5Sy7K
QSf5kthvJf4J7cfrm9g0nPgDcku/12KMiaJAPQKaDGszByigUViH2/YktVMTbcDp
nVajdWiFPwYXIw9J1bxauTi2KrtBB89tkBoeGuPIPO7eOdRFZW0K+HpW+Mg+N2nU
Tu6AeiKtXa1hTZ9wCa3k3LIQHucUGA==
=wykO
-----END PGP SIGNATURE-----

--nibbad2xacefy4to--
