Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD904CF4ED
	for <lists+linux-can@lfdr.de>; Mon,  7 Mar 2022 10:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiCGJYO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Mar 2022 04:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiCGJYF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Mar 2022 04:24:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB7356434
        for <linux-can@vger.kernel.org>; Mon,  7 Mar 2022 01:23:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p15so30435255ejc.7
        for <linux-can@vger.kernel.org>; Mon, 07 Mar 2022 01:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1KsWS/Km5ymmHojsz3R4CV+vnmDjDKNNWFaUpjoaCY=;
        b=IGry8qzl5s/aX2ZICuuGS12W9UPHlSBXHF213489EPYh++oHipDSdDvQAUwbhWcJ7d
         iqA5gN1QP1hp3b2ZXsCkBfdSr04NJL3rZNawHI4YSqgbqJHzpMUR+S2t/RKeXCNjL5M2
         vJ2wWQ5b+zQRuxdvXiXzXElWu2ZiaVg2BAC/JDJjmqtjug3pWuMZKyb//R5ynD9R3+xk
         NMjQQdMLRnJjg2Swe7TUXcEdj8Ld0pHBxWeC7iZCwg78n3yPUVoby9ArbTxaQTZTHVTJ
         HddXebm6hrGWxeQjWtYD91N9m8SlR8LnKC8Ti9ckQG8D/q6km7ovdYH0vQMNZaMkCaRm
         aGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1KsWS/Km5ymmHojsz3R4CV+vnmDjDKNNWFaUpjoaCY=;
        b=A8T418zoBXVM8FVbx7gLTLsTIzBmM0Gf5kQZ6JsFWRW37eyUVZUV+UtLVylYsysNuA
         urCi206K4LRWT/Yij+Mj5NkUMjepJp6Xwt3Qwb5Y7to3UGbGmv3eUWiBo0PojjYyO3sT
         JZKTxiTTLbBbCiszqN+/BEZ1aiIEDz9Z2JE7nfaM8bItqzbow27Tpm0OvufFbRfM2ZUU
         s+aiy2olyRyH6uj/sBa466EQ8T7mxX8auk3nSB3zYM2bHS7pXbwBXDVqOYMEazh49p1F
         yGfv/QWht05uKF1Xj7pr51j5Pbe2yv1FqnyduVmKsgcSbz8XRMTbpZnQSVDiC0kxRDjq
         iaYQ==
X-Gm-Message-State: AOAM5314YMV7FAoDWgtKqFp84SzuiJOWN4lHK1PlH/zB4zx35/Q/XVKt
        NyjcZWeXQk4TvjMzNWXSpQjrrlu+8s3ArOOXSzvh1w==
X-Google-Smtp-Source: ABdhPJxAemVcQjSXIoI905JfgF4cI1d95D553RgtN5XZhyqoHJTJej6DD7dwYYJPjyxcGl9UZbckjpy6b4OO7CzjjQM=
X-Received: by 2002:a17:906:888e:b0:6da:ed04:5e40 with SMTP id
 ak14-20020a170906888e00b006daed045e40mr8642737ejc.286.1646644989659; Mon, 07
 Mar 2022 01:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20220303225525.29846-1-kris@embeddedTS.com>
In-Reply-To: <20220303225525.29846-1-kris@embeddedTS.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Mar 2022 10:22:59 +0100
Message-ID: <CAMRc=McesjKviO=5gK3GN+XukZfSr=um9W8+sqXw9GSFX0QTgw@mail.gmail.com>
Subject: Re: [PATCH] drivers: Fix Links to Technologic Systems web resources
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, wg@grandegger.com,
        mkl@pengutronix.de,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Mar 3, 2022 at 11:57 PM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> Technologic Systems has rebranded as embeddedTS with the current
> domain eventually going offline. Update web/doc URLs to correct
> resource locations.
>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
>  drivers/gpio/gpio-ts5500.c       | 4 ++--
>  drivers/net/can/sja1000/Kconfig  | 2 +-
>  drivers/net/can/sja1000/tscan1.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ts5500.c b/drivers/gpio/gpio-ts5500.c
> index b159e92a3612..8e03614c7a24 100644
> --- a/drivers/gpio/gpio-ts5500.c
> +++ b/drivers/gpio/gpio-ts5500.c
> @@ -11,11 +11,11 @@
>   * Actually, the following platforms have DIO support:
>   *
>   * TS-5500:
> - *   Documentation: http://wiki.embeddedarm.com/wiki/TS-5500
> + *   Documentation: https://docs.embeddedts.com/TS-5500
>   *   Blocks: DIO1, DIO2 and LCD port.
>   *
>   * TS-5600:
> - *   Documentation: http://wiki.embeddedarm.com/wiki/TS-5600
> + *   Documentation: https://docs.embeddedts.com/TS-5600
>   *   Blocks: LCD port (identical to TS-5500 LCD).
>   */

For GPIO

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>

>
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
> index 110071b26921..4b2f9cb17fc3 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -107,7 +107,7 @@ config CAN_TSCAN1
>         depends on ISA
>         help
>           This driver is for Technologic Systems' TSCAN-1 PC104 boards.
> -         http://www.embeddedarm.com/products/board-detail.php?product=TS-CAN1
> +         https://www.embeddedts.com/products/TS-CAN1
>           The driver supports multiple boards and automatically configures them:
>           PLD IO base addresses are read from jumpers JP1 and JP2,
>           IRQ numbers are read from jumpers JP4 and JP5,
> diff --git a/drivers/net/can/sja1000/tscan1.c b/drivers/net/can/sja1000/tscan1.c
> index 3dbba8d61afb..749002f21e27 100644
> --- a/drivers/net/can/sja1000/tscan1.c
> +++ b/drivers/net/can/sja1000/tscan1.c
> @@ -7,8 +7,8 @@
>
>  /*
>   * References:
> - * - Getting started with TS-CAN1, Technologic Systems, Jun 2009
> - *     http://www.embeddedarm.com/documentation/ts-can1-manual.pdf
> + * - Getting started with TS-CAN1, Technologic Systems, Feb 2022
> + *     https://docs.embeddedts.com/TS-CAN1
>   */
>
>  #include <linux/init.h>
> --
> 2.11.0
>
