Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7E7B7E6A
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjJDLnC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJDLnB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 07:43:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB0D3
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 04:42:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qo0HI-0000zB-Pp; Wed, 04 Oct 2023 13:42:56 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qo0HI-00B1Dj-Cm; Wed, 04 Oct 2023 13:42:56 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 194D122EDF9;
        Wed,  4 Oct 2023 11:42:56 +0000 (UTC)
Date:   Wed, 4 Oct 2023 13:42:55 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 01/27] can: dev: add can_state_get_by_berr_counter() to
 return the CAN state based on the current error counters
Message-ID: <20231004-mowing-sharpness-93c1f82b29ea-mkl@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
 <20231004-at91_can-rx_offload-v1-1-c32bf99097db@pengutronix.de>
 <CAMZ6RqL7EUeYeBB3XUvZeL=bMNzSOPSEoTB7R5D8CTLFz1n+Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sirfmrb43hecf332"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqL7EUeYeBB3XUvZeL=bMNzSOPSEoTB7R5D8CTLFz1n+Mg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--sirfmrb43hecf332
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.10.2023 19:50:55, Vincent Mailhol wrote:
> On Wed. 4 Oct. 2023, 18:24, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > Some CAN controllers do not have a register that contains the current
> > CAN state, but only a register that contains the error counters.
> >
> > Introduce a new function can_state_get_by_berr_counter() that returns
> > the current TX and RX state depending on the provided CAN bit error
> > counters.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/can/dev/dev.c | 22 ++++++++++++++++++++++
> >  include/linux/can/dev.h   |  4 ++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> > index 7f9334a8af50..6242424fadbc 100644
> > --- a/drivers/net/can/dev/dev.c
> > +++ b/drivers/net/can/dev/dev.c
> > @@ -90,6 +90,28 @@ const char *can_get_state_str(const enum can_state s=
tate)
> >  }
> >  EXPORT_SYMBOL_GPL(can_get_state_str);
> >
> > +static enum can_state can_state_err_to_state(u16 err)
> > +{
> > +       if (err < 96)
> > +               return CAN_STATE_ERROR_ACTIVE;
> > +       if (err < 128)
> > +               return CAN_STATE_ERROR_WARNING;
> > +       if (err < 256)
> > +               return CAN_STATE_ERROR_PASSIVE;
>=20
> Please use the macros from include/uapi/linux/can/error.h.
>=20
>   https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can/e=
rror.h#L130

Done.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sirfmrb43hecf332
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdT70ACgkQvlAcSiqK
BOj3Qgf+JTlxB6CwhqqvvuwT820BlTxl9/uOFDRAD7g4wog2EGNF9RxH1zCdo0+y
mEOrjbegxQi30CqgYAdvm1I/24weyMEWqVwX/Jx3y8sm3JSOAbkn0PmJyOKQF+L3
y/v7jfgrYvO3LCS8m1fS8jvQbF6saXzjD9EFWTOw/H0eUinXMbsxiqQSwT6tAcQh
SfIxdMqwOBGFuHMgsR70ZgyI2QfmOII/kuqZ3uxrd9GnpFz6rKHZor9iqWzgBuOK
EuPSWAh9pkM/K8cawxdB+eB6s2oBVmu87VXsMcKo2sefUT7p6qEnd+Wx/5vPPVnw
UF/36DY+0oUkeG6Zq+Ff0eBiQnrxJw==
=puAW
-----END PGP SIGNATURE-----

--sirfmrb43hecf332--
