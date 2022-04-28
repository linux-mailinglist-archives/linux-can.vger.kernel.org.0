Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3681512CA0
	for <lists+linux-can@lfdr.de>; Thu, 28 Apr 2022 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbiD1H0L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Apr 2022 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245007AbiD1H0K (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Apr 2022 03:26:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD15237EF
        for <linux-can@vger.kernel.org>; Thu, 28 Apr 2022 00:22:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1njyU7-0008HO-54; Thu, 28 Apr 2022 09:22:43 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-6c64-eec7-9c08-9d9e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6c64:eec7:9c08:9d9e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 357746F716;
        Thu, 28 Apr 2022 07:22:40 +0000 (UTC)
Date:   Thu, 28 Apr 2022 09:22:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Carsten Emde <c.emde@osadl.org>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Matej Vasilevski <matej.vasilevski@gmail.com>
Subject: Re: [PATCH v1 0/4] can: ctucanfd: clenup acoording to the actual
 rules and documentation linking
Message-ID: <20220428072239.kfgtu2bfcud6tetc@pengutronix.de>
References: <cover.1650816929.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcxxcdxgu3kxmktr"
Content-Disposition: inline
In-Reply-To: <cover.1650816929.git.pisa@cmp.felk.cvut.cz>
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


--bcxxcdxgu3kxmktr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.04.2022 18:28:07, Pavel Pisa wrote:
> The minor problems reported by actual checkpatch.pl and patchwork
> rules has been resolved at price of disable of some debugging
> options used initially to locate FPGA PCIe integration problems.
>=20
> The CTU CAN FD IP core driver documentation has been linked
> into CAN drivers index.
>=20
> The code has been tested on QEMU with CTU CAN FD IP core
> included functional model of PCIe integration.
>=20
> The Linux net-next CTU CAN FD driver has been tested on real Xilinx
> Zynq hardware by Matej Vasilevski even together with his
> timestamp support patches. Preparation for public discussion
> and mainlining is work in progress.
>=20
> Jiapeng Chong (2):
>   can: ctucanfd: Remove unnecessary print function dev_err()
>   can: ctucanfd: Remove unused including <linux/version.h>

I had these already applied.

> Pavel Pisa (2):
>   can: ctucanfd: remove PCI module debug parameters and core debug
>     statements.
>   docs: networking: device drivers: can: add ctucanfd and its author
>     e-mail update

Split into separate patches and applied.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bcxxcdxgu3kxmktr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJqQLwACgkQrX5LkNig
0137aQgAm4/aKEBQCVIJOoaJFszErBnxVNtaeKBzCLxHa54WFg6PiGNtEYgYF+ni
H6/wAkTF3DPcJ5ARQPKAb5OEGCoeYhnf7dUhCeAVT1jUxhqjjwHNGoFWER1PJmj7
IPsO8ghp61ej7OiA6iboVzsSmkqJ7Tp2IdB3F56NvLQyqqvYgr55jrV3b0T72DIk
u0vOWlk7ZWuqdTBBl5Rv8i4k1CUaoxED+ozCSp08T9Tg/B4NKN4aF3NnG0Fl+DnR
grRv/BX6SHoY0br3y2QJnGCdpcJbuEnVjgNQnVO9zFKUV0qMkK+SqEOGbiz/xXnw
buzoK4IsBiXdNa8nA6M5qlzXczu/rg==
=wVmG
-----END PGP SIGNATURE-----

--bcxxcdxgu3kxmktr--
