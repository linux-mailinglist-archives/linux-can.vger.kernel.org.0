Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C07581093
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiGZJ6g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 05:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiGZJ6c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 05:58:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B822F671
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 02:58:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a13so15756870ljr.11
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyYbQQcFZQRL8ECdYgGH1HmSxup/wpbTfi7HF0LCxSI=;
        b=dc+dWNLW58/A4YGuWG6aqIz3GF2LA4+cOtc5Lipk+dhZCJvUzuQJlY50hVu3dgZqUx
         FwQk2LRYdkDcChnjC0xALDshOKMYYngjYnfyY8vq0pEJ58709EHxPfwh8xgpPlJqnaTt
         pPPOBq05ESAPYZZOlRQXn7FlooRKRgFmgGPIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyYbQQcFZQRL8ECdYgGH1HmSxup/wpbTfi7HF0LCxSI=;
        b=0wFky9oEBhddAfcPNdr9LQhAsscPO5sTYW1I4KDyTukOFOoHq00hCoQm4135lQaFOT
         fbUGrgiZxewHuqEDHbMYib7ipE10LwYiYqm3gfonTsKjOTL4Ng31kYklY4Y7sZe2jvUX
         5Gz7a4GU7MpXH8ITxtlnnNvYdI8HJYv8cbWJgzxOpHhXIzmRrHN4hxwfNwnetZvauLVe
         RgAWfQ6pyQ4FZ05cQBovox2LxOkoeZRdHbr97HjsrorvKx2Ce3I/HD9oll1q9RFO0wcr
         eZMqGT5NzSMdwoF8h88vlWNqP7+OW3U1kIq5UxJNsApDmlYdKqFEZpNTTGXjcQFiZphY
         6Rig==
X-Gm-Message-State: AJIora/GmYS5ffpnutjrec8X8pNRPfALgHA0MUhZL3YeiUzZeD4pba09
        Ic8EcqEime0pq4iB+766DPWZmWVlS8yZaS20bSJk9A==
X-Google-Smtp-Source: AGRyM1tuwCzAuF5JFkUjq+VdoraUhYDiyOnbofMxNTTgoE78kbTVnaxfQVyrt7GUTzxfqRy0qkd7C0ym8oJN2uKJ+Ro=
X-Received: by 2002:a05:651c:897:b0:25d:e574:b64 with SMTP id
 d23-20020a05651c089700b0025de5740b64mr5725889ljq.203.1658829508741; Tue, 26
 Jul 2022 02:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr> <20220726085447.csoxejg63ho2vrfk@pengutronix.de>
In-Reply-To: <20220726085447.csoxejg63ho2vrfk@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Tue, 26 Jul 2022 11:58:17 +0200
Message-ID: <CABGWkvr3nE9ihLTB0QM05UXzHUYS4N2U7OnOdFFyfOPFAYg84A@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] can: remove litteral strings used for driver
 names and remove DRV_VERSION
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Jul 26, 2022 at 10:54 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 26.07.2022 17:26:57, Vincent Mailhol wrote:
> > This is a cleanup series.
> >
> > The patches 1 to 8 get rid of any hardcoded strings and instead relies
> > on the KBUILD_MODNAME macros to get the device name. Patch 9 replaces
> > the ES58X_MODULE_NAME macro with KBUILD_MODNAME in
> > etas_es58x. Finally, also in etas_es58x, patch 10 removes the
> > DRV_VERSION so that the module uses the default behavior and advertise
> > the kernel version instead of a custom version.
>
> Added to linux-can-next/master. Dropped patch "[PATCH v2 03/14] can:
> slcan: add software tx timestamps", to let Dario Binacchi pick that up.

or "can: slcan: use KBUILD_MODNAME and define pr_fmt to replace
hardcoded names" ?

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
