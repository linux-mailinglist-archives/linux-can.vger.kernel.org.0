Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915D9626F5E
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 13:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiKMMEJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 07:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiKMMEI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 07:04:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B664EC
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 04:04:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ouBiV-0003mG-U5; Sun, 13 Nov 2022 13:04:03 +0100
Received: from pengutronix.de (hardanger-2.fritz.box [IPv6:2a03:f580:87bc:d400:6d7d:dd1c:b670:c511])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0159911BD7A;
        Sun, 13 Nov 2022 12:04:02 +0000 (UTC)
Date:   Sun, 13 Nov 2022 13:04:02 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils-dev 2/5] lib: add pr_debug() macro
Message-ID: <20221113120402.ymdyylxm3avhxsaw@pengutronix.de>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113085321.87910-3-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rf7qh6ze4qfjv5p5"
Content-Disposition: inline
In-Reply-To: <20221113085321.87910-3-mailhol.vincent@wanadoo.fr>
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


--rf7qh6ze4qfjv5p5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.11.2022 17:53:18, Vincent Mailhol wrote:
> Add the pr_debug() macro so that replace:
>=20
>   #ifdef DEBUG
>   	printf("foo");
>   #endif
>=20
> by:
>=20
>   	pr_debug("foo");
>=20
> Apply the pr_debug() macro wherever relevant.
>=20
> Currently, there is no consensus whether debug messages should be
> printed on stdout or stderr. Most of the modules: canbusload.c,
> candump.c and canlogserver.c use stdout but
> mcp251xfd/mcp251xfd-dev-coredump.c uses stderr. Harmonize the behavior
> by following the major trend and make
> mcp251xfd/mcp251xfd-dev-coredump.c also output to stdout.
>=20
> CC: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> @Marc, was there any reasons to print debug information to stderr and
> not stdout in mcp251xfd-dev-coredump.c?

No real reason, just gut feeling. There are at least 2 differences: IIRC
stdout is line buffered, it will not write to console until a newline.
stderr will print even if there is no newline. The other one is: If
use/parse the stdout if the program you're debugging (i.e. in a pipe)
the debug output on stdout will interfere with the regular output.

[...]

> diff --git a/lib.h b/lib.h
> index a4d3ce5..1cb1dd4 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -47,6 +47,12 @@
> =20
>  #include <stdio.h>
> =20
> +#ifdef DEBUG
> +#define pr_debug(fmt, args...) printf(fmt, ##args)
> +#else
> +#define pr_debug(...)
> +#endif

With this change if DEBUG is not defined, the print format strings are
not checked. This is why I have the pr_no macro. Side node: For functions
you can use __attribute__ ((format (printf, 2, 3))).

> +
>  /* buffer sizes for CAN frame string representations */
> =20
>  #define CL_ID (sizeof("12345678##1"))
> diff --git a/mcp251xfd/mcp251xfd-dev-coredump.c b/mcp251xfd/mcp251xfd-dev=
-coredump.c
> index 5874d24..422900f 100644
> --- a/mcp251xfd/mcp251xfd-dev-coredump.c
> +++ b/mcp251xfd/mcp251xfd-dev-coredump.c
> @@ -17,18 +17,10 @@
> =20
>  #include <linux/kernel.h>
> =20
> +#include "../lib.h"
>  #include "mcp251xfd.h"
>  #include "mcp251xfd-dump-userspace.h"
> =20
> -#define pr_err(fmt, args...)    fprintf(stderr, fmt, ##args)
> -#define pr_no(fmt, args...)     while (0) { fprintf(stdout, fmt, ##args)=
; }
> -
> -#ifdef DEBUG
> -#define pr_debug(fmt, args...) pr_err(fmt, ##args)
> -#else
> -#define pr_debug(fmt, args...) pr_no(fmt, ##args)
> -#endif
> -
> =20
>  struct mcp251xfd_dump_iter {
>  	const void *start;
> diff --git a/slcanpty.c b/slcanpty.c
> index 4ac9e8a..3eba07e 100644
> --- a/slcanpty.c
> +++ b/slcanpty.c
> @@ -49,8 +49,6 @@
>  #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
>  #define DEVICE_NAME_PTMX "/dev/ptmx"
> =20
> -#define DEBUG

For completeness mention that you switch off debugging in slcanpty.c.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rf7qh6ze4qfjv5p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNw3TAACgkQrX5LkNig
011m9gf/Wc771hU6fanhOlHbX7dMCD0XiSsRzHu7DciVemQbr6WfeR3KkEPNB4Eo
0MIZ9/ZnUr5LvsfzifL+2RiBwKEzWjOsICCk9PS4+xYnPDpm4gwyu9DsIVZ8xx0+
eqP+yCssx6jzg/u0gSLI03mx91HiJbH1IEoc1nas7MxvCzv3IE5N1r7xvRTuzFZA
KOwKLVW4c6JksT7GBVqaABcn1zZUO8lTjt+55QelMmbMNy+vyXjSib7A6tZwyZ/i
Ocg7rdnhuR7GGFBxj6sGYlFvYDfIsbuxvnDXK6G3PPB7Lcg/tIXgM+AcH1ieAA3H
3KK7+8ok5tCKq/74orr22kgH8bSgCA==
=Ocrz
-----END PGP SIGNATURE-----

--rf7qh6ze4qfjv5p5--
