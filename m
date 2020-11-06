Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7F52A9BA8
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 19:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgKFSPX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 13:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgKFSPW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 13:15:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7479FC0613CF
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 10:15:22 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kb6Ge-0001jj-CP; Fri, 06 Nov 2020 19:15:20 +0100
Received: from [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06] (2a03-f580-87bc-d400-33f0-799f-c05f-fe06.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 607A658C6E9;
        Fri,  6 Nov 2020 18:15:19 +0000 (UTC)
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 00/17] Add support for CPC-USB/FD CAN FD interface
Message-ID: <c733cee5-e346-e607-ec6e-9eea78010965@pengutronix.de>
Date:   Fri, 6 Nov 2020 19:15:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TKfwzQ6FScozB9djUyPpq6DzgnAWKmXS3"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TKfwzQ6FScozB9djUyPpq6DzgnAWKmXS3
Content-Type: multipart/mixed; boundary="zfh8chTBjcTx8WFcMglgBY12yrOuiExVf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
 linux-can@vger.kernel.org
Cc: wg@grandegger.com
Message-ID: <c733cee5-e346-e607-ec6e-9eea78010965@pengutronix.de>
Subject: Re: [PATCH 00/17] Add support for CPC-USB/FD CAN FD interface
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>

--zfh8chTBjcTx8WFcMglgBY12yrOuiExVf
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/6/20 6:01 PM, Gerhard Uttenthaler wrote:
FTBFS:

> ems_usb.c: In function =E2=80=98ems_usb_rx_err=E2=80=99:
> ems_usb.c:574:20: error: expected =E2=80=98)=E2=80=99 before =E2=80=98_=
_attribute__=E2=80=99
>   574 |     __attribute__((fallthrough));
>       |                    ^
>       |                    )
> ems_usb.c:574:32: error: expected statement before =E2=80=98)=E2=80=99 =
token
>   574 |     __attribute__((fallthrough));
>       |                                ^
> ems_usb.c:576:20: error: expected =E2=80=98)=E2=80=99 before =E2=80=98_=
_attribute__=E2=80=99
>   576 |     __attribute__((fallthrough));
>       |                    ^
>       |                    )
> ems_usb.c:576:32: error: expected statement before =E2=80=98)=E2=80=99 =
token
>   576 |     __attribute__((fallthrough));
>       |                                ^

use "fallthrough;" instead.

please fix the following sparse warnings:

> ems_usb.c:533:66: warning: incorrect type in initializer (different bas=
e types)                                                                 =
                                                 [14/7920]
> ems_usb.c:533:66:    expected unsigned int [usertype] psr              =
                                                                         =
                                                         =20
> ems_usb.c:533:66:    got restricted __le32 [usertype] psr              =
                                                                         =
                                                         =20
> ems_usb.c:534:37: warning: cast from restricted __le32                 =
                                                                         =
                                                         =20
> ems_usb.c:535:72: warning: restricted __le32 degrades to integer       =
                                                                         =
                                                         =20
> ems_usb.c:805:29: warning: invalid assignment: |=3D                    =
                                                                         =
                                                           =20
> ems_usb.c:805:29:    left side has type restricted __le32              =
                                                                         =
                                                         =20
> ems_usb.c:805:29:    right side has type int                           =
                                                                         =
                                                         =20
> ems_usb.c:807:29: warning: invalid assignment: &=3D                    =
                                                                         =
                                                           =20
> ems_usb.c:807:29:    left side has type restricted __le32              =
                                                                         =
                                                         =20
> ems_usb.c:807:29:    right side has type int                           =
                                                                         =
                                                         =20
> ems_usb.c:810:37: warning: invalid assignment: |=3D                    =
                                                                         =
                                                           =20
> ems_usb.c:810:37:    left side has type restricted __le32              =
                                                                         =
                                                         =20
> ems_usb.c:810:37:    right side has type int                           =
                                                                         =
                                                         =20
