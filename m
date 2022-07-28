Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE523584017
	for <lists+linux-can@lfdr.de>; Thu, 28 Jul 2022 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiG1Ngi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jul 2022 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiG1Nfp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jul 2022 09:35:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE04C626
        for <linux-can@vger.kernel.org>; Thu, 28 Jul 2022 06:35:44 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oH3fx-0006zM-4R; Thu, 28 Jul 2022 15:35:41 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E1B3CBCE32;
        Thu, 28 Jul 2022 13:35:37 +0000 (UTC)
Date:   Thu, 28 Jul 2022 15:35:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v4 05/14] can: tree-wide: advertise software timestamping
 capabilities
Message-ID: <20220728133536.m2qdlkjxk5qtsddl@pengutronix.de>
References: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
 <20220727101641.198847-6-mailhol.vincent@wanadoo.fr>
 <20220728093819.q37lzttsknqzi6a5@pengutronix.de>
 <CAMZ6RqKFDpzB5L-HkJ0=gTw0vL6G7SV5bz=8dUgGpMS+OzvsOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elw3tgvny4o5ass6"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKFDpzB5L-HkJ0=gTw0vL6G7SV5bz=8dUgGpMS+OzvsOg@mail.gmail.com>
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


--elw3tgvny4o5ass6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.07.2022 22:28:51, Vincent MAILHOL wrote:
> > > diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/ms=
can.c
> > > index 78a21ab63601..b1677588a4c8 100644
> > > --- a/drivers/net/can/mscan/mscan.c
> > > +++ b/drivers/net/can/mscan/mscan.c
> > > @@ -676,6 +676,7 @@ struct net_device *alloc_mscandev(void)
> > >       priv =3D netdev_priv(dev);
> > >
> > >       dev->netdev_ops =3D &mscan_netdev_ops;
> > > +     dev->ethtool_ops =3D &mscan_ethtool_ops;
> > >
> > >       dev->flags |=3D IFF_ECHO; /* we support local echo */
> >
> > | drivers/net/can/mscan/mscan.c: In function =E2=80=98alloc_mscandev=E2=
=80=99:
> > | drivers/net/can/mscan/mscan.c:679:29: error: =E2=80=98mscan_ethtool_o=
ps=E2=80=99 undeclared (first use in this function)
> > |   679 |         dev->ethtool_ops =3D &mscan_ethtool_ops;
> > |       |                             ^~~~~~~~~~~~~~~~~
> > | drivers/net/can/mscan/mscan.c:679:29: note: each undeclared identifie=
r is reported only once for each function it appears in
> >
> > I'm fixing this.
>=20
> Thanks for catching this.

n.p.

> mscan does not show up in the menuconfig by default because it
> requires CONFIG_PPC. And it is not possible to add CONFIG_COMPILE_TEST
> to mscan's KBUILD file because some PPC specific symbols would be
> missing. So this is yet another pitfall.

:(

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--elw3tgvny4o5ass6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLikKUACgkQrX5LkNig
012KfAf+IotEhzC+3cD6wFQvX5+WHGcs3oOHcfr3/djr4H/Xutm25tbfVahmHRVz
ktKvWUyqWglnuDlDwPR6dog2iubAG2IbjGCw8BB5JfHuXSeVJKR0vrK8drS7lrQy
AcJdknwQ3+Yv4gdqo1s5mdrDfj7uLwZA7jVWnPgvbROFQqoZ1hEmn45zTCEFRt80
+b1z6HAwjT1+ZgRqNe0BagUYd3UC7Ha2tG96fLWdj8cRjWKK2xABMViYC+keShCL
X2rb+ba/bzQmO73gR5jo87PBBcVQ8vS6974OqYuf87aZzTGFO8smCqXHDXiUFDdf
pczGZQgFM0/+mRIbx97G8VUoC0cpvA==
=UaRI
-----END PGP SIGNATURE-----

--elw3tgvny4o5ass6--
