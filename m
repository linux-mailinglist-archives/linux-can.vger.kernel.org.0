Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE3582223
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiG0I3p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 27 Jul 2022 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiG0I3l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 04:29:41 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF80C45993
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 01:29:37 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id c131so29095023ybf.9
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 01:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ojALS/GDkNBh0gxDZrkDQdTzMuy3oE9Qm51YlD+V7wQ=;
        b=jUFKurO6PbXd0ZaOcJ7Jb+Tvvd8lebR7k6Fboqz0Zxvha9xjR596pjsK2JyuKeypI0
         gumOy5w0V3nDP6E4i/8P7pHbxmHUqAxvWZwPakjUGHXTbJ+IG+QTQRRzW0McY+92qUm9
         OEK2gjkIhlCJYlhSLS4CH2wvaa0koUK2nN1dT9TFvohyX4V+b7xRk4r0LP0mizL4O0mW
         Mibp7kkYVRMTVD2wdqMIK0XPT+sDABuYUKbwGwwTHcVxynIzDrxk537o6JbaV6Tji+w+
         mmiNZucRwumuBpqoEDLl5V7DbqewGZ9nGPnJHFUGphScFknxb9y+Mq1BoprMb9sszCwc
         WT6g==
X-Gm-Message-State: AJIora+PUW79DEjzvxn5XLMfhWI7ebCaIa1DPcv9ARG3xBFLXkosBmvz
        Hv4JEMw2e4rENd3Uy0NVoaQK7JNFFovmJBULRrU=
X-Google-Smtp-Source: AGRyM1sh6KFw+YZRC/jOP0Hi4goA6JY1cR9CHh2uVneMsYm2NB1hD+kRVtiyjU2IZHLQp5rQ+BdGqKskavE4LSTtjU8=
X-Received: by 2002:a25:db50:0:b0:671:75aa:bf47 with SMTP id
 g77-20020a25db50000000b0067175aabf47mr4681799ybf.20.1658910576889; Wed, 27
 Jul 2022 01:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-15-mailhol.vincent@wanadoo.fr> <20220727080634.l6uttnbrmwbabh3o@pengutronix.de>
In-Reply-To: <20220727080634.l6uttnbrmwbabh3o@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 27 Jul 2022 17:29:25 +0900
Message-ID: <CAMZ6RqL0sNAFtLiiopeaA2Oyqq15=dhdOnLivTWngPxGyAFHQw@mail.gmail.com>
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

On Wed. 27 Jul. 2022 at 17:10, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 26.07.2022 19:24:54, Vincent Mailhol wrote:
> > Currently, userland has no method to query which timestamping features
> > are supported by the peak_usb driver (aside maybe of getting RX
> > messages and obseverse whever or not hardware timestamps stay at
> > zero).
> >
> > The canonical way for a network driver to advertise what kind of
> > timestamping it supports is to implement
> > ethtool_ops::get_ts_info(). Here, we use the CAN specific
> > can_ethtool_op_get_ts_info_hwts() function to achieve this.
> >
> > In addition, the driver currently does not support the hardware
> > timestamps ioctls. According to [1], SIOCSHWTSTAMP is "must" and
> > SIOCGHWTSTAMP is "should". This patch fills up that gap by
> > implementing net_device_ops::ndo_eth_ioctl() using the CAN specific
> > function can_eth_ioctl_hwts().
> >
> > [1] kernel doc Timestamping, section 3.1: "Hardware Timestamping
> > Implementation: Device Drivers"
> > Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers
> >
> > CC: Stephane Grosjean <s.grosjean@peak-system.com>
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >
> > Hi Stéphane, as far as I understand, the pcan_usb and the pacn_usb_pro
>                                                             ^^^^
>                                                             pcan
>
> > support hardware timestamps but the pcan_usb_fd doesn't. If not the
> > case, let me know.
> >
> > This is not tested. If you find any issue or if you want to modify,
> > feel free to pick up that patch and resend it.
>
> I have a:
>
> | Bus 002 Device 009: ID 0c72:0012 PEAK System PCAN-USB FD
>
> It supports hardware RX timestamps (Debian kernel 5.18.0-2-amd64) only:
>
> |  (1970-01-01 01:00:00.000000)  peakfd0  TX - -  002   [1]  01
> |  (1970-01-01 02:17:09.473817)  peakfd0  RX - -  002   [1]  3C
> |  (1970-01-01 01:00:00.000000)  peakfd0  TX - -  002   [1]  02
> |  (1970-01-01 02:17:09.673980)  peakfd0  RX - -  002   [1]  3D

Thanks for the confirmation. So this means that all Peak hardware
supports the hardware timestamping. This will greatly simplify the
logic. No need to have two different struct ethtool_ops. I will
prepare a v4.

Yours sincerely,
Vincent Mailhol
