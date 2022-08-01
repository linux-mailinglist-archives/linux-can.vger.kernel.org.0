Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC52587067
	for <lists+linux-can@lfdr.de>; Mon,  1 Aug 2022 20:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiHAS2d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Aug 2022 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHAS2b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Aug 2022 14:28:31 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385531DD6;
        Mon,  1 Aug 2022 11:28:30 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id q16so10398358pgq.6;
        Mon, 01 Aug 2022 11:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rglz1TTxTmf+c3cdK8Q5dI8qChhX6LpSVcgQgfQx+fg=;
        b=6LO21PynwbNGu+nR0+oEIvXTDNgOTw2ORF0l1KK2AsnQiDENQGkCYiDa/gxySTVWX8
         icRuOJPSPcZUarCjjeL7tsIz0uKK9eBbguPnV3QEUy5m8YpDdi3+Vj00L6L933Uc2C0X
         0nogZ0hSueVXvF7o5Xifmcih6sohhFKz5AmMn9Hc1oZ7vfJY1VEvrGYTOXTFvA/WCAU/
         XGxiu3PRJJUy0E+59giwqUh38xrcwnsRwNiGQZ+Jil9WPchU2gUELry0N0+luZ8rTQKq
         01S59e4bfMgrvSlvCfGhlkKU13M+XHimJp+4+ZMRT5LLhGnZV4VMy3CvMeXnSQOP6/lS
         PZHg==
X-Gm-Message-State: AJIora9SgV2MP5E2RLP0BDeba9kaxtAj3ED9AEeY02FnoXn3jMyjylUX
        XbF6niqEQUOkzAbIaZd1lG1M81ZuLR9vNUQHF2E=
X-Google-Smtp-Source: AGRyM1tpsZmJJw5Lk/y0+O1+Ly7WkLbLfPm0H7j0RHsNs0KbMOWnoVI7rEbN4KfJOTy5lmvBymMN2FflU+0FD2zRq+4=
X-Received: by 2002:a05:6a00:21c8:b0:52b:ffc0:15e7 with SMTP id
 t8-20020a056a0021c800b0052bffc015e7mr17640398pfj.29.1659378509910; Mon, 01
 Aug 2022 11:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com> <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <YrSjRvb8rIIayGlg@Sun> <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
 <YrXNltWSYbplstPx@rowland.harvard.edu> <aaf64d6c-1893-67ed-013e-67d21c8be152@linuxfoundation.org>
 <YrX9SBpxp1E2cOyI@rowland.harvard.edu> <e1c416bc-0239-6070-c516-c98332a6491d@linuxfoundation.org>
 <Yrpa1zpwfauSMoTi@rowland.harvard.edu> <b18313ab-c408-83dc-ee96-a64a432fbfcb@linuxfoundation.org>
 <07e82270-cc75-d346-72cf-0a60ffba06dc@linuxfoundation.org>
In-Reply-To: <07e82270-cc75-d346-72cf-0a60ffba06dc@linuxfoundation.org>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 2 Aug 2022 03:28:18 +0900
Message-ID: <CAMZ6RqKmxzcCEGFyt3wB6rfHECHhLxb3phcs=FOQZGs_S_cvMA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Hongren Zenithal Zheng <i@zenithal.me>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 2 Aug. 2022 at 02:48, Shuah Khan <skhan@linuxfoundation.org> wrote:
> On 6/30/22 8:10 PM, Shuah Khan wrote:
> > On 6/27/22 7:35 PM, Alan Stern wrote:
> >> On Mon, Jun 27, 2022 at 04:54:17PM -0600, Shuah Khan wrote:
> >>> On 6/24/22 12:07 PM, Alan Stern wrote:
> >>>> In the future people will want to make other changes to
> >>>> include/linux/usb.h and they will not be aware that those changes will
> >>>> adversely affect usbip, because there is no documentation saying that
> >>>> the values defined in usb.h are part of a user API.  That will be a
> >>>> problem, because those changes may be serious and important ones, not
> >>>> just decorative or stylistic as in this case.
> >>>>
> >>>
> >>> How often do these values change based on our past experience with these
> >>> fields?
> >>
> >> I don't know.  You could check the git history to find out for certain.
> >> My guess would be every eight or ten years.
> >>
> >>>> I agree with Hongren that values defined in include/linux/ should not be
> >>>> part of a user API.  There are two choices:
> >>>>
> >>>
> >>> I agree with this in general. I don't think this is an explicit decision
> >>> to make them part of API. It is a consequence of simply copying the
> >>> transfer_flags. I am with you both on not being able to recognize the
> >>> impact until as this is rather obscure usage hidden away in the packets.
> >>> These defines aren't directly referenced.
> >>>
> >>>>     Move the definitions into include/uapi/linux/, or
> >>>>
> >>>
> >>> Wouldn't this be easier way to handle the change? With this option
> >>> the uapi will be well documented.
> >>>
> >>>>     Add code to translate the values between the numbers used in
> >>>>     userspace and the numbers used in the kernel.  (This is what
> >>>>     was done for urb->transfer_flags in devio.c:proc_do_submiturb()
> >>>>     near line 1862.)
> >>>>
> >>>
> >>> I looked at the code and looks simple enough. I am okay going this route
> >>> if we see issues with the option 1.
> >>
> >> It's up to you; either approach is okay with me.  However, I do think
> >> that the second option is a little better; I don't see any good reason
> >> why the kernel should be forced to use the same numeric values for these
> >> flags forever.  Especially since the only user program that needs to
> >> know them is usbip, which is fairly closely tied to the kernel; if there
> >> were more programs using those values then they would constitute a good
> >> reason for choosing the first option.
> >>
> >
> > Thank you Alan and Hongren for your help with this problem. Since there
> > are no changes to the flags for the time being, I am comfortable going
> > with the second option.
> >
> > I will send a patch soon.
> >
>
> Patch is almost ready to be sent out. Changes aren't bad at all. Hoping to
> get this done sooner - summer vacations didn't cooperate.
>
> Just an update that I haven't forgotten and it will taken care of.
> thanks,

Thanks for keeping this under your radar. I also have on my TODO list
to send a new version of my patch to add the `URB_FREE_COHERENT' flag
but this time adding an `allocated_length' field to struct urb. I will
wait for your patch to go first. By the way, I will be out for summer
holiday for the next couple of weeks so I wasn't planning to submit
anything soon regardless.

Yours sincerely,
Vincent Mailhol
