Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA5710543
	for <lists+linux-can@lfdr.de>; Thu, 25 May 2023 07:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbjEYFWt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 May 2023 01:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbjEYFWY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 May 2023 01:22:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45C21AC
        for <linux-can@vger.kernel.org>; Wed, 24 May 2023 22:16:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae454844edso7786125ad.1
        for <linux-can@vger.kernel.org>; Wed, 24 May 2023 22:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684991809; x=1687583809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w6KR3HMaO2Ce1KtsONQ+tcBMpRdgbXx21IhlWiizFF0=;
        b=E6mIq+sK7StbgvuAfq1SyzRa7ze8wqqORKQEzXPU1vUJ6fC3PX8zbYoPnDEWf82h+9
         Dweu6qMOVUEtVTYbGUsC2ErI+eynOc8haXkGxVWxTwF3dg/FRWe+DOSwFjOzotsyGYPj
         w7to0MIsRG+nQll+SHjtXkbK+IWH3i/kDAvRkUJio1LdaFPV5ZKHkUKVz3K9pWDziGKT
         kmTu0VUVzxBoldg+yL1ogzqnSbkCMl6kINMDqkK+nKYeJ9e+FfCFZggFox4ygMiQF892
         d3iBjCZom1pd35b6Pbw6HAfwk8fHa5JIBaTouhVZMeLK4ZjYsrl34VZv3opgs7Uhc9iW
         Qx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684991809; x=1687583809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6KR3HMaO2Ce1KtsONQ+tcBMpRdgbXx21IhlWiizFF0=;
        b=GzCQZiS0qppYj0Cs5ZrFBL4xnT6QV3kdvxhzVVzPZ+52ilb7mlUSCGhzLFMqAupUzz
         5T7f4pl0JRvVGBIjoZi1x1JOtFaqCfTG66X0+nq+ww/gLTe0yaw3J32QhkS8Yl85DRir
         oK5GIAImHsXo3aheP5YZ7A4oDXc6Z1KLx4EZj1WqEN+dXGnY+B1KDxb37//tNDGfEbIR
         wjDipIq01U4dRFBC1spf/WvlA/bRe4F1i/PmWlLV8wbi5oVlk3ArZePFiNB2ImqNZtpD
         5BX700l9Aa3xLi39CoOXSxLf4FNpZo7BbY7eL9UGGDooaQAToTJV2I/KS3xN4Xo+cnAk
         QGiw==
X-Gm-Message-State: AC+VfDzBwbV87/PNyqVpuHmiiPlNc8Bu+t7+Y69rgsyOo6CGCzCHMv8E
        Nvva6mS9QUXcrDxIk0Nk5vaoqLY4AHK4iFX8CFMNhj3ZmK4=
X-Google-Smtp-Source: ACHHUZ4qKorKpNOo3XfkS2gh93rVtP0YrtWPRguYB6kQ2GDVcyf5NRElL4I1YiXHMIclZpwCACbgdW49Wd5x/Jtfgto=
X-Received: by 2002:a17:903:2287:b0:1a9:bdf8:f551 with SMTP id
 b7-20020a170903228700b001a9bdf8f551mr367557plh.69.1684991809221; Wed, 24 May
 2023 22:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230515212930.1019702-1-mkl@pengutronix.de> <CAMZ6RqKToYbfsOX4v_jK7X28hLyiYnH7j784eVeFuKrj7ujRSA@mail.gmail.com>
 <20230522215354.2c79c007@gmx.net> <20230522-hesitant-dehydrate-d2af514565d0-mkl@pengutronix.de>
 <CAMZ6Rq+-4D_W8d_2wxuN5TnTmRZ4+C3MwGuBOVNH_vQ2UveTbw@mail.gmail.com> <AM0PR10MB3683D7C815CD334AE831F60490419@AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM0PR10MB3683D7C815CD334AE831F60490419@AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 25 May 2023 14:16:38 +0900
Message-ID: <CAMZ6RqKmmEHitD7Aaq+zjyBUHvvbu0szhxnRQS71wxATydjYSA@mail.gmail.com>
Subject: Re: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
To:     Markus Marb <marm@hms-networks.de>
Cc:     Peter Seiderer <ps.report@gmx.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        socketcan <socketcan@hms-networks.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Markus,

On Wed. 24 May 2023 at 20:24, Markus Marb <marm@hms-networks.de> wrote:
> Hi,
>
> > If you do not have the hardware specification (or at least the documentation of ixxat_canbtp->tdo) then it will be hard for you to do anything here.
> The tdo field is documented in our windows drivers manual[1]. The socketcan driver seems to use CAN_BTMODE_RAW(IXXAT_USB_BTMODE_NAT), so the hardware specific number of CAN clock cycles is expected here.
>
> From the manual:
> wTDO:
> Offset to the transceiver delay (or Secondary Sample Point SSP) that is
> automatically determined by the controller. Value is only relevant with fast data
> bit rate. If in field dwMode the bit CAN_BTMODE_RAW is set, the hardware
> specific number of CAN clock cycles is expected here. If not, the value defines
> the Secondary Sample Point (SSP) in relation to the total number of time quanta
> per bit (example: if wTS1+wTS2=100 and wTDO=65 the SSP is 65% of a bit time).
> Value 0 deactivates the SSP.
>
> [1]: https://www.ixxat.com/docs/librariesprovider8/ixxat-english-new/pc-can-interfaces/02---windows-drivers/vci-v4.0.1133.0-windows-11-10.zip?sfvrsn=2d1dfdd7_20
> See "./VCI V4.0.1133.0 - Windows 11, 10/Manuals/VCI V4 C-CanFD Software Design Guide English.pdf"

This seems enough to implement the feature. Unless documented
elsewhere, it seems that you have no TDCV or TDCF support. So
something like that should do the job:

  static const struct can_tdc_const es58x_tdc_const = {
          .tdcv_min = 0,
          .tdcv_max = 0, /* Manual mode not supported. */
          .tdco_min = <Minimum value wTDO can take, should be
documented somewhere>,
          .tdco_max = <Maximum value wTDO can take, should be
documented somewhere>,
          .tdcf_min = 0,
          .tdcf_max = 0, /* Manual mode not supported. */
};

Look at the doc of struct can_tdc and can_tdc_const for the details:

  https://elixir.bootlin.com/linux/v6.3/source/include/linux/can/bittiming.h#L20

Then add the CAN_CTRLMODE_TDC_AUTO capabilities.

Finally, using it should be something in this spirit:

  if (can_tdc_is_enabled(&priv->can)) {
          ixxat_canbtp->tdo = cpu_to_le16(priv->can.tdc.tdco);
  } else {
          ixxat_canbtp->tdo = 0;
  }

The else branch can be omitted in case you already memset()
ixxat_canbtp to zero.

You can test it by running your device at the maximum supported data
bitrate. Below ip command should show you the tdco value:

  ip --details link show can0

> Please note that for example the simplified SSP positioning (setting tdo to 0XFFFF) described in the document is handled in the windows driver and not in the device firmware, so it cannot be used here.

That part will be out of scope of the linux driver, I guess.

> Best regards
> Markus
