Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB2F1761
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 14:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfKFNjy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Nov 2019 08:39:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38336 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFNjy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 08:39:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so18899831pfp.5
        for <linux-can@vger.kernel.org>; Wed, 06 Nov 2019 05:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke8coMwjzpUJJRORFQqrEkPdRrRfsJ/SAVAzf+RZb9A=;
        b=lO3GXJVnf7vIp4mJXYcle5VNdtdOz/WluFvsDJIkYq+SathFZrvpARdz2RyNjHygRi
         eGZP8mnQhUo99v6mpfUzyOPgaKDOJTAmtIyKXZeYdvh8R8I+0OjqiSgom/eqoFCVptUm
         7QRVwiIdg14/e3nkbGfQWY1XwvzEFyX/MoJ0tAd8pWHX/MiS6GzReWHCGTA5YVKbFfSl
         CdbyJ7eFdJccyK6PVGW0RK8kZ6ikgmYfQtWND4BcEPuG++2+6OPkQ/TgHY1N8IRoIV1p
         3lfu4aVVI43qY/YudbD0sRFbZAdyN5KXSDQL58El/GcegmT1GhWGk0ipgZaHbUNad7fO
         4V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke8coMwjzpUJJRORFQqrEkPdRrRfsJ/SAVAzf+RZb9A=;
        b=WOuAZ/ALaCA3CYalQdFcIW0Xlup5is86ulM+EEbk4LZWVI2ku0x2F1QKvM+zpJc89P
         JhkhljYQqc48cr+LDFNvs61U04KDv4a/7a3OsLhcL8QtMHKZFykcuTg4kXgKff/JljzB
         D2rHMGin4WqymGYIdkcH5A8Lm5ca7CVw6Q6LJBhaoOl4iDav4VyneEIqrHGwslNRuBUe
         iGSHzjAcBedVW+I9YG0h6VwZo2sOoEiTR9Pgt56ub7tfe+QpwoB60dhYms44KKb2+Que
         yaMG08pDw1GYWD9rePu6dFII4b4iWpaBfFLV5zNoq+qQ9hEkQu2pgQg5JA55hhTS74pq
         9bKw==
X-Gm-Message-State: APjAAAXDhy+/giQnickSXosylpiDlb3YMFZGJhsyFbBnNSiMcmsJNz2G
        j9u83qYyoW/Nzgg9z4jnizXUVZTcmERgI6h9AYYxC+NX
X-Google-Smtp-Source: APXvYqw+M9mzpjEroH49YLYO3Yyer0idJ2SYjfS7svt1ZoLlAWQucGhTLnzAHa7L5fOP8En1MRHfXPIhspi/ieT5ifU=
X-Received: by 2002:a17:90a:b90b:: with SMTP id p11mr3984361pjr.73.1573047593596;
 Wed, 06 Nov 2019 05:39:53 -0800 (PST)
MIME-Version: 1.0
References: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com>
 <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com> <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net>
In-Reply-To: <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net>
From:   Jaroslav Beran <jara.beran@gmail.com>
Date:   Wed, 6 Nov 2019 14:39:41 +0100
Message-ID: <CADNXvDytmhBaZy08KVftU9vKqaqM+8XdCaXTtb3T_MQ4Th=vOQ@mail.gmail.com>
Subject: Re: Fwd: Return value of write() in BUS-OFF state
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver,

On Wed, Nov 6, 2019 at 12:12 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hello Jaroslav,
>
> On 05/11/2019 22.46, Jaroslav Beran wrote:
>
> > So far I've learned this issue is most probably caused by upper (net
> > and can) layers (so this is not specific for certain controller
> > driver). When a driver calls can_bus_off, it sets carrier-off and
> > triggers linkwatch_* actions that deactivate net queues and substitute
> > a struct qdisc with `noop_qdisc`. Upon sending a frame, it's enqueue
> > function - noop_enqueue - just returns NET_XMIT_CN, which is
> > transformed by net_xmit_errno macro to zero, that's passed by
> > net/can/af_can.c:can_send up to a userspace caller of write as
> > success.
>
> Hm.
>
> > According to description for qdisc return codes in
> > include/linux/netdevice.h, NET_XMIT_CN stands for `congestion
> > notification` and further
> >
> > /* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
> >   * indicates that the device will soon be dropping packets, or already drops
> >   * some packets of the same priority; prompting us to send less aggressively. */
> >
> >
> > Is this behavior appropriate for a node in BUS-OFF state? I'd rather
> > expect such controller would be always dropping all frames (not just
> > soon and some) until reset.
>
> The common use of the net_xmit_errno macro probably really does not fit
> to the CAN specialties ...
>
> > In current situation a caller of write gets success even if his frame
> > is lost for sure. Is there any specific reason for this? Of course he
> > can be notified by receiving error frame, but why don't just return
> > error in can_send?
>
> Yes. It makes sense to forward the carrier-off state that is thankfully
> provided by the linkwatch triggers to the user space.
>
> Looking to man(2) send we should provide -ENOBUFS in the case of
> carrier-off state, right?

Maybe -ENETDOWN is more suitable?

>
> Would you like to provide a patch?

Sure.

Best regards,
Jaroslav
