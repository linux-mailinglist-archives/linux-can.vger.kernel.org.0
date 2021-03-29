Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B934C4BF
	for <lists+linux-can@lfdr.de>; Mon, 29 Mar 2021 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhC2HTc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Mar 2021 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhC2HTB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Mar 2021 03:19:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03009C061574
        for <linux-can@vger.kernel.org>; Mon, 29 Mar 2021 00:19:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lQmAl-0008RS-SU; Mon, 29 Mar 2021 09:18:51 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:44b9:f06e:1c40:69b1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0D452602742;
        Mon, 29 Mar 2021 07:01:37 +0000 (UTC)
Date:   Mon, 29 Mar 2021 09:01:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Rong Chen <rong.a.chen@intel.com>,
        Patrick Menschel <menschel.p@posteo.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
Message-ID: <20210329070136.xbgjqc7fpuku7d2t@pengutronix.de>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
 <a5599800-53f4-c53f-abcc-e166ea9028b9@rasmusvillemoes.dk>
 <080d9e5c-fe1f-4a64-2938-8ca6d8a98d78@hartkopp.net>
 <0a8e8e95-c1a2-ede6-9f87-1ab7a0a155e3@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="no2yxwukvxsasx2v"
Content-Disposition: inline
In-Reply-To: <0a8e8e95-c1a2-ede6-9f87-1ab7a0a155e3@rasmusvillemoes.dk>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--no2yxwukvxsasx2v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.03.2021 15:00:55, Rasmus Villemoes wrote:
[...]
> So let us guess that it's the ABI choice -mabi=3Dapcs-gnu
>=20
> $ arm-linux-gnueabihf-gcc -O2 -msoft-float -mabi=3Dapcs-gnu -Q
> --help=3Dtarget | grep struct
>   -mstructure-size-boundary=3D            32
>=20
> Bingo. (-msoft-float is also included just as in the real command line
> because gcc barfs otherwise).
>=20
> Now what CONFIG_* knobs are responsible for putting -mabi=3Dapcs-gnu in
> CFLAGS is left as an exercise for the reader. Regardless, it is not a
> bug in the compiler. The error is the assumption that this language

For the record:

If CONFIG_AEABI is not set "-mabi=3Dapcs-gnu" is used, which leads to the
bigger structure size boundary.

| ifeq ($(CONFIG_AEABI),y)
| CFLAGS_ABI      :=3D-mabi=3Daapcs-linux -mfpu=3Dvfp
| else
| CFLAGS_ABI      :=3D$(call cc-option,-mapcs-32,-mabi=3Dapcs-gnu) $(call c=
c-option,-mno-thumb-interwork,)
| endif

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--no2yxwukvxsasx2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBhe00ACgkQqclaivrt
76k/PQf/V4wzlOaxxCPhkLS9K/CuqzRFcuwvLONqKlnwLipN6bWjW7r8AU6IwtF9
dZsm2Jd26fbOpfqiI30fG//Q7CQxHKSZGcXgy3iX/sAdIEAlAus3QMwZgQ9dHnzE
hdTCWyu8BvbQ4HF43Kf4QkPA8pD6eaGu4PoDpYecY0t4x5fYukctCcQNOkGF/1F1
MDbii6ekH7xCzq7sXtUmQvZb8EuXjHK5Y6qPgLnJIV4N9N2Uk4LZqckGBj5spqXk
aBE2/idWrZdmLkB4VVjR9cFd1ynixgzzqswIwaTHVu7/t4hI6tS99B2P+j8LqKaa
RWnJTfUMOngWKD54GuDlNBfUeOxFaw==
=LRmw
-----END PGP SIGNATURE-----

--no2yxwukvxsasx2v--
