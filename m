Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB91377653
	for <lists+linux-can@lfdr.de>; Sun,  9 May 2021 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhEILaA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 9 May 2021 07:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhEIL37 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 May 2021 07:29:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED206C061573
        for <linux-can@vger.kernel.org>; Sun,  9 May 2021 04:28:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so13683251wry.1
        for <linux-can@vger.kernel.org>; Sun, 09 May 2021 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaLM6gqnr87nZ/J/GoIbImlKOLbOi6aa/fwQ0JZIaSI=;
        b=bLewWa/lCyqxDDIcoZPSsZVSA4RaF6k9cxcr3z02/w0ecM/lOYQaIz1BVazRNLKf5x
         8omo5m+6MpN8c85jKZ1rcK3FmUhCKq/TPaJl6qrTxSm/iQRNwiHUoZCzGXBbi1I6iphy
         cjLDSPQuZUHjcLXLr0a7JcCk7C87RVe8EZ0uhAc/EYmV92B66150kEhW55CxFqKxe1Hu
         94HBWFmDfumdDVfI603DzGed4meHe6A+0vzVegsqEFtu0o/YFkWjCYz6NY5CLJJqnWrZ
         hKnfJfIyVdE4B1mF6JrOLhBnmvDDw1bGpt1veCoTw8jQqIPdVe8JQUl2OwidEjRlP8qD
         jNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaLM6gqnr87nZ/J/GoIbImlKOLbOi6aa/fwQ0JZIaSI=;
        b=P5NMJwq5swjO7xyc/KJ3A7VtBajRTSQinQjq0ev7DZvh+HA92CVqX1VPeXErcRYi+b
         vHJiJgklca9fI6yHO8lMnlpzaamXv+ay+MLlXtJu3BYOUlGH4+vZrnicZyKlKrJM4la6
         Dof8KZfkRLfCExjYyK75dkaTiKo56kUYj19G6v3framrUBR9oTGJN9vv7Lv7rWfMGu//
         VqV+0jZUBJgP1+febNPOFN09h65Y1Vtr7JQOBGl5TTRq1usK3qi2LY0enXYRjo1gTzXc
         WMRkDAcqIbYO/XOFXSrsmdF95UHrL/XhSk7YkbTZih9eLbuowUIciIVSSYGlO/GbqjoZ
         N8xA==
X-Gm-Message-State: AOAM533NM7zOeHd1pWXDtYDhLqYl0i6mluFLof53gZWLwrcFuj7Vf46e
        c9muP+6BvPrx3L1ijtdfG3PGFR7zfrdIRRhT0uoFfKv9slw=
X-Google-Smtp-Source: ABdhPJzsqntl5R/Miby/7ERXNOg2WCCToNoGvsQnGK8MtPVwWz/hzrC2lf814LUf6JUz7G3mNpZCZeLE1aGFLIAxoo4=
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr24478518wrw.49.1620559734469;
 Sun, 09 May 2021 04:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210504203546.115734-1-erik@flodin.me> <20210504203546.115734-2-erik@flodin.me>
 <cf5fdb14-47e2-2d08-0d29-c621bff7b312@hartkopp.net> <CAAMKmocxj1zOQastSqKhHmV0-9HVh3NpPmSPWf=byxj+fFPUHQ@mail.gmail.com>
 <64bf5aaf-1e8c-2f29-8263-63710a771843@hartkopp.net> <CAAMKmoda0U912_6Qp97fzt4BjcbUPDrE8Cy5C7C-TS5_7du31Q@mail.gmail.com>
 <46bdff5c-c0ab-56e9-7c70-8a3267458d55@hartkopp.net>
In-Reply-To: <46bdff5c-c0ab-56e9-7c70-8a3267458d55@hartkopp.net>
From:   Erik Flodin <erik@flodin.me>
Date:   Sun, 9 May 2021 13:28:40 +0200
Message-ID: <CAAMKmocsZBsFfpRLyLHqFE94xb-xrm5S8YG=QzQTndDjtOyuzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: add support for filtering own messages only
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 6 May 2021 at 07:26, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 05.05.21 20:54, Erik Flodin wrote:
> > On Wed, 5 May 2021 at 11:15, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> On 05.05.21 10:37, Erik Flodin wrote:
> >>
> >>>>> Add a new flag to can_rx_register/unregister that, when set, requires
> >>>>> that the received sk_buff's owning socket matches the socket pointer
> >>>>> given when setting the filter. This makes it possible to set a filter
> >>>>> that matches all frames sent on a given socket and nothing else.
> >>>>
> >>
> >> (..)
> >>
> >>>>
> >>>> Wouldn't that already match your requirements?
> >>>
> >>> I guess that would require me to use two sockets: one for sending
> >>> (with RECV_ONLY_OWN_MSGS set) and one for receiving. The problem might
> >>> then be how to avoid the second socket seeing the frames sent from the
> >>> first, without disabling loopback completly?
> >>
> >> This is indeed a question of the application layout.
> >>
> >>   From what I understood your main requirement is to double check the
> >> outgoing traffic whether is has been sent.
> >
> > What I would like to have is:
> > 1. Be notified when a frame has been sent. I send (from user space) a
> > single frame and wait until I get confirmation before sending the next
> > to give other nodes on the bus a slot to start sending, even if their
> > frames have ID with lower priority.
>
> o_O
>
> Sorry, but I have problems to get behind your use-case.
>
> 1. You are sending a frame
> 2. You get a confirmation
> 3. You are waiting some time (which is not written above), to give other
> nodes a slot??

No explicit sleep is needed. The machine is sufficient slow so that
just waiting for the confirmation before sending the next frame is
enough. But if the frames are queued in the socket/device then the
frames are sent back-to-back.

> 4. goto 1??

Yes.

// Erik
