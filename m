Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD57E619630
	for <lists+linux-can@lfdr.de>; Fri,  4 Nov 2022 13:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiKDM1g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Nov 2022 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKDM1f (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Nov 2022 08:27:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D46D1FFB3
        for <linux-can@vger.kernel.org>; Fri,  4 Nov 2022 05:27:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oqvnI-0002GD-0y; Fri, 04 Nov 2022 13:27:32 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 09D90112E6E;
        Fri,  4 Nov 2022 12:27:29 +0000 (UTC)
Date:   Fri, 4 Nov 2022 13:27:29 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org,
        Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH] can: dev: fix skb drop check
Message-ID: <20221104122729.gwrlooxkegp3ofyc@pengutronix.de>
References: <20221102095431.36831-1-socketcan@hartkopp.net>
 <CAMZ6RqJ+q5UmFrQFKKzxHzC4pOVT0HS6vD9509Rbth_cUFkjkg@mail.gmail.com>
 <ad18725f-e751-4e3f-3f99-ee6749a800c3@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ialo6yogde3h4so"
Content-Disposition: inline
In-Reply-To: <ad18725f-e751-4e3f-3f99-ee6749a800c3@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7ialo6yogde3h4so
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.11.2022 11:28:29, Oliver Hartkopp wrote:
>=20
>=20
> On 02.11.22 11:17, Vincent MAILHOL wrote:
> > On Wed. 2 Nov. 2022 at19:06, Oliver Hartkopp <socketcan@hartkopp.net> w=
rote:
> > > In commit a6d190f8c767 ("can: skb: drop tx skb if in listen only mode=
") the
> > > priv->ctrlmode element is read even on virtual CAN interfaces that do=
 not
> > > create the struct can_priv at startup. This out-of-bounds read may le=
ad to
> > > CAN frame drops for virtual CAN interfaces like vcan and vxcan.
> > >=20
> > > This patch mainly reverts the original commit and adds a new helper f=
or CAN
> > > interface drivers that provide the required information in struct can=
_priv.
> > >=20
> > > Fixes: a6d190f8c767 ("can: skb: drop tx skb if in listen only mode")
> > > Reported-by: Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
> > > Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > Cc: Max Staudt <max@enpas.org>
> > > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >=20
> > Cross fire... I missed your patch and sent another one. That said:
> >=20
> > Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >=20
> > Thank you!
>=20
> :-D
>=20
> Yes! I would be fine with both of them. The main difference is the naming
> and the inline implementation.
>=20
> So let us Marc decide ;-)

I've added Oliver's patch to linux/can + Cc: stable@vger.kernel.org # 6.0.x

> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> Btw. my patch is missing the pch_can driver change which was already remo=
ved
> in net-next.

As this goes into v6.0, which still has the pch_can, I'll fix that
driver too.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7ialo6yogde3h4so
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNlBS4ACgkQrX5LkNig
013aPQf/S0jcyu6gtY7SIDv4ggtSy9P6q/QLGjzJx1T9wOMS3JW1XSbvKlP6tRMX
URW4FZibapK/ocoMMXmXeczCakF9F38f8zkofpRf13C/hG5UAYUU3uTMDWuBv7C3
WK4fRKzhPeqj+5ySsN/kHxb8nKUo37NzU3hSOYRhuag/d7UTPexNz73U9pl3ztN3
j+DE8aNHwAbNyJzQyWwl83HiGFqh2oJXpz7l9rP9ZkRxR77vU//Nxcf7LjnQ0bmy
KLw92kdAXUyaKB42s0NRF0CJ5QceDJohwY6rrJ6bahAp/c5cRJu1mSoGIhoPT0uV
x9SpYDL8KM5IZ+s3Nx0yVlehrhRPZg==
=cPmU
-----END PGP SIGNATURE-----

--7ialo6yogde3h4so--
