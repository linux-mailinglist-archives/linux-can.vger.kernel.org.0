Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABCA595E92
	for <lists+linux-can@lfdr.de>; Tue, 16 Aug 2022 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiHPOu5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Aug 2022 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHPOuz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Aug 2022 10:50:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93A459A2
        for <linux-can@vger.kernel.org>; Tue, 16 Aug 2022 07:50:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oNxu7-0007RG-Oh; Tue, 16 Aug 2022 16:50:51 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3999ECC0B9;
        Tue, 16 Aug 2022 14:50:50 +0000 (UTC)
Date:   Tue, 16 Aug 2022 16:50:48 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v2 00/15] can: kvaser_usb: Various fixes
Message-ID: <20220816145048.leptfnx2wlk6vbdd@pengutronix.de>
References: <20220708115709.232815-1-extja@kvaser.com>
 <20220719184059.pzqgxsgl7hw3cdne@pengutronix.de>
 <48197e64-6dda-12d0-26ce-34054b23f7b4@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="brfbl2sv64tkqiby"
Content-Disposition: inline
In-Reply-To: <48197e64-6dda-12d0-26ce-34054b23f7b4@kvaser.com>
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


--brfbl2sv64tkqiby
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2022 20:59:01, Jimmy Assarsson wrote:
> On 7/19/22 20:40, Marc Kleine-Budde wrote:
> > On 08.07.2022 13:56:54, Jimmy Assarsson wrote:
> > > This patch series was originally posted by Anssi Hannula [1].
> > > Since v1 I've rebased the patches on top of commit
> > > b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits=
")
> > > and replaced a couple of patches with new ones.
> >=20
> > Jimmy, as all of these patches went through your hands, they need your
> > S-o-b. Can I add it while applying?

Jimmy, can you resend this series rebased again current net/main. Please
add your S-o-b and take care of Anssi Hannula's issue in patch 04/15.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--brfbl2sv64tkqiby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmL7rsUACgkQrX5LkNig
013EnwgAnxD0lhftERiL2IDbgLEvZ30umXFyk2R8jdh0cPax2u/jP0fIbF1wNSXr
cQHg2uP7p7/7AiFFlB4OJJNwHQUV15ziiUebCGYBQaASOuSWfnqTI0SehcuLQHVY
kHrSSjZtwUWbpFb9nbBtlv9peaz8KGl5ro4l1DWo5hoYwf6UOwrHvS7qV7WrpUaQ
VytGa1y8iWpZkCwxMBXP3vttHpAsmBjU1FeTvjGIe+hDPVjpaMYIzfX8nUgFb5t3
JyBtBP8h+2ui+n2xPLd9LzpwSecNTMW46FzEp27PqW6ZLwtdyDOUxkXExAWRuqhM
G4QaYjSi7xsoCrAokkV77hSMRTir9A==
=Zmi+
-----END PGP SIGNATURE-----

--brfbl2sv64tkqiby--
