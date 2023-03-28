Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED2A6CB73C
	for <lists+linux-can@lfdr.de>; Tue, 28 Mar 2023 08:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1GeS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Mar 2023 02:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjC1GeQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Mar 2023 02:34:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92581982
        for <linux-can@vger.kernel.org>; Mon, 27 Mar 2023 23:33:55 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ph2u2-0000fN-5D; Tue, 28 Mar 2023 08:33:54 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1F73D19DEA6;
        Tue, 28 Mar 2023 06:33:53 +0000 (UTC)
Date:   Tue, 28 Mar 2023 08:33:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v3] can: isotp: add module parameter for maximum pdu
 size
Message-ID: <20230328063351.ysgaza6yesiersmh@pengutronix.de>
References: <20230326115911.15094-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y4hxs7qowhtel3hf"
Content-Disposition: inline
In-Reply-To: <20230326115911.15094-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--y4hxs7qowhtel3hf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.03.2023 13:59:11, Oliver Hartkopp wrote:
> With ISO 15765-2:2016 the PDU size is not limited to 2^12 - 1 (4095) bytes
> but can be represented as a 32 bit unsigned integer value which allows
> 2^32 - 1 bytes (~4GB). The use-cases like automotive unified diagnostic
> services (UDS) and flashing of ECUs still use the small static buffers
> which are provided at socket creation time.
>=20
> When a use-case requires to transfer PDUs up to 1025 kByte the maximum
> PDU size can now be extended by setting the module parameter max_pdu_size.
> The extended size buffers are only allocated on a per-socket/connection
> base when needed at run-time.
>=20
> Link: https://github.com/raspberrypi/linux/issues/5371
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129  |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--y4hxs7qowhtel3hf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQiikwACgkQvlAcSiqK
BOhgrggAjnBbpDwykXBV4+ywDKw1dE5+OtRUOJLKP1ezibW/xww9Y9st1cts2ccw
qg2AYJqd2mQGd2UliESKuSY3VFbAGpoclYyF/e7dNkBuuWkvpnbHnrWJcth1BK9p
zcMgGBqr8mqZI1V+cP/Wz1xZEgUgdTMftDrGl1hlBwiWM6J+Zbw6fBnPwK43nBbV
kLn6VoUsF2ZyGFRN2qOgk2NF2tyEiVrFNHRhUNiA5BEgC4BTZ4s8JjFmTR+rJE0R
ICf0SR4udhljK/gwJT82FjjN6v2cnVQd1k6j2GTmltmpuxzZihY0CvO1TMdKXf4Y
2fDjHHvYiNTtSw/aVi2mHjxbP9NXbQ==
=UUny
-----END PGP SIGNATURE-----

--y4hxs7qowhtel3hf--
