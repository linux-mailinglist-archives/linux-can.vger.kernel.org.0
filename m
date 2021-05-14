Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E886380CC2
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhENPWq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 11:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhENPWq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 11:22:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC69C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 08:21:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhZd7-0000DS-HV; Fri, 14 May 2021 17:21:33 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9F2A16244E0;
        Fri, 14 May 2021 15:21:32 +0000 (UTC)
Date:   Fri, 14 May 2021 17:21:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514152131.qo4ybv4zx5mbscop@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
 <20210514131049.yluxu3cxaspeptvb@bigthink>
 <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
 <20210514145430.i4ajyapz6zhjnrro@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lajqivvmyj3t2u57"
Content-Disposition: inline
In-Reply-To: <20210514145430.i4ajyapz6zhjnrro@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--lajqivvmyj3t2u57
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 15:54:30, Torin Cooper-Bennun wrote:
> On Fri, May 14, 2021 at 04:12:37PM +0200, Marc Kleine-Budde wrote:
> > Ah, ok. Do they need any handling/acknowledge? You only read TCAN4X5X_I=
NT_FLAGS, are
> > those clear-or-read?
>=20
> An extra note on this... most of the faults worth responding to here are
> serious enough that the interface should just be shut down, or at least,
> the device will need to be init'd again.=20
>=20
> I'm surprised no handling was implemented in the first place -

At least you should write a warning message that you (as a developer)
and your users get noticed when these error hits.

> makes it very difficult to debug problems when you're prototyping new
> kit. The driver is written as though these interrupts are meaningless!

Proper error handling is not trivial....and from my experience, in most
cases the documentation of those kinds of errors and how to recover is
quite sparse, I haven't looked deep into the tcan4x5x docs though.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lajqivvmyj3t2u57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCelXkACgkQqclaivrt
76mdwAgAsGae+MIfSqVoJcNLujFZiwcTsx6OatBgNI9mYAh/ZC9y9jwX7oe/oHf8
2Puj2yPTC98e9lKIXwc8JdKfb4gUWvJzp/X++GiPH99iHBQBqnAVCLLijYuuIA76
Jw+fCvfEsGQ0ApTNnMCl0xJ7Q9zkX4IO50/w3J0WLrm9LzWWzebANSajQeQkJZ53
VY/0JMIMOqlEkA9hXCmX6duJA2OpAxjWReNUDMVEQERITKXyfSIjrQ/cu6xCx9xO
JpCCvcwHKHvTxiPCjEhpE4fHQoXRc7wb1rxtSHoQFCjoH1OKfN5vvZXsTz1f1P0w
ueGcLkleWdAHsK2vV6vL+ztxCTvTUw==
=suKZ
-----END PGP SIGNATURE-----

--lajqivvmyj3t2u57--
