Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28243B5958
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 09:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhF1HDN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 03:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1HDN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 03:03:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43B9C061574
        for <linux-can@vger.kernel.org>; Mon, 28 Jun 2021 00:00:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lxlGA-0005eO-AW; Mon, 28 Jun 2021 09:00:46 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5559:217e:8326:2717])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 61B60644A62;
        Mon, 28 Jun 2021 07:00:45 +0000 (UTC)
Date:   Mon, 28 Jun 2021 09:00:44 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/5] can: peak_usb: PCAN-USB: add support of loopback and
 one-short mode
Message-ID: <20210628070044.sj2y5lxauuhls5ly@pengutronix.de>
References: <20210625130931.27438-1-s.grosjean@peak-system.com>
 <20210625130931.27438-3-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7bdapffal7mjvlnp"
Content-Disposition: inline
In-Reply-To: <20210625130931.27438-3-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7bdapffal7mjvlnp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.06.2021 15:09:28, Stephane Grosjean wrote:
> The CAN - USB PCAN-USB interface is able to generate one-shot frames as
> well as loopback frames that it transmits starting from version 4.1 of its
> firmware.
>=20
> This patch allows to add these one-shot and loopback functions to the
> driver when the embedded firmware allows it.

Does it makes sense print a firmware update available message if the
adapter doesn't run the latest firmware?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7bdapffal7mjvlnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDZc5oACgkQqclaivrt
76mJ+ggArGiKfHoLf46Ot3R2d2Ji4ryW3AEfE7B1YKqrlcABMAYbOt2Xef83C0VQ
RjJ4+dIMFLSTQEDk4C4M+21GzmD+btumDE7/xRpFlROrZWfv+Ja1zKFOAS8kKjSr
gE4byZw8KFagiarLxJy18hQBvxzK2cXuq2jokByLVuW7OGuRVMiFaSY+Eh8z+bUz
Zhby42RRP9xq1Ir9e4iBXG6PllkVleuTBw97byAH15nFxaH6c3FzKiBa7gVBKBbq
co495UmDz9ikXoYrS8N90wybC18X8dxh/kujbitZojDel2h88DeQdEHN0IhJqq10
ZLH/zInCe4PzOnSsKOF05nrptzQDGA==
=sgjc
-----END PGP SIGNATURE-----

--7bdapffal7mjvlnp--
