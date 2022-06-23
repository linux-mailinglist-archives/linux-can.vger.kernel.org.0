Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637BC557D4D
	for <lists+linux-can@lfdr.de>; Thu, 23 Jun 2022 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiFWNul (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Jun 2022 09:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiFWNul (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2022 09:50:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98D29CA9
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2022 06:50:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o4NED-0003rY-8o; Thu, 23 Jun 2022 15:50:37 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-80e1-c56b-9df2-c963.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:80e1:c56b:9df2:c963])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E9D8E9D288;
        Thu, 23 Jun 2022 13:50:35 +0000 (UTC)
Date:   Thu, 23 Jun 2022 15:50:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: ram initialization on mcp2518fd
Message-ID: <20220623135035.y2kfgwj4cbnqnaec@pengutronix.de>
References: <e3f73c56-1b46-4ee9-357e-40400c746e09@prevas.dk>
 <87wndgyl2l.fsf@hardanger.blackshift.org>
 <441514ec-7b43-e11c-09b5-bdaf7fca0077@prevas.dk>
 <d614f497-b8f2-68cd-745b-1e3be2b991d5@prevas.dk>
 <20220616124056.cnnvlqwwkknjta7w@pengutronix.de>
 <8db56a87-a1c7-1810-ad74-c7a8e268a00d@prevas.dk>
 <20220617141751.ua3emcdaarrnx7si@pengutronix.de>
 <6e01d1e0-4e26-c42f-5d8d-f5aabe0d9d31@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="avlwgw2or3wftqzl"
Content-Disposition: inline
In-Reply-To: <6e01d1e0-4e26-c42f-5d8d-f5aabe0d9d31@prevas.dk>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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


--avlwgw2or3wftqzl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.06.2022 09:09:09, Rasmus Villemoes wrote:
> >> There is still something to be looked at, since I see
> >>
> >> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #=
08!!!
> >=20
> > Update to a newer kernel. In v5.15 this problem is fixed.
>=20
> Oh, great, thanks. I'll try to give 5.15 a quick spin, we're mostly on
> 5.10 because this project started when that was the latest LTS.

Here you can find the mcp251xfd driver and many enhancements of the CAN
drivers and infrastructure back ported to v5.10 and v5.15. Feel free to
test:

| https://git.pengutronix.de/cgit/mkl/linux/

The "-flat" tags contains a linear series against the latest stable,
while the tags without "-flat" are merges of different topics of the
back port. As the name of the tags suggest this work is sponsored by
microchip.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--avlwgw2or3wftqzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK0b6gACgkQrX5LkNig
013fkwf/Q/9AnBvAb7+ldY7sWcG4EwAGL6FdQabG2k2rYCFgeiI28wpmRI2C2TWd
p3DcL36cy4CgM0cukvt8WOaUSl9xIWHwCW860RigPnMitlN04XAnLvEER5OYWJ9E
4tUo3OGFHIQVOgczioJqZCPL1d83rRPmbMkPmLv6HqavI7HCoeH5rz6AQKB4sH45
JPxISdM3/RvIXgwpFVyf4ZVe2EsiZMc5IEmpVyVzTF/ZjMDDtkhoNcWGBQZVnqnq
bdqXyoH7W1L2kqVFL97e8X8+Udbad/RD4FmWpET1ayQ1taWpy7UK9tL6kg6HWfvo
Bc8XXbi6+VcYlyOzBXpuaH6KxTsWCw==
=Jg+9
-----END PGP SIGNATURE-----

--avlwgw2or3wftqzl--
