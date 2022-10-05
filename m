Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1F95F5026
	for <lists+linux-can@lfdr.de>; Wed,  5 Oct 2022 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJEHG0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Oct 2022 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJEHGZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Oct 2022 03:06:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA666501A5
        for <linux-can@vger.kernel.org>; Wed,  5 Oct 2022 00:06:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ofyU1-0000Do-QQ; Wed, 05 Oct 2022 09:06:21 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 74914F4C26;
        Wed,  5 Oct 2022 07:06:20 +0000 (UTC)
Date:   Wed, 5 Oct 2022 09:06:18 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Jacob Kroon <jacob.kroon@gmail.com>, linux-can@vger.kernel.org,
        Dario Binacchi <dariobin@libero.it>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC can-next] can: remove obsolete PCH CAN driver
Message-ID: <20221005070618.o3jdakrgzdvhkswh@pengutronix.de>
References: <20220924174424.86541-1-socketcan@hartkopp.net>
 <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
 <20220926082526.ofoderi7wrpyolff@pengutronix.de>
 <1653bdae-2ed0-7cc4-993e-cae922f1c524@gmail.com>
 <23216e28-49be-6461-9525-1faad3d439a7@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3gfmoykm3tklkhis"
Content-Disposition: inline
In-Reply-To: <23216e28-49be-6461-9525-1faad3d439a7@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--3gfmoykm3tklkhis
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.10.2022 20:44:07, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> now that net-next is closed for the merge window would you consider this
> removal for the next can-next phase or is this something that can be still
> applied after the merge window to 6.1-rc1?

This will go into net-next once it's open again. Why do you ask?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3gfmoykm3tklkhis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM9LOgACgkQrX5LkNig
010peAgAqtWLnnK9B+5hLwHt+B9gMiqNTYi5zQTkkAYwQykRaBV3XKBiF6hGhZaJ
vgrhfuX9CS6I5tx4Bh3PxMBqUpqRuPmFyBcWVNRSi1BR8KDXLfVrrmW/v+/zxHsw
c1UOFVxlQuo1ZfB/j70VwkAiaRr1SZHx/OTUy6ghL11Imdbqa5A2k5MenIMTII0Y
T4mHRXRCKrjK1+kQRz724oa+4f7VVlscxFE28lOX995eto6IK1RGV1oHk1l5ANiO
MWvhC7iXnh0iUZdDtAHEI1eXFBFdONxwSSXxda98OwZxHfkEK8KNgfrhY6gHCw0O
chvB4ctG+qKwElvINXkhdOJYYBOKUw==
=moZ1
-----END PGP SIGNATURE-----

--3gfmoykm3tklkhis--
