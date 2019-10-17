Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84EADB20F
	for <lists+linux-can@lfdr.de>; Thu, 17 Oct 2019 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404687AbfJQQNo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Oct 2019 12:13:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41383 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404522AbfJQQNn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Oct 2019 12:13:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so2356028lfn.8
        for <linux-can@vger.kernel.org>; Thu, 17 Oct 2019 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zT61HrC5IdU2SPC8nl76JQHUxTVCg/LPIiL1UqreXW8=;
        b=Vb49nb45mjj4S2IJDKTjFXCDmLY0TWQsf4dk3PNwKGPbVYjmTwzXtue7GQTk/1oQ3s
         WZaNouUQquD6ibAW5os9Pirwy8BMPV67j2hc/iyhTv4x7EaLJUvt1YBlMjlSSGza1Tel
         krFD902ZR6P15BA686FYOX+Yw7EWXzs3bw/6HjLKe0nlGJsjNGbC238YqPYc/Gez3TGx
         RVsPQXJ1GnYmEUQqv6WAZN8zHPuMHZNle1E+tPj60Yx+ZCn1W27OVxy5+yipjgmDNobX
         ZPPC+HyHQR1jcDS/cmHubi+GGCSiki+o88frjkncoGxEAuxpFgPju6fM6Pz6OM3W3H1D
         CUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zT61HrC5IdU2SPC8nl76JQHUxTVCg/LPIiL1UqreXW8=;
        b=r+OaSjNW4FO/2oyciEWy6T9AtZDy+/wn9osKa7Gj9eLn8NY/jVF32zMw6BXbnUoWE/
         JoyNJQ06eoRXViSrEMGCNysNLA2KIsLeBzPC6q9lN3f/hoyLZMoL1YoCfSQK7NSsDiga
         j80yCnx4p+UXg/lfqMZCfqIh52I/p5w8+0B55IK5l/UqtEYvCe2w6Cj35wPXR+F5KQPv
         WAqGMNATov6nbLm+FnTh6QqlXUoxy4bDxoUu8EZSFm8SPAY2JfcTBfA1zRQD7DgHdF1+
         CpsHQmofgNzs9r/0FP/GZeYrrOtAhHPmOOe8g8+BP+2CCfOOP5FvUTCB1XNzFXlpgfDt
         0qWA==
X-Gm-Message-State: APjAAAV4mLwlBWd6oNGdYvEy9MXiiDyxVBl9V6g43Oil2AJ9dX1fo9Lk
        iVzd0gZzQY1Z1vj80qoLnfnd2L7N/AW7HHvbvME=
X-Google-Smtp-Source: APXvYqyApsO9Y8SYHnTkHStLqksDeoajoKmBSlEy4FwNeP0aqVau5062TmL4Dz+3ZHf0sc3nTOJCCtQbRzvOcLGAfls=
X-Received: by 2002:a19:ae18:: with SMTP id f24mr3062766lfc.186.1571328821835;
 Thu, 17 Oct 2019 09:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHChkrv6cKgNam-znKu_wOZm-y6gNkONmGWP6RFZpiSprq5_gQ@mail.gmail.com>
 <896bd824-1149-4229-a703-d2c946acd92b@pengutronix.de> <20191017074727.GA700@x1.vandijck-laurijssen.be>
In-Reply-To: <20191017074727.GA700@x1.vandijck-laurijssen.be>
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Thu, 17 Oct 2019 11:13:30 -0500
Message-ID: <CAHChkrsBMQy+=dQv-0JYqp7jrg3UvmQ_4JdR9WYrjAioNxfigw@mail.gmail.com>
Subject: Re: c_can/d_can driver question
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks, Marc and Kurt.

>> Can you give me a pointer to this driver? Are you talking about the
>> mainline linux-3.1?

I sit corrected on this one. Further investigation indicates that this
driver (authored by TI for AM335x)  was never submitted to mainline
Linux 3.1.
Here is the link to the driver:
https://github.com/calixtosystems/linux-am335x/tree/master/linux-am33x/drivers/net/can/d_can.

>> The algorithm that tries to read the CAN frames in the correct order was
>> added in v3.15. That algorithm should be ported to the rx-offload
>> helper. This way the mailboxes can be read in interrupt context and not
>> from NAPI (which runs in softirq context only).
>>
>> If this basically works, it can be extended to support 64 mailboxes.
> I'm facing overflows, and have good results with the patchset I sent
> last week. As Marc says, reading the mailboxes in NAPI softirq may cause
> regular overflows.

Ok.  I see the newer changes to the c_can driver and will be trying those.

--elenita


On Thu, Oct 17, 2019 at 2:47 AM Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
> On wo, 16 okt 2019 23:01:41 +0200, Marc Kleine-Budde wrote:
> > On 10/16/19 9:06 PM, Elenita Hinds wrote:
> > > I'm hoping someone can help me with this ...
> > >
> > > The DCAN module I'm testing with supports 64 CAN messages and DMA. The
> > > combined c_can/d_can driver seem to only support 16 RX message objects
> > > and no DMA (as far as I can tell).
> >
> > ACK
> >
> > > I noticed that older Linux version
> > > (3.1) implemented a separate d_can driver that supports both.  I'm
> > > wondering why these were removed from the latest c_can/d_can files.
> >
> > Can you give me a pointer to this driver? Are you talking about the
> > mainline linux-3.1?
> >
> > > The reason for this question is I'm seeing frame losses and I think it
> > > is due to the driver. Increasing the socket buffer sizes did not have
> > > any effect; the number is overruns was still pretty large.
> > >
> > > Any feedback would be appreciated.
> >
> > The problem with the c_can and d_can is, that it doesn't have a proper
> > FIFO but only mailboxes. And these mailboxes don't implement a
> > timestamp, so that it's not that easy to read messages in the correct order.
> >
> > Does the device support bus master DMA? As CAN messages are quite small,
> > the overhead of setting up DMA might be too high.
> >
> > The algorithm that tries to read the CAN frames in the correct order was
> > added in v3.15. That algorithm should be ported to the rx-offload
> > helper. This way the mailboxes can be read in interrupt context and not
> > from NAPI (which runs in softirq context only).
> >
> > If this basically works, it can be extended to support 64 mailboxes.
>
> I'm facing overflows, and have good results with the patchset I sent
> last week. As Marc says, reading the mailboxes in NAPI softirq may cause
> regular overflows.
>
> Kurt
