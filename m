Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106FE6029BE
	for <lists+linux-can@lfdr.de>; Tue, 18 Oct 2022 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJRLAd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Oct 2022 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJRLAV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Oct 2022 07:00:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3EB95ADB
        for <linux-can@vger.kernel.org>; Tue, 18 Oct 2022 04:00:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1okkKY-0005AR-Qe; Tue, 18 Oct 2022 13:00:18 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E98DD101981;
        Tue, 18 Oct 2022 11:00:17 +0000 (UTC)
Date:   Tue, 18 Oct 2022 13:00:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Sebastien FABRE <sebastien.fabre@actia.fr>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        ore@pengutronix.de
Subject: Re: J1939: Send messages without acknowledging
Message-ID: <20221018110016.sgvh2prqm5ehstxv@pengutronix.de>
References: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dqyzzeqhhydoemiy"
Content-Disposition: inline
In-Reply-To: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
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


--dqyzzeqhhydoemiy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.10.2022 14:55:58, Sebastien FABRE wrote:
> Hello,
>=20
> I am working on 5.4 kernel, and I have the same behavior with 5.10
> kernel version.
>=20
> I reproduce the behavior with a custom application. A j1939 socket is
> created with SO_BROADCAST and SO_J1939_PROMISC options and is binded.
> The application sends a claim message then 50 broadcast messages in
> loop (without waiting) with size greater than 8 bytes (50).
>=20
> Every sendto methods return success directly and sessions are stored
> in sk_session_queue.
>=20
> If the can is 'on' but nobody acknowledges, after some times, trames
> are no longer sent (ENOBUFS) but the application does not have this
> information (sendto returned success).
>=20
> Moreover, txqueuelen does not have impact to this behavior (queue size
> seems to be infinite).
>=20
> To finish, closing socket will take a long time depending on
> sk_session_queue size because of J1939_XTP_TX_RETRY_LIMIT: kernel
> seems to try to send every message 100 times if ENOBUFS is received.
>=20
> Is it the expected behavior? How can the application know that
> messages are no longer sent?

It's sort of expected....I think we haven't thought of that corner case.
There is the socket TX timeout option, seems we have to implement this
for j1939.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dqyzzeqhhydoemiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNOhz0ACgkQrX5LkNig
013vewf/SuadPPcLDk14U9NZ+JiGWdf+evLfcQNRUfAizhs/NB8e7YLvIjCEDeBl
7fdFmpSjZdbw/0hB+AeVyrEYODZ6SscbfE5ONqZc7CIv7s1Fjghz8xu8dMhOhmbo
6R5M0QOBGopzj/Yz4kpOyu6p/F+t0ODNCVbjket1lSYvRVZYcjhF2TON5RvIS8Fv
MUIuwXtBWgQMvg5H+OKrHwQeT/zeb6/OJM6JYyt2Z2KhWiC1wn2lNn6uK5Vr5ge7
qaafbIuyp07X3A8t4PAeq/9gkcGvIQ7CvveVYbH5mPjWZoJVdzad8Ik8XAaIVpEl
+1/VVnlfiQYdBaRJOiRNieniPL9hTA==
=hnOk
-----END PGP SIGNATURE-----

--dqyzzeqhhydoemiy--
