Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E02703FDA
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbjEOVcQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 May 2023 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbjEOVcP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 17:32:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B57100E3
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 14:32:12 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyfne-0003k3-L5; Mon, 15 May 2023 23:32:10 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DC0DA1C5E5A;
        Mon, 15 May 2023 21:32:09 +0000 (UTC)
Date:   Mon, 15 May 2023 23:32:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     linux-can@vger.kernel.org, Florian Ferg <flfe@hms-networks.de>
Subject: Re: Any update for the IXXAT USB-to-CAN adapters drivers?
Message-ID: <20230515-salon-sherry-cabae5cf7c49-mkl@pengutronix.de>
References: <20230514151221.049873cb@gmx.net>
 <20230515-repurpose-essential-7f66fdcde4d5-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5cub2mxofbp4g7eg"
Content-Disposition: inline
In-Reply-To: <20230515-repurpose-essential-7f66fdcde4d5-mkl@pengutronix.de>
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


--5cub2mxofbp4g7eg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.05.2023 23:07:51, Marc Kleine-Budde wrote:
> On 14.05.2023 15:12:21, Peter Seiderer wrote:
> > does anybody know what happened with the IXXAT USB-to-CAN adapters driv=
ers
> > attempts to bring the patches upstream?
>=20
> I think upstreaming starved due to lack of enough reviewing power in the
> community.
>=20
> > I found the following attempts
> >
> > - 'Re: [PATCH] can: usb: IXXAT USB-to-CAN adapters drivers' ([1] from J=
une 2018)
> > - '[PATCH v6] can: usb: IXXAT USB-to-CAN adapters drivers' ([2] from Se=
p 2018)
> >
> > but now follow ups and/or references in the actual linux source
> > tree...
>=20
> The newest I have in my archive is:
>=20
> | Date: Thu, 27 Sep 2018 16:04:43 +0200
> | From: Florian Ferg <flfe@hms-networks.de>
> | To: linux-can@vger.kernel.org
> | CC: Florian Ferg <flfe@hms-networks.de>
> | Message-ID: <20180927140443.29051-1-flfe@hms-networks.de>
> | Subject: [PATCH v7] can: usb: IXXAT USB-to-CAN adapters drivers
>=20
> If you're interested to bring the driver mainline, I can forward you
> that mail.

ported (+ compile tested only) to recent net-net/main:

https://lore.kernel.org/all/20230515212930.1019702-1-mkl@pengutronix.de/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5cub2mxofbp4g7eg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRipNYACgkQvlAcSiqK
BOguLAf/QT2ZqntiSCe0YWwUt81gtQUv5dMOhOBQIFHTZI2YM5DzI1UWHEB2gbHj
DE9mCWgWSk+Q6pwy2OFYeMAN0goht5KI0+AnFUfoLrjzEntesq21fABsRS1tKe3p
6vc4Oh8nKpdITKtcdAv8rIGOhv4E4k4s63Izql4odHzTXm6KIPJmv/uOu+j+X+fJ
gfPwy7lJkzKSlujufG4db/hZYRc98MT1Uf20W1Kac+gyLKz4UTcM6kGcsEcPmwpP
ySvnVBADoWOzNg3u4HzC7Pl3NfqL0h6bdTIQ+zqcshSXZdA1pPHIDV6ZwJEjzKcl
m2TPVzlCs0UZRDw5/ueOSAyhwlY1Zw==
=kZfM
-----END PGP SIGNATURE-----

--5cub2mxofbp4g7eg--
