Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556CD4E644B
	for <lists+linux-can@lfdr.de>; Thu, 24 Mar 2022 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbiCXNrL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Mar 2022 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350545AbiCXNrK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Mar 2022 09:47:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284288B27
        for <linux-can@vger.kernel.org>; Thu, 24 Mar 2022 06:45:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nXNmN-00023N-Bw; Thu, 24 Mar 2022 14:45:31 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-3ab7-c980-9798-01be.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:3ab7:c980:9798:1be])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D7E0852B2B;
        Thu, 24 Mar 2022 13:45:00 +0000 (UTC)
Date:   Thu, 24 Mar 2022 14:45:00 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        manivannan.sadhasivam@linaro.org
Subject: Re: can-next 2022-03-13: mcp251xfd: add coalescing support
Message-ID: <20220324134500.bmxil6dyvwraqent@pengutronix.de>
References: <20220313083640.501791-1-mkl@pengutronix.de>
 <DM4PR11MB539016D37DC0A025799B809BFB189@DM4PR11MB5390.namprd11.prod.outlook.com>
 <20220323140347.hkuklvkefvb4l6l5@pengutronix.de>
 <DM4PR11MB5390224F4ABAED6DFC430266FB189@DM4PR11MB5390.namprd11.prod.outlook.com>
 <20220323192858.pixhyf2jzah7eqiv@pengutronix.de>
 <DM4PR11MB53902541ACA7F003887D7915FB199@DM4PR11MB5390.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqbdlljq3xda5lyz"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB53902541ACA7F003887D7915FB199@DM4PR11MB5390.namprd11.prod.outlook.com>
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


--nqbdlljq3xda5lyz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.03.2022 12:28:10, Thomas.Kopp@microchip.com wrote:
> Hrm, good point. Now with frequency scaling set to performance I don't
> see the difference anymore and see a consistent 2 SPI interrupts per
> CAN-FD message. So at least in performance mode this seems to be the
> same. Would be interesting to see the effects on a weaker system than
> the Pi4.
>=20
> In CAN-FD mode I can't get the driver to allocate less than 1 Fifo
> with a depth of 16 to RX. Is that intended?

Yes, take a look at:

| const struct can_ram_config mcp251xfd_ram_config

The struct describes the hardware and gives configuration constraints.
E.g. the minimum RX is set to 16.

> I.e. I try to use ethtool -G can0 rx 8 tx 8 and it still leads to the
> following setup:
>=20
> FIFO setup: TEF:         0x400:  8*12 bytes =3D   96 bytes
> FIFO setup: RX-0: FIFO 1/0x418: 16*76 bytes =3D 1216 bytes
> FIFO setup: TX:   FIFO 2/0x8d8:  8*72 bytes =3D  576 bytes
> FIFO setup: free:                              160 bytes

=46rom my point of view a lower value for RX brings more negative impact
(RX FIFO overflows, etc...), than the increase of TX buffers from 8 to
16 brings positive impact (increased CAN bus load).

If there are use cases where 16 TX buffers are beneficial, I'm happy to
discuss them and change the defaults.

BTW: There are other/better TX optimizations options like implementing
TX byte queue limits with netdev_xmit_more() support.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nqbdlljq3xda5lyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI8ddkACgkQrX5LkNig
011jnAf7BOq/GCw+T/k1h5dKQtpXAVfQ5nWQ8g7+DyNJBxVWCvVl29n0EPkgNd2F
+Qu02QFOy79N1s/w18/p43bJNspMnoAgHXCHcxZJlV0ebxnNt9JAIq+ZXgkpyjnK
vR/zYPKPl2uvcUq4+vCFn9W39U0062r/F5QonCJVkn07mljQ0QXoYFRGHd1A+X4s
lJFzSWX8MNJWJs2X3jWz++2E2NGK6vKKXOpGVmeUCt/7Ax1uJfrjEB9chjrd1821
wI58ZtbfhgHt+EbXIThHt1IMWcGNzzYUubYmTDV/BHZRa51aSlmGqKg82uvMA8hC
3++EctNVezPzlhnZOvc0GMrqah2pwg==
=5zSA
-----END PGP SIGNATURE-----

--nqbdlljq3xda5lyz--
