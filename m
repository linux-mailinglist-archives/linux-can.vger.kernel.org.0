Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE66D589B
	for <lists+linux-can@lfdr.de>; Tue,  4 Apr 2023 08:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjDDGRR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Apr 2023 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjDDGRQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2023 02:17:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B222689
        for <linux-can@vger.kernel.org>; Mon,  3 Apr 2023 23:16:54 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pjZyN-0007vo-PG; Tue, 04 Apr 2023 08:16:51 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B2FA01A5E08;
        Tue,  4 Apr 2023 06:16:49 +0000 (UTC)
Date:   Tue, 4 Apr 2023 08:16:48 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>,
        Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH can-next v2] kvaser_usb: convert USB IDs to hexadecimal
 values
Message-ID: <20230404-vitamins-sandblast-46fc4a4b4251@pengutronix.de>
References: <20230329090915.3127-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5qlep4semp7j4gvk"
Content-Disposition: inline
In-Reply-To: <20230329090915.3127-1-socketcan@hartkopp.net>
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


--5qlep4semp7j4gvk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.03.2023 11:09:15, Oliver Hartkopp wrote:
> USB IDs are usually represented in 16 bit hexadecimal values.
> To match the common representation in lsusb and for searching USB IDs
> in the internet convert the decimal values to lowercase hexadecimal.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Jimmy Assarsson <extja@kvaser.com>
> Reviewed-by: Alexander Dahl <ada@thorsis.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5qlep4semp7j4gvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQrwM4ACgkQvlAcSiqK
BOgQCQf8C5SUcy9W4Vkrxxzvqi0lRDUtAkExrqVFdEbtRfycGvB3Us70HwD9ud6s
nwEsZ4C43It9zFfE5nihf0Rhw4l5+CBJWWKRoIrwoHRTfp0DxWoHV+bettf1+EyB
efvT9HiCKK8DhZK34z7Qv1UPeBPajZhvNzGBwfbm64//qvuU0cD7O5dcmHDeNesb
ajUb8lQub68U/IcNY1Vptx1eEWPukj8ze/8VFhIerBX7aK0l42/5cIpr589AGbev
BVLlS9UXoU1U43nP0N8tnQHlNvo4ReF/SH7DxJckAbDpv70jKUHyYTo3X0I4aIO+
6TIKWN664Bu5qhMInVhp09qgrbPR/Q==
=kdan
-----END PGP SIGNATURE-----

--5qlep4semp7j4gvk--
