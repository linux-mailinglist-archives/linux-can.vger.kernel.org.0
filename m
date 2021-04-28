Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B136D5EE
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbhD1KsX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 06:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbhD1KsV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 06:48:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA7CC06138A
        for <linux-can@vger.kernel.org>; Wed, 28 Apr 2021 03:47:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lbhjC-0007uO-CH; Wed, 28 Apr 2021 12:47:34 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4048:54d7:3c62:4ce5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5CD7B618789;
        Wed, 28 Apr 2021 10:47:33 +0000 (UTC)
Date:   Wed, 28 Apr 2021 12:47:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org,
        "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Message-ID: <20210428104732.bbmklgyuto5oi3kd@pengutronix.de>
References: <20210428090914.252967-1-mkl@pengutronix.de>
 <20210428091224.lsqf4tttd7uijdms@pengutronix.de>
 <f18cb9ce-4bab-80b2-ccc7-37fbafe04995@hartkopp.net>
 <f81170bc-b6d2-37c0-a6b0-86fb9570407c@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rife7ladlqdowiw3"
Content-Disposition: inline
In-Reply-To: <f81170bc-b6d2-37c0-a6b0-86fb9570407c@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--rife7ladlqdowiw3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.04.2021 12:24:32, Oliver Hartkopp wrote:
> > Maybe the way to trigger the sk_error_report(sk) we might return '-1'
> > while the error is then propagated inside errno.
>=20
> I added some debug print in isotpsend:
>=20
> diff --git a/isotpsend.c b/isotpsend.c
> index 3ea574c..c2937fa 100644
> --- a/isotpsend.c
> +++ b/isotpsend.c
> @@ -45,10 +45,11 @@
>  #include <libgen.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <errno.h>
>=20
>  #include <net/if.h>
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>  #include <sys/types.h>
> @@ -252,10 +253,11 @@ int main(int argc, char **argv)
>                     buf[buflen] =3D ((buflen % 0xFF) + 1) & 0xFF;
>      }
>=20
>=20
>      retval =3D write(s, buf, buflen);
> +    printf("retval %d errno %d\n", retval, errno);

Note: in user space errno is only valid if retval is "-1"...

>      if (retval < 0) {
>             perror("write");
>             return retval;
>      }
>=20
>=20
> $ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
> 43.269173590
> retval 44 errno 0
> 44.271162277
>=20
> So it waits for the timeout as required by the '-b' option - but the errno
> is not set :-/

I'm not sure what we have to return in the kernel...

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rife7ladlqdowiw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCJPUEACgkQqclaivrt
76mRGgf/TDKXSgvwLMgzM6JV+gcc/XujR+2ofvJX6Po46aqdKgUB0nkI1r299h4r
g4bICW7DDoa4EyKeCAb8wYA0TuDbGs5ehJ5cDoGwAIDFXjPs+5WwlGHDxxZGrX7m
80yfnrGqKhdSawDM4qcXwmp1GHxli7mXCg9BePoymd/V60N7VmJ6QR+TiTObDIVs
lO82UsGRZa3oCpkeMSuASs4WqcMfij1cRCqp2mnjVmADuRwzcU1kfxsN8o8JhT37
sG7WrIWeP/0zaFXGjT9pFPD7ejdPZjeWYHTWWgopZI00nmQDuhvwTtVRmfutiW7s
0cXpdkLCumnMwkDnG3LwvBMk6IuORg==
=fznx
-----END PGP SIGNATURE-----

--rife7ladlqdowiw3--
