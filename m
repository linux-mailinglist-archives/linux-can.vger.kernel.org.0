Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1DE545871
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 01:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346171AbiFIXS7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 19:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346130AbiFIXSz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 19:18:55 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AAC2050E3;
        Thu,  9 Jun 2022 16:18:49 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3137eb64b67so55129917b3.12;
        Thu, 09 Jun 2022 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dH0Dm0iPn6cgl1xgOOJlLmmw2nkyEf9WMupG8aaylQ=;
        b=O75lPcXoGbrfUKnZIgN+cPHeGiWV0dG2NRKCqGEfyXBrQbmuInb63ZtosPm8oMYp9P
         eD7gpi7nFEOKynpwPoEtI8QaNyDP+lwBHrJ0YH1FUNC6GKzU66+Wp7ZVeZpA7eJB+SQp
         hfB6BxtTrtpDS7CDyczaAiCH1ya/WTMVu8Qo+ii6UyV7z1YjZt+NbPVNj5F8m/HX93ih
         bMXFZqFmZ6MA34x47IQQwm+q3VapoLxOPZ54lGQqtcBgsFVGCYRjFPvinvs05zeC3d2i
         hKKGWK2LCQz7zeinKaScoSfVdzbyJvsSGkuzwobqCkGTYF9OWgpM3TdO8wCJUmeyUh1U
         Butw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dH0Dm0iPn6cgl1xgOOJlLmmw2nkyEf9WMupG8aaylQ=;
        b=76RuTJYm1pLDYnMoR0TJ495p1tWa0WMN14K8pYSll1FIG2LTyoO3VXjwq2WME89WOW
         mPvrcuwS74GXOWsB60HDRmgJRebbk+RfssbVVxWOMRpMcOY7OPYKVeJhUVBVaHIIAHPw
         kYlEvbRa45nWFlCF8IuvlQMsfRAdVvHrLFDs5g8CYrxr3gNqaaZIVFtmpjdl3x/pry/W
         NyB9dee9UYkRyMCcI59O+7VDeVNUqVBelhQGQvb8/FM23lIxmh/Sc48YxrUSRmSFsReK
         7tw2EVMIcr1zs2BASYijfJFpkCf5xQBHjyOpeE/DRq2mAGUD2AvQ5jj+JXFRTxpfw6kr
         sbJA==
X-Gm-Message-State: AOAM531VFD1D2FvAroMLlyO+i5SBOBjkeu5eGlD2t/zV1DlSmT0Vu3zh
        i+anOOyBIpqLKTwDIKpw2OASLkQtw1mHPUKkTJc=
X-Google-Smtp-Source: ABdhPJxhkZhVFYz6RvmAFkV5PZRNamjLYXTAVVDezobobRAPRGRSScvFmB977elghAWh+E0jKDye7wHJC798RZCIpFo=
X-Received: by 2002:a81:1845:0:b0:30c:b463:cff3 with SMTP id
 66-20020a811845000000b0030cb463cff3mr45252716ywy.45.1654816728483; Thu, 09
 Jun 2022 16:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220609204714.2715188-1-rhett.aultman@samsara.com> <20220609204714.2715188-3-rhett.aultman@samsara.com>
In-Reply-To: <20220609204714.2715188-3-rhett.aultman@samsara.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 10 Jun 2022 08:18:37 +0900
Message-ID: <CAMZ6Rq+SDwUTixrr87ZMC7_5JC+bJA-gx8nkYbkha75xV47sWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drivers: usb/core/urb: allow URB_FREE_COHERENT
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 10 juin 2022 at 06:13, Rhett Aultman <rhett.aultman@samsara.com> wrote:
> The URB_FREE_COHERENT flag needs to be added to the allowed flags set in
> order to prevent a "bogus flags" warning when it is used.
>
> Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> ---
>  drivers/usb/core/urb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index 1460fdac0b18..36c48fb196e0 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -507,7 +507,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
>
>         /* Check against a simple/standard policy */
>         allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |
> -                       URB_FREE_BUFFER);
> +                       URB_FREE_BUFFER | URB_FREE_COHERENT);
>         switch (xfertype) {
>         case USB_ENDPOINT_XFER_BULK:
>         case USB_ENDPOINT_XFER_INT:

Thanks for the testing and thanks for fixing this warning.
I do not think this needs to be a separate patch. You can squash it to
my patch and add Co-developed-by/Signed-off-by tags to reflect your
work.

Yours sincerely,
Vincent Mailhol