> ems_usb.c:812:37: warning: invalid assignment: &=3D
> ems_usb.c:812:37:    left side has type restricted __le32
> ems_usb.c:812:37:    right side has type int
> ems_usb.c:815:37: warning: invalid assignment: |=3D
> ems_usb.c:815:37:    left side has type restricted __le32
> ems_usb.c:815:37:    right side has type int
> ems_usb.c:817:37: warning: invalid assignment: &=3D
> ems_usb.c:817:37:    left side has type restricted __le32
> ems_usb.c:817:37:    right side has type int
> ems_usb.c:1321:22: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1321:22:    expected restricted __le32 [usertype] can_clk
> ems_usb.c:1321:22:    got unsigned int [usertype] freq
> ems_usb.c:1323:22: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1323:22:    expected restricted __le16 [usertype] tseg1
> ems_usb.c:1323:22:    got unsigned int
> ems_usb.c:1324:22: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1324:22:    expected restricted __le16 [usertype] tseg2
> ems_usb.c:1324:22:    got unsigned int [usertype] phase_seg2
> ems_usb.c:1325:20: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1325:20:    expected restricted __le16 [usertype] brp
> ems_usb.c:1325:20:    got unsigned int [usertype] brp
> ems_usb.c:1326:20: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1326:20:    expected restricted __le16 [usertype] sjw
> ems_usb.c:1326:20:    got unsigned int [usertype] sjw
> ems_usb.c:1335:24: warning: restricted __le32 degrades to integer
> ems_usb.c:1353:29: warning: invalid assignment: |=3D
> ems_usb.c:1353:29:    left side has type restricted __le32
> ems_usb.c:1353:29:    right side has type int
> ems_usb.c:1355:37: warning: invalid assignment: |=3D
> ems_usb.c:1355:37:    left side has type restricted __le32
> ems_usb.c:1355:37:    right side has type int
> ems_usb.c:1361:22: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1361:22:    expected restricted __le16 [usertype] tseg1
> ems_usb.c:1361:22:    got unsigned int
> ems_usb.c:1362:22: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1362:22:    expected restricted __le16 [usertype] tseg2
> ems_usb.c:1362:22:    got unsigned int [usertype] phase_seg2
> ems_usb.c:1363:20: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1363:20:    expected restricted __le16 [usertype] brp
> ems_usb.c:1363:20:    got unsigned int [usertype] brp
> ems_usb.c:1364:20: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1364:20:    expected restricted __le16 [usertype] sjw
> ems_usb.c:1364:20:    got unsigned int [usertype] sjw
> ems_usb.c:1373:24: warning: restricted __le32 degrades to integer
> ems_usb.c:1428:21: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1428:21:    expected restricted __le32 [usertype] config
> ems_usb.c:1428:21:    got int
> ems_usb.c:1429:22: warning: incorrect type in assignment (different bas=
e types)
> ems_usb.c:1429:22:    expected restricted __le32 [usertype] can_clk
> ems_usb.c:1429:22:    got int
> ems_usb.c:1455:38: warning: restricted __le16 degrades to integer
> ems_usb.c:1455:38: warning: restricted __le16 degrades to integer

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--zfh8chTBjcTx8WFcMglgBY12yrOuiExVf--

--TKfwzQ6FScozB9djUyPpq6DzgnAWKmXS3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+lkrEACgkQqclaivrt
76nMTwf+MZsd9jbsFe/nvf36Uov+OJIYNMxJafQC9wMK4X+VyJe5zW04Pn6/GwCe
Zs9RxCe8RSNIQctyi9msO14oLoMDRI5IrVO2Pu2PHia6JW3qGIekg3nhg2u7v75Y
cDXVxJJDb1Dpr8Hqu/mxh93kYKZL5/NxXE+PHE808h/oqu7/wBf0rog+NKoLeECp
a6j35CgIsb9wojSwTi1RLmaQrIYgWzHRCVfK4SmYyMZxDWk3rO3lGUkqGZorrJkt
pWp4X331mRa62vIiNXvMQtUZEcqC/L+QDENDRebLEXqkk5E+3fsG0bDKWYpXCwRi
KaoX8rgxnCd/Jq9vmwnCo4CapetFXw==
=MVmT
-----END PGP SIGNATURE-----

--TKfwzQ6FScozB9djUyPpq6DzgnAWKmXS3--
