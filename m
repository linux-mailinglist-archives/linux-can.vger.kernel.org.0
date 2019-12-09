Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B911775A
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 21:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfLIUYq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 15:24:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43439 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLIUYp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 15:24:45 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iePaF-0001Bj-RM; Mon, 09 Dec 2019 21:24:44 +0100
Received: from [IPv6:2a03:f580:87bc:d400:858e:130c:14c0:366e] (unknown [IPv6:2a03:f580:87bc:d400:858e:130c:14c0:366e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CFC9248C2B9;
        Mon,  9 Dec 2019 20:24:42 +0000 (UTC)
To:     Thomas Kopp <thomas.kopp@microchip.com>,
        linux-can <linux-can@vger.kernel.org>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: mcp2517fd: double transmitted message after BUS-OFF
Message-ID: <64a07162-6ed7-9a1e-2904-12b666562378@pengutronix.de>
Date:   Mon, 9 Dec 2019 21:24:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KwPJJtIUyb2IEgJZouuGVx8RhCwvkJHN4"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KwPJJtIUyb2IEgJZouuGVx8RhCwvkJHN4
Content-Type: multipart/mixed; boundary="RKzobOT0fKHyhKmf7YZAXd5kzlt05jFuk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Thomas Kopp <thomas.kopp@microchip.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <64a07162-6ed7-9a1e-2904-12b666562378@pengutronix.de>
Subject: mcp2517fd: double transmitted message after BUS-OFF

--RKzobOT0fKHyhKmf7YZAXd5kzlt05jFuk
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

I'm currently rewriting the mcp25xxfd CAN driver and observing a strange
effect on the mcp2517fd. I'll retest thi on the mcp2518fd later.

The test is to send CAN-2.0 frames at 500 kbit/s with a gap of ~100ms
with dlc=3D1 and incrementing CAN-ID and first data byte from can0 to
can1. Both interfaces are on the same host, both are mcp2517fd.

After some time I short CAN-H and CAN-L for several seconds, until this
problem occurs.

This is the log, ignore the fact that the CAN frames are shown as RX'ed
before TX'ed.

                                              CANID  DLC data[0]
>  (2019-12-09 19:09:04.583745)  can1  RX - -  047   [1]  47
>  (2019-12-09 19:09:04.583766)  can0  TX - -  047   [1]  47
>  (2019-12-09 19:09:04.683866)  can1  RX - -  048   [1]  48
>  (2019-12-09 19:09:04.683885)  can0  TX - -  048   [1]  48
>  (2019-12-09 19:09:05.384905)  can1  RX - -  048   [1]  48
>  (2019-12-09 19:09:05.485030)  can1  RX - -  049   [1]  49

The problem is, that can1 receives the message with CANID 048 two times.

Looking at the TEF Objects, it shows that the id=3D048 CAN frame is
recorded twice as send. TEF Object 0x0 and TEF Object 0x1 both have
id=3D0x48 and Sequence Number=3D0x48.

> [  125.607608] TEF Object: 0x00 (0x400)                                =
                                                                     =20
> [  125.611174]               id =3D 0x00000048                         =
                                                                       =20
> [  125.615190]            flags =3D 0x00009001
> [  125.619194]               ts =3D 0x344e4c79
> [  125.623195]              SEQ =3D 0x000048              Sequence
> [  125.627904]=20
> [  125.629390] TEF Object: 0x01 (0x40c)  priv-HEAD  chip-TAIL  priv-TAI=
L  priv-FIFO-full
> [  125.637227]               id =3D 0x00000048
> [  125.641229]            flags =3D 0x00009001
> [  125.645244]               ts =3D 0x35fa2cba
> [  125.649249]              SEQ =3D 0x000048              Sequence
> [  125.653959]=20
> [  125.655444] TEF Object: 0x02 (0x418)
> [  125.659011]               id =3D 0x00000049
> [  125.663012]            flags =3D 0x00009201
> [  125.667027]               ts =3D 0x36374a5b
> [  125.671029]              SEQ =3D 0x000049              Sequence
> [  125.675738]=20
> [  125.677223] TEF Object: 0x03 (0x424)
> [  125.680789]               id =3D 0x00000043
> [  125.684805]            flags =3D 0x00008601
> [  125.688810]               ts =3D 0x331cb9e4
> [  125.692811]              SEQ =3D 0x000043              Sequence
> [  125.697543]=20
> [  125.699029] TEF Object: 0x04 (0x430)
> [  125.702596]               id =3D 0x00000044
> [  125.706615]            flags =3D 0x00008801
> [  125.710620]               ts =3D 0x3359d7d5
> [  125.714636]              SEQ =3D 0x000044              Sequence
> [  125.719331]=20
> [  125.720814] TEF Object: 0x05 (0x43c)
> [  125.724396]               id =3D 0x00000045
> [  125.728401]            flags =3D 0x00008a01
> [  125.732401]               ts =3D 0x3396f4d6
> [  125.736417]              SEQ =3D 0x000045              Sequence
> [  125.741112]=20
> [  125.742595] TEF Object: 0x06 (0x448)
> [  125.746177]               id =3D 0x00000046
> [  125.750182]            flags =3D 0x00008c01
> [  125.754196]               ts =3D 0x33d41227
> [  125.758198]              SEQ =3D 0x000046              Sequence
> [  125.762892]=20
> [  125.764391] TEF Object: 0x07 (0x454)
> [  125.767961]               id =3D 0x00000047
> [  125.771962]            flags =3D 0x00008e01
> [  125.775977]               ts =3D 0x34112f78
> [  125.779979]              SEQ =3D 0x000047              Sequence

In the TX Object 0x0 the id=3D0x48 is already overwritten by 0x50, but in=

TX Object 0x1, we see id=3D0x49.

> [  125.802466] TX Object: 0x00 (0x460)
> [  125.805960]               id =3D 0x00000050
> [  125.809963]            flags =3D 0x0000a001
> [  125.813979]    SEQ_MCP2517FD =3D 0x000050              Sequence (MCP=
2517)
> [  125.819544]    SEQ_MCP2518FD =3D 0x000050              Sequence (MCP=
2518)
> [  125.825144]             data =3D 50
> [  125.828453]=20
> [  125.829938] TX Object: 0x01 (0x470)  priv-HEAD  priv-TAIL  priv-FIFO=
-full
> [  125.836748]               id =3D 0x00000049
> [  125.840752]            flags =3D 0x00009201
> [  125.844772]    SEQ_MCP2517FD =3D 0x000049              Sequence (MCP=
2517)
> [  125.850340]    SEQ_MCP2518FD =3D 0x000049              Sequence (MCP=
2518)
> [  125.855920]             data =3D 49
> [  125.859234]=20
> [  125.860719] TX Object: 0x02 (0x480)  chip-HEAD  chip-TAIL  chip-FIFO=
-empty
> [  125.867602]               id =3D 0x0000004a
> [  125.871607]            flags =3D 0x00009401
> [  125.875624]    SEQ_MCP2517FD =3D 0x00004a              Sequence (MCP=
2517)
> [  125.881189]    SEQ_MCP2518FD =3D 0x00004a              Sequence (MCP=
2518)
> [  125.886769]             data =3D 4a
> [  125.890083]=20
> [  125.891567] TX Object: 0x03 (0x490)
> [  125.895062]               id =3D 0x0000004b
> [  125.899063]            flags =3D 0x00009601
> [  125.903064]    SEQ_MCP2517FD =3D 0x00004b              Sequence (MCP=
2517)
> [  125.908644]    SEQ_MCP2518FD =3D 0x00004b              Sequence (MCP=
2518)
> [  125.914227]             data =3D 4b
> [  125.917536]=20
> [  125.919019] TX Object: 0x04 (0x4a0)
> [  125.922499]               id =3D 0x0000004c
> [  125.926512]            flags =3D 0x00009801
> [  125.930514]    SEQ_MCP2517FD =3D 0x00004c              Sequence (MCP=
2517)
> [  125.936093]    SEQ_MCP2518FD =3D 0x00004c              Sequence (MCP=
2518)
> [  125.941657]             data =3D 4c
> [  125.944979]=20
> [  125.946463] TX Object: 0x05 (0x4b0)
> [  125.949943]               id =3D 0x0000004d
> [  125.953979]            flags =3D 0x00009a01
> [  125.957984]    SEQ_MCP2517FD =3D 0x00004d              Sequence (MCP=
2517)
> [  125.963549]    SEQ_MCP2518FD =3D 0x00004d              Sequence (MCP=
2518)
> [  125.969130]             data =3D 4d
> [  125.972444]=20
> [  125.973928] TX Object: 0x06 (0x4c0)
> [  125.977426]               id =3D 0x0000004e
> [  125.981427]            flags =3D 0x00009c01
> [  125.985443]    SEQ_MCP2517FD =3D 0x00004e              Sequence (MCP=
2517)
> [  125.991010]    SEQ_MCP2518FD =3D 0x00004e              Sequence (MCP=
2518)
> [  125.996597]             data =3D 4e
> [  125.999906]=20
> [  126.001389] TX Object: 0x07 (0x4d0)
> [  126.004886]               id =3D 0x0000004f
> [  126.008890]            flags =3D 0x00009e01
> [  126.012891]    SEQ_MCP2517FD =3D 0x00004f              Sequence (MCP=
2517)
> [  126.018471]    SEQ_MCP2518FD =3D 0x00004f              Sequence (MCP=
2518)
> [  126.024054]             data =3D 4f

Is this behaviour known, or even documented somewhere?

Feel free to call me if you need more details.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--RKzobOT0fKHyhKmf7YZAXd5kzlt05jFuk--

--KwPJJtIUyb2IEgJZouuGVx8RhCwvkJHN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3urYYACgkQWsYho5Hk
nSDjZwf/d8eq64rY0fQBkwxEIVXNfL44FtZJb7D3ubFKMUMl+nIMdeQ11YTIDZmz
B0q0CwQbf+YJr2VQuujBvJ3YcXPwbmwdxw7otXyGmB+zihBbL96Yvp42z6no54j/
7iar28JS6C0417uE1sKW0fdeR+1xmKVR8sh87WSYlqD0LuEckj+eckjV5GCo7qMA
46KA1Kd+BtxVcK+ehLo3L1L+gwle6HJNdfCy4L6vt/1+TC8OhsIi1Wsiv1mlnLOi
D4msM5d1jaP2nwqnRhHPiI2uFzYa1mg7vn9Dc2q0PGO8Hgr+lwyDT+F6GQJe7g1s
5kAZ8tU2joxNzsns6J9dhTcze2QDNw==
=uj2w
-----END PGP SIGNATURE-----

--KwPJJtIUyb2IEgJZouuGVx8RhCwvkJHN4--
