Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8E5458F3
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 02:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiFJAFY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 20:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiFJAFX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 20:05:23 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4C2EA404;
        Thu,  9 Jun 2022 17:05:21 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-30ce6492a60so257368847b3.8;
        Thu, 09 Jun 2022 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rw54DKLgsReePuyIeN6kM1mexgWFFu3bCYqVwRXSeus=;
        b=gHKqH6AnuMCobVdh8glhec8XDoxyJQHav52Xw9NVESk31p3JwcAM/Euk/DS0yauVyj
         62l6Byqf0hCILoqf0pNbrzVPb/BJuDOeklaxqLPU5ywycqJARAce28uzIsp9yvxpJPUz
         seXRVd6AuAfLRym1rqpb63uL1MN6cFKOLajYERU4E2PvxAF2puUT1F30fNEVLVdCVnCB
         8Hk6CT6zFBHEt3LwmpcccNLPKeh8GvQz6qU1QY3vBKIGFi8/bI4zq1hvJLC8KgwCO3zl
         HznHxSTnr5G2yCK1a5SJxBAeiPUK+RIGMbEloDCKBO5xf288FxhXR+UEhW/2+E0GLPL5
         tFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rw54DKLgsReePuyIeN6kM1mexgWFFu3bCYqVwRXSeus=;
        b=3TE6iPDBvSypw/vFEn0U8iTCCw7nGmxuVXXYOjOARHwK1ayZL3DtNf3iA/W26BDZhb
         9HAQ07OldAfFh15kCAnCj1PtugbL1lJ/KuqmMT3UMcSscpf8lBk+uy5vijn97ZWeAO/N
         m3KrVSH3fUefA075Cfe+QCLT433DuRu1F9Nz3vjFz47fCjX9bGSnoXYqzS1CNBaULK+i
         BfugGFqPMfBroBo9Ug4vWOoDvVwFAJEJL/btUKe4sciFSfEjhBvrYqJcpAu3QnSRGl3X
         0tmycgUPAp7toyHKMXIBWHWa7+5h+LmdFxEDSrvgeILbyoNcUQZiyq6n/99Gc/oIPL2P
         lhxQ==
X-Gm-Message-State: AOAM531n89w3JQR6x6zU/f73q5W/sofxPndnwoKFhFG+QNCSF107pPqr
        wQaNnYjtkCm+afkgsUlNFRdh7Ghv8snYVg83TzA=
X-Google-Smtp-Source: ABdhPJzsxKHS6848+DMMPwQeWowkHq7828o5WykA6d6FeE7wp1UeLOWMVtRdzTnGvszTWPjk0zZhPmG8OnRR+tnlE+8=
X-Received: by 2002:a81:60c6:0:b0:30f:ea59:10c7 with SMTP id
 u189-20020a8160c6000000b0030fea5910c7mr44589707ywb.78.1654819520875; Thu, 09
 Jun 2022 17:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220609204714.2715188-1-rhett.aultman@samsara.com> <20220609204714.2715188-4-rhett.aultman@samsara.com>
In-Reply-To: <20220609204714.2715188-4-rhett.aultman@samsara.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 10 Jun 2022 09:05:09 +0900
Message-ID: <CAMZ6RqKwvSswxThiKqEB8VhD5MyHvRbSwO_9-ZNwLgmnm-0iBw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] can: gs_usb: fix DMA memory leak on close
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 10 Jun 2022 at 05:53, Rhett Aultman <rhett.aultman@samsara.com> wro=
te:
> The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
> gs_can_open() and then keeps this memory in an URB, with the expectation
> that the memory will be freed when the URB is killed in gs_can_close().
> Memory allocated with usb_alloc_coherent() cannot be freed in this way
> and much be freed using usb_free_coherent() instead.  This means that
      ^^^^
and must

> repeated cycles of calling gs_can_open() and gs_can_close() will lead to
> a memory leak.
>
> Historically, drivers have handled this by keeping an array of pointers
> to their DMA rx buffers and explicitly freeing them.  For an example of
> this technique used in the esd_usb2 driver, see here:
> https://www.spinics.net/lists/linux-can/msg08203.html
>
> While the above method works, the conditions that cause this leak are
> not apparent to driver writers and the method for solving it at the
> driver level has been piecemeal.  This patch makes use of a new
> URB_FREE_COHERENT flag on the URB, reducing the solution of this memory
> leak down to a single line of code.
>
> Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index b29ba9138866..3ded3e14c830 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -768,7 +768,7 @@ static int gs_can_open(struct net_device *netdev)
>                                           buf,
>                                           dev->parent->hf_size_rx,
>                                           gs_usb_receive_bulk_callback, p=
arent);
>
> -                       urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> +                       urb->transfer_flags |=3D (URB_NO_TRANSFER_DMA_MAP=
 | URB_FREE_COHERENT);

Nitpick but parenthesis are not needed here. Also, there are no
reasons to do a |=3D. I would prefer to see this:
        urb->transfer_flags =3D URB_NO_TRANSFER_DMA_MAP | URB_FREE_COHERENT=
;

>                         usb_anchor_urb(urb, &parent->rx_submitted);

I looked at the code of gs_usb, this driver has a lot of dust. What
strikes me the most is that it uses usb_alloc_coherent() each time in
its xmit() function instead of allocating the TX URB once in the
open() function and resubmitting then in the callback function. That
last comment is not a criticism of this patch. But if someone has the
motivation to do some cleaning, go ahead=E2=80=A6

Aside from the nitpicks, the patch looks good to me. You can add this
to your v3:
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol
