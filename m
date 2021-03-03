Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3765532C593
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 01:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355365AbhCDAXl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835026AbhCCIC7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 03:02:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCBCC0617AB
        for <linux-can@vger.kernel.org>; Tue,  2 Mar 2021 23:48:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHMFQ-0003Ie-1Y; Wed, 03 Mar 2021 08:48:44 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a20d:2fb6:f2cb:982e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EAE9D5ECA3C;
        Wed,  3 Mar 2021 07:48:42 +0000 (UTC)
Date:   Wed, 3 Mar 2021 08:48:41 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?dWtyZm9pbC5jb20sIEPRgtGD0LTQuNC+0L/QsNC6INCj0LrRgNCw0LjQvdCw?=
         =?utf-8?B?LCDQktC+0YHRgtC+0YfQvdGL0Lkg0YDQtdCz0LjQvtC9?= 
        <ukrfoil@gmail.com>
Cc:     =?utf-8?B?U2NobMO8w59sZXIs?= Timo <t.schluessler@krause.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: mcp251x hangs during ifup
Message-ID: <20210303074841.me5egjpecebrpxc4@pengutronix.de>
References: <20210301165856.37gvqkomvjkjvbj2@pengutronix.de>
 <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
 <20210302071901.ptwvejkedascbdsv@pengutronix.de>
 <638520bccd0c44d091d5715fe7d303ec@HG-SRV-053.HG.local>
 <CACGOs=TG4jyXKHBfPGDEJp1gSA+PyNVqCM7grPGMpe9+wYDBLA@mail.gmail.com>
 <20210303072653.zb66tkdlsxtval5n@pengutronix.de>
 <CACGOs=TJhoV99D=V-7xa8LG6Ftx8SWUO_XCHGAP3L1_UGLVm3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qjyipyfts5bxvvcy"
Content-Disposition: inline
In-Reply-To: <CACGOs=TJhoV99D=V-7xa8LG6Ftx8SWUO_XCHGAP3L1_UGLVm3w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qjyipyfts5bxvvcy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2021 09:44:54, ukrfoil.com, C=D1=82=D1=83=D0=B4=D0=B8=D0=BE=D0=BF=
=D0=B0=D0=BA =D0=A3=D0=BA=D1=80=D0=B0=D0=B8=D0=BD=D0=B0, =D0=92=D0=BE=D1=81=
=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=B3=D0=B8=D0=BE=D0=BD w=
rote:
| root@nanopi-neo:~#cat /proc/interrupts
|            CPU0       CPU1       CPU2       CPU3     =20
|  25:          0          0          0          0     GICv2  50 Level     =
timer@1c20c00
|  26:          0          0          0          0     GICv2  29 Level     =
arch_timer
|  27:    1696369    3348041    3820461      82777     GICv2  30 Level     =
arch_timer
|  30:          0          0          0          0     GICv2  82 Level     =
1c02000.dma-controller
|  32:       5404          0          0          0     GICv2  92 Level     =
sunxi-mmc
|  34:          0          0          0          0     GICv2 103 Level     =
musb-hdrc.2.auto
|  35:          0          0          0          0     GICv2 104 Level     =
ehci_hcd:usb1
|  36:          0          0          0          0     GICv2 105 Level     =
ohci_hcd:usb2
|  37:          0          0          0          0     GICv2 110 Level     =
ehci_hcd:usb3
|  38:          0          0          0          0     GICv2 111 Level     =
ohci_hcd:usb4
|  42:       9952          0          0          0     GICv2 114 Level     =
eth0
|  43:          4          0          0          0     GICv2  97 Level     =
sun6i-spi
|  46:         49          0          0          0     GICv2  32 Level     =
ttyS0
|  47:  211302239          0          0          0     GICv2  38 Level     =
mv64xxx_i2c
|  48:   18992623          0          0          0     GICv2  39 Level     =
mv64xxx_i2c
|  49:          0          0          0          0     GICv2  72 Level     =
1f00000.rtc
|  63:          0          0          0          0     GICv2 152 Level     =
arm-pmu
|  64:          0          0          0          0     GICv2 153 Level     =
arm-pmu
|  65:          0          0          0          0     GICv2 154 Level     =
arm-pmu
|  66:          0          0          0          0     GICv2 155 Level     =
arm-pmu
| 111:          1          0          0          0  sunxi_pio_edge  44 Edge=
      usb0-id-det
