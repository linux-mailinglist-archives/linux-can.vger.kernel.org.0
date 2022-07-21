Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C878857C58E
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 09:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiGUHxV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiGUHxU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 03:53:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99CC7CB73
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 00:53:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oEQzi-0005lg-WD; Thu, 21 Jul 2022 09:53:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D0452B67DA;
        Thu, 21 Jul 2022 07:53:11 +0000 (UTC)
Date:   Thu, 21 Jul 2022 09:53:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Message-ID: <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
References: <20220719112748.3281-1-socketcan@hartkopp.net>
 <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net>
 <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
 <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y7oridywublz7puh"
Content-Disposition: inline
In-Reply-To: <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
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


--y7oridywublz7puh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.07.2022 09:36:21, Oliver Hartkopp wrote:
> Btw. How should we finally name the 'non data' header of CAN XL?
>=20
> 1. CANXL_HEADER_SIZE
> 2. CANXL_HEAD_SIZE
> 3. CANXL_HDR_SIZE
> 4. CANXL_HDR_SZ <- currently in the patches
> 5. CANXL_HD_SZ
>=20
> I think it has to be 'head' and not 'header'.

Header! Header is in front of data.

> In skbs we also have head and tail.

Yes, but they point at the head or tail of the buffer allocated with the
skb.

> So I would vote for 2 or 5 with a tendency to 5.

3, 1, 4

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--y7oridywublz7puh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLZBeIACgkQrX5LkNig
012wZAgAtthpfA6mhf8Go0llwtM4ZZlRbJReQ0AzDBAgOvB6xh9tSfm5hU+5LoIB
bZTul7D4itn3gos+PJ43ZOKlQU7ATz3+X63bwQX39Ki7g1jnX/yqynke4HpxG+nk
X2ESbXRq8XdZzQm2lcc76lOMXVO6LNFiYfo98YexoA6ph5AidIJ0cM4tg4+NLFir
65wadQzOEK/v1/P2Cv8kAvn5oEwqpc6Elfn8XhG+xrIvHpg4Rhv1ye4w0S5u0bXS
Su+EoWbIxCG+n9slaB90Yt564UDyGuItvnxF+tSt27FJwpjJQTeWsZVO8YAB9RYA
Dz5JeLU2t5p5+NFtzupoAuUZdcAMgQ==
=unM4
-----END PGP SIGNATURE-----

--y7oridywublz7puh--
