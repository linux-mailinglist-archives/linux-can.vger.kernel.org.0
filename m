Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF95ED7A5
	for <lists+linux-can@lfdr.de>; Wed, 28 Sep 2022 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiI1IZh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Sep 2022 04:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiI1IZb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Sep 2022 04:25:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02835183B9
        for <linux-can@vger.kernel.org>; Wed, 28 Sep 2022 01:25:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1odSNc-0001ZV-Uc; Wed, 28 Sep 2022 10:25:20 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AEF0DEF5F9;
        Wed, 28 Sep 2022 08:25:19 +0000 (UTC)
Date:   Wed, 28 Sep 2022 10:25:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jacob Kroon <jacob.kroon@gmail.com>
Cc:     dariobin@libero.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Message-ID: <20220928082516.5hxt22y7u6cwjbmz@pengutronix.de>
References: <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
 <36690382.801104.1663955706569@mail1.libero.it>
 <a162f149-58ba-24eb-474f-294b9fe78e51@gmail.com>
 <8665ef57-17fb-dfd7-afa2-8e5bebceb617@gmail.com>
 <1885528784.804387.1663962304792@mail1.libero.it>
 <a843df30-f1f9-f2dc-2d3f-4302c928c34c@gmail.com>
 <d9cf121c-de6c-b3e7-cb71-db505fc8c88f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6btkj2go4p5xkbqp"
Content-Disposition: inline
In-Reply-To: <d9cf121c-de6c-b3e7-cb71-db505fc8c88f@gmail.com>
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


--6btkj2go4p5xkbqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.09.2022 07:17:25, Jacob Kroon wrote:
> Machine is still running with CAN network traffic working, so both patches
> at
>=20
> https://marc.info/?l=3Dlinux-can&m=3D166393304023574&w=3D2
> https://marc.info/?l=3Dlinux-can&m=3D166396200108947&w=3D2
>=20
> are working for me.

Can I add your Tested-by for my variant of the patch? That is:

| https://lore.kernel.org/all/20220923114223.726808-1-mkl@pengutronix.de

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6btkj2go4p5xkbqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM0BOoACgkQrX5LkNig
012R1wf/eikJ2y/A0s1KZ4wCOLKysuqpf3bM5ExOLBVKHk6X7xWsE2buHbkJNpN/
ZwM+CPPPjYqVF0CZ+QgFfyGPuYhhJWvJO7r7zG6sya5Lyl9KecgG/PqivJLDd5Jn
fgGnaqj5aUinTjKrxcC9SvnHmQ3E+duhvfi2riVcgvFpBRc2ztUfmRnqJURcuPWO
oBX+3xPfk/SkMb6eiqtE/iH/Wc83pWwdthqBfrUtV0sscdSeil5nQOYfctA9oRTX
J8dkTxfFvtikSpuMYp5bRLXklUaxJbJ1QIZPVb8MiPTWEypiP2WZKPG6b96w9ikx
FfkR6S5esSMuDXFOrfmuWILPnrt02Q==
=H6+q
-----END PGP SIGNATURE-----

--6btkj2go4p5xkbqp--
