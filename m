Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96261951B
	for <lists+linux-can@lfdr.de>; Fri,  4 Nov 2022 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKDLDq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Nov 2022 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiKDLD1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Nov 2022 07:03:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36CBB24
        for <linux-can@vger.kernel.org>; Fri,  4 Nov 2022 04:03:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oquTn-0007Re-AQ; Fri, 04 Nov 2022 12:03:19 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 82409112D50;
        Fri,  4 Nov 2022 11:03:18 +0000 (UTC)
Date:   Fri, 4 Nov 2022 12:03:17 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: presume-ack option exact meaning
Message-ID: <20221104110317.7hxjuzrfe6slye6e@pengutronix.de>
References: <DU2PR03MB8108CC9551DF1818EE355542D63B9@DU2PR03MB8108.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwokkbbcvjsvsfiq"
Content-Disposition: inline
In-Reply-To: <DU2PR03MB8108CC9551DF1818EE355542D63B9@DU2PR03MB8108.eurprd03.prod.outlook.com>
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


--zwokkbbcvjsvsfiq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.11.2022 10:56:16, St=C3=A9phane Grosjean wrote:
> Hello all,
>=20
> I have searched the net, but I can't find a clear explanation of what
> the "presume-ack" option available in socket-can is.
>=20
> Some PEAK-System devices offer an option called "self-ack" which
> allows the controller sending the frame to also send the ACK itself.

Does it actually send an ACK to the bus or ignore the missing ACK?

> Does this behavior correspond to what the "presume-ack" option should
> enable?
>=20
> Thank you all for your help and regards,

In

| https://lore.kernel.org/all/1404934273-19233-3-git-send-email-nebaruzdin@=
gmail.com

Nikita Edward Baruzdin writes:

| Most CAN controllers have a support for ignoring ACK absence. Some of
| them refer to this feature as a self test mode (e. g. SJA1000) and some
| include it as a part of a loopback mode (e. g. MCP2510).
|=20
| Setting the introduced flag via netlink should make CAN controller
| perform a successful transmission, even if there is no acknowledgement
| (dominant ACK bit) received.

Does that answer your question?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zwokkbbcvjsvsfiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNk8XMACgkQrX5LkNig
0122rwf+J+KlLNlFAmAUIX/xNGbu0aGVgWFQfkawDgmpfEPC2V4/EysLrsNz9XXi
jFTlbfNWTGgu7/6id/NB+VrDWaS0uSCCGgrzW/5HCeAyjNXsoLBoXpNt/nlJme8w
O8p1WxJGMPiTohX2yuRv4n85Pi6YNn09Vc7P48+hqQAyyeceX05aehVaE+uOcodK
UBur0ITFVgzUne6dDIxqwPZNtMj7qiSj47C3aNpyKEcTAmZLDu0BKPU7vP6lBMXa
kv0VxYfJWzvFt3J7TzsHeZaWJ/k6++Ry6fYWV7Ym+8hwR9w91Fiji6Q5QyDZ8g3T
kCUT+JGUZuRRekUzzkTQqkmvqDjliA==
=spqv
-----END PGP SIGNATURE-----

--zwokkbbcvjsvsfiq--
