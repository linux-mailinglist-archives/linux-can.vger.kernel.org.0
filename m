Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18DA5F9A51
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 09:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiJJHqD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 03:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiJJHpm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 03:45:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F0867444
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 00:42:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ohn3L-00023y-Di; Mon, 10 Oct 2022 09:18:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 37F55F8F21;
        Mon, 10 Oct 2022 07:03:21 +0000 (UTC)
Date:   Mon, 10 Oct 2022 09:03:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 4/6] can: gs_usb: add ability to enable / disable berr
 rerporting
Message-ID: <20221010070319.kcmv2zo5gzd6uohx@pengutronix.de>
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162452.200322-5-mkl@pengutronix.de>
 <20221006163650.b6n2g44kl5d3ptq4@pengutronix.de>
 <6c4445d4-e494-4cbf-3b74-e6db4f37d522@victronenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="alpxxskujg2e5ohl"
Content-Disposition: inline
In-Reply-To: <6c4445d4-e494-4cbf-3b74-e6db4f37d522@victronenergy.com>
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


--alpxxskujg2e5ohl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.10.2022 00:11:49, Jeroen Hofstee wrote:
> Hi,
>=20
> On 10/6/22 18:36, Marc Kleine-Budde wrote:
> > On 06.10.2022 18:24:50, Marc Kleine-Budde wrote:
> > > From: Jeroen Hofstee <jhofstee@victronenergy.com>
> > >=20
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
>=20
> It would look like this, untested:
>=20
> subject: can: gs_usb: add ability to enable / disable berr rerporting
>=20
> The open source firmware candleLight report bus errors
> unconditionally. This adds support to enable / disable bus error
> reporting with the standard netlink property.
>=20
> Signed-off-by: Jeroen Hofstee <jeroen@myspectrum.nl>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> =C2=A0drivers/net/can/usb/gs_usb.c | 18 +++++++++++++++++-
> =C2=A01 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 7c1f13a90419..039e8d91ad88 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -135,6 +135,13 @@ struct gs_device_config {
> =C2=A0/* GS_CAN_FEATURE_BT_CONST_EXT BIT(10) */
> =C2=A0/* GS_CAN_FEATURE_TERMINATION BIT(11) */
>=20
> +/* Previous versions of this driver didn't support the berr-reporting fl=
ag,
> + * this flag tells if berr-reporting is supported. When not set, the dev=
ice
> + * can default to its own preference to be backwards compatible.
> + */
> +#define GS_CAN_MODE_BERR_REPORTING_SET BIT(12)
> +#define GS_CAN_MODE_BERR_REPORTING BIT(13)

You've convinced me :) This is overengineered, and it "breaks" the nice
1-to-1 mapping of feature and mode bits :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--alpxxskujg2e5ohl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNDw7UACgkQrX5LkNig
010cUQf/V63o30hOfVyvo+FFpzlgc1DeqdW/z2nC1nrK/bBYWcrCVcOZxrnWZEa5
3DNgIbbwTDksgmEToU67vAF//QeBO/1bIHRHOTk0dl4Lm78j9B2w6DqjUoPl47TS
n2mT5gLOdWu6FFQmdkZyP+ywWvXx3OzmmsboczaFFwyGWFHCSF5CbW6tSQx8tJPJ
ZRqOduGzqmV0H1pJsn9MgIndErJZYe1cbrid4lSOPgObG/k/yyBmM86QqpT3+ler
lhmn52lGW8brrSVNFou4CE2UTKW6an378S4E6C8WiMLiRZ3KZAuzVnxrEmew1E3K
gS+ozPLx7ulkva5uf9b4nq8ZB3mCBA==
=fZwN
-----END PGP SIGNATURE-----

--alpxxskujg2e5ohl--
