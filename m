Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3DD674739
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 00:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjASX2z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 18:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjASX2y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 18:28:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A859CF
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:28:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so6565893pjq.0
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ4DzURW3gb3artfl+ORegwlhY85u6mxhqyFx2drihc=;
        b=JX/z9fT2UNs1YEVuaweF+9fB+rnrEwa1c3/ru4RxWyj/JtrajJ9BypHgOgAxMQ9FGT
         07PWlUSEjVTnnsqLlfdUCYxJc02SJnDFiPQ9m1FrM3XsrYBfgZlXZCxCmZIA25XQwfmN
         tyJxkXDwMVzp6vt2uUhSYznHJN5RAQAlWFoL2ks/IQUyNjiOBZ9p7t/38QLj/V0xelSS
         NKleyd5NH5sUUQ37YcM0q4MK4o7nC6Bui2Z1GvhnnrWC9EaJ9maOO+dkcrTuiIHLEy2c
         QzlLhLgA6yzQs+Q9nZ2DmQCZv44GxFMjP5bqXD7KOU90QoeV5wAZ7ORr/TosIQvLuMaR
         7nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ4DzURW3gb3artfl+ORegwlhY85u6mxhqyFx2drihc=;
        b=0eqR5jSxx/UFMKzkkGt5JkfDxgUTtc5EFDudvAHOIE182v6i8+0pJOPlJC8IDc9ePs
         wphmB954jmUM5yl290y/LQI6V2LVSlZYc9rMOtHtHtz5TCwK9m0d6H8kWXFHAjt8xY6w
         b9jC+FWSeXURzvVhkqHFn577BZjiHFsUrXtQiANZZ3FM7vk8wcqlz7c1Y3W/3PJwW1iH
         xg822OWbScgaHAjO5soBiMt51ZPQWP5d4BHMBujYE3MB8ZDu2rG22gomZ213RIbj0RgP
         6M/O5OioP1U06/6UnSnm5eQyEss1VXbCwZiCoN6XyakpS8TIAx0y1cYafMJJ3JpH14VQ
         GjqA==
X-Gm-Message-State: AFqh2kpGqWEoEf0ExA/pRuyJY4mys54aEZeqszB6Dhd7eKKKGeU3MGPw
        fNRAQa/dXdj92z10OMMa5rkqF8y2WxsdY9nqPpVxRppK97U=
X-Google-Smtp-Source: AMrXdXv3Dy2Ah4zH6iaKUm38EFA6ALgavKEQpz0smoo5ENcmVY/aQaPjb43YV0RkY8cD9vPhXXH7c8iFXgbByfhYSD8=
X-Received: by 2002:a17:90a:e501:b0:229:d9d0:6df6 with SMTP id
 t1-20020a17090ae50100b00229d9d06df6mr624396pjy.222.1674170932980; Thu, 19 Jan
 2023 15:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
In-Reply-To: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 20 Jan 2023 08:28:41 +0900
Message-ID: <CAMZ6Rq+5yUCPv9MuTof8xe3UcSzzq+aS9bXzZjUd=8d0jjtMvA@mail.gmail.com>
Subject: Re: [PATCH 0/8] can: ems_pci: Add support for CPC-PCIe v3
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Gerhard,

I had a quick look at your series. I have a couple of nitpicks. The
rest looks good.

On Fri. 20 Jan. 2023 at 01:02, Gerhard Uttenthaler
<uttenthaler@ems-wuensche.com> wrote:
> The CPC-PCIe v3 uses a Asix AX99100 instead of the discontinued
> PLX PCI9030 bridge chip. This patch series adds support for this
> card version and cleaned some code styling issues.
>
> Gerhard Uttenthaler (8):
>   Fixed code style, copyright and email address
>   Added Asix AX99100 definitions
>   Initialize BAR registers
>   Added read/write register and post irq functions
>   Initialize CAN controller base addresses
>   Added IRQ enable
>   Deassert hardware reset
>   Added MODULE_AUTHOR

>   Fixed code style, copyright and email address
    ^^^^^
>   Added Asix AX99100 definitions
    ^^^^^
>   Initialize BAR registers
>   Added read/write register and post irq functions
    ^^^^^
>   Initialize CAN controller base addresses
>   Added IRQ enable
    ^^^^^
>   Deassert hardware reset
>   Added MODULE_AUTHOR
    ^^^^^

For the titles, please use imperative (e.g. add) instead of past
tense (e.g. Added). This also applies to the description.

>
>  drivers/net/can/sja1000/ems_pci.c | 152 ++++++++++++++++++++++--------
>  1 file changed, 113 insertions(+), 39 deletions(-)
>
> --
> 2.35.3
>
> --
> EMS Dr. Thomas Wuensche e.K.
> Sonnenhang 3
> 85304 Ilmmuenster
> HR Ingolstadt, HRA 170106
>
> Phone: +49-8441-490260
> Fax  : +49-8441-81860
> http://www.ems-wuensche.com
