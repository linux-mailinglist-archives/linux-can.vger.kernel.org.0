Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E39055D4AE
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbiF1Jtl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Jun 2022 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344546AbiF1JtD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Jun 2022 05:49:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D152B242
        for <linux-can@vger.kernel.org>; Tue, 28 Jun 2022 02:49:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j21so21349804lfe.1
        for <linux-can@vger.kernel.org>; Tue, 28 Jun 2022 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=801n56RRF19njvd3sN05U/Pk8HphuQt6u550b7DOhRU=;
        b=Sfi0J69vaMPOEhNG6WtijHlldNNBSyYKnabmbOfatQmzjdbaXohnb9sm9+yIsihXvi
         QJ6SWz6Kek1j6cgGpPZjrhIwqFGVDwFz/nBlqGdA/jXJN2i6beXkwxUrk0LV2gvs2pPE
         mhM8qjY9dRRa5iwv6n0/36hybYgJBVcA10VCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=801n56RRF19njvd3sN05U/Pk8HphuQt6u550b7DOhRU=;
        b=dBQUYE849/r46MQXG2iyBoJG5ZtepiEXO9xS4mtG0B+l35amWgTql6s+HjaahX+LLW
         BpdfvISPfy1xHd3tA0n51r+O2HLVck/GlPLMqeJWlJGOZZXZuYvGS+ZRToE1+2Ocw1xY
         ATCoeMX8dyixrA0G/llIlCDqRk3d88gR3Ab2LqEbVsBz9ZWmFKtRqg9pAUg/oMXqrn7V
         sIVyCbANt8n3nts0Ea1aP/F+fc5yPZzkvAYCFNC0tw5HlPhgWGKK1pFw8/YZrVwD+rE5
         QExvJmPwVPRdXWi0y9grj30C/urMwv6i39hEcZ78XZ6Ri89VGrf9Xdcr0I8+7jE4RJPe
         HT0w==
X-Gm-Message-State: AJIora+LhGY+fGdbu+LKecEeVf0TvozdZK5NfX1y68qqcVeuKgFy84bK
        d3/JxrC/RV723q/vKXy8kSEnWWPRCfgzbCS15WQmTC0TWCwuIg==
X-Google-Smtp-Source: AGRyM1v9VpZqgUeR8hbmV2LkX0jtJ4z1jBxFd7ywaOEYWsrdztcyr+Zma9hibdiHk7yxd1rIAzY7os2Cfgn+rdIMq6k=
X-Received: by 2002:a05:6512:1192:b0:481:4ba:f14d with SMTP id
 g18-20020a056512119200b0048104baf14dmr10376899lfr.662.1656409739307; Tue, 28
 Jun 2022 02:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
 <20220614122821.3646071-6-dario.binacchi@amarulasolutions.com> <20220628092833.uo66jbnwhh5af6je@pengutronix.de>
In-Reply-To: <20220628092833.uo66jbnwhh5af6je@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Tue, 28 Jun 2022 11:48:48 +0200
Message-ID: <CABGWkvrdw27T+g==HrknM+52mhvgEDS_4P9__7tsc+aV-oAvCw@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] can: slcan: use CAN network device driver API
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Tue, Jun 28, 2022 at 11:28 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 14.06.2022 14:28:14, Dario Binacchi wrote:
> > As suggested by commit [1], now the driver uses the functions and the
> > data structures provided by the CAN network device driver interface.
> >
> > Currently the driver doesn't implement a way to set bitrate for SLCAN
> > based devices via ip tool, so you'll have to do this by slcand or
> > slcan_attach invocation through the -sX parameter:
> >
> > - slcan_attach -f -s6 -o /dev/ttyACM0
> > - slcand -f -s8 -o /dev/ttyUSB0
> >
> > where -s6 in will set adapter's bitrate to 500 Kbit/s and -s8 to
> > 1Mbit/s.
> > See the table below for further CAN bitrates:
> > - s0 ->   10 Kbit/s
> > - s1 ->   20 Kbit/s
> > - s2 ->   50 Kbit/s
> > - s3 ->  100 Kbit/s
> > - s4 ->  125 Kbit/s
> > - s5 ->  250 Kbit/s
> > - s6 ->  500 Kbit/s
> > - s7 ->  800 Kbit/s
> > - s8 -> 1000 Kbit/s
> >
> > In doing so, the struct can_priv::bittiming.bitrate of the driver is not
> > set and since the open_candev() checks that the bitrate has been set, it
> > must be a non-zero value, the bitrate is set to a fake value (-1U)
> > before it is called.
> >
> > The patch also changes the slcan_devs locking from rtnl to spin_lock. The
> > change was tested with a kernel with the CONFIG_PROVE_LOCKING option
> > enabled that did not show any errors.
>
> You're not allowed to call alloc_candev() with a spin_lock held. See
> today's kernel test robot mail:
>
> | https://lore.kernel.org/all/YrpqO5jepAvv4zkf@xsang-OptiPlex-9020
>
> I think it's best to keep the rtnl for now.

The rtnl_lock() uses a mutex while I used a spin_lock.

static DEFINE_MUTEX(rtnl_mutex);

void rtnl_lock(void)
{
mutex_lock(&rtnl_mutex);
}
EXPORT_SYMBOL(rtnl_lock);

So might it be worth trying with a mutex instead of rtnl_lock(), or do
you think it is
safer to return to rtn_lock () anyway?

Thanks and regards,
Dario

>
> regards,
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
