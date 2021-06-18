Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021543AC6D2
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 11:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhFRJM2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 05:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhFRJM1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 05:12:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798DC061574
        for <linux-can@vger.kernel.org>; Fri, 18 Jun 2021 02:10:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1luAW1-000850-C7; Fri, 18 Jun 2021 11:10:17 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e7d0:b47e:7728:2b24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6DF1963EB9C;
        Fri, 18 Jun 2021 09:10:16 +0000 (UTC)
Date:   Fri, 18 Jun 2021 11:10:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 1/2] can: netlink: clear data_bittiming if fd is turned
 off
Message-ID: <20210618091015.kioemxe3j3cbx6qg@pengutronix.de>
References: <20210618081904.141114-1-mailhol.vincent@wanadoo.fr>
 <20210618081904.141114-2-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5z5a2vbwwxtxfxvv"
Content-Disposition: inline
In-Reply-To: <20210618081904.141114-2-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5z5a2vbwwxtxfxvv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2021 17:19:03, Vincent Mailhol wrote:
> When the FD is turned off through the netlink interface, the value

values

> still remain in data_bittiming and are displayed despite of the
> feature being disabled.
>=20
> Example:
>=20
> $ ip link set can0 type can bitrate 500000 dbitrate 2000000 fd on
> $ ip --details link show can0
> 1:  can0: <NOARP,ECHO> mtu 72 qdisc pfifo_fast state DOWN mode DEFAULT gr=
oup default qlen 10
>     link/can  promiscuity 0 minmtu 0 maxmtu 0
>     can <FD> state STOPPED restart-ms 0
> 	  bitrate 500000 sample-point 0.875
> 	  tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
> 	  ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-i=
nc 1
> 	  dbitrate 2000000 dsample-point 0.750
> 	  dtq 12 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1
> 	  ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-i=
nc 1
> 	  clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_=
segs 65535
>=20
> $ ip link set can0 type can bitrate 500000 fd off
> $ ip --details link show can0
> 1:  can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT gr=
oup default qlen 10
>     link/can  promiscuity 0 minmtu 0 maxmtu 0
>     can state STOPPED restart-ms 0
> 	  bitrate 500000 sample-point 0.875
> 	  tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
> 	  ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-i=
nc 1
> 	  dbitrate 2000000 dsample-point 0.750
> 	  dtq 12 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1
> 	  ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-i=
nc 1
> 	  clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_=
segs 65535
>=20
> Remark: once FD is turned off, it is not possible to just turn fd back
> on and reuse the previously input data bittiming values:

> $ ip link set can0 type can bitrate 500000 fd on
> RTNETLINK answers: Operation not supported
>=20
> This means that the user will need to overwrite data bittiming with
                                        ^^^^^^^^^
set

At least with your change it's more a "set again" than to overwrite.

> fresh values in order to turn fd on again.
>=20
> Because old data bittiming values can not be reused, this patch just
> clears priv->data_bittiming whenever FD is turned off. This way, the
> data bittiming variables are not displayed anymore.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Hi Marc,
>=20
> I suggest to rebase this patch before the netlink TDC series.

makes sense - If you're OK with the changes, I'll add them while
applying.

Your patch makes the interface consistent, another option would be to
allow FD mode if the data bit timing values have been set before.
Opinions?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5z5a2vbwwxtxfxvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDMYvQACgkQqclaivrt
76kROAgAssBPAbjue3ZubMsyzYCoEDUPZ2HpCwpoVaFPYtluknhPbZ8AC/1j2Kze
LqyR8fxuDBtj3wmGh7X1O3Mm8rCXQIqFPvHE5Fug6CdryuOnjrCQNktIvKEpYe+Z
GRsowA0PyPKgRdtNm1E7hCbt18kvsM7wQ5iQ0qqPM6lQ73hitqFV+zqlWneEgEg/
0el77pwDMr50//7vFF7o7wpdXmQCK7K4Cf/cw7uLYrNYyJSHbGfkXu4tUFSqRwLu
8GVIEedHyv+/xZGRaI/OIZyEGWsEkxEBNYofxJ6TddzYzukTaeKlCst74VFyR+RY
Me6NLcn5tdKb8GCCVGs/P1p0Qg/KRQ==
=VPVq
-----END PGP SIGNATURE-----

--5z5a2vbwwxtxfxvv--
