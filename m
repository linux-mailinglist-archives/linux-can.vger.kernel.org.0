Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A94686256
	for <lists+linux-can@lfdr.de>; Wed,  1 Feb 2023 10:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjBAJGQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 1 Feb 2023 04:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBAJGM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2023 04:06:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD815D91A
        for <linux-can@vger.kernel.org>; Wed,  1 Feb 2023 01:06:10 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pN94B-0001i9-0o; Wed, 01 Feb 2023 10:06:07 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:8296:86a1:ae4c:835e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2E8BE16C06E;
        Wed,  1 Feb 2023 09:06:06 +0000 (UTC)
Date:   Wed, 1 Feb 2023 10:05:57 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        mark@baggywrinkle.co.uk
Subject: Re: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of
 min3()
Message-ID: <20230201090557.qxgmygovuts5ttyh@pengutronix.de>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
 <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j72fop7oy55nasbl"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com>
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


--j72fop7oy55nasbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.09.2022 17:28:15, Vincent Mailhol wrote:
> > > Not directly a criticism of this patch (as things were already like
> > > that), but if the user provides an incorrect value for SJW (or any
> > > other bittiming argument), wouldn't it be better to inform? Returning
> > > -EINVAL might be too violent. Maybe a dmesg would be good?
> >
> > I'd say it would be consistent to keep returning -EINVAL (at least for =
the SJW>(min p1,p2)) condition.
> >
> > The same is done for FD Bitrate < Arbitration bitrate and both conditio=
ns have the same level of justification in the ISO 11898-1:2015
> > "The data bit time shall have the same length as the nominal bit time o=
r it shall be shorter than the nominal bit time."
> >
> > "In nominal bit time and in data bit time, SJW shall be less than or eq=
ual to the minimum of these two items: Phase_Seg1 and Phase_Seg2."
> >
> > Shall is a binding requirement to be ISO conformant in this case.
>=20
> What you say makes sense.
>=20
> Also, I was assuming that can_fixup_bittiming() was already doing the
> out of range check:
> https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/net/can/dev/bitt=
iming.c#L27
>=20
> But in reality, only one of either can_calc_bittiming(),
> can_fixup_bittiming() or can_validate_bitrate() is being called. And
> thus, can_validate_bitrate() might be called with out of range values
> and in that case the neltink interface should return -ERANGE (for
> example if sjw > sjw_max).
>=20
> Sees that there is more work to do here than initially anticipated.

If you configure the bitrate + sjw there will be a check for sjw within
the limits (< sjw_max, < min(phase_seg1, phase_seg2)).

If you configure the low level timing parameters there will be limit
checks on the user supplied phase_seg1, phase_seg2 and sjw and a limit
check on the calculated brp.

What should be the return value if these checks fail?

I think it's best to always return -EINVAL and set an error message with
NL_SET_ERR_MSG_FMT().

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--j72fop7oy55nasbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPaK3IACgkQrX5LkNig
013btwf/cY9GpaFQ67P3RIdXQBJaGA5a2cIURm8mTmpcmamH8BDUvsFKF2aJF/xq
PMa7fqY+WLkauxrLLYU4V0Ul9tmVPGwlVLTV3Ykpja7C6QgjB9w8XC30rd9ggIHp
1UYCC1cWfEgqMbPtPgK3FOsmgQQ63SJgIAIn/iKOS+ZohMH4t0sImVVpZ06LeVci
8FC/cRvJw029Qj3ZPuxSyfCDajErB71YT9WE52NHKd3X3fxGJji+rZGzqc3ZWbs8
1wCqfzROgAayuNyrcTDJod6N3Rk3LWmQWeWcjBPDzlSB20JAnjkOgs7lywryd3Dn
2PNaWRU+f5FxRWbjGVfd6O1UEEdrXg==
=wcQv
-----END PGP SIGNATURE-----

--j72fop7oy55nasbl--
