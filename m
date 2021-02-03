Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065B630D530
	for <lists+linux-can@lfdr.de>; Wed,  3 Feb 2021 09:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhBCI1J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Feb 2021 03:27:09 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:38508 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhBCI1E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Feb 2021 03:27:04 -0500
Received: by mail-yb1-f179.google.com with SMTP id i6so16802365ybq.5
        for <linux-can@vger.kernel.org>; Wed, 03 Feb 2021 00:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SfDCgsLPVNMkoPlfHEnYZdnYjdV5IflalDNzAtWbxk=;
        b=bGDhmV+BbvnMnkWQ+PwaOb5nL60wyB/Qz7J6Mo0o1rB5aqErRs9VlDO2KPq3NM8E8i
         iTaaFCuEOsypzM5Pse/3IDQqHkaG/FkhQS4P/AUJ8P5yreRxl5+V2mlmpUMcc+Oyt6d8
         OMu3+0udDXylYmlHeZNsUsmQYK4z6GIQ9ottlFjv42SXLJoH81BzaIiR2vNDnW6CTLgT
         I8Qlykuy+P1FX1WaA6KeEZqV6T/9UiDxrGLnLHr1jc2SjWv/i+8nWarptfaEK0zXNEa/
         UIy0WV+JpnN3BWouvJxYZe73TdvEC8ee7suE3ouIvcOrdQXzWH+/RD2Sj4agc0fmkKoK
         HJhA==
X-Gm-Message-State: AOAM533ayf0uVqW+uy5p5tv27bscEH+ERO03ObF0AwZL7WrsWbMx1beH
        JxMM3dO4/wtp2Qg5PkuZvihkDkQrPOwirpEsqZU=
X-Google-Smtp-Source: ABdhPJxkXoL8IYcirec2lDAjr7YxfQ3JjSkWuscIob4gP3jvtmP3LB/4PdQz9AzKM25Y/sOysGWHuVcGgL8JT5PxzxE=
X-Received: by 2002:a25:ba05:: with SMTP id t5mr2672938ybg.360.1612340782927;
 Wed, 03 Feb 2021 00:26:22 -0800 (PST)
MIME-Version: 1.0
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net> <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
 <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com> <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
 <17b14b11-87bf-9508-0da5-1031c5d5e132@pengutronix.de> <20210202082340.GA23043@x1.vandijck-laurijssen.be>
 <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de> <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net>
 <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de> <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
 <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
 <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net> <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
 <d7584992-78a0-4be7-6b31-0bc1e4adfeca@hartkopp.net> <707944b7-f202-edb1-cb67-beedaeedfda0@gmail.com>
In-Reply-To: <707944b7-f202-edb1-cb67-beedaeedfda0@gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 3 Feb 2021 17:26:11 +0900
Message-ID: <CAMZ6RqK_McbYNMqdb+zynH-CGaERFv5j5MgNd9X7MJBqu1f4Xw@mail.gmail.com>
Subject: Re: [Question] Sending CAN error frames
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 3 Feb 2021 at 15:42, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
>
> On 2021-02-02 20:19, Oliver Hartkopp wrote:
> > On 02.02.21 12:12, Vincent MAILHOL wrote:
> >
> >>> The CAN_ERR_FLAG has been renamed in the documentation to indicate
> >>> "error messages" from the CAN controller, as an error frame is something
> >>> completely different.
> >>>
> >>> Now as we are talking about having CAN_ERR_FLAG in the TX path besides
> >>> the vcan testing stuff, we should think about an API for the really
> >>> outgoing frames.
> >>>
> >>> We could not only think about "create an error frame right now" but also
> >>> think about a more intelligent CAN node, which also offers to destroy
> >>> one or more specific CAN ID(s) at a specific bit position after
> >>> detecting that CAN ID.
> >>
> >> My original idea was to leave it unspecified until a device was
> >> actually capable of doing such a thing. But I am not against
> >> defining the API now :) We might just have to wait a long time
> >> for someone to actually implement it.
> >>
> >>> We could use the CAN_RTR_FLAG and the data[] section of the outgoing
> >>> error CAN frames for such an API.
> >>
> >> We are not limited to the CAN_RTR_FLAG and the data[]
> >>
> >> First, we have to list the use cases.
> >>
> >> As I wrote before, there are only two forms for the error flag:
> >>    - The active error flag: 6 consecutive dominant bits
> >>    - The passive error flag: 6 consecutive recessive bits
> >
> > IMO this passive error flag stuff is pointless.
> > The passive error does not have any effect on the bus. Nobody sees it. It's just a measure to continue counting error counters inside the CAN controller. IMO it's a read-only feature about the controller internal status.
>
> I agree.

Passive error flags will have effect if initiated by the
transmitter. It will break the bitsuffing rule and other nodes
will notice.  Passive error flags initiated by the receivers
shall indeed have no effects.

This is admitelly an edge case. It really depends how much we
want to cover with our API.

> >> The device can either inject the flag either during:
> >>    - bus idle
> >
> > Is an error flag defined at bus idle?
> >
> > Error flags are intended to destroy *other CAN controllers* transmissions when detecting protocol violations. There can not be a protocol violation at idle time, right?
>
> This is what the Kvaser CAN controller does. It will wait for the bus to become idle, before an active error flag is transmitted.

To add to Jimmy's comment, the ISO standard does not
differentiate this. In section 10.4.4.2 "Error flag", it states
that "An error-active node detecting an error condition shall
signal this by sending an active error flag."

If you try to shortcut the CAN High and CAN low wires or connect
those to the ground while the bus is idle, you would probably get
some errors.

> >>    - while it is transmitting a frame
> >
> > What's the use-case for destroying your own transmission?

For active error flags: I admit that there is no benefit. You
could emulate this easily if you have two nodes under your
control: you send the frame on the first node and inject the error
on the second one.

The only use case is for the passive error flag just because the
transmission is the only way to do it. So it just brings us back
to the above discussion: how much do we want to cover.

> >>    - while it is receiving a frame
> >
> > This makes sense, especially when you can destroy specific CAN ID frames at a specific bit position.
> > Or for any CAN ID at a specific bit position.
> > Or for any CAN ID at an undefined bit position.
>
> I agree.
>
> >> The error flag can occur at any time.
> >
> > Sure? (see above)
> >
> > Of course we might also provide some pump gun mode which just sends an error flag at some (any) time.
>
> As above.
>
> > But for what reason?
>
> Testing purpose, e.g if you develop software where you want to keep track of bus errors, this makes it possible to test such software in a controlled way.
> We also use this ourselves when testing the transitions ERROR_ACTIVE <-> ERROR_WARNING <-> ERROR_PASSIVE, for Rx.

I think that there are two axes in this discussion: the attacker
point of view and the functional testing point of view.

From the attacker point of view, you are mostly interested in
destroying the transmitter frames.

For the functional testing, it is about covering the all the
aspects of the standard: make sure that all the TX and RX counters
are correctly incremented, test the transitions between the
different states and that for all offsets. And to confirm all
aspects, you might want to inject both the active and the passive
error flags and do it at all possible positions.

That said, my vision on functional testing is an uneducated
guess. I never worked on that and my personal focus is more the
attacker point of view.


Yours sincerely,
Vincent
