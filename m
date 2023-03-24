Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB96C83B5
	for <lists+linux-can@lfdr.de>; Fri, 24 Mar 2023 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCXRvK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Mar 2023 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCXRvG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2023 13:51:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD81A65C
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2023 10:50:47 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pflYp-00023U-2G; Fri, 24 Mar 2023 18:50:43 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 99F2A19BB03;
        Fri, 24 Mar 2023 17:50:41 +0000 (UTC)
Date:   Fri, 24 Mar 2023 18:50:40 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michal Sojka <michal.sojka@cvut.cz>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Subject: Re: [RFC PATCH v2] can: isotp: fix poll() to not report false
 EPOLLOUT events
Message-ID: <20230324175040.hxsd3avlvddoemqz@pengutronix.de>
References: <20230302092812.320643-1-michal.sojka@cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ufiakrlqmjteg5fu"
Content-Disposition: inline
In-Reply-To: <20230302092812.320643-1-michal.sojka@cvut.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ufiakrlqmjteg5fu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Oliver, what about this patch?

Marc

On 02.03.2023 10:28:12, Michal Sojka wrote:
> When using select/poll/epoll() with a non-blocking ISOTP socket to
> wait for when non-blocking write is possible, false EPOLLOUT event is
> sometimes returned. This can happen at least after sending a message
> which must be split to multiple CAN frames.
>=20
> The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
> not equal to ISOTP_IDLE and this behavior is not reflected in
> datagram_poll(), which is used in isotp_ops.
>=20
> This is fixed by introducing ISOTP-specific poll function, which
> suppresses the EPOLLOUT events in that case.
>=20
> This can be tested with a program available at
> https://github.com/wentasah/isotp-poll-test/blob/fd095b2242c49dc5d3e36faf=
5ac9f4f47fd002c7/isotp-poll-test.c
> which can trigger the problem on a vcan interface. When running the
> program as:
>=20
>     ./isotp-poll-test -s 123 -d 321 -o
>=20
> it starts sending ISOTP messages that include increasing ASCII
> numbers. poll() is used to wait before the next transmission.
>=20
> With current mainline Linux, once the message length is greater than 7
> bytes, write() returns -EAGAIN and the program terminates. This should
> not happen, because the previous poll() reported that the write()
> would not block.
>=20
> After applying this patch, the above command doesn't fail - if one
> runs some ISOTP reader such as:
>=20
>     isotprecv -l -s 321 -d 123 vcan0
>=20
> This test program can also show another problem. When running:
>=20
>     ./isotp-poll-test -s 321 -d 123 -i -a
>=20
> and then in another terminal:
>=20
>     ./isotp-poll-test -s 123 -d 321 -o
>=20
> The first program receives the messages and uses the counter values to
> check for lost messages. After a random number of iterations a lost
> message is always detected. I believe that ISOTP should be reliable
> protocol, at least on vcan, shouldn't it?
>=20
> Anyway, this patch doesn't try to address this problem.
>=20
> Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
> Reported-by: Jakub Jira <jirajak2@fel.cvut.cz>
>=20
> ---
> Changelog:
>=20
> v2: Added waiting for isotp-specific wait queue: poll_wait(file, &so->wai=
t, wait).
> ---
>  net/can/isotp.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9bc344851704..ec163e36ac53 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1608,6 +1608,21 @@ static int isotp_init(struct sock *sk)
>  	return 0;
>  }
> =20
> +static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_=
table *wait)
> +{
> +	struct sock *sk =3D sock->sk;
> +	struct isotp_sock *so =3D isotp_sk(sk);
> +
> +	__poll_t mask =3D datagram_poll(file, sock, wait);
> +	poll_wait(file, &so->wait, wait);
> +
> +	/* Check for false positives due to TX state */
> +	if ((mask & EPOLLWRNORM) && (so->tx.state !=3D ISOTP_IDLE))
> +		mask &=3D ~(EPOLLOUT | EPOLLWRNORM);
> +
> +	return mask;
> +}
> +
>  static int isotp_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
>  				  unsigned long arg)
>  {
> @@ -1623,7 +1638,7 @@ static const struct proto_ops isotp_ops =3D {
>  	.socketpair =3D sock_no_socketpair,
>  	.accept =3D sock_no_accept,
>  	.getname =3D isotp_getname,
> -	.poll =3D datagram_poll,
> +	.poll =3D isotp_poll,
>  	.ioctl =3D isotp_sock_no_ioctlcmd,
>  	.gettstamp =3D sock_gettstamp,
>  	.listen =3D sock_no_listen,
> --=20
> 2.39.2
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129  |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ufiakrlqmjteg5fu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQd4u0ACgkQvlAcSiqK
BOiQ1gf/fbExvTUBdWuqXzHqCirr72yxKDLDmr/Y2thdEyARmsTtg+71mGOhlE6S
sJsWFFNOcCSY1kZl3lHWZW222wD56ubC0/5zdAp6gjNeaDZJakz+CjKOleuW/Ewh
SqNuh271/h5vC0sHZOvQZd5l5bhB6BfkcA5JEedMp0tN3enRZkh9PbUYC+vBGa/o
m6Ylie+Y95ryiC+l0katYLNhchLJjKYP0VBaKJZ3S26BONbpdkCPkjN1J71eisoi
VMEfRo0TC7Vt7PsuD4571B+pZBnuPmV4OiQwKJylrOSXH50AnNI9VSgIK19JWqtO
0ptGVS6KHTdVn2yYB5MDM6TGGmhg6Q==
=PoRB
-----END PGP SIGNATURE-----

--ufiakrlqmjteg5fu--
