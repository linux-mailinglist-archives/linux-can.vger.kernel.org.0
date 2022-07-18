Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A47577C0D
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 08:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiGRG7Q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 02:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiGRG7N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 02:59:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD0BCE39
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 23:59:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o7so17755793lfq.9
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GO3uA2rxRxycaIZWuXyXRdx96dLNo4R9q43JD/r2tQg=;
        b=JN3hyblSQ+M4A9lVuWRw+yqTx9aPDW5rwSkL5perJjWMnLI4T7EMXTiMKkRjohkvQm
         f5bHHgoUzRIMWc079HVg6MeW+5uqAV+0HJoIX7mHKLF9S3W3q7PJysurf4K78ChTj5Gk
         J6gi6f4LlrBrQUauJOcG7aqXchluL2ZX88Zd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GO3uA2rxRxycaIZWuXyXRdx96dLNo4R9q43JD/r2tQg=;
        b=hAKMJn7a46KINPJ0t2DgtUbX/EAZIbOFeGnwkNAdvjNF4G9CruLlh0Pvqeb9oNet6l
         3FXcL43SQOglKO/vv082pxnarzrO+qSV0xBMqQ2b0+NBWBQR22ZPtk4oPq/VpM2MDE4Z
         UWl0630PjwYgfjm8p1JTyE5QlpKBnZS58rrHW9sCEgjYxOVzX9iLZwvM76ZAuqfsJm+F
         0jj2lAsyVnoa3FArCv2y1jwjrL0EfZ/8Jjlgvex5gWZJusJw+OzkV/Dvn3EWTX8KlOI3
         lr5xRjr0D/Xj0AFLkGQPtknCybRL1RTK281wySUwwy4IM0D9Fg8JuNdhaBVE85qS078h
         fI7Q==
X-Gm-Message-State: AJIora8H3iWhroWBMwKF6S/wUUHq61odY08YEofhHLw561wq5zERIxwe
        /qACG9NkKHx5ESKMNYY2oV/mIiwf5kHehlyog8D0vkCFVr5guQ==
X-Google-Smtp-Source: AGRyM1vWyEa08U8hagNwhm2XiLPa7IGxJpj40fHevWAebDu4a4p6mJ3QRmNnXYbRIkZ1lGAF16E0riabjqpYgIkxoV4=
X-Received: by 2002:a05:6512:32c1:b0:489:e9de:2f0 with SMTP id
 f1-20020a05651232c100b00489e9de02f0mr15049956lfg.117.1658127550799; Sun, 17
 Jul 2022 23:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com> <507b5973-d673-4755-3b64-b41cb9a13b6f@hartkopp.net>
In-Reply-To: <507b5973-d673-4755-3b64-b41cb9a13b6f@hartkopp.net>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Mon, 18 Jul 2022 08:59:00 +0200
Message-ID: <CABGWkvokcOW2G+CAH4Lna_pRa1ck-zKRpSifjGj-VX_cb9xP5A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] can: slcan: extend supported features (step 2)
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver,

On Sun, Jul 17, 2022 at 4:13 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hello Dario,
>
> I have been maintaining the slcan.c driver for a long time and I'm still
> in the MODULE_AUTHOR() macro.
>
> As you are very committed to the slcan driver and its extensions it
> probably makes sense to take over the maintainer-ship and add yourself
> to the MODULE_AUTHOR() macro.
>
> Analogue to the CAN FD driver from the CTU you could also provide a
> similar patch for the MAINTAINER file:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=cfdb2f365cb9d
>

I am happy and honored. I hope I am adequate for the task.
Thanks and regards,

Dario

> Best regards,
> Oliver
>
>
> On 16.07.22 19:00, Dario Binacchi wrote:
> > With this series I try to finish the task, started with the series [1],
> > of completely removing the dependency of the slcan driver from the
> > userspace slcand/slcan_attach applications.
> >
> > The series, however, still lacks a patch for sending the bitrate setting
> > command to the adapter:
> >
> > slcan_attach -b <btr> <dev>
> >
> > Without at least this patch the task cannot be considered truly completed.
> >
> > The idea I got is that this can only happen through the ethtool API.
> > Among the various operations made available by this interface I would
> > have used the set_regs (but only the get_regs has been developed), or,
> > the set_eeprom, even if the setting would not be stored in an eeprom.
> > IMHO it would take a set_regs operation with a `struct ethtool_wregs'
> > parameter similar to `struct ethtool_eeprom' without the magic field:
> >
> > struct ethtool_wregs {
> >       __u32   cmd;
> >       __u32   offset;
> >       __u32   len;
> >       __u8    data[0];
> > };
> >
> > But I am not the expert and if there was an alternative solution already
> > usable, it would be welcome.
> >
> > The series also contains patches that remove the legacy stuff (slcan_devs,
> > SLCAN_MAGIC, ...) and do some module cleanup.
> >
> > The series has been created on top of the patches:
> >
> > can: slcan: convert comments to network style comments
> > can: slcan: slcan_init() convert printk(LEVEL ...) to pr_level()
> > can: slcan: fix whitespace issues
> > can: slcan: convert comparison to NULL into !val
> > can: slcan: clean up if/else
> > can: slcan: use scnprintf() as a hardening measure
> > can: slcan: do not report txerr and rxerr during bus-off
> > can: slcan: do not sleep with a spin lock held
> >
> > applied to linux-next.
> >
> > [1] https://lore.kernel.org/all/20220628163137.413025-1-dario.binacchi@amarulasolutions.com/
> >
> >
> > Dario Binacchi (5):
> >    can: slcan: remove useless header inclusions
> >    can: slcan: remove legacy infrastructure
> >    can: slcan: change every `slc' occurrence in `slcan'
> >    can: slcan: use the generic can_change_mtu()
> >    can: slcan: send the listen-only command to the adapter
> >
> >   drivers/net/can/slcan/slcan-core.c | 465 +++++++++--------------------
> >   1 file changed, 134 insertions(+), 331 deletions(-)
> >



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