| IPI0:          0          0          0          0  CPU wakeup interrupts
| IPI1:          0          0          0          0  Timer broadcast interr=
upts
| IPI2:         47         88         79         82  Rescheduling interrupts
| IPI3:     304963    2353917     362091       1661  Function call interrup=
ts
| IPI4:          0          0          0          0  CPU stop interrupts
| IPI5:          0          0          0          0  IRQ work interrupts
| IPI6:          0          0          0          0  completion interrupts
| Err:          0
[...]
| root@nanopi-neo:~#cat /proc/interrupts
|            CPU0       CPU1       CPU2       CPU3     =20
|  25:          0          0          0          0     GICv2  50 Level     =
timer@1c20c00
|  26:          0          0          0          0     GICv2  29 Level     =
arch_timer
|  27:    1711040    3437940    3850320      84900     GICv2  30 Level     =
arch_timer
|  30:          0          0          0          0     GICv2  82 Level     =
1c02000.dma-controller
|  32:       5516          0          0          0     GICv2  92 Level     =
sunxi-mmc
|  34:          0          0          0          0     GICv2 103 Level     =
musb-hdrc.2.auto
|  35:          0          0          0          0     GICv2 104 Level     =
ehci_hcd:usb1
|  36:          0          0          0          0     GICv2 105 Level     =
ohci_hcd:usb2
|  37:          0          0          0          0     GICv2 110 Level     =
ehci_hcd:usb3
|  38:          0          0          0          0     GICv2 111 Level     =
ohci_hcd:usb4
|  42:      10190          0          0          0     GICv2 114 Level     =
eth0
|  43:         18          0          0          0     GICv2  97 Level     =
sun6i-spi
|  46:         49          0          0          0     GICv2  32 Level     =
ttyS0
|  47:  214592622          0          0          0     GICv2  38 Level     =
mv64xxx_i2c
|  48:   19314189          0          0          0     GICv2  39 Level     =
mv64xxx_i2c
|  49:          0          0          0          0     GICv2  72 Level     =
1f00000.rtc
|  63:          0          0          0          0     GICv2 152 Level     =
arm-pmu
|  64:          0          0          0          0     GICv2 153 Level     =
arm-pmu
|  65:          0          0          0          0     GICv2 154 Level     =
arm-pmu
|  66:          0          0          0          0     GICv2 155 Level     =
arm-pmu
| 107:          1          0          0          0  sunxi_pio_edge  40 Edge=
      spi0.0
| 111:          1          0          0          0  sunxi_pio_edge  44 Edge=
      usb0-id-det
| IPI0:          0          0          0          0  CPU wakeup interrupts
| IPI1:          0          0          0          0  Timer broadcast interr=
upts
| IPI2:         48         88         85         83  Rescheduling interrupts
| IPI3:     305542    2828247     362982       1704  Function call interrup=
ts
| IPI4:          0          0          0          0  CPU stop interrupts
| IPI5:          0          0          0          0  IRQ work interrupts
| IPI6:          0          0          0          0  completion interrupts
| Err:          0

That looks good, the IRQ is not shared. Can you test again with
IRQ_TYPE_EDGE_FALLING in the DT instead of IRQ_TYPE_LEVEL_LOW?

| can0: can@0 {
|       reg =3D <0>;
|       compatible =3D "microchip,mcp2515";
|       pinctrl-names =3D "default";
|       pinctrl-0 =3D <&can0_pin_irq>;
|       interrupt-parent =3D <&pio>;
|       interrupts =3D <6 8 IRQ_TYPE_EDGE_FALLING>;

You better use IRQ_TYPE_LEVEL_LOW instead of IRQ_TYPE_EDGE_FALLING, but
that's unrelated to this problem.

|       clocks =3D <&can0_osc_fixed>;
|       spi-max-frequency =3D <10000000>;
|       gpio-controller;
|       gpio-cells =3D <2>;
|       status =3D "okay";
| };

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qjyipyfts5bxvvcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA/P1cACgkQqclaivrt
76m7sAgAtZCTxGrSYfQ8PvrIsO0qZ2XzTPwF/CdoTtdrhK/kxwyS1qzv2vmIbBrf
AiI91vxlU1vqGbmPxHUemmVhHEUOq4NdjgW/w6Qas1ZX3k+eYLAnTQ/XTxEDxqlD
YqrAu2BDTygaa2LvwCXwzBN54xfjXsq1Gc83xolWrhhVkuv3h0mu+CsssNnEhL+u
PqAOwlUPPiEJRQ5HbvkXP4QpvADaBumHyOVZWZENLltBHU/SMOKGTFKkfZ2BOZwa
1XPO7+njU4gq7+8rNdK2yRbxh/gXRT0ISCBzSRo9rfUAu3+TKgVxzTrJ8rQ3e6Zi
bsZKBkJKfAPUloNNLUzL71RhzgfGDQ==
=iK8p
-----END PGP SIGNATURE-----

--qjyipyfts5bxvvcy--
