Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC9351227
	for <lists+linux-can@lfdr.de>; Thu,  1 Apr 2021 11:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhDAJYF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Apr 2021 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbhDAJXz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Apr 2021 05:23:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D81C0613E6
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 02:23:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRtYQ-0004AF-7X; Thu, 01 Apr 2021 11:23:54 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3432:3a72:abbc:cd9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7A8E9605934;
        Thu,  1 Apr 2021 09:23:53 +0000 (UTC)
Date:   Thu, 1 Apr 2021 11:23:52 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: m_can error/overrun frames on high speed
Message-ID: <20210401092352.usi3jngorhmpdrsd@pengutronix.de>
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
 <20210331083744.pui7rtjexvejjvf6@pengutronix.de>
 <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dddpdridrb3w45c4"
Content-Disposition: inline
In-Reply-To: <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--dddpdridrb3w45c4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.04.2021 11:04:25, Belisko Marek wrote:
> > As far as I know the beagle bone boards all have d_can controllers, not
> > m_can.
> Yes sorry it was typo.

No problem, just wanted to be sure :)

> > > I discovered that when set bitrate to 500k during replaying can file
> > > from PC to board ip detect 4-5 error/overrun frames. When comparing
> > > the original file with received one few lines in candump are missing.
> > > When decreased can speed to 125KB replaying the same file no
> > > error/overruns are detected and files are the same. I'm not can expert
> > > thus I'm asking for some advice on how to debug such phenomena. I'm
> > > using mainline 4.12 kernel which shows this symptom. I compared
> > > changes with the latest mainline kernel and there are few patches only
> > > which seems can influence can behavior (others are only cosmetical). I
> > > took :
> > >
> > > 3cb3eaac52c0f145d895f4b6c22834d5f02b8569 - can: c_can: c_can_poll():
> > > only read status register after status IRQ
> > > 23c5a9488f076bab336177cd1d1a366bd8ddf087 - can: c_can: D_CAN:
> > > c_can_chip_config(): perform a sofware reset on open
> > > 6f12001ad5e79d0a0b08c599731d45c34cafd376 - can: c_can: C_CAN: add bus
> > > recovery events
> > >
> > > I know most of the answers for such issues is to try latest kernel
> > > (i'm in process trying 5.10).
> >
> > That's going into the right direction. Please try the lastest
> > net-next/master, which includes this merge:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3D9c0ee085c49c11381dcbd609ea85e902eab88a92

> I tried to build this kernel and when run on my target and run on
> other side cangen can0 -g0 (at 500kb bitrate) after some time I see on
> receiving side:

Does the current net-next lead to fewer lost frames than your original
kernel? I mean does it make the situation better?

> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP
> mode DEFAULT group default qlen 10
>     link/can  promiscuity 0
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>           bitrate 500000 sample-point 0.875
>           tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>           c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>           clock 24000000
>           re-started bus-errors arbit-lost error-warn error-pass bus-off
>           0          0          0          0          0          0
>     numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
>     RX: bytes  packets  errors  dropped overrun mcast
>     6300263    999976   4       0       4       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     0          0        0       0       0       0
>=20
> errors/overrun frames. My theory is that before napi handling of
> received data we disable interrupts and when we process received
> messages and re-enable irq again we can see overrun because reading of
> data can be slow.

Yes, I assume the same problem.

> Is there anything I can tune to have it read faster? Thanks.

I don't think it can be done with tuning. To work around this problem,
you can convert the c_can driver to the rx-offload infrastructure. You
do the RX from the CAN HW in the IRQ handler, but pass it to the
networking stack in NAPI. This dance is needed, as otherwise the
networking stack messes up the order of received CAN frames.

There even is an old branch that implemented that, but was never merged:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/=
?h=3Dc_can

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dddpdridrb3w45c4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBlkSYACgkQqclaivrt
76mEygf/SFrm9zi5ur82t8k9PjVgBW9rqLMyP6UzAvIp6/fQl6K8TjAxSZpEd4c4
yz7VjA8IctBKWaOF7CETb0HlX88AfodbY/AZlFMm8iO+Jl08i9gwXgvjdncw1QdS
uRZJIhoq9E7l9+nTPqmFoS1iUi+1gNJ2CEbberKhnbjC3yXOm3kyEd07dPx3+9C7
oHbXCE05Cb2qBVSWyMTh8hXKrO0pJWWSTr3gvhic96dQsXp+sWONaj3vWAbhyDqC
dKd2gKqAC9ilbKo6eqQrSS48OXRrDmfQt8UVvFn5tUfp2Dak13JnPeV+I0nUnjUY
VwPUnLR8T9M/2wmZDGfsd3g18Ffkbg==
=jXVk
-----END PGP SIGNATURE-----

--dddpdridrb3w45c4--
