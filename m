Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0062961A
	for <lists+linux-can@lfdr.de>; Tue, 15 Nov 2022 11:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiKOKjs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Nov 2022 05:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiKOKjr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Nov 2022 05:39:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2386E00E
        for <linux-can@vger.kernel.org>; Tue, 15 Nov 2022 02:39:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1outM0-00088X-7H; Tue, 15 Nov 2022 11:39:44 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6ac2:39cd:4970:9b29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1DA2811EF0B;
        Tue, 15 Nov 2022 08:57:44 +0000 (UTC)
Date:   Tue, 15 Nov 2022 09:57:38 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils-dev v3 0/6] can-utils-dev: a set of update and
 cleanup patches
Message-ID: <20221115085738.wd6ozab7k4d4qam2@pengutronix.de>
References: <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
 <20221115081545.lovcyysosrix4dk6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tiov2z26hb4l3uq7"
Content-Disposition: inline
In-Reply-To: <20221115081545.lovcyysosrix4dk6@pengutronix.de>
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


--tiov2z26hb4l3uq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.11.2022 09:15:45, Marc Kleine-Budde wrote:
> On 15.11.2022 01:38:42, Vincent Mailhol wrote:
> > This series contain cleanup patches and update of header files. There
> > is no real relation between each patch (aside of 2/6 and 3/6 which
> > form a pair) so I will end the cover letter here and let you refer to
> > the short description.
>=20
> Applied to master.

Squashed the following changes:

> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 7088c5120154..a4e8484db931 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -33,6 +33,7 @@ set(PROGRAMS_CANLIB
>      cansequence
>      log2asc
>      log2long
> +    slcanpty
>  )
> =20
>  set(PROGRAMS_J1939
> @@ -58,7 +59,6 @@ set(PROGRAMS
>      isotptun
>      slcan_attach
>      slcand
> -    slcanpty
>  )
> =20
>  add_executable(can-calc-bit-timing

Fixed linking with cmake

> diff --git a/Makefile b/Makefile
> index c3baa6b287fc..529343d576df 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -46,6 +46,7 @@ MAKEFLAGS :=3D -k
>  CFLAGS :=3D -O2 -Wall -Wno-parentheses
> =20
>  CPPFLAGS +=3D \
> +       -I. \
>         -Iinclude \
>         -DAF_CAN=3DPF_CAN \
>         -DPF_CAN=3D29 \

Add the missing include search path to for mcp251xfd-dev-coredump...:

> diff --git a/mcp251xfd/mcp251xfd-dev-coredump.c b/mcp251xfd/mcp251xfd-dev=
-coredump.c
> index 422900f9cb9e..680c73479d1f 100644
> --- a/mcp251xfd/mcp251xfd-dev-coredump.c
> +++ b/mcp251xfd/mcp251xfd-dev-coredump.c
> @@ -17,7 +17,7 @@
> =20
>  #include <linux/kernel.h>
> =20
> -#include "../lib.h"
> +#include "lib.h"
>  #include "mcp251xfd.h"
>  #include "mcp251xfd-dump-userspace.h"
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tiov2z26hb4l3uq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNzVIAACgkQrX5LkNig
011FPQf7BKXd8TAzRQe/y5DzoKjrQnirrOSQ6wGcNPEQyd3JZ1IFFnOyZbcNlr0Y
sarsQo3X+HKs0GVNGVjMbTcXgc0F8AfbFvoVuvJEoJm450xKcJnbXbFQmdkdPtpu
fDUr3JnCF0/6cEagv+fg/giXn0t8dwZo3CjEs8S7DJ4UP6dnI6n8e6Tv79ov/MHc
+WiVIKVDOw+4FYJW8JqftqUKGqTAncIJFjch5n/aUtUQyQFTY6f83B8YpzxY9nPc
QwZOpsb8Bql/20gws/TcP10gs6v+JfJxirFFqsLBT/5fFqN718yQp5RatguJ19bc
dvG1v6i4V83dn0ee5JJwKcodLnvHRQ==
=Wr3Z
-----END PGP SIGNATURE-----

--tiov2z26hb4l3uq7--
