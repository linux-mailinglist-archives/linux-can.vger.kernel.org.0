Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08211391B88
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 17:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhEZPUK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 11:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbhEZPUJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 11:20:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9967C061574
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 08:18:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1llvIp-0007fj-Dy; Wed, 26 May 2021 17:18:35 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:cbc5:840b:a05c:ea5c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9FC2A62CB2D;
        Wed, 26 May 2021 15:18:34 +0000 (UTC)
Date:   Wed, 26 May 2021 17:18:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 2/5] can: m_can: m_can_isr(): handle
 device-specific interrupts
Message-ID: <20210526151833.5ppprex6zzrclr6u@pengutronix.de>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526124747.674055-3-torin@maxiluxsystems.com>
 <20210526150705.s4ms7jhowsuts3yf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vlkabva3u2cvf3xp"
Content-Disposition: inline
In-Reply-To: <20210526150705.s4ms7jhowsuts3yf@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vlkabva3u2cvf3xp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.05.2021 17:07:05, Marc Kleine-Budde wrote:
> On 26.05.2021 13:47:44, Torin Cooper-Bennun wrote:
> > +	if (!ir) {
> > +		/* Handle device-specific interrupts */
> > +		if (cdev->ops->handle_dev_interrupts)
> > +			irq_ret =3D cdev->ops->handle_dev_interrupts(cdev, false);
> > +		return irq_ret;
> > +	}
> > +
> > +	/* ACK M_CAN interrupts */
> > +	m_can_write(cdev, M_CAN_IR, ir);
> > =20
> > +	/* ACK device-specific interrupts */
> >  	if (cdev->ops->handle_dev_interrupts)
> >  		cdev->ops->handle_dev_interrupts(cdev, true);
>=20
> Why do you call a 2nd time the handle_dev_interrupts() callback?

I see, clear and no clear. Why are these two separate operations?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vlkabva3u2cvf3xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCuZscACgkQqclaivrt
76ksJwgAqGMnSHpbETeb//QAT+Nangt4HdaUBntz2n0BjjeJikfcEYC9d7bRVuEN
WyZ70uLCSNu0aQq+yWDYCn6DOHk5ywY6lrKiajMCBPHwE0TKPFnJaAO67piZfvSz
t6bRNpLrN3BqNT55UR+01N/l4CNxayTp8pMDgo5L/gGQ+H+mUHU15qIp4t0F9dGG
NQaV5NiK91XgvPDgVzGqYOc35z3aqdSJL4wmoe2KRHQXIjuWlxHLoy6TT4JzD0L6
GkwhtxL7b0ZoaDw/qCg0TxyXNoa3QFjQK8MbvQ+84WH91mmoVTL/JIuwLGQLwlVf
Qond4RRKMy7i42Ge69XEPz/V0Ket/w==
=Ons+
-----END PGP SIGNATURE-----

--vlkabva3u2cvf3xp--
