Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CEE706A10
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEQNjY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjEQNjX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 09:39:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454D524C
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 06:39:20 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzHN8-0008H8-W6
        for linux-can@vger.kernel.org; Wed, 17 May 2023 15:39:19 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 69D801C7288
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 13:39:18 +0000 (UTC)
Date:   Wed, 17 May 2023 15:36:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: Re: [netdev-net:main 50/55] Error:
 arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
Message-ID: <20230517-blighted-scowling-352ffbea5190-mkl@pengutronix.de>
References: <202305172130.eGGEUhpi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o2goxmpnvvbsn7zv"
Content-Disposition: inline
In-Reply-To: <202305172130.eGGEUhpi-lkp@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--o2goxmpnvvbsn7zv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good Bot!

On 17.05.2023 21:21:58, kernel test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
> head:   6ad85ed0ebf7ece0f376950a6b3b3c6048093d35
> commit: 0920ccdf41e3078a4dd2567eb905ea154bc826e6 [50/55] ARM: dts: stm32:=
 add CAN support on stm32f746
> config: arm-randconfig-r034-20230517
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/=
commit/?id=3D0920ccdf41e3078a4dd2567eb905ea154bc826e6
>         git remote add netdev-net git://git.kernel.org/pub/scm/linux/kern=
el/git/netdev/net.git
>         git fetch --no-tags netdev-net main
>         git checkout 0920ccdf41e3078a4dd2567eb905ea154bc826e6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Darm olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305172130.eGGEUhpi-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
> >> Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
> >> FATAL ERROR: Unable to parse input tree

Doh!

The stm32f7-rcc.h is missing the definition for CAN3.

| 		can3: can@40003400 {
| 			compatible =3D "st,stm32f4-bxcan";
| 			reg =3D <0x40003400 0x200>;
| 			interrupts =3D <104>, <105>, <106>, <107>;
| 			interrupt-names =3D "tx", "rx0", "rx1", "sce";
| 			resets =3D <&rcc STM32F7_APB1_RESET(CAN3)>;
| 			clocks =3D <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
| 			st,gcan =3D <&gcan3>;
| 			status =3D "disabled";
| 		};
|=20
| 		gcan3: gcan@40003600 {
| 			compatible =3D "st,stm32f4-gcan", "syscon";
| 			reg =3D <0x40003600 0x200>;
| 			clocks =3D <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
| 		};
|=20

| $ git grep CAN include/dt-bindings/mfd/stm32f7-rcc.h
| include/dt-bindings/mfd/stm32f7-rcc.h:78:#define STM32F7_RCC_APB1_CAN1   =
        25
| include/dt-bindings/mfd/stm32f7-rcc.h:79:#define STM32F7_RCC_APB1_CAN2   =
        26

Dario, do you have a fix at hand?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--o2goxmpnvvbsn7zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRk2F8ACgkQvlAcSiqK
BOiHswf+OmL/Kwk66FYE+/7sP3GdU9P2r277b3TtvVucWk4mjwti30Q3DYQg3TyK
CLA3dYow/uQl3Spxy5YKRHI4Rc2VnTOyRnqMYi6LKE9FrergvWdIXTP0vYKYUPCg
E18XN8ClNr2Y0PzGUonX2Wlj+UfLG4LVUlaJuKc8D+jxEyhNwzdxuoS3qILQv4dR
Ty0dev6ps3WNdta0qt1oCcliCg4RZOaLvj70QKTC7ucywfoc587HjId6cuX+zhqj
0wy+BbxjhVCWHH1/kFrwr8AozGeG/U1/hRWkB2cHi/ldwrk7rC/w9ZEA7GSq/TMa
3ZXXCakMSv82wbfhKn1rWFMx00cLUg==
=tQM4
-----END PGP SIGNATURE-----

--o2goxmpnvvbsn7zv--
