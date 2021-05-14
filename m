Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240B5380EA9
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhENROe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 13:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhENROe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 13:14:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674DAC061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 10:13:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhbNI-00034n-UR; Fri, 14 May 2021 19:13:21 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9D99B6245A9;
        Fri, 14 May 2021 17:13:19 +0000 (UTC)
Date:   Fri, 14 May 2021 19:13:18 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514171318.hqeazqprda5rgjpc@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
 <20210514131049.yluxu3cxaspeptvb@bigthink>
 <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
 <20210514145430.i4ajyapz6zhjnrro@bigthink>
 <20210514152131.qo4ybv4zx5mbscop@pengutronix.de>
 <20210514164455.inr3getboissqasr@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wyomaabrnff5ztzv"
Content-Disposition: inline
In-Reply-To: <20210514164455.inr3getboissqasr@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wyomaabrnff5ztzv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 17:44:55, Torin Cooper-Bennun wrote:
> > Proper error handling is not trivial....and from my experience, in most
> > cases the documentation of those kinds of errors and how to recover is
> > quite sparse, I haven't looked deep into the tcan4x5x docs though.
>=20
> I guess I should give credit where it's due, in that the driver works
> fine without full error handling for the vast majority of cases. It may
> just be that the application I'm working on is more sensitive to faults.
>=20
> The docs are fairly sparse on error handling from a programmer's
> perspective, yes. I've learned more from experience with this chip than
> from the datasheet!

That's exactly what I meant :D

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wyomaabrnff5ztzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCer6wACgkQqclaivrt
76ndhwf9FMc97K7NYrcxP2J8qPet45u1mkRnyu5Pm8cHZNwysx/jZplspt7bbKAA
Ll/TTu202Q+tiS7xHih1kqBq+x/KCzPWVHwJEVDJ1aFeQ9VJQDPr/jA48rotVHaq
espcYDTch6M6qliZ/9cHMj/wgpgr5P1g8M2pl3/fFgPdPRaIVXoHR2E7ys177Piy
NPzAM5o/ZBAWRUYSGuk3iyJkcDgQcU5BQgOcZ273yP3WZhYNBkMcvAsQ6nfbb+40
zneCr/hKiq+L1riCZoxg7ljXq8aHq6c6hncko4kpHFt48lbDPDIZBrT3QgBiwJ5O
u2aJaoe6Dp+aOLmbsWbRSwMVZZE2Wg==
=YpHx
-----END PGP SIGNATURE-----

--wyomaabrnff5ztzv--
