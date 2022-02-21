Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ADB4BED59
	for <lists+linux-can@lfdr.de>; Mon, 21 Feb 2022 23:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiBUWpJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Feb 2022 17:45:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiBUWpI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Feb 2022 17:45:08 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D008B1CFC0
        for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022 14:44:43 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id b35so9535624ybi.13
        for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022 14:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E+2yYkNp5p1SWHWTFW6emniGImU8ZPvJWh3npwHgr1w=;
        b=RxhXAm2Hdd/158ZRkVTaHMmLAvYDdTcBeohDejJY9bli9FfR1VA5W05crxKBP+p/1z
         jadGRgTBmUBcuy1crvfm3UqIjO9s4qVBJXjX0fM65LGXbo632OfkeVBx3wJ0TxEDl+Cx
         4Yf3dgJlXSY/g0VchrIwIKPiWss9GQ4EUNpVSGNPiOZzPU1rd1mljkU+ynbKYSuQQp8n
         86NzrZNaVyOdFtmW8i4h1ajOZUkflW0jpJ/W8BBGA2key8OK5umB59AyL3xxXGDNK0tx
         PYHqvp9VxnAE1satboMp1xOmdOEoZ28rgi1iMAXVmRy/k40/l9yOiSdGMxVEyg0l3MES
         7HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E+2yYkNp5p1SWHWTFW6emniGImU8ZPvJWh3npwHgr1w=;
        b=RLiyr7b3zPY2gcShNwVL97pve/MAxI42XGS45R2s/l86SshvmYBAXsq/e3SiZ/g82S
         WvnbeSoLFs5doGUC04oi0SpxcIaLN2F/zKZvHVG0t99+Cuqutv7wHlrYgYcnMeq3ndUP
         ScIWXOeN1nZj7E2Dft25ww8rB0vL96qzoQasCB0fcStb1k7o1i1xvFfVbAKXHRfjlIA2
         p7L4x0EcwhddoXfYwwoNQLrt2LAt0EIX3zhj/yg+HdO52YnYnUUBwFxJPozgYLgh6z01
         PJJATNIKN8cSJsYWm8dhhnAMAp6G+qn1qDdOxTCYaaX7np33b44pOzc8AiSRzZyRw0dr
         FgpQ==
X-Gm-Message-State: AOAM532YYnjZAoPW0wx8Rhxy3pzGNhoEdvWzKRLNOgRxK5iLKc54miVW
        cnay8lCrrWymLpMgw0IFkDr0/9a0XfEZ2CbHprWijKAFeVM=
X-Google-Smtp-Source: ABdhPJzyTpmgWVBRhkYklZNluVUJm4qnpxQ2x2+XXWxxB5V5P1y0Lo8TA6OLgrn8ksxEo/tMoVnqzyu1JwsozIqnEes=
X-Received: by 2002:a25:d2c6:0:b0:621:b173:813d with SMTP id
 j189-20020a25d2c6000000b00621b173813dmr19774444ybg.500.1645483482545; Mon, 21
 Feb 2022 14:44:42 -0800 (PST)
MIME-Version: 1.0
References: <PA4PR03MB67970BDE7AB5545F3425264AD63A9@PA4PR03MB6797.eurprd03.prod.outlook.com>
In-Reply-To: <PA4PR03MB67970BDE7AB5545F3425264AD63A9@PA4PR03MB6797.eurprd03.prod.outlook.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 22 Feb 2022 07:44:31 +0900
Message-ID: <CAMZ6RqL+1JcQb06DYjQQgrxzScDk9aruvVdCgc2wgUTumU8Wzg@mail.gmail.com>
Subject: Re: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
To:     =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can Mailing List <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 22 Feb 2022 =C3=A0 01:39, St=C3=A9phane Grosjean
<s.grosjean@peak-system.com> wrote:
>
> Hi Marc,
>
> >On 15.02.2022 16:10:45, Marc Kleine-Budde wrote:
> >> On 11.02.2022 10:57:34, St=C3=A9phane Grosjean wrote:
> >> > endianess is handled by lower level functions (see for ex
> >> > pcan_usb_fd_get_user_devid()/pcan_usb_fd_set_user_devid() in PATCH
> >> > 2/6).
> >> >
> >> > This data is really a number and must be treated as such.
> >>
> >> What's the use case for the data/number? What's the big picture?
>
> >| Jan 01 05:16:21 DistroKit kernel: peak_usb 1-1:1.0: PEAK-System PCAN-U=
SB FD v1 fw v3.2.0 (1 channels)
> >| Jan 01 05:16:21 DistroKit kernel: peak_usb 1-1:1.0 can0: attached to P=
CAN-USB FD channel 0 (device 1144201745)
> >                                                                        =
                             ^^^^^^^^^^
>
> >But that is something different than the serial number, right?
>
> Yep! This is a number that can be used to uniquely identify the device, r=
egardless of the USB port or the order in which it is connected. The purpos=
e is to allow the user to name the network interface according to this numb=
er. This is for example what is done by the "historical" driver "pcan" whic=
h is freely downloadable from www.peak-system.com.

FYI, for the dual interfaces (PCAN-USB Pro), you might want to
populate net_device::dev_port as well.
c.f. https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git=
/commit/?h=3Dtesting&id=3De233640cd3034ae65924316a0d95ccacb86ae4bd


Yours sincerely,
Vincent Mailhol
