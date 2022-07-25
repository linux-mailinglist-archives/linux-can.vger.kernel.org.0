Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93F4580076
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGYOJS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 10:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiGYOJR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 10:09:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7B14D35
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 07:09:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oFyll-0007zx-OC; Mon, 25 Jul 2022 16:09:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6CC57B9A47;
        Mon, 25 Jul 2022 14:09:12 +0000 (UTC)
Date:   Mon, 25 Jul 2022 16:09:11 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v1 10/24] can: tree-wide: implement
 ethtool_ops::get_drvinfo()
Message-ID: <20220725140911.2djwxfrx3kdmjeuc@pengutronix.de>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725133208.432176-11-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dvegs2d76ezich2a"
Content-Disposition: inline
In-Reply-To: <20220725133208.432176-11-mailhol.vincent@wanadoo.fr>
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


--dvegs2d76ezich2a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.07.2022 22:31:54, Vincent Mailhol wrote:
> For all CAN drivers, implement the get_drvinfo() function.
>=20
> After this patch, it is now possible to retrieve basic information by
> doing:
>=20
> | $ ethtool -i canX

This is the output of unpatched mcp251xfd driver.=20

| $ ethtool -i mcp251xfd0
| driver: mcp251xfd
| version: 5.18.10-v8+
| firmware-version:=20
| expansion-rom-version:=20
| bus-info: spi0.0
| supports-statistics: no
| supports-test: no
| supports-eeprom-access: no
| supports-register-dump: no
| supports-priv-flags: no

(v5.19/patched is currently compiling}

IMHO there's no need to implement a default .get_drvinfo callback. BTW:
I removed one from the c_can driver some time ago:

https://lore.kernel.org/all/20220124215642.3474154-10-mkl@pengutronix.de/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dvegs2d76ezich2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLepAIACgkQrX5LkNig
013vBgf/ZIlvKqD+NhU/Glca9VNet5ZUaJ8LFjeqI4QvpoMS7P1Plxg8WYgI9YAJ
cw5nS/zZIBZvaWSoH2B+4eCJVm85PFsWe03M70eSIIqA9RPjhvhdXjTtphlaEU4U
VC56T2SCbMlywF4ot+RM0NLslNK4JoO1vWKW7ygCRLy3iG3JLh5VUn4zqShgHHzl
hRDGua7s0VKEerdwbBui3cvqY9uwrLbkNVU9d/M/WjcWqjpvkNa/H4ZK1OMry8Be
1cvMrzZUVf4JJ4H2DnRqY+mw3GzKwXFp7nYQYKiw5+DXr/hC8HCA5f5EJr2g1a6s
48kcgz+eQLZ4zFxaATv+gwbzBwUlYQ==
=4SwA
-----END PGP SIGNATURE-----

--dvegs2d76ezich2a--
