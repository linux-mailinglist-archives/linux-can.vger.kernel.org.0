Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695FF687CE1
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 13:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBBMHv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 07:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBBMHu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 07:07:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42FE3F28D
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 04:07:49 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNYNX-0007Bd-B0; Thu, 02 Feb 2023 13:07:47 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C24D616D453;
        Thu,  2 Feb 2023 12:07:46 +0000 (UTC)
Date:   Thu, 2 Feb 2023 13:07:38 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
        kernel@pengutronix.de, Mark Bath <mark@baggywrinkle.co.uk>
Subject: Re: [PATCH v2 14/17] can: bittiming: can_sjw_set_default(): use
 Phase Seg2 / 2 as default for SJW
Message-ID: <20230202120738.3f3amaj5bdntjmhc@pengutronix.de>
References: <20230202110854.2318594-1-mkl@pengutronix.de>
 <20230202110854.2318594-15-mkl@pengutronix.de>
 <CAMZ6Rq+5AKC2X+vNwbs0wvTGbx1zssF8tTS4TdhxnOH0=6nhrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vanpiwzhnz5h5epg"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+5AKC2X+vNwbs0wvTGbx1zssF8tTS4TdhxnOH0=6nhrw@mail.gmail.com>
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


--vanpiwzhnz5h5epg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.02.2023 20:57:42, Vincent Mailhol wrote:
> On Thu. 2 Feb 2023 at 20:09, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > "The (Re-)Synchronization Jump Width (SJW) defines how far a
> >  resynchronization may move the Sample Point inside the limits defined
> >  by the Phase Buffer Segments to compensate for edge phase errors." [1]
> >
> > In other words, this means that the SJW parameter controls the CAN
> > controller's tolerance to frequency errors compared to other CAN
> > controllers.
> >
> > If the user space doesn't provide a SJW parameter, the
> > kernel chooses a default value of 1. This has proven to be a good
> > default value for CAN controllers, but no longer for modern
>                     ^^^^^^^^^^^^^^^
> > controllers.
>=20
> Are you missing a word here? You oppose CAN controllers to modern
> ones.
>=20
> I think the point is Classical CAN only controllers vs. CAN-FD
> controllers. A CAN-FD controller is able to sample at bitrates up to 5
> or 8 Mbits and have maximum bitimming values five or eight times the
> ones of a Classical CAN only controller (which is only capable of
> sampling 1 Mbits).
>=20
> I propose this instead:
>=20
>   This has proven to be a good default value for Classical CAN
>   controllers, but no longer for modern CAN-FD ones.

The difference that matters here is not that the controllers support
CAN-FD, but that they have a much greater max tseg{1,2} compared to the
sja1000. But that's only the case on CAN-FD controller.

Will change the description as you proposed!

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vanpiwzhnz5h5epg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPbp4cACgkQvlAcSiqK
BOj4CAf/bLen0uPo3mzJS9u2tUXc2HFacUUszsFfxLi23548mLfnX7lAMoFPOA9K
h0lWlWBeub9Z8T6fqAy7i1E9ePCtD5A3gLV3FWPFbb197xWWg9QF0YZDf/WXmNrO
UjysLhKt5Ym/s3Am7qXyV3P9F/Y1j1WB9hdem12j9S3Heq6/knYPdWRnOPU83DPE
TnWVvDpPCaj0AAQTUlOkPMmdPnSd36Akowci0QKnDX+sn7bdpa71KfpDIPDBlUV6
g9Hy/Oxx+trSNDSdrfXBH6wdzXa8nJyUcrmh8zJyo878sh+GTwGgcNA39fTXQSl6
HdEcvdtNXyWF1uClrnmUHF6C2vbLLw==
=C6HN
-----END PGP SIGNATURE-----

--vanpiwzhnz5h5epg--
