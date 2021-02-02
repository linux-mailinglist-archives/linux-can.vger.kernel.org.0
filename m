Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4130BCBC
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 12:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhBBLN3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 2 Feb 2021 06:13:29 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:43266 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhBBLNZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 06:13:25 -0500
Received: by mail-yb1-f174.google.com with SMTP id y128so20011936ybf.10
        for <linux-can@vger.kernel.org>; Tue, 02 Feb 2021 03:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iUVswe4zmhP5ywb/Hm5XxbnHvtzALyIeaxgZyr8SRvs=;
        b=D7tKFM+Nl84XL59dCCDFOqMIgIiJhKD8uNth9KsW3lmG4ERGMRo/vjnUS3d0/j4OEk
         bUZbWtfU0ipGGYzUjuPJBSnVGWH8xfkP6jTRnkL+xlKqT3o5KxWsQRPdU0HAcSGfzXS1
         GMQkpEijKM5HXig0CalJfDwD1xtBgFSsRyDgmT+j+QUXhNNOgLzAkOXc5rBHd27Jrmfc
         dLjzPA/r/U7cxcZE0rqlIFq8ncdd7uEqSVklk/0le1eOQzbg01a2vG+0fdMGwQtW+GgZ
         rglBc4/8r6GowKc8KYrzqfcB4bZOtJDkXMeD3uPH+9qqpz9c6kfMon9xpWdHpSUPNQkw
         22ig==
X-Gm-Message-State: AOAM5327Lnq88p2MJshP/VW/DUzSNJaeA/RS3jsHW1+d6RFjByBgYmLt
        0UZW6YDVu/f1ZXgTzr20wgJWK7KbecyqcqJIxKU=
X-Google-Smtp-Source: ABdhPJyW8cWzsiOlq60rVat30ena5FzzjWHCNz/IF0nK/A4LnBRcJTtP9FkzKBukw863JQ0RIQISVj18iH2G8TX8GQs=
X-Received: by 2002:a25:dec2:: with SMTP id v185mr4747627ybg.145.1612264363846;
 Tue, 02 Feb 2021 03:12:43 -0800 (PST)
MIME-Version: 1.0
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net> <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
 <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com> <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
 <17b14b11-87bf-9508-0da5-1031c5d5e132@pengutronix.de> <20210202082340.GA23043@x1.vandijck-laurijssen.be>
 <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de> <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net>
 <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de> <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
 <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com> <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net>
In-Reply-To: <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 2 Feb 2021 20:12:32 +0900
Message-ID: <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
Subject: Re: [Question] Sending CAN error frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 2 févr. 2021 à 19:14, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 02.02.21 11:00, Vincent MAILHOL wrote:
> >>> If CAN_CTRLMODE_TX_ERR has been added to the kernel and
> >>> can_dropped_invalid_skb() is updated, then a CAN frame with CAN_ERR_FLAG set
> >>> would be either send as an error frame or dropped by can_dropped_invalid_skb().
> >>>
> >>> So it would be echoed only if the driver supports CAN_CTRLMODE_TX_ERR and it's
> >>> enabled.
> >>
> >> ACK.
> >
> > The echo would be special here.  We have to remember that the
> > payload of the CAN_ERR_FLAG frames is an arbitrary design. This
> > payload has no meaning for the data link.
> >
> > When we echo back the frame, only the DLC, CAN ID and payload of
> > the TX frame are irrelevant (except for vcan).
> >
> > My current idea would be to follow what Kvaser did: they send the
> > frame and the device reports the error flag (c.f. the example
> > given by Jimmy above). So the echo feature would not be used
> > for error flags.
>
> In fact I would suggest to think a about a proper API (aka CAN frame
> content definition) for outgoing CAN frames with the CAN_ERR_FLAG set.
>
> The CAN_ERR_FLAG has been renamed in the documentation to indicate
> "error messages" from the CAN controller, as an error frame is something
> completely different.
>
> Now as we are talking about having CAN_ERR_FLAG in the TX path besides
> the vcan testing stuff, we should think about an API for the really
> outgoing frames.
>
> We could not only think about "create an error frame right now" but also
> think about a more intelligent CAN node, which also offers to destroy
> one or more specific CAN ID(s) at a specific bit position after
> detecting that CAN ID.

My original idea was to leave it unspecified until a device was
actually capable of doing such a thing. But I am not against
defining the API now :) We might just have to wait a long time
for someone to actually implement it.

> We could use the CAN_RTR_FLAG and the data[] section of the outgoing
> error CAN frames for such an API.

We are not limited to the CAN_RTR_FLAG and the data[]

First, we have to list the use cases.

As I wrote before, there are only two forms for the error flag:
  - The active error flag: 6 consecutive dominant bits
  - The passive error flag: 6 consecutive recessive bits

The device can either inject the flag either during:
  - bus idle
  - while it is transmitting a frame
  - while it is receiving a frame
The error flag can occur at any time.


My first proposal would be:

 1/ One flag to specify the error flag form (active or
    passive). Passive error flags can not be used when receiving
    a frame.

 2/ One flag to specify if we inject during bus idle or not.

 3/ One flag to specify if we inject while transmitting or
    receiving a frame.

 4/ If injecting while receiving, have the ability to specify
    the CAN ID, DLC and flag filters (EFF, SFF, RTR, BRS...) of
    the frame on which we want to inject the error flag. I do not
    see the need for a complex filter. I would propose to either
    have an exact match or no match (e.g. inject on next frame
    whatever this frame is).

 5/ One flag to specify if injection while transmitting is done
    on exact match or on any frames (if done on any frames,
    the filters 4/ are ignored). This flag is ignore for bus idle or
    while receiving.

 6/ If we inject while receiving, do it on the next normal frame
    we transmit (no filter). The userland have to send two frame:
    one with CAN_ERR_FLAG and one normal one on which we
    will inject the error flag in order to use the feature.

 7/ Have an offset: the bit index on which we want to inject the
    error flag. I am not yet sure if we should ignore bitstuffing
    or not. If the bus is idle, wait offset bit times before
    injecting. Else, start counting the bits from the Start of
    Frame.


The flags 1/, 2/, 3/, 5/ and the offset 7/ goes into the data[]
payload, the filters 3/ goes into their respective field (CAN ID,
DLC, FF, SFF, RTR, BRS flags).



Yours sincerely,
Vincent
