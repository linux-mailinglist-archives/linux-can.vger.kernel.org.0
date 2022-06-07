Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BAB53FB0C
	for <lists+linux-can@lfdr.de>; Tue,  7 Jun 2022 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiFGKSW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jun 2022 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbiFGKSV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jun 2022 06:18:21 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B99A5AB8;
        Tue,  7 Jun 2022 03:18:19 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31332df12a6so22245017b3.4;
        Tue, 07 Jun 2022 03:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBzzjrW5juvtMxlABnBwXXEgrG6Shz7BoM3Ydn6iWhA=;
        b=MeMtQVL0KVK1hB9C8LvqNpZSfMLubwEXLJKZ5JRzvLnJK6+M94rPNTP419KGP3D+6H
         5DunzGH4ba6UVXXlh+0p8DS9AIU8BhNydza8iPKTN5PcyWfvAzGFYqR0HHGDlgMMa5E2
         w0TK1Ip55TQOoatOriaJsEodS8QXrzRytwW54HyHbhKAQ+o6zFLVL9rsmZUxVFkSAHip
         t5DPZ5tsr18MY8jIPBSOYRkxMboMCKEfwhVi3yjssy94xLvFxkpIKsczUbrPSmavT3fT
         QPiVND8dkck+1h2T+MNsAvm2ZPlvUmaevCRNK38nyhp8Fi0VlZrBjwE5vK/gBWvv/DGS
         jSRQ==
X-Gm-Message-State: AOAM532DNN7Oqe31Zb5DPmJXdBP+sAr6BvnsgOr6YLq4Lmt2V017dtNd
        boo7TgcwEkxuJnSn94odPKTAzCxnsyJ3fpBQIvoETPVC1N2uZg==
X-Google-Smtp-Source: ABdhPJwabTB68SgD2RHKpT9rlldr7Ana6c6z5pASJyhvX7TkJ3Houss4f+xvmVxYmfN4Pab+dnnionFkSFhb8beGLAY=
X-Received: by 2002:a0d:ee47:0:b0:2ff:85e6:9e03 with SMTP id
 x68-20020a0dee47000000b002ff85e69e03mr30797967ywe.172.1654597099002; Tue, 07
 Jun 2022 03:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
 <20220604144157.208849-1-mailhol.vincent@wanadoo.fr> <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
 <a57f4af7-3fbc-0853-dd9c-b80b2425b4f5@suse.com> <CAMZ6Rq+6z-Nz=Nao2u_=LOC5QYF6KBjy-HdK1x41O4zo1c8HHg@mail.gmail.com>
 <66b14321-667a-46a3-27db-cb8682bd5476@suse.com>
In-Reply-To: <66b14321-667a-46a3-27db-cb8682bd5476@suse.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 7 Jun 2022 19:18:08 +0900
Message-ID: <CAMZ6Rq+CtOQ7Gn62QQqDd=_0dvCNhh5g_oXB6LmHEd0MfRym1g@mail.gmail.com>
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

On Tue. 7 Jun 2022 at 18:49, Oliver Neukum <oneukum@suse.com> wrote:
> On 05.06.22 15:45, Vincent MAILHOL wrote:
> >
> > This is how I see things:
> >   * In the open() function, the driver will do the coherent allocation
> > for its transfer_buffers, fill those into URBs and add all the URBs in
> > an anchor.
> >   * During runtime, the driver will keep recycling the same URBs (no
> > need to kill URB nor to usb_free_coherent() the transfer_buffer).
> Yes.
> >   * Finally, in the close() function, the driver has to kill the URBs
> > and usb_free_coherent() the transfer_buffers. As far as I understand,
> > no helper functions allow us to do all that, thus requiring the driver
> > to iterate through the anchor to manually usb_free_coherent() the
> > transfer buffer.
> Yes. But you cannot nicely solve that with a flag as you proposed. You
> would need to use a helper function.
> > So, the intent of this patch is to provide a method to both kill the
> > URBs and usb_free_coherent() the transfer buffer at once. The
> Well, you don't directly. Your patch frees the buffer together with the URB.
> That has some uses, but you still would need to iterate over the URBs
> Yes, there is a helper for that, but then you cover one and only one
> use case, that is, you leave no way to free the buffers without
> at the same time discrading the URBs.
>
> You can do that, but it strikes me as unelegant.

Elegancy is also my concern.

My RFC originated from this patch:
https://lore.kernel.org/linux-can/alpine.DEB.2.22.394.2206031547001.1630869@thelappy/

Here the proposed solution was to keep a pointer of all the
transfer_buffer in a local array to be able to free them when closing.
I really found that original patch to be unelegant which led me to
propose this RFC.
Comparatively, I still think my patch to be a more elegant solution,
and the original author also seems to share my thoughts.

If my patch is unelegant, then what would be the elegant/state of the
art way to free all this DMA allocated memory?
(pointing to any reference driver implementation should be enough for
me to understand).


Yours sincerely,
Vincent Mailhol
