Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB369DE3F
	for <lists+linux-can@lfdr.de>; Tue, 21 Feb 2023 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjBUKyO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Feb 2023 05:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjBUKyN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2023 05:54:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A29522A1C
        for <linux-can@vger.kernel.org>; Tue, 21 Feb 2023 02:54:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pUQHi-00057x-KU; Tue, 21 Feb 2023 11:54:10 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:27e2:f49:4c60:b961])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 77FF817E712;
        Tue, 21 Feb 2023 10:54:09 +0000 (UTC)
Date:   Tue, 21 Feb 2023 11:53:59 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Hartley Sweeten <HartleyS@visionengravers.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Michal Simek <michal.simek@amd.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: RE: xlinix_can: bug when sending two RTR frames
Message-ID: <20230221105359.qswmhdnwp5wcsopb@pengutronix.de>
References: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
 <a2256c85-4253-dff5-fa8e-00fc02916095@hartkopp.net>
 <ea15524a-1ed9-0dbb-9511-c333a66a2555@amd.com>
 <BY3PR01MB6515CC4390A51A5564C69634D0A09@BY3PR01MB6515.prod.exchangelabs.com>
 <5b5acff7-30ee-433c-ab59-59da4b371a49@hartkopp.net>
 <BY3PR01MB6515AB04C38C68ECD442961BD0A19@BY3PR01MB6515.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2c43vv6m4kag6l2"
Content-Disposition: inline
In-Reply-To: <BY3PR01MB6515AB04C38C68ECD442961BD0A19@BY3PR01MB6515.prod.exchangelabs.com>
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


--w2c43vv6m4kag6l2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.02.2023 15:52:33, Hartley Sweeten wrote:
> But non RTR messages are always sent immediately.

| https://github.com/linux-can/can-utils/issues/405#issuecomment-1438257809

Neeli Srinivas says:

| Thanks for letting us know,
| We are able to reproduce the issue on our end.
| we are looking into it. Will get back to you.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--w2c43vv6m4kag6l2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmP0or8ACgkQvlAcSiqK
BOhBNgf8Cq0iELnC1+icNqZGL5sLHlhdClZnL3U00JRh7DN3NHS8eqo3cui87/TP
vxpVS+lrNBqZoGlThEejfci/+ghn3L8rbg0yM8dV4jhxnj9XX1LiiA0y1+AAixfx
2mir+Z95s0WtLcLc9RhTl5ch1LutlSOa4BO54Wjfec/yatdbtb8fyiTDthhK/LbI
245OP8AClMoEMlE/FQdbnNdU6jW1MChwd5jZGx77YR1gAol+jhpD/GM2+G0/GxSo
53ukYKjnhK1XWmpZsb7FtBjjBM1CNSiEEXSy/uuLaOmcWclTSrjqaCSSNRhO+wSd
J2WGb4S19GIg6MVJ+hAYLbHBprMVAw==
=aE7/
-----END PGP SIGNATURE-----

--w2c43vv6m4kag6l2--
