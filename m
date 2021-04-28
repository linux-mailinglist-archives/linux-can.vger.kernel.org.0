Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA0C36D6FE
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhD1MIl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhD1MIk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 08:08:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FA4C061574
        for <linux-can@vger.kernel.org>; Wed, 28 Apr 2021 05:07:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lbiyv-0006tg-TU; Wed, 28 Apr 2021 14:07:53 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4048:54d7:3c62:4ce5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 761FC6187F7;
        Wed, 28 Apr 2021 12:07:52 +0000 (UTC)
Date:   Wed, 28 Apr 2021 14:07:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org,
        "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Message-ID: <20210428120751.xkczqby455rexpne@pengutronix.de>
References: <20210428090914.252967-1-mkl@pengutronix.de>
 <20210428091224.lsqf4tttd7uijdms@pengutronix.de>
 <f18cb9ce-4bab-80b2-ccc7-37fbafe04995@hartkopp.net>
 <f81170bc-b6d2-37c0-a6b0-86fb9570407c@hartkopp.net>
 <20210428104732.bbmklgyuto5oi3kd@pengutronix.de>
 <ee8058e0-af0a-8759-a62b-b1585c8992b3@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dubs27k3a75eo2wp"
Content-Disposition: inline
In-Reply-To: <ee8058e0-af0a-8759-a62b-b1585c8992b3@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--dubs27k3a75eo2wp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.04.2021 13:45:10, Oliver Hartkopp wrote:
> On 28.04.21 12:47, Marc Kleine-Budde wrote:
> > On 28.04.2021 12:24:32, Oliver Hartkopp wrote:
> > > > Maybe the way to trigger the sk_error_report(sk) we might return '-=
1'
> > > > while the error is then propagated inside errno.
> > >=20
> > > I added some debug print in isotpsend:
> > >=20
> > > diff --git a/isotpsend.c b/isotpsend.c
> > > index 3ea574c..c2937fa 100644
> > > --- a/isotpsend.c
> > > +++ b/isotpsend.c
> > > @@ -45,10 +45,11 @@
> > >   #include <libgen.h>
> > >   #include <stdio.h>
> > >   #include <stdlib.h>
> > >   #include <string.h>
> > >   #include <unistd.h>
> > > +#include <errno.h>
> > >=20
> > >   #include <net/if.h>
> > >   #include <sys/ioctl.h>
> > >   #include <sys/socket.h>
> > >   #include <sys/types.h>
> > > @@ -252,10 +253,11 @@ int main(int argc, char **argv)
> > >                      buf[buflen] =3D ((buflen % 0xFF) + 1) & 0xFF;
> > >       }
> > >=20
> > >=20
> > >       retval =3D write(s, buf, buflen);
> > > +    printf("retval %d errno %d\n", retval, errno);
> >=20
> > Note: in user space errno is only valid if retval is "-1"...
>=20
> Ok, just returned '-1' in that case of blocking write (which runs into the
> timeout) ...
>=20
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9f94ad3caee9..d5d541b4fed5 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -952,10 +952,11 @@ static int isotp_sendmsg(struct socket *sock, struct
> msghdr *msg, size_t size)
>         }
>=20
>         if (wait_tx_done) {
>                 /* wait for complete transmission of current pdu */
>                 wait_event_interruptible(so->wait, so->tx.state =3D=3D
> ISOTP_IDLE);
> +               return -1;
>         }
>=20
>         return size;
>  }
>=20
> And now got this:
>=20
> $ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
> 22.411570468
> retval -1 errno 1
         ^        ^
         |     that is your -1
      it's -1, as your return value was negative
     =20
> write: Operation not permitted
>=20
> So still nothing to see from "sk->sk_err =3D ECOMM;"
>=20
> But when adding 'return -ECOMM' at the above section it works like this:
>=20
> $ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
> 58.453452222
> retval -1 errno 70
> write: Communication error on send

looks good

> This is obviously the expected behaviour for user space:
>=20
> - get '-1' in the case of socket related errors
> - get the details from errno

ACK

> Maybe all that sk_err stuff is only relevant for listen/accept constructi=
ons
> for connection oriented sockets and can be removed inside isotp.c ...

My theory is:
- return bytes send from isotp_sendmsg() or -errno as usual
- use sk->sk_error_report(sk) to wake up user space if it is blocked in
  poll() or blocking in sendmsg()/recvmsg()

For example, if you have a normal read() blocking on a CAN_RAW socket on
an interface, you get a ENETDOWN when you ifdown the interface:

https://elixir.bootlin.com/linux/latest/source/net/can/raw.c#L302

e.g.:

| =E2=9E=9C (pts/54) frogger@hardanger:/tmp candump can0 &
| [1] 260474
| =E2=9E=9C (pts/54) frogger@hardanger:/tmp (1) sudo ip link set can0 down
| read: Network is down
| [1]  + 260474 exit 1     candump can0

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dubs27k3a75eo2wp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCJUBQACgkQqclaivrt
76mVBwgAivX7Tdp2EcfeZjT/n0D+CgYc8IaR1FArBJLlZAvYAc2G0TyQ6WEgOw1g
jG3R62nqP7eaMa2TgZoMypB++dkDTKLNAGFxdkhxnEmfe4x5+4qhUSELZgSF/WKh
dJ41sKlMMT9vx9/+Le0eZC1lXm7M1V/itKHzHZvIDgaqDLVmuus+yHTIsgBw0m9k
Yp71uwbQwWPEUj25nPN6L7384uv8VpvBBx3zWRycKjEFH2A0mx6OqjELmDgSWWtV
tuE9JIoH03Znf7nqjaWkZ1cHH86S4y/lpF9vW8RVnQZOc5awyazXCGfBwm9+CEZI
Y6YfVyGg2ocjIxmxdr7KKuhDHfekqg==
=WwSR
-----END PGP SIGNATURE-----

--dubs27k3a75eo2wp--
