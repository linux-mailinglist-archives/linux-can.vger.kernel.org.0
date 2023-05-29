Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C067147C6
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjE2KPV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 06:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2KPT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 06:15:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266B83
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 03:15:14 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q3ZuA-0000jf-C7; Mon, 29 May 2023 12:15:10 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EE7461CDDD2;
        Mon, 29 May 2023 10:15:08 +0000 (UTC)
Date:   Mon, 29 May 2023 12:15:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: j1939: j1939_sk_send_loop_abort(): improved
 error queue handling in J1939 Socket
Message-ID: <20230529-escalate-petticoat-976947c5ff2c-mkl@pengutronix.de>
References: <20230526081946.715190-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvongy46xmtqqt6x"
Content-Disposition: inline
In-Reply-To: <20230526081946.715190-1-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mvongy46xmtqqt6x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.05.2023 10:19:46, Oleksij Rempel wrote:
> This patch addresses an issue within the j1939_sk_send_loop_abort()
> function in the j1939/socket.c file, specifically in the context of
> Transport Protocol (TP) sessions.
>=20
> Without this patch, when a TP session is initiated and a Clear To Send
> (CTS) frame is received from the remote side requesting one data packet,
> the kernel dispatches the first Data Transport (DT) frame and then waits
> for the next CTS. If the remote side doesn't respond with another CTS,
> the kernel aborts due to a timeout. This leads to the user-space
> receiving an EPOLLERR on the socket, and the socket becomes active.
>=20
> However, when trying to read the error queue from the socket with
> sock.recvmsg(, , socket.MSG_ERRQUEUE), it returns -EAGAIN,
> given that the socket is non-blocking. This situation results in an
> infinite loop: the user-space repeatedly calls epoll(), epoll() returns
> the socket file descriptor with EPOLLERR, but the socket then blocks on
> the recv() of ERRQUEUE.
>=20
> This patch introduces an additional check for the J1939_SOCK_ERRQUEUE
> flag within the j1939_sk_send_loop_abort() function. If the flag is set,
> it indicates that the application has subscribed to receive error queue
> messages. In such cases, the kernel can communicate the current transfer
> state via the error queue. This allows for the function to return early,
> preventing the unnecessary setting of the socket into an error state,
> and breaking the infinite loop. It is crucial to note that a socket
> error is only needed if the application isn't using the error queue, as,
> without it, the application wouldn't be aware of transfer issues.
>=20
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Reported-by: David Jander <david@protonic.nl>
> Tested-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied to linux-can, added stable on Cc.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mvongy46xmtqqt6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmR0eykACgkQvlAcSiqK
BOgQiggAquFQWp8JcNGEW3M8XDLDriPJI++T9TNxvt18R2mvq9dp3avKNDso7B0b
PA6A8m3RwS/gb7ibqOJtIOKt8fh0RGcraKEuYgUvEijNGfQ8L1WtjJjIV9o+gAfz
aNeXUrdf+Nq+4s3TlZpvdPQfOIuLxuxX6mIeauq2rYmTEJLrAX8Wzqrh8H/l+Qy4
zutQnmixVDiefKLi3Gm8/Sj7J1EtepjVa6E6e5VKdM/JdGEZ6SRzwXAtTviGy8BX
yP7z/ced3z0C31lXnyR4oxpCYPSEfbGm1iGqZJz/jQVy+tWKLWRZ9vZCIK1tGbrG
bcIGjG9vVvt3fkmjpTHT09ZtqcVoCw==
=6eIq
-----END PGP SIGNATURE-----

--mvongy46xmtqqt6x--
