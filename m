Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312965AD49B
	for <lists+linux-can@lfdr.de>; Mon,  5 Sep 2022 16:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiIEORt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Sep 2022 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbiIEORs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2022 10:17:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD5580A3
        for <linux-can@vger.kernel.org>; Mon,  5 Sep 2022 07:17:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVCv3-0000at-92; Mon, 05 Sep 2022 16:17:45 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:86c0:9b80:5c95:555])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 50649DAD62;
        Mon,  5 Sep 2022 14:17:44 +0000 (UTC)
Date:   Mon, 5 Sep 2022 16:17:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jacob Kroon <jacob.kroon@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Message-ID: <20220905141743.2hqexc3gmzzgdgly@pengutronix.de>
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <68dd96fb-69e7-d82f-75b3-610afe9ae0b8@hartkopp.net>
 <c1c8bbbe-4282-1dc4-db20-a21b55eecc14@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cve2wybuct6tltoy"
Content-Disposition: inline
In-Reply-To: <c1c8bbbe-4282-1dc4-db20-a21b55eecc14@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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


--cve2wybuct6tltoy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.09.2022 17:13:46, Jacob Kroon wrote:
> Thank you Oliver for all the good hints.
>=20
> I've done some more logging, but there are no error frames being logged.
>=20
> I can see that both pch_can and c_can_pci drivers call can_put_echo_skb()=
 in
> their ndo_start_xmit functions, but neither checks the return value wheth=
er
> it succeeded or not. Shouldn't both these return NETDEV_TX_BUSY if there =
are
> no echo slots available ?

No - The TX queue between the kernel and the driver should only be
active in the first place if there is room in the hardware TX queue. If
there is room in the hardware TX queue, there's room in the echo skb
array, too.

> One reason I ask is because whenever I strace the application, it would s=
eem
> the problem goes away, and I'm guessing strace:ing will slow down my
> application.

ACK - strace slows down the app, probably resulting in the TX queue not
run full.

If I find some time I can try to reproduce the problem on a beagle bone,
which uses d_can core. Just got back from holidays, so I'm quite busy
right now. Drop me a note, if you need commercial support.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cve2wybuct6tltoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMWBQIACgkQrX5LkNig
010lMggAs5zAgnCdt2JVP0Iu4M5a3COz0+F1dwlftrnmtVuqsl0YL4P1azxzGbwm
OF0Jw+wE/IEI49+4KnNEP7FPffriZw8l4yO8tkSDUj0QxuMGQQ9oZThZKUcEmQ8P
z19KAVOfOXAMGGZctnU8jB3sSZjSkM9Yq12EC3IIx8tS568kXsVQ8S7ETGcWhScf
i+JEcUyva/DFY/UnlQEpV8tw5iGaVmgvhUQ2RKE0numY1nLfHKL1Ai3qoZpX/zor
T1/mnNGklT0S/L4ppcmnKMrslZdmMnlPwgkBzisBcMnrQGKJ8dxyirIY6KWtC6Ps
4RSvnjVAW3Sl4Bg1b8KTzJPpLH9Rvw==
=1U1N
-----END PGP SIGNATURE-----

--cve2wybuct6tltoy--
