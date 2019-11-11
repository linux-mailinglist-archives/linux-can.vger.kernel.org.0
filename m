Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DFBF7160
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 11:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKKKIw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 05:08:52 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKKIw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2019 05:08:52 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iU6cr-0006zH-Nf; Mon, 11 Nov 2019 11:08:49 +0100
Received: from [IPv6:2a03:f580:87bc:d400:fcf3:94db:a77f:e6a3] (unknown [IPv6:2a03:f580:87bc:d400:fcf3:94db:a77f:e6a3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AD86447A0A9;
        Mon, 11 Nov 2019 10:08:46 +0000 (UTC)
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: Wake up issue about Flexcan driver in v5.4 kernel
Message-ID: <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
Date:   Mon, 11 Nov 2019 11:08:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mhoREVIxmN65ur2rnClNULuGZWyn1gNM7"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mhoREVIxmN65ur2rnClNULuGZWyn1gNM7
Content-Type: multipart/mixed; boundary="bwejrZt9Ct50E0vGA92jp6EkAPY22KIZl";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
Subject: Re: Wake up issue about Flexcan driver in v5.4 kernel
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>

--bwejrZt9Ct50E0vGA92jp6EkAPY22KIZl
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/11/19 10:48 AM, Joakim Zhang wrote:
> I came across a strange phenomenon about wake up in Flexcan driver with=

> v5.4 kernel, I connected two i.MX7D-SDB board.
>=20
> I found that CAN frame which try to wake up the system will not be
> received at another side in order. Like below case:
>=20
> Sender: cangen can0 -vv
> =C2=A0 can0=C2=A0 4D9=C2=A0=C2=A0 [8]=C2=A0 89 72 0C 5F C8 15 2D 3A
> =C2=A0 can0=C2=A0 0AA=C2=A0=C2=A0 [8]=C2=A0 B7 DC 14 61 7F A0 8E 40
> =C2=A0 can0=C2=A0 304=C2=A0=C2=A0 [8]=C2=A0 42 5C D7 3B D6 1D 36 56
> =C2=A0 can0=C2=A0 0D9=C2=A0=C2=A0 [7]=C2=A0 B0 C3 1B 7B 9B 3A 19
> =C2=A0 can0=C2=A0 66B=C2=A0=C2=A0 [8]=C2=A0 8A B0 D9 56 00 46 76 48
> =C2=A0 can0=C2=A0 22D=C2=A0=C2=A0 [8]=C2=A0 44 4B FD 53 B2 D3 A5 33
> =C2=A0 can0=C2=A0 47E=C2=A0=C2=A0 [8]=C2=A0 B9 6B 72 0B 4C 15 96 72
> =C2=A0 can0=C2=A0 54C=C2=A0=C2=A0 [3]=C2=A0 3F BE 8F
> =C2=A0 can0=C2=A0 7C1=C2=A0=C2=A0 [8]=C2=A0 EE A7 B4 11 6C 80 8F 7D
> =C2=A0 can0=C2=A0 5D6=C2=A0=C2=A0 [5]=C2=A0 EB 20 1E 3E DB
> =C2=A0 can0=C2=A0 794=C2=A0=C2=A0 [8]=C2=A0 B1 56 9E 13 6D 88 CE 52
> =C2=A0 can0=C2=A0 584=C2=A0=C2=A0 [1]=C2=A0 08
>=20
> =C2=A0
>=20
> Receiver: candump can0 &
> =C2=A0 can0=C2=A0 0AA=C2=A0=C2=A0 [8]=C2=A0 B7 DC 14 61 7F A0 8E 40
> =C2=A0 can0=C2=A0 304=C2=A0=C2=A0 [8]=C2=A0 42 5C D7 3B D6 1D 36 56
> =C2=A0 can0=C2=A0 0D9=C2=A0=C2=A0 [7]=C2=A0 B0 C3 1B 7B 9B 3A 19
> =C2=A0 can0=C2=A0 66B=C2=A0=C2=A0 [8]=C2=A0 8A B0 D9 56 00 46 76 48
> =C2=A0 can0=C2=A0 22D=C2=A0=C2=A0 [8]=C2=A0 44 4B FD 53 B2 D3 A5 33
> =C2=A0 can0=C2=A0 4D9=C2=A0=C2=A0 [8]=C2=A0 89 72 0C 5F C8 15 2D 3A
> =C2=A0 can0=C2=A0 47E=C2=A0=C2=A0 [8]=C2=A0 B9 6B 72 0B 4C 15 96 72
> =C2=A0 can0=C2=A0 54C=C2=A0=C2=A0 [3]=C2=A0 3F BE 8F
> =C2=A0 can0=C2=A0 7C1=C2=A0=C2=A0 [8]=C2=A0 EE A7 B4 11 6C 80 8F 7D
> =C2=A0 can0=C2=A0 5D6=C2=A0=C2=A0 [5]=C2=A0 EB 20 1E 3E DB
> =C2=A0 can0=C2=A0 794=C2=A0=C2=A0 [8]=C2=A0 B1 56 9E 13 6D 88 CE 52
> =C2=A0 can0=C2=A0 584=C2=A0=C2=A0 [1]=C2=A0 08
>=20
> You can see that wake up frame(can0=C2=A0 4D9=C2=A0=C2=A0 [8]=C2=A0 89 =
72 0C 5F C8 15 2D 3A)
> will be received at 6^th , it=E2=80=99s hard to understand.

- What did you do before wakeup?
  - Clean reboot?
  - ifdown/ifup?
  - sending other packets?
- Does this happen on every wakeup?
- Is the wake up frame always "received" as 6th frame?
- Is the situation the same, if you add some delay between the frames,
  using the "cangen -g option"?
- How big can you make the -g until the frames are received in order
  again?

The reception path works like this:
In the interrupt handler the rx-offload reads all mailboxes based on the
iflag register. It iterates over all set mailboxes, starting with the
first. All mailboxes are read including the rx-timestamp, sorted and
added into a queue. At the end of the IRQ handler the queue is added to
the per device queue thats read in the NAPI and pushed into the
networking stack.

Maybe something with the timestamp of the first packet is wrong, as the
counter is only 16 bits wide, it will overflow quite often.

Maybe you can trace_printk the mailbox number, timestamp and can_id in
mailbox_read() and analyse output after wakeup. Feel free to post the
output of the tracer here.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--bwejrZt9Ct50E0vGA92jp6EkAPY22KIZl--

--mhoREVIxmN65ur2rnClNULuGZWyn1gNM7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3JMykACgkQWsYho5Hk
nSCKvwf/VHaABdVhbEgdQdbA+PDypnevXW4SqvyGSJ2jNmxUcDFlG3zMEARAsmYN
dYGs+GzAPMQ8i3GUvRMZEPDISk5SV/yooSII9CTA4GX8ZGGRVBwVYqf8/pEy3fKI
rKhEgG3CqfiFqt75llIVLqaxyfmyZ2N5iFg1JrDWfSOrAR5hGm0ZOCQdslNF6YwI
2fND0yPjGL7MH0YqZW+oLz51b6UGfo4dm280J3lbfIMc8vTm3d7a4hVRyUBwU/Oo
iNPuIqmHJh5P/ECEQ/LDCruyBJJ+VgJcQLV04kt1EH5ZKuVq4l8y5z08O5fZdP4E
HiQOUbgI+Vt9OAJlEHjEJPiAJvqUeg==
=E+Mk
-----END PGP SIGNATURE-----

--mhoREVIxmN65ur2rnClNULuGZWyn1gNM7--
