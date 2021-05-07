Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96B3766FA
	for <lists+linux-can@lfdr.de>; Fri,  7 May 2021 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhEGOTr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 May 2021 10:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhEGOTq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 May 2021 10:19:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9CFC061574
        for <linux-can@vger.kernel.org>; Fri,  7 May 2021 07:18:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lf1JV-00042k-4U; Fri, 07 May 2021 16:18:45 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:10aa:68ec:7bd5:aa67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D260561EE1B;
        Fri,  7 May 2021 14:18:43 +0000 (UTC)
Date:   Fri, 7 May 2021 16:18:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH RFC] can: isotp: isotp_sendmsg(): return error on FC
 timeout on TX path
Message-ID: <20210507141842.uu3huooq4gfywacd@pengutronix.de>
References: <e9ebf4ab4b1a431eac24a21ab8379894@liebherr.com>
 <20210507125017.hu3rcilzcw4rknof@pengutronix.de>
 <d691ed18-d9d4-bf78-d506-cbd7a74dba6b@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="neugqirz5rcmoufj"
Content-Disposition: inline
In-Reply-To: <d691ed18-d9d4-bf78-d506-cbd7a74dba6b@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--neugqirz5rcmoufj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.05.2021 16:12:49, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> On 07.05.21 14:50, Marc Kleine-Budde wrote:
> > On 07.05.2021 12:29:33, Sottas Guillaume (LMB) wrote:
> > > Indeed the first version (with positive value) does not work, but I
> > > just tested the V2 of the patch, and work like a charm. Let me know if
> > > I can help to get it integrated
> >=20
> > You can send you Tested-by to that v2 patch, like Oliver did to the v1.
>=20
> Of course I did the test to my adapted version which now became the v2 ;-)

I interpreted your post that way :D

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--neugqirz5rcmoufj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCVTD8ACgkQqclaivrt
76lSBgf+Nd5F3375taF2igF4WCprlSkviOpzm1IWckVnqfe3fHdE+t1TsxKfpk3j
a7ugy8Oul/RJD2Pc1c1hfWvPj4n4Ljl9uqA4WSbS/H1FQcPk/fPicQUJIP0I5cDv
6Au6IJcnW8fE9xC2gGUCqSee9Y1icQMEcmbryicNqZGCNbvXl3gUSfvQQZMw16H0
E84ePXreS++CQsL32jnVJlbJavFGPNFxGjhmuR6lXw8vCmUWvELrtTktW+CVPYaF
BqbecXkWEz07ImxuoODI+DkYy5OBQrep2+peNX1hhCOgndL6ARvvA5lmJSReew9P
cgd8FnTty3Qn2aX5LrsmiJyaY9AlFQ==
=OWnn
-----END PGP SIGNATURE-----

--neugqirz5rcmoufj--
