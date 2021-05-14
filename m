Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B36E380C56
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhENO5L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhENO5K (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 10:57:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E642C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:55:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhZEL-0005SI-Sk; Fri, 14 May 2021 16:55:57 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 13A796244A7;
        Fri, 14 May 2021 14:55:57 +0000 (UTC)
Date:   Fri, 14 May 2021 16:55:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514145556.utpdscudwcidmmcz@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
 <20210514131049.yluxu3cxaspeptvb@bigthink>
 <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
 <20210514144434.etefrlqq5pwcb34t@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45lw77k4wnn6zoj5"
Content-Disposition: inline
In-Reply-To: <20210514144434.etefrlqq5pwcb34t@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--45lw77k4wnn6zoj5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 15:44:34, Torin Cooper-Bennun wrote:
> On Fri, May 14, 2021 at 04:12:37PM +0200, Marc Kleine-Budde wrote:
> > > The TCAN4550 has interrupts that cannot be disabled or masked, includ=
ing
> > > those for faults involving SPI, power, and transceiver issues (e.g. C=
AN
> > > stuck dominant).
> >=20
> > Ah, ok. Do they need any handling/acknowledge? You only read TCAN4X5X_I=
NT_FLAGS, are
> > those clear-or-read?
>=20
> In theory, for any of these, clearing the register should be sufficient
> for the interrupt pin to go inactive... emphasis on "in theory".

Ok, but as you noticed in your patch, if no IRQ is pending in M_CAN_IR,
the main driver doesn't call the tcan4x5x handler.

So the IRQ stays active, the IRQ handler is repeatedly called and
returns IRQ_NONE. Then you get the nobody cared warning.

regards,
Marc=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--45lw77k4wnn6zoj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCej3kACgkQqclaivrt
76lWNgf+JdO0Y+Kz/ibvgVc0kbDolMXjMFgxnzKX1S3UyxchIN4HMNV47FTKs3Sa
0CCow6J4Yh+Gp5b3Zk2cU8PYtx6ASdRLA31GyKhPx1LhqnjVBqYB4DlM1baJ2JKO
2Nz2SfWmDz7E/lOFJe0gWW6emt5ayoDAJLTsqA30n2x2vEq09/GnktYk1u/O/zr/
7KrZW5JH1sVMv4xix2NVOgHAXBEPvTqRiTnyx4MSDH+FWX6C0SM8mffnYyDbVk9c
j7IJC2hupFd9QMjZtp2k/u07AJcKNpx3KHrGtohmYBm/SG1+2zPma0hEtPBU2ydX
rWy55FRtXe/BVU2yzqAlpL5lDekc4g==
=Nagp
-----END PGP SIGNATURE-----

--45lw77k4wnn6zoj5--
