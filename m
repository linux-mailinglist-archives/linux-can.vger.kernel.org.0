Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E496C5F9A50
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 09:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJJHpw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 03:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJJHpb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 03:45:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3887961706
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 00:42:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ohn3L-00023z-Di; Mon, 10 Oct 2022 09:18:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 467A4F8F1A;
        Mon, 10 Oct 2022 07:00:45 +0000 (UTC)
Date:   Mon, 10 Oct 2022 09:00:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 4/6] can: gs_usb: add ability to enable / disable berr
 rerporting
Message-ID: <20221010070043.yubz67efaa43wbj4@pengutronix.de>
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162452.200322-5-mkl@pengutronix.de>
 <20221006163650.b6n2g44kl5d3ptq4@pengutronix.de>
 <e9a8edc8-c019-6396-6655-fe331c89df7b@victronenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ivfqvzfzdmxiflaw"
Content-Disposition: inline
In-Reply-To: <e9a8edc8-c019-6396-6655-fe331c89df7b@victronenergy.com>
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


--ivfqvzfzdmxiflaw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.10.2022 20:30:27, Jeroen Hofstee wrote:
> > > The open source firmware candleLight report bus errors
> > > unconditionally. This adds support to enable / disable bus error
> > > reporting with the standard netlink property.
> > I haven't checked the candleLight firmware, yet.
> >=20
> > If the unmodified firmware sends bus errors per default and we introduce
> > BERR_REPORTING as suggested in this patch, we have to modify the default
> > behavior for bus errors: By default the firmware will not send bus
> > errors, but only if GS_CAN_MODE_BERR_REPORTING is requested during
> > open().
> >=20
> > I'm not sure if we want to change the default behavior of the
> > firmware....To work around this backwards compatibility issue we can
> > explicitly turn BERR reporting on or off during open via
> > GS_CAN_MODE_BERR_REPORTING_ON or GS_CAN_MODE_BERR_REPORTING_OFF.
> >=20
> > What do you think?
> >=20
> Personally, I wouldn't care about backward compatibility, it was added
> later on despite they know it should be a socketcan option, see [1] and
> for most if not all users, having error frames on a bit level / crc misma=
tch
> level is only annoying, unless you are really looking deep into problems
> and then enabling a simple flag isn't your biggest problem, especially not
> if it is a documented/common flag which is supposed to do exactly that.
>=20
> Obviously state changes are still send after my changes to candleLight
> are accepted without bit error reporting being set.
>=20
> So yes afaiac berr-reporting is simply turned off by default. Unless there
> really are users which need them and can't simply set a single bit; my
> guess there isn't any of them.

Makes sense. If a user is interested in debugging such low level
problems a firmware update should be no problem and is suggested
anyways.

Let's keep your original logic, where bus error reporting
is disabled by default.

I'll try to find time to look into your firmware changes later this
week.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ivfqvzfzdmxiflaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNDwxkACgkQrX5LkNig
010lXwf7BZ8KHVsVnBQ3dyhJqhqwZESHlDPJARD84di4/7JhN++NWu4hhC0FLMIP
Au69GJwv3FLLuAsATcCff5LfMvwji88pfNaW6YnUz3GY7f/Ue6FLc5WpORVxdJPm
2MFY1aYt4cNbWwU/QO4Tc0Dsq9dVSOoihioHrX1YPaSgrXTV5DSfBkryEGaccjgr
ofwb0xamUw/b03huAxYzUlMLbAA7yeE98ZucTO23p0Q3RpMs6boJgglCtMTdKYci
4j8deNaPIt+XC/g7mK007WJoMlt2xRcZVBaqwLvlZ7TCa+ybfA9MbxRAHM/RDV7T
wITvthiAgvMdREhrk2PXjkl2uObYKA==
=OmCS
-----END PGP SIGNATURE-----

--ivfqvzfzdmxiflaw--
