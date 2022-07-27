Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464F45822E9
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiG0JRd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 27 Jul 2022 05:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiG0JRd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 05:17:33 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A4828735
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 02:17:31 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ef5380669cso168583537b3.9
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 02:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s2LmnS9G2P/s2ZK9Xkvej54SHndHtHWG1MjXMX+0AbE=;
        b=SzdBXA0L5RwFLS8jlVsN9SWAHHx9mbYMrxGF1w0MzsAuLpQnKKIGjOFe9q01QUpK3G
         fAADwPsxK+1jLU/M+rXi5bt1sctZ5XCJHdKKh5iUqZIENdWdcLNVHt1heYq/EMMpojjV
         i55+tzKSzMrL8tp0Ezxg3rO8ORE91hoOUjDSDnyjZuLeJY/l6sTgkoMbLy85/WpGwchy
         Oea7xg71Co+Cib8XZ5oJb+s7qZfC7wbbhZRQBSykNy222Thaqq/s0WtpAdNdCLPWWeLn
         +6kGFCCLqyJqmQgNcd5JPxdANxUGm0H9PkD+NYj8Mqj88XwOJsYVt0P5LGtdL1l5W9NQ
         bBLg==
X-Gm-Message-State: AJIora+kLmsZ9bHHXCGb1GV+R/X0ZgBuNbuv2leUW9JlrNnYFBDwC1ZD
        hWJ7AIA/j0bbdv0emXNdieEuPHL4pKd+Q8hv4Nw=
X-Google-Smtp-Source: AGRyM1tcPDbQDqt5xRxhtEFkHs8E1YDLav6yGYr//oGDJVMX440XOnRf74EQbSUQwymis7dIyL8cM0njcd+Rz6JjRI8=
X-Received: by 2002:a81:1902:0:b0:31e:b49e:3ecd with SMTP id
 2-20020a811902000000b0031eb49e3ecdmr18449585ywz.191.1658913450707; Wed, 27
 Jul 2022 02:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-15-mailhol.vincent@wanadoo.fr> <20220727080634.l6uttnbrmwbabh3o@pengutronix.de>
 <CAMZ6RqL0sNAFtLiiopeaA2Oyqq15=dhdOnLivTWngPxGyAFHQw@mail.gmail.com> <20220727084257.brcbbf7lksoeekbr@pengutronix.de>
In-Reply-To: <20220727084257.brcbbf7lksoeekbr@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 27 Jul 2022 18:17:19 +0900
Message-ID: <CAMZ6RqJaEk2rHB=7fGdk_qrvbnjv5YM6aWYzFdeyKNtFjGcZEQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] can: peak_usb: advertise timestamping
 capabilities and add ioctl support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 27 Jul. 2022 at 17:50, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 27.07.2022 17:29:25, Vincent MAILHOL wrote:
> > On Wed. 27 Jul. 2022 at 17:10, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > On 26.07.2022 19:24:54, Vincent Mailhol wrote:
> > > > Currently, userland has no method to query which timestamping features
> > > > are supported by the peak_usb driver (aside maybe of getting RX
> > > > messages and obseverse whever or not hardware timestamps stay at
> > > > zero).
> > > >
> > > > The canonical way for a network driver to advertise what kind of
> > > > timestamping it supports is to implement
> > > > ethtool_ops::get_ts_info(). Here, we use the CAN specific
> > > > can_ethtool_op_get_ts_info_hwts() function to achieve this.
> > > >
> > > > In addition, the driver currently does not support the hardware
> > > > timestamps ioctls. According to [1], SIOCSHWTSTAMP is "must" and
> > > > SIOCGHWTSTAMP is "should". This patch fills up that gap by
> > > > implementing net_device_ops::ndo_eth_ioctl() using the CAN specific
> > > > function can_eth_ioctl_hwts().
> > > >
> > > > [1] kernel doc Timestamping, section 3.1: "Hardware Timestamping
> > > > Implementation: Device Drivers"
> > > > Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers
> > > >
> > > > CC: Stephane Grosjean <s.grosjean@peak-system.com>
> > > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > > ---
> > > >
> > > > Hi Stéphane, as far as I understand, the pcan_usb and the pacn_usb_pro
> > >                                                             ^^^^
> > >                                                             pcan
> > >
> > > > support hardware timestamps but the pcan_usb_fd doesn't. If not the
> > > > case, let me know.
> > > >
> > > > This is not tested. If you find any issue or if you want to modify,
> > > > feel free to pick up that patch and resend it.
> > >
> > > I have a:
> > >
> > > | Bus 002 Device 009: ID 0c72:0012 PEAK System PCAN-USB FD
> > >
> > > It supports hardware RX timestamps (Debian kernel 5.18.0-2-amd64) only:
> > >
> > > |  (1970-01-01 01:00:00.000000)  peakfd0  TX - -  002   [1]  01
> > > |  (1970-01-01 02:17:09.473817)  peakfd0  RX - -  002   [1]  3C
> > > |  (1970-01-01 01:00:00.000000)  peakfd0  TX - -  002   [1]  02
> > > |  (1970-01-01 02:17:09.673980)  peakfd0  RX - -  002   [1]  3D
> >
> > Thanks for the confirmation. So this means that all Peak hardware
> > supports the hardware timestamping.
>
> The PCAN-USB FD only support RX hardware timestamping, not TX.

> > This will greatly simplify the
> > logic. No need to have two different struct ethtool_ops. I will
> > prepare a v4.
>
> We have a peak_pciefd card:
>
> | 01:00.0 Network controller: PEAK-System Technik GmbH Device 0018 (rev 01)
>
> Only RX HW timestamps (Debian kernel 5.16.0-0.bpo.4-amd64):
>
> |  (1970-01-01 01:00:00.000000)  can0_iobus  TX - -  601   [8]  40 0C 21 01 00 00 00 00
> |  (1970-02-16 18:25:06.810100)  can0_iobus  RX - -  581   [8]  53 0C 21 01 00 00 00 00
> |  (1970-01-01 01:00:00.000000)  can0_iobus  TX - -  602   [8]  40 0C 21 01 00 00 00 00
> |  (1970-02-16 18:25:06.819380)  can0_iobus  RX - -  582   [8]  53 0C 21 01 00 00 00 00

O_o
This comes as a surprise.

I read your first message too quick and did not get the nuance that
only *RX* hardware timestamp was supported.

After investigation, I found this message from Stéphane:

| Those hw tx timestamps are not supported by the peak_usb
| driver: your socket-can application will receive "local
| software" TX timestamps only, corresponding roughly to the time
| the CAN frame has been given to the USB core of the kernel.
|
| However, this is possible with our pcan driver: you can get
| an "echoed" message with a HW TX timestamp for each message
| your application sends.

Source: https://forum.peak-system.com/viewtopic.php?t=5572#p12913

So the hardware does support it, it is just that the mainstream driver
does not implement it.


Yours sincerely,
Vincent Mailhol
