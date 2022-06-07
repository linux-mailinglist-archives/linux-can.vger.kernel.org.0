Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74453FE76
	for <lists+linux-can@lfdr.de>; Tue,  7 Jun 2022 14:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbiFGMMu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jun 2022 08:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiFGMMq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jun 2022 08:12:46 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D217938199;
        Tue,  7 Jun 2022 05:12:42 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id s39so3232758ybi.0;
        Tue, 07 Jun 2022 05:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEwK1vx/2yk7NVaeI2J3y3hC1hEAxTfNuhq4EHfuIWo=;
        b=x3LN9S0TpXGy5QtW9xdsvKR6bbp1zglrnwdV9RwSPXVEMb6eTj0HDK0Q5UksQz5SyE
         refFWWQp6v5X+LO+XXRv9IRcAcxask9ZOrd6+NvElyOerBRPYecuxCnXQS5JSok8Ulbt
         vRgKI33qh7pOMWoZ1hLek0EB96xtlcgXKHmhUrzaEBmgpnilZXz/+mPgiMHsdSS8O1e3
         1Pm6jwes1ga3qxgonJKYIMp8Nzh5fFACc1tIrD8h9eUYDNA1kS48IXg8m9nYniPur1bp
         ra/zs9fDB/wVRINMt5E8R9dGLhLJvM/oHa/pqo941aKtMCOQ2Ui+agZS9HeyghC/9wDQ
         G3sA==
X-Gm-Message-State: AOAM530bAWR6rQQ5ZHKSrZLSzuekPeQrwrkkGPBkrpNtACizaUAkFlPU
        k713bnBadqjSIQA4wFtao7Ywp8+CFfIgPpZjGA4=
X-Google-Smtp-Source: ABdhPJz+7xVTAKU4E2nSG2gZCZspR2k1aXKXEyrsPokqKGyQ/9qqsd1pWIM5coR/qhCHRQrgwcaEigfKv2yk+aVpIrw=
X-Received: by 2002:a25:3145:0:b0:64e:ac9a:eb27 with SMTP id
 x66-20020a253145000000b0064eac9aeb27mr29000721ybx.630.1654603961914; Tue, 07
 Jun 2022 05:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
 <20220604144157.208849-1-mailhol.vincent@wanadoo.fr> <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
 <a57f4af7-3fbc-0853-dd9c-b80b2425b4f5@suse.com> <CAMZ6Rq+6z-Nz=Nao2u_=LOC5QYF6KBjy-HdK1x41O4zo1c8HHg@mail.gmail.com>
 <66b14321-667a-46a3-27db-cb8682bd5476@suse.com> <CAMZ6Rq+CtOQ7Gn62QQqDd=_0dvCNhh5g_oXB6LmHEd0MfRym1g@mail.gmail.com>
 <409f73a8-8679-61ff-4da6-018833c7a96d@suse.com>
In-Reply-To: <409f73a8-8679-61ff-4da6-018833c7a96d@suse.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 7 Jun 2022 21:12:30 +0900
Message-ID: <CAMZ6RqJ8MTQJ=tfK0f7+04skq0ov-WEHSwwe_4CN1Qka38f=Hg@mail.gmail.com>
Subject: Re: [RFC PATCH] USB: core: urb: add new transfer flag URB_FREE_COHERENT
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can <linux-can@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 7 Jun 2022 at 20:46, Oliver Neukum <oneukum@suse.com> wrote:
> On 07.06.22 12:18, Vincent MAILHOL wrote:
> > Here the proposed solution was to keep a pointer of all the
> > transfer_buffer in a local array to be able to free them when closing.
> > I really found that original patch to be unelegant which led me to
> > propose this RFC.
> It was.
> > Comparatively, I still think my patch to be a more elegant solution,
> > and the original author also seems to share my thoughts.
> >
> > If my patch is unelegant, then what would be the elegant/state of the
> > art way to free all this DMA allocated memory?
> > (pointing to any reference driver implementation should be enough for
> > me to understand).
>
> I have two options to offer.
>
> 1. Use the existing URB_NO_TRANSFER_D;MA_MAP to decide
> how to free memory.

If doing so, all drivers using DMA would need to be adjusted (or else
that would be a double free). Similar to URB_FREE_BUFFER, I think it
must be a separate flag so that the drivers still have the option to
release the memory by hand if needed for specific use cases.

> 2. Provide an explicit API in usbcore among the anchor API

Like a usb_kill_anchored_urbs_and_free_coherent()?

Wouldn't it be inconsistent with the URB_FREE_BUFFER flag? It is weird
to me if a normal kmalloc()ed buffer would have to use a flag and
DMAed buffers a special API call.
I mean, yes, it would work but I am not convinced that this approach
is more elegant.

The other advantage I see in my approach is that by setting the
URB_FREE_COHERENT flag, all the kill/free functions from the URB API
would benefit. For example, usb_free_urb() would also benefit. Right
now, I only see the use case for usb_kill_anchored_urbs() but I am
worried that we will have to duplicate many of the URB API.


Yours sincerely,
Vincent Mailhol
