Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319FA348C6A
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 10:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCYJOA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCYJNn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 05:13:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358F2C06174A
        for <linux-can@vger.kernel.org>; Thu, 25 Mar 2021 02:13:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lPM3f-00073x-NO; Thu, 25 Mar 2021 10:13:39 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f5fd:792d:c506:d37f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 123B85FF92E;
        Thu, 25 Mar 2021 09:13:38 +0000 (UTC)
Date:   Thu, 25 Mar 2021 10:13:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        linux-can@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
Message-ID: <20210325091337.q66pwkqsmgqt3dwh@pengutronix.de>
References: <20210325081326.1652-1-socketcan@hartkopp.net>
 <20210325084714.GE8446@x1.vandijck-laurijssen.be>
 <63afa11b-da2f-65ed-f833-392ca625496f@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cz6dckpv6jwks2oo"
Content-Disposition: inline
In-Reply-To: <63afa11b-da2f-65ed-f833-392ca625496f@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cz6dckpv6jwks2oo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.03.2021 10:11:56, Oliver Hartkopp wrote:
> Thanks Kurt!
>=20
> @Marc: Would you suggest to split this patch in two parts (raw, bcm) and
> (isotp) - as it would simplify the stable process?

Yes, make it so.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cz6dckpv6jwks2oo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBcVD4ACgkQqclaivrt
76m0PQf+OkChFUCVeM4VfOCUmzEsnz8xC43laEtiVJbDmlGG6vzI86t1ZQYvTDqF
U+do0c95JJ42nriPzkmSmteg1JJDG2m3Hnz552BwhE9SUdCJl9j42Y+VzB0F/4KM
gNhcJ7/P6yj5q8jOdAGBMnZ6KwXwyhYQ5U62fJPbojmHS2xUKFCbin5pLse5u/WQ
l9bqUA0kSISa/XPui/G5CQP9D4atUMLdj94ViA79ezJWcqVVLqfnm1j1+2baCvJS
p7QedQhQTt/DjzLKmDBqWtDwuNERTci8FP54/f6QpwsiL8zEdBkhJm3O2/iWPa+4
EuLi4qyRh6J/aVGNohbwpmL20qXF/w==
=5lrR
-----END PGP SIGNATURE-----

--cz6dckpv6jwks2oo--
