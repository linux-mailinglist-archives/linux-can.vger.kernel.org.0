Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C752D706A72
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEQOCD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjEQOCC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 10:02:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49F126
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 07:02:00 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzHj5-0003ED-3j
        for linux-can@vger.kernel.org; Wed, 17 May 2023 16:01:59 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 829CE1C72C5
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 14:01:58 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id KCsUNDvbZGTragUAs6a69A
        (envelope-from <dario.binacchi@amarulasolutions.com>)
        for <mkl-all@blackshift.org>; Wed, 17 May 2023 13:48:43 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BC2901C729A
        for <mkl-all@blackshift.org>; Wed, 17 May 2023 13:48:43 +0000 (UTC)
Received: from glittertind.blackshift.org (unknown [172.20.34.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature ECDSA (secp384r1))
        (Client CN "glittertind.blackshift.org", Issuer "R3" (verified OK))
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9DEAC1C7299
        for <ptx@kleine-budde.de>; Wed, 17 May 2023 13:48:43 +0000 (UTC)
Received: from metis.ext.pengutronix.de (unknown [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        by glittertind.blackshift.org (Postfix) with ESMTPS id 41BF35527EB
        for <ptx@kleine-budde.de>; Wed, 17 May 2023 13:48:43 +0000 (UTC)
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <dario.binacchi@amarulasolutions.com>)
        id 1pzHWC-00013U-No
        for mkl@pengutronix.de; Wed, 17 May 2023 15:48:42 +0200
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-559de1d36a9so8033867b3.1
        for <mkl@pengutronix.de>; Wed, 17 May 2023 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684331318; x=1686923318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qen4NzyYSwUvBTn53Q3ZSIlNULvDmGe0dSmKsYdoj2o=;
        b=D8rWFqa6FLhwuACF80JJS6kNCFwXCVmR7Nq1uyGV4JKuCtNJKy4NN5XJ5P/5vm55bT
         pmjjcjfzuXSHW692VNg65IHxkhgXiMAPUgx8e4YzRnKs9nz5dBFP/BFTkbKJpM5o1hsI
         diDnE3CD3nJozCI+bEa5ZNow9Oqk/qznlz0rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684331318; x=1686923318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qen4NzyYSwUvBTn53Q3ZSIlNULvDmGe0dSmKsYdoj2o=;
        b=giQr/cJ2ri9ZmDLK9ypW+pvk1+9oyLIQZzxlxOd4jtavDpk71M1qnEM0nu2g3cQZXV
         3It7CrTp1pGJBDuLyFelnIY6LiBz8VyIVCQRcVQb6ZgkWkqECbI/UX86nsXznriiHEog
         NS3uSJAXR0HfDnWOnRl3hfne6/2Y83rlucxgBBZI8L386WE6FAUbJfGBPX/LOFIkchNO
         CC4PxTujyJ7wU452HHbuiDyS4x0GepNct4tLTXXiZ58IDiM7ZN9P8zxU19Ot6i+OkJ9A
         chzA0qhUL8E5uSEwiUshU09+e8VDAYJXFZRXOBLj5BVmTcWjmWBrs+cGLIt0eGIv/CUR
         113g==
X-Gm-Message-State: AC+VfDxYmdm5GZBhDcn9x9W/NtbAL+2D361VF672BSFw4rYeW92C7pBv
        ZvwPdDbh7LBK8Q2ZOyKzkRMs3COMyzISvRgK3j55xT3i8iS3jsivd/eVQw==
X-Google-Smtp-Source: ACHHUZ5feHmaW3tO0gy3xW/+BrKZqYha6hvsqDGlOmjX/Wduc93igtxQTu6O8ZcgA4VUWc4IoLHyrhKYp167Xh2pBiY=
X-Received: by 2002:a0d:f281:0:b0:560:beeb:6fc1 with SMTP id
 b123-20020a0df281000000b00560beeb6fc1mr25014343ywf.16.1684331317745; Wed, 17
 May 2023 06:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <202305172130.eGGEUhpi-lkp@intel.com> <20230517-blighted-scowling-352ffbea5190-mkl@pengutronix.de>
In-Reply-To: <20230517-blighted-scowling-352ffbea5190-mkl@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 17 May 2023 15:48:26 +0200
Message-ID: <CABGWkvrhXqpx=gKMcGcUUNhA+rUPRfYHJ6LXjFgwBWwsJnjakg@mail.gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [netdev-net:main 50/55] Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21
 syntax error
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Wed, May 17, 2023 at 3:36=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> Good Bot!
>
> On 17.05.2023 21:21:58, kernel test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git ma=
in
> > head:   6ad85ed0ebf7ece0f376950a6b3b3c6048093d35
> > commit: 0920ccdf41e3078a4dd2567eb905ea154bc826e6 [50/55] ARM: dts: stm3=
2: add CAN support on stm32f746
> > config: arm-randconfig-r034-20230517
> > compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.gi=
t/commit/?id=3D0920ccdf41e3078a4dd2567eb905ea154bc826e6
> >         git remote add netdev-net git://git.kernel.org/pub/scm/linux/ke=
rnel/git/netdev/net.git
> >         git fetch --no-tags netdev-net main
> >         git checkout 0920ccdf41e3078a4dd2567eb905ea154bc826e6
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Darm olddefconfig
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202305172130.eGGEUhpi-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
> > >> FATAL ERROR: Unable to parse input tree
>
> Doh!
>
> The stm32f7-rcc.h is missing the definition for CAN3.
>
> |               can3: can@40003400 {
> |                       compatible =3D "st,stm32f4-bxcan";
> |                       reg =3D <0x40003400 0x200>;
> |                       interrupts =3D <104>, <105>, <106>, <107>;
> |                       interrupt-names =3D "tx", "rx0", "rx1", "sce";
> |                       resets =3D <&rcc STM32F7_APB1_RESET(CAN3)>;
> |                       clocks =3D <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
> |                       st,gcan =3D <&gcan3>;
> |                       status =3D "disabled";
> |               };
> |
> |               gcan3: gcan@40003600 {
> |                       compatible =3D "st,stm32f4-gcan", "syscon";
> |                       reg =3D <0x40003600 0x200>;
> |                       clocks =3D <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
> |               };
> |
>
> | $ git grep CAN include/dt-bindings/mfd/stm32f7-rcc.h
> | include/dt-bindings/mfd/stm32f7-rcc.h:78:#define STM32F7_RCC_APB1_CAN1 =
          25
> | include/dt-bindings/mfd/stm32f7-rcc.h:79:#define STM32F7_RCC_APB1_CAN2 =
          26
>
> Dario, do you have a fix at hand?

in version 1,  the patch "dt-bindings: mfd: stm32f7: add binding
definition for CAN3"
was accepted by Lee Jones
(https://lore.kernel.org/lkml/20230424090229.GB8035@google.com/#t)
So I removed it in version 2 as I described in its cover letter:
https://marc.info/?l=3Dlinux-arm-kernel&m=3D168262836731935&w=3D2
Can we ensure that the patch is merged before this series?

Thanks and regards,
Dario


>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

