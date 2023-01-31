Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C968322E
	for <lists+linux-can@lfdr.de>; Tue, 31 Jan 2023 17:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjAaQFF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Jan 2023 11:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjAaQFC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2023 11:05:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFCE4B181
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 08:04:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pMt7m-0006K2-Gd; Tue, 31 Jan 2023 17:04:46 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:29f7:a2fc:d3f6:7550])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2049716A584;
        Tue, 31 Jan 2023 16:04:45 +0000 (UTC)
Date:   Tue, 31 Jan 2023 17:04:36 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        mark@baggywrinkle.co.uk
Subject: Re: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of
 min3()
Message-ID: <20230131160436.2vfszb3qqsyx3ea7@pengutronix.de>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
 <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dsqwaygaza7kvbac"
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


--dsqwaygaza7kvbac
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Finally I've found some time to look at this again...

On 12.09.2022 17:28:15, Vincent Mailhol wrote:
> Also, I was assuming that can_fixup_bittiming() was already doing the
> out of range check:
> https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/net/can/dev/bitt=
iming.c#L27
>
> But in reality, only one of either can_calc_bittiming(),
> can_fixup_bittiming() or can_validate_bitrate() is being called. And
> thus, can_validate_bitrate() might be called with out of range values
> and in that case the neltink interface should return -ERANGE (for
> example if sjw > sjw_max).
>
> Sees that there is more work to do here than initially anticipated.

I've converted the existing netdev_err() NL_SET_ERR_MSG_FMT(). This
means the error message is transported via netlink to user space and
printed by the "ip" tool.

| # ip link set flexcan0 txqueuelen 10 type can bitrate 2200000
| Warning: bitrate error 2.5%.
|=20
| # ip link set flexcan0 txqueuelen 10 type can bitrate 22000000
| Error: bitrate error 80.5% too high.

This is the error message for the SJW check:

| # ip link set flexcan0 txqueuelen 10 type can bitrate 500000 sjw 3
| Error: SJW 3 bigger than phase_seg1 6 and/or phase_seg2 2.

Maybe add a '=3D' between the phase_seg and the actual number:

| Error: SJW 3 bigger than phase_seg1=3D6 and/or phase_seg2=3D2.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dsqwaygaza7kvbac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPZPBIACgkQrX5LkNig
013/QQf9Fi5CJV72FgVk9UyS4zkO7uvJQx4/2X2ZZ1sUJYVk4cJvToAwsEh8pjsq
hfSfQZpR6Z43eATffMfDrazAhBp/KyZSWAI7d5aMnOubKlqEam+kH7KKno4pX/23
KyFDejt8Azw/2+MzmkevEgun3dxXXqn07OOYhk5L2A4DmXD4wrNeNhQzoPSbTRT3
EcEl0EU46P20WV0Y1/5nsDgB+Q9yGNaGaUugvCDBP3Tv00HX1q6MMQNhwo6Tp5DI
jSxhmEnGbAkL3ULZ/iprxU4UVEHX+i2ceLWEfjM9rlOFy5u1JVBVr6Ec7lLTwvFw
MJIoPhlRtRnHtbcEoW/uhWTv19ZXpg==
=Zw7t
-----END PGP SIGNATURE-----

--dsqwaygaza7kvbac--
