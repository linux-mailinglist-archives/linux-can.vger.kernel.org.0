Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726305BC386
	for <lists+linux-can@lfdr.de>; Mon, 19 Sep 2022 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiISHep (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Sep 2022 03:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISHeo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2022 03:34:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89949634D
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2022 00:34:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oaBIe-0005B5-Rt; Mon, 19 Sep 2022 09:34:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1318:547e:856d:5888])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0022AE5A83;
        Mon, 19 Sep 2022 07:34:39 +0000 (UTC)
Date:   Mon, 19 Sep 2022 09:34:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Trevitz, Daniel" <Daniel.Trevitz@wika.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: Re: [PATCH v2 0/3] can: gs_usb: cleanups and termination support
Message-ID: <20220919073431.7pteskuiei3bgeno@pengutronix.de>
References: <20220918211802.692405-1-mkl@pengutronix.de>
 <de6f97b076ca4a06862cbb91a50fc718@wika.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hjnr5pvefqv5lgej"
Content-Disposition: inline
In-Reply-To: <de6f97b076ca4a06862cbb91a50fc718@wika.com>
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


--hjnr5pvefqv5lgej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.09.2022 22:00:35, Trevitz, Daniel wrote:
> Is there a place to document this?

Please add it to the SocketCAN documentation:

| https://github.com/torvalds/linux/blob/master/Documentation/networking/ca=
n.rst

> Example setting termination state:
> 	on: ip link set dev can0 type can termination 120
> 	off: ip link set dev can0 type can termination 0
>=20
> Read the state:
> 	ip -details link show can0=20
>=20
> 58: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group de=
fault qlen 10
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can state STOPPED restart-ms 0=20
>           gs_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp_inc 1
>           termination 120 [ 0, 120
>           clock 48000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 g=
so_max_segs 65535 gro_max_size 65536 parentbus usb parentdev 3-12.2:1.0

A patch against this file on this mailing list is preferred, please
include your Signed-off-by. For details see:

| https://github.com/marckleinebudde/linux/blob/master/Documentation/proces=
s/submitting-patches.rst#sign-your-work---the-developers-certificate-of-ori=
gin

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hjnr5pvefqv5lgej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMoG4IACgkQrX5LkNig
010ejwgApJnPD6aUnI+3VYoQwN75rE96BQA0A+YCDPvMHqxGhLIqBKmm0sk1FTlK
YidIdgcn3aDaYoXn0mxX5QDz8pyJKEMZUmpSYcpxJlf11xNF7vui1ovNiQdEWoIn
P9cVyCNL/njm8WJF30QDXCbMWl4Ubu3Ziz3+eU0Z+NzqrITVRlgW3XEvGz441afP
+zZcmXsLG+gRPxF13mHg86xIMYomFvGLvqn0wNcfDge/j0ThCRing9sMr5wzL6es
tU26mCNO+l89vaXv7/h64d2QP9mEuyTlcP49BE3V3IgoZ+7BRaSNo2KdAjk5PnaM
RGtIW5Y++217759aBcVG11ZlIYCpnA==
=HUKc
-----END PGP SIGNATURE-----

--hjnr5pvefqv5lgej--
