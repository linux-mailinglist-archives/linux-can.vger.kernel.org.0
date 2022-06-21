Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9F9553513
	for <lists+linux-can@lfdr.de>; Tue, 21 Jun 2022 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352087AbiFUO73 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Jun 2022 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351048AbiFUO73 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2022 10:59:29 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD1026108;
        Tue, 21 Jun 2022 07:59:28 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id r3so24922401ybr.6;
        Tue, 21 Jun 2022 07:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlYEkEgHnc9Ae9Drr6+iNu963dX3eiVRPETKn6CwNAI=;
        b=Z7n/ZFEub9DXcESlVkgIlInsV3Xtbtf9iQzL/Crs5ODNJwN9JTNgpvVgZX1463v5Z/
         DeNH2LkNl0jd1rv4Zk+wIYC1z2GpVTg515uikEoQHWWhhNfVj8/veUdAM0ePuMB7B7Vb
         +nPoJIW6gKpIVXH6uGLDCvGZlhGNNKBw2CJg82AISlLtSJ4rMNG7fgzncCp2plyIhq32
         JGuRT29xD+IdPtUYCy4ZhpLlYqkuBsAr6jZ6PJGO7s1i4toTi4S4wUc88JKxpd869WSu
         TDV3rlAZn2vmmhLdGSAbrVzIapX3pGHKeefWKpePatOZrPdWlULASfoVDR5ge+FvkXk/
         1YZg==
X-Gm-Message-State: AJIora9HKqhRVQVuox0yQiOE15HpXvIAhPYGos/WwmQB00pIaqmzLwSO
        8jVIrQufP9tl11PP11gHmyav28PWZnD+HGsWuyI=
X-Google-Smtp-Source: AGRyM1vuJgzXGWBXA15accitt7xc/K+If2SFjz7y0+bz3M7n7OMPHXYl99p0We+tr/M1/t1emdk5w+sPFv8Fzh/nedE=
X-Received: by 2002:a05:6902:242:b0:668:f7e9:b2f8 with SMTP id
 k2-20020a056902024200b00668f7e9b2f8mr14328286ybs.423.1655823567485; Tue, 21
 Jun 2022 07:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com> <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com> <YrHM8mqG3WVVesk4@kroah.com>
In-Reply-To: <YrHM8mqG3WVVesk4@kroah.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 21 Jun 2022 23:59:16 +0900
Message-ID: <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>
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

On Tue. 21 Jun 2022 at 22:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Jun 12, 2022 at 01:06:37AM +0900, Vincent MAILHOL wrote:
> > On Sun. 12 juin 2022 at 00:31, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > On 10.06.2022 17:33:35, Rhett Aultman wrote:
> > > > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > >
> > > > When allocating URB memory with kmalloc(), drivers can simply set the
> > > > URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
> > > > will be freed in the background when killing the URB (for example with
> > > > usb_kill_anchored_urbs()).
> > > >
> > > > However, there are no equivalent mechanism when allocating DMA memory
> > > > (with usb_alloc_coherent()).
> > > >
> > > > This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
> > > > cause the kernel to automatically call usb_free_coherent() on the
> > > > transfer buffer when the URB is killed, similarly to how
> > > > URB_FREE_BUFFER triggers a call to kfree().
> > > >
> > > > In order to have all the flags in numerical order, URB_DIR_IN is
> > > > renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
> > > > value 0x0200.
> > > >
> > > > Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > > Co-developed-by: Rhett Aultman <rhett.aultman@samsara.com>
> > > > Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> > > > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > >
> > > FWIW:
> > > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > >
> > > This patch probably goes upstream via USB. Once this is in net I'll take
> > > the 2nd patch.
> >
> > Question to Greg: can this first patch also be applied to the stable
> > branches? Technically, this is a new feature but it will be used to
> > solve several memory leaks on existing drivers (the gs_usb is only one
> > example).
>
> We take in dependent patches into the stable trees all the time when
> needed, that's not an issue here.
>
> What is an issue here is that this feels odd as other USB developers
> said previously.
>
> My big objection here is what validates that the size of the transfer
> buffer here is really the size of the buffer to be freed?  Is that
> always set properly to be the length that was allocated?  That might
> just be the size of the last transfer using this buffer, but there is no
> guarantee that I can see of that says this really is the length of the
> allocated buffer, which is why usb_free_coherent() requires a size
> parameter.

Thanks for the comment.

I (probably wrongly) assumed that urb::transfer_buffer_length was the
allocated length and urb::actual_length was what was actually being
transferred. Right now, I am just confused. Seems that I need to study
a bit more and understand the real purpose of
urb::transfer_buffer_length because I still fail to understand in
which situation this can be different from the allocated length.

> If that guarantee is always right, then we should be able to drop the
> size option in usb_free_coherent(), and I don't think that's really
> possible.

I do not follow you on this comment. usb_free_coherent() does not have
a reference to the URB, right? How would it be supposed to retrieve
urb::transfer_buffer_length?


Yours sincerely,
Vincent Mailhol
