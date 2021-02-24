Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA53234E4
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 02:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhBXBGu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 20:06:50 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:33474 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhBXALE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 19:11:04 -0500
Received: by mail-yb1-f169.google.com with SMTP id x19so93485ybe.0
        for <linux-can@vger.kernel.org>; Tue, 23 Feb 2021 16:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cml7mREV7L5A/aqvNQAAB5IflVJixN22fq1jq0gbRRA=;
        b=cvqN2OKf7in8ByhFpbjnQFzXjgmdOQ9YUSKLztB7AhzxrGEPETF3US0rs3Hvq0O3hB
         x8dMEcVxmsuq5d2ixkr/4+49uWuUMAAJKqOEBKRqwLbex5sXGnc6+Qho13vwtPvOaPJT
         z9HIW/xe2N2e7rqcUMNTlVJGcnWQYp4PmKvHgxtjYv1HrLL57VK0VqHN9rLlSns7GwC+
         4rUN5Xv6x+njvmIzQvxWXzubR3oYIUXfRXJkat44BC3EQxYWdmk8IDbxMG5diEPW807t
         /Hxg0Q+SwHYoIP5mz5wV7RSVjUakxwKepov4aOZqGpXizOAeIArH87ZKiCahxF/SR5xv
         Cx4w==
X-Gm-Message-State: AOAM531zs1gHjNynJbxhCDkgSlbfiDiYnpgWXdIRP6K4y3A4iujyp+6K
        d3jFjBazlzBW0owmAhVl1uDJ5H2JZwKVEWjh8ZhWaJQUYP5AnA==
X-Google-Smtp-Source: ABdhPJwylANlyaj45F25bMY6+YAhXGplUkJW7eRogMnd7ar/U4TowIO0bPUHa4nA3Z2rHi809Wh20dr5odsoQqmU5Qw=
X-Received: by 2002:a05:6902:4b2:: with SMTP id r18mr45085435ybs.226.1614125420922;
 Tue, 23 Feb 2021 16:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
 <20210223162852.218041-4-mailhol.vincent@wanadoo.fr> <87im6id0o3.fsf@hardanger.blackshift.org>
In-Reply-To: <87im6id0o3.fsf@hardanger.blackshift.org>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 24 Feb 2021 09:10:10 +0900
Message-ID: <CAMZ6RqJ71DW7=AaABijtLnvi1nX-z3eDTnwx=UZQhX-6AGu0Cw@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] can: netlink: move '=' operators back to previous
 line (checkpatch fix)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Wed. 24 Feb 2021 at 04:49, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 24.02.2021 01:28:50, Vincent Mailhol wrote:
> [...]
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -8,20 +8,18 @@
> >  #include <net/rtnetlink.h>
> >
> >  static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
> > -     [IFLA_CAN_STATE]        = { .type = NLA_U32 },
> > -     [IFLA_CAN_CTRLMODE]     = { .len = sizeof(struct can_ctrlmode) },
> > -     [IFLA_CAN_RESTART_MS]   = { .type = NLA_U32 },
> > -     [IFLA_CAN_RESTART]      = { .type = NLA_U32 },
> > -     [IFLA_CAN_BITTIMING]    = { .len = sizeof(struct can_bittiming) },
> > -     [IFLA_CAN_BITTIMING_CONST]
> > -                             = { .len = sizeof(struct can_bittiming_const) },
> > -     [IFLA_CAN_CLOCK]        = { .len = sizeof(struct can_clock) },
> > -     [IFLA_CAN_BERR_COUNTER] = { .len = sizeof(struct can_berr_counter) },
> > -     [IFLA_CAN_DATA_BITTIMING]
> > -                             = { .len = sizeof(struct can_bittiming) },
> > -     [IFLA_CAN_DATA_BITTIMING_CONST]
> > -                             = { .len = sizeof(struct can_bittiming_const) },
> > -     [IFLA_CAN_TERMINATION]  = { .type = NLA_U16 },
> > +     [IFLA_CAN_STATE]                = { .type = NLA_U32 },
> > +     [IFLA_CAN_CTRLMODE]             = { .len = sizeof(struct can_ctrlmode) },
> > +     [IFLA_CAN_RESTART_MS]           = { .type = NLA_U32 },
> > +     [IFLA_CAN_RESTART]              = { .type = NLA_U32 },
> > +     [IFLA_CAN_BITTIMING]            = { .len = sizeof(struct can_bittiming) },
> > +     [IFLA_CAN_BITTIMING_CONST]      = { .len = sizeof(struct can_bittiming_const) },
> > +     [IFLA_CAN_CLOCK]                = { .len = sizeof(struct can_clock) },
> > +     [IFLA_CAN_BERR_COUNTER]         = { .len = sizeof(struct can_berr_counter) },
> > +     [IFLA_CAN_DATA_BITTIMING]       = { .len = sizeof(struct can_bittiming) },
> > +     [IFLA_CAN_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
> > +     [IFLA_CAN_TERMINATION]          = { .type = NLA_U16 },
> > +     [IFLA_CAN_TERMINATION]          = { .type = NLA_U16 },
>
> You doubled the last entry by mistake.

Arf...
As you noticed, the double entry is then removed in the next
patch. That is because I saw the issue but miserably modified the
wrong patch.

I will correct this in v2.


Yours sincerely,
Vincent
