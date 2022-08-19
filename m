Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599EF599B01
	for <lists+linux-can@lfdr.de>; Fri, 19 Aug 2022 13:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347439AbiHSLar (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Aug 2022 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347538AbiHSLa2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Aug 2022 07:30:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A23D12AFF
        for <linux-can@vger.kernel.org>; Fri, 19 Aug 2022 04:30:27 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oP0Cn-0004Tf-S2; Fri, 19 Aug 2022 13:30:25 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 16083CE5EE;
        Fri, 19 Aug 2022 11:30:25 +0000 (UTC)
Date:   Fri, 19 Aug 2022 13:30:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v4 6/6] can: sja1000: Add support for RZ/N1 SJA1000 CAN
 Controller
Message-ID: <20220819113023.xk2yz6qqbq74albs@pengutronix.de>
References: <20220710115248.190280-1-biju.das.jz@bp.renesas.com>
 <20220710115248.190280-7-biju.das.jz@bp.renesas.com>
 <20220819084532.ywtziogd7ycuozxx@pengutronix.de>
 <04b05aa5-e926-1050-b1ed-e5ad99a23722@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zgrveunpxwgygtsl"
Content-Disposition: inline
In-Reply-To: <04b05aa5-e926-1050-b1ed-e5ad99a23722@hartkopp.net>
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


--zgrveunpxwgygtsl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.08.2022 13:23:22, Oliver Hartkopp wrote:
> net-next has been rebased to 6.0-rc1 some house ago.
>=20
> Do you have any plans for the CAN XL support for linux-can-next?
>=20
> So far there has been no new feedback for a while.

I want to have Vincent's Ack for the series, but he's on vacation. I'll
be on vacation the next 2 weeks... I think I'll merge it when I'm back
to give Vincent time to look at the series.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zgrveunpxwgygtsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmL/dEgACgkQrX5LkNig
010v0gf9EB+Yt1T0J4fXevmU37wt6TBBLuAmc9kJ+OkgFUOpEpXqhHqx7+dK6LFD
+6c1T4lOHaX/+W6q5HHPZVR88sQ28uUPXkDq/CsjaZ+7Kz14ONtamJO8Ug6tmKVp
gMt8+AETCJV0hn+kLnXLdKBxQrbPhE+uJ1S8R2Fy8JQCv0sDTYWqI7B7rqOr0tCh
8ib+hNnPK/cIL/ElqW5aymU+JTYMMxm4FasEBNbADUH2AwWjLv4dOhuOwQa/t0HW
uq7WFPnjxop6IvDcYvaGeMqtkIfLqH7/EQ9ujDSRxeQo7mM/OPjNnLg1r9cYCTzL
gTriXfF6enQutc2zj1gS1g+sgvWTHA==
=79Kn
-----END PGP SIGNATURE-----

--zgrveunpxwgygtsl--
