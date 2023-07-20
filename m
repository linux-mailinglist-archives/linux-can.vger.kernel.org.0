Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6991675AAD8
	for <lists+linux-can@lfdr.de>; Thu, 20 Jul 2023 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGTJau (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Jul 2023 05:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGTJad (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Jul 2023 05:30:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824A2D47
        for <linux-can@vger.kernel.org>; Thu, 20 Jul 2023 02:20:01 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qMPp9-0000It-Vw; Thu, 20 Jul 2023 11:19:52 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BF9781F60F1;
        Thu, 20 Jul 2023 09:19:50 +0000 (UTC)
Date:   Thu, 20 Jul 2023 11:19:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH 0/2] can: gs_usb: fix time stamp counter initialization
Message-ID: <20230720-conclude-ravioli-6d846555a635-mkl@pengutronix.de>
References: <20230716-gs_usb-fix-time-stamp-counter-v1-0-9017cefcd9d5@pengutronix.de>
 <C3H7gx4Krj3hjq14-A92mCFngjXEie679zE1xQvTosJTiMAbVmr9Z6_cLvWKfPjLOjOOKgOAWFBuMCp5J2HxRMCWZal7RAWwsEecEpnvkSI=@jbrengineering.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7uejvxoxd27og7sz"
Content-Disposition: inline
In-Reply-To: <C3H7gx4Krj3hjq14-A92mCFngjXEie679zE1xQvTosJTiMAbVmr9Z6_cLvWKfPjLOjOOKgOAWFBuMCp5J2HxRMCWZal7RAWwsEecEpnvkSI=@jbrengineering.co.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7uejvxoxd27og7sz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2023 12:55:03, john@jbrengineering.co.uk wrote:
> Hi Marc,
>=20
> Thanks for this. I've had a look and tested it (candleLight_fw v2.0,
> `candump can0 -H`, unload) and all seems good.

Thanks for testing!

Meanwhile the patch got mainline, otherwise I would have added your
Tested-by.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7uejvxoxd27og7sz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS4/DMACgkQvlAcSiqK
BOgRHggAmJaDvg6tdtv/vG+NzRxRveQloAvF/lOKp4J5GoEpUs1R3k/xV9oAPwRQ
DXA6uejihMEKY26MffG3Y3VJYn4k8R6jP1bgK/Cob82njxGX4JgDKCWX3jd60eGA
wK8ALjXbcTWjE0H/O+v+RSgf94KZaITjJFWjd3J9oVtmaFAEJW6aPOUfNmV3nigD
Nu9USVQdApvOFLLsxuCcuqFZubBjk6RU101Z/7eaeapQ4JhL/Esh2IWQbr3ydO00
Y2JsObey7IULM1Ut03pLTAZEQfpWAoI7J2CBQaznhGEqvYrq5WP6uICdLQBBNEkQ
rMriOHaB4TufxwDDRsuFyY4oo6N2fA==
=Ukr2
-----END PGP SIGNATURE-----

--7uejvxoxd27og7sz--
