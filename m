Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474B454F905
	for <lists+linux-can@lfdr.de>; Fri, 17 Jun 2022 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiFQOR5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jun 2022 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFQOR5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2022 10:17:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58942C10A
        for <linux-can@vger.kernel.org>; Fri, 17 Jun 2022 07:17:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o2CnI-0000pz-NP; Fri, 17 Jun 2022 16:17:52 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0B72B986A5;
        Fri, 17 Jun 2022 14:17:51 +0000 (UTC)
Date:   Fri, 17 Jun 2022 16:17:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: ram initialization on mcp2518fd
Message-ID: <20220617141751.ua3emcdaarrnx7si@pengutronix.de>
References: <e3f73c56-1b46-4ee9-357e-40400c746e09@prevas.dk>
 <87wndgyl2l.fsf@hardanger.blackshift.org>
 <441514ec-7b43-e11c-09b5-bdaf7fca0077@prevas.dk>
 <d614f497-b8f2-68cd-745b-1e3be2b991d5@prevas.dk>
 <20220616124056.cnnvlqwwkknjta7w@pengutronix.de>
 <8db56a87-a1c7-1810-ad74-c7a8e268a00d@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r4svecx46yzhh3ie"
Content-Disposition: inline
In-Reply-To: <8db56a87-a1c7-1810-ad74-c7a8e268a00d@prevas.dk>
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


--r4svecx46yzhh3ie
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.06.2022 16:01:56, Rasmus Villemoes wrote:
> >>> Have you enabled DMA on SPI?
> >>
> >> Not explicitly, but nor have I done anything to disable/not enable it,
> >> so I'm not really sure what the right answer is. Is that a CONFIG_ knob
> >> or module/kernel parameter?
> >=20
> > You can use "/delete-property/ dmas;" and "/delete-property/ dma-names;"
> > in your board dts on the &ecspi1 node, the module parameter "use_dma=3D=
0",
> > or the kernel command line "spi-imx.use_dma=3D0" to disable DMA.
> >=20
> > The SPI host driver uses PIO for smaller transfers, but switches to DMA
> > mode for bigger ones (IIRC > 64 bytes). The clearing of the memory
> > definitely falls into the big transfer category. The SPI DMA mode is
> > broken on various kernel variants (downstream, mainline), kernel
> > versions, SoC variants and used SDMA firmware versions. For the
> > mcp251xfd driver DMA is also slower. So switch of DMA and try again.
>=20
> Thanks! Disabling DMA did the trick, and I can now send traffic back and
> forth between the two chips, and since the RAM now gets properly
> initialized, I also don't get the ecc error interrupts.

\o/

> There is still something to be looked at, since I see
>=20
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!=
!!

Update to a newer kernel. In v5.15 this problem is fixed.

> when I start the traffic test. And the dev_id reading still doesn't
> work (though it's not really used for anything other than an
> informative printk).

What does it read on your board? But still that transfer should work.

> But I'll have to get our hardware guys to help me do some soldering to
> capture all four channels at once to see just exactly what is going on
> there.

Have a look at these: https://sensepeek.com/pcbite_20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--r4svecx46yzhh3ie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKsjQsACgkQrX5LkNig
011olwf/YUPvhU/YpW+i/DK2AH786xWq98rOo/2GCVsvKdOxyBA3dimnFqjg8Bjz
rCjTy7spQQov1Iztyr8qMt4U6CWOS0QfJHJFoLPv9kqIkG+ewMGtYSjKCpAC0mfd
b2jNpYNURVLmzzqwsTk80pghwFvNUqdF9KK6rIKVNkW6/qnngQmmI62wP9d/rdpK
PxWfdnx5KxNr+/f6awOvLnS3/xun9dV/iawbwzOvQ6g2CbU2+jJfbfeXg/o9qkTc
djwO5trNV47cmtJhU0B4PlXJ3q0kQeWRZazOrDeNjwQQLSNWsYzOP1m1EEsNzrYy
DmSlfacIl7c3xs+vgmfkTYDp3uMEGA==
=W0KS
-----END PGP SIGNATURE-----

--r4svecx46yzhh3ie--
