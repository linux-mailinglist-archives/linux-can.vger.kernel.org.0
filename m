Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D1834FBC5
	for <lists+linux-can@lfdr.de>; Wed, 31 Mar 2021 10:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCaIiM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Mar 2021 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhCaIhs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Mar 2021 04:37:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB17C061574
        for <linux-can@vger.kernel.org>; Wed, 31 Mar 2021 01:37:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRWME-00047G-8O; Wed, 31 Mar 2021 10:37:46 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a06:b6ed:4055:757b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 88B1A604C6C;
        Wed, 31 Mar 2021 08:37:45 +0000 (UTC)
Date:   Wed, 31 Mar 2021 10:37:44 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: m_can error/overrun frames on high speed
Message-ID: <20210331083744.pui7rtjexvejjvf6@pengutronix.de>
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5qs7hrtiq474kisj"
Content-Disposition: inline
In-Reply-To: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5qs7hrtiq474kisj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.03.2021 08:31:14, Belisko Marek wrote:
> I have a beaglebone based board and I'm performing some tests.

As far as I know the beagle bone boards all have d_can controllers, not
m_can.

> I discovered that when set bitrate to 500k during replaying can file
> from PC to board ip detect 4-5 error/overrun frames. When comparing
> the original file with received one few lines in candump are missing.
> When decreased can speed to 125KB replaying the same file no
> error/overruns are detected and files are the same. I'm not can expert
> thus I'm asking for some advice on how to debug such phenomena. I'm
> using mainline 4.12 kernel which shows this symptom. I compared
> changes with the latest mainline kernel and there are few patches only
> which seems can influence can behavior (others are only cosmetical). I
> took :
>=20
> 3cb3eaac52c0f145d895f4b6c22834d5f02b8569 - can: c_can: c_can_poll():
> only read status register after status IRQ
> 23c5a9488f076bab336177cd1d1a366bd8ddf087 - can: c_can: D_CAN:
> c_can_chip_config(): perform a sofware reset on open
> 6f12001ad5e79d0a0b08c599731d45c34cafd376 - can: c_can: C_CAN: add bus
> recovery events
>=20
> I know most of the answers for such issues is to try latest kernel
> (i'm in process trying 5.10).

That's going into the right direction. Please try the lastest
net-next/master, which includes this merge:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3D9c0ee085c49c11381dcbd609ea85e902eab88a92

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5qs7hrtiq474kisj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBkNNYACgkQqclaivrt
76n7GAf7BXz8hg6g15h22PKhBMdiXCHhEDkLr0hJEiJUf0yF/mIy6qc69gE+q852
nJaxOYsgAbnbTcktFLQSNQrcjfz2Ibiu2/2nGZOrRWpTZgDgaPh1fzjv7nCGD5dO
7xQ54cpOQdDOCahFX2bXzuJMbrZREfwU5u33O6s0GUgH9fA4pWs8W/xpr7gTK0cF
Qp4oY1y8WAiukLYbqQNQchajkqiFfoKZ33UZEa64F4zuyx2hhUg3+V4ah4KwOFTH
KybxFFVGXTOrEgwj1nxEFsn6XtJcvuaO63vKCGqKjq8bFH7+bGFUcAldbXFaNfXL
fDutuH3+j4WusHPo80UP5Z9CHLvvOA==
=y6KT
-----END PGP SIGNATURE-----

--5qs7hrtiq474kisj--
