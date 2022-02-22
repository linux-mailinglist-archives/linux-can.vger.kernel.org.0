Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D64BFCAA
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiBVPfE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBVPfE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:35:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FF7160FF5
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:34:38 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMXBU-0006s2-RR; Tue, 22 Feb 2022 16:34:36 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3D24B3A95F;
        Tue, 22 Feb 2022 15:34:36 +0000 (UTC)
Date:   Tue, 22 Feb 2022 16:34:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x: wake pin
Message-ID: <20220222153435.hs3gtsixqu7gazc5@pengutronix.de>
References: <20220222150334.rbhm3uzbh4jp4ap4@skn-laptop.hadsten>
 <20220222151901.tn5sq6ihbaycwiuo@pengutronix.de>
 <20220222153210.32ro3rmdpi7a3f2a@skn-laptop.hadsten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5y2d56xp2aibv4r6"
Content-Disposition: inline
In-Reply-To: <20220222153210.32ro3rmdpi7a3f2a@skn-laptop.hadsten>
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


--5y2d56xp2aibv4r6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 16:32:10, Sean Nyekjaer wrote:
> On Tue, Feb 22, 2022 at 04:19:01PM +0100, Marc Kleine-Budde wrote:
> > On 22.02.2022 16:03:34, Sean Nyekjaer wrote:
> > > The TCAN4x5x device have 2 wake pins. One for waking the host control=
ler
> > > and one for waking the tcan controller it self.
> > >=20
> > > We only have the wake for the tcan controller it self implemented
> > > right?
> >=20
> > Sort of. The tcan driver contains handling for the device_state_gpio. I
> > think should be the pin from the tcan to SoC. The handling of this pin
> > looks fishy.
>=20
> Ah, Okay so state-gpio maps to nWKRQ and wake-gpio maps to WAKE.
> I don't think one should wire the WAKE pin to the SoC.

I think that's one way (the only one?) to get the device out of sleep
mode?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5y2d56xp2aibv4r6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIVAokACgkQrX5LkNig
010kPQgAjZ5GjeFjTjDnt57xUjlZAvTebY7mNPfFB/uMoW0oCU12fM1LOt4JIiHX
Dr4kWAwOLef6jZrsl0iHfLAfaKItCCyVog6NS8R4HQ7/U8lNc5qbTQv0plsEZuxA
A4j1SXeZZxtqCm9eaDyQ62fDXPxZxHNstD1ogHNvRiM/fY0f2qdmvU5mfdrL801w
bhWk/HLlwoBcGVRXebvmrb4N8bVWUN/8UMfVtpcQeD6Xrd/u8EFWuozjFYfEUtI7
b9vp60H/7o4zP8hk1yJNDnBQSfWMfsOoV7p8mp8jWCYL0H6x37OPb5inK3UmVmaC
Drqgy2LK+JLGeBvmDJDXo659bnN63w==
=DrCE
-----END PGP SIGNATURE-----

--5y2d56xp2aibv4r6--
