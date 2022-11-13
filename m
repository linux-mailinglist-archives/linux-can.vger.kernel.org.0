Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A75626FBF
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 14:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiKMNeT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 08:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiKMNeS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 08:34:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F67FCF3
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 05:34:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ouD7o-0003jT-4i; Sun, 13 Nov 2022 14:34:16 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6d7d:dd1c:b670:c511])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 672F911BDB6;
        Sun, 13 Nov 2022 13:34:15 +0000 (UTC)
Date:   Sun, 13 Nov 2022 14:34:06 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils-dev 2/5] lib: add pr_debug() macro
Message-ID: <20221113133406.bmwavedn66wng3cu@pengutronix.de>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113085321.87910-3-mailhol.vincent@wanadoo.fr>
 <20221113130325.5tagqsi4t4523uob@pengutronix.de>
 <CAMZ6RqKjAyYL6rNXaFK4dTQn=XtYnMw29RNmQJMo1pu29GrE-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2or3tced2wf7goml"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKjAyYL6rNXaFK4dTQn=XtYnMw29RNmQJMo1pu29GrE-Q@mail.gmail.com>
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


--2or3tced2wf7goml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.11.2022 22:19:23, Vincent MAILHOL wrote:
> On Sun. 13 Nov. 2022 at 22:12, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> > On 13.11.2022 17:53:18, Vincent Mailhol wrote:
> >
> > > diff --git a/mcp251xfd/mcp251xfd-dev-coredump.c b/mcp251xfd/mcp251xfd=
-dev-coredump.c
> > > index 5874d24..422900f 100644
> > > --- a/mcp251xfd/mcp251xfd-dev-coredump.c
> > > +++ b/mcp251xfd/mcp251xfd-dev-coredump.c
> > > @@ -17,18 +17,10 @@
> > >
> > >  #include <linux/kernel.h>
> > >
> > > +#include "../lib.h"
> >
> > Does #include <lib.h> work?
>=20
> Unfortunately, no:

Using the plain makefile without autotools and cmake?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2or3tced2wf7goml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNw8kwACgkQrX5LkNig
012iugf4yWErXw8fCjer4BmcKHkw0C8whfjv2KpWezdjAc8MRscsT9xrWgOF2s7T
Lu/joQvrjh6/z3b4w9sUgXlpabrPGnt1z8XkHllpWZFxj3eH/8gnwyfiXseY6RUW
kb/svMc3EyH2MOPxyU/SyMxR6skHigRu9aQLQThb7r6VVkqJA4p6DaxOUMh+qx0m
+yczIQpmaDfTcX3k4VkKzePbYkvInaTUGPX1PfPcRp93xez7TjYN4RizkXztF0/p
ZPx3OyDD30cksa5H+zJdbGDwAgfECGNbm4rzpewHXnJyCUqxlry9bBD3e5yD+92c
nqc2r/TVLrWLJj0MFtQElr652LSC
=xfws
-----END PGP SIGNATURE-----

--2or3tced2wf7goml--
