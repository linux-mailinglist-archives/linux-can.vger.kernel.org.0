Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0A58320A
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiG0SbF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbiG0Sap (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 14:30:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410990984
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 10:28:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b16so15577352lfb.7
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSRdOcYBGEhsD0JRGIxpSP2+2S3G17g+bVVcWxkddkc=;
        b=LaYhMSAkQrlnjWhscM/AO/d8pKWM5zTS62luTq8mORS8f+dxQK4DJaRClQnQIYJMvl
         FBNpCAL4sM1726or9MhHgNms3wz/Xch9TN3Gaf+J9GbaOqoDNy7ylvdxXNOBDl97zGlA
         lfsTfD9El4TsPMwA1ZGsEat01hHa7pa42AkJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSRdOcYBGEhsD0JRGIxpSP2+2S3G17g+bVVcWxkddkc=;
        b=yWR3dRusVHkj0xAoxoxK6DQTcSz/MnGr5+fpTWCP+dFbod6tqrF7hcrvBOkYBD7Zec
         okNkOE1ZiCaVZXHt9MYkOby/O+VNMMmqBrm8R39E+i5kbcDzSNQu9R6FlY+WJLg74UJG
         8wG9x5g2BYszZhGJSi0ky+dAlCIspIEP93G4LiZag6ClVVGkono2GM+TvsihFu8lWViA
         xLEMviWeRzAMpfnUJ6JrL3s+5tLXQOx5fpxcv4HcY6dFfkZInJ1A+g+BsBEQAr9yRY/w
         j0ZDrtXye7ELNLXyfD4pwV8bW9HTVHC/YFQ5ZFdbJZ5hxZjAAQO9WHCvYngAv/79L20v
         /aqw==
X-Gm-Message-State: AJIora/C5mmG4nntHk7DaN62X8bjP8BWtRQTlwhAqVScw99nU+kPfJ9u
        Y3Pvtcx4kDqe4IZvb8qmOovt9UOS525kGmcOqHM39w==
X-Google-Smtp-Source: AGRyM1u6jLeziOqS31v6XNiLVcQNVbm0iaQvSgqYtOePAP9toZYu6KQVUSCFhtr23LeflRxNDqUMs8TGJlbIIyxQ5nQ=
X-Received: by 2002:a19:ca5d:0:b0:48a:74a6:2f10 with SMTP id
 h29-20020a19ca5d000000b0048a74a62f10mr8818600lfj.153.1658942936087; Wed, 27
 Jul 2022 10:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
 <20220726210217.3368497-9-dario.binacchi@amarulasolutions.com>
 <20220727113054.ffcckzlcipcxer2c@pengutronix.de> <CABGWkvrmbQcCHdZ_ANb+_196d9HsAxAHc4QS94R19v5STHcbiA@mail.gmail.com>
 <20220727172101.iw3yiynni6feft4v@pengutronix.de>
In-Reply-To: <20220727172101.iw3yiynni6feft4v@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 27 Jul 2022 19:28:45 +0200
Message-ID: <CABGWkvqF4HSKVrO8W8oyDPCMfx_B2xQZ_EWET11RZb6k8Kmb=w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 8/9] can: slcan: add support to set bit time
 register (btr)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        netdev@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Jul 27, 2022 at 7:21 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 27.07.2022 17:55:10, Dario Binacchi wrote:
> > Hello Marc,
> >
> > On Wed, Jul 27, 2022 at 1:31 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > >
> > > On 26.07.2022 23:02:16, Dario Binacchi wrote:
> > > > It allows to set the bit time register with tunable values.
> > > > The setting can only be changed if the interface is down:
> > > >
> > > > ip link set dev can0 down
> > > > ethtool --set-tunable can0 can-btr 0x31c
> > > > ip link set dev can0 up
> > >
> > > As far as I understand, setting the btr is an alternative way to set the
> > > bitrate, right?
> >
> > I thought of a non-standard bitrate or, in addition to the bitrate, the
> > possibility of enabling some specific CAN controller options. Maybe Oliver
> > could help us come up with the right answer.
> >
> > This is the the slcan source code:
> > https://github.com/linux-can/can-utils/blob/cad1cecf1ca19277b5f5db39f8ef6f8ae426191d/slcand.c#L331
> > btr case cames after speed but they don't seem to be considered alternative.
> >
> > > I don't like the idea of poking arbitrary values into a
> > > hardware from user space.
> >
> > However this is already possible through the slcand and slcan_attach
> > applications.
> > Furthermore, the driver implements the LAWICEL ASCII protocol for CAN
> > frame transport over serial lines,
> > and this is one of the supported commands.
> >
> > >
> > > Do you have a use case for this?
> >
> > I use the applications slcand and slcan_attach as a reference, I try to make the
> > driver independent from them for what concerns the CAN setup. And the bit time
> > register setting is the last dependency.
>
> Ok - We avoided writing bit timing registers from user space into the
> hardware for all existing drivers. If there isn't a specific use case,
> let's skip this patch. If someone comes up with a use case we can think
> of a proper solution.

Ok. So do I also remove the 7/9 "ethtool: add support to get/set CAN
bit time register"
patch ?

Thanks and regards,
Dario

>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
