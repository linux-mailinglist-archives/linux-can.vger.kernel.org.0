Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1119293A0F
	for <lists+linux-can@lfdr.de>; Tue, 20 Oct 2020 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgJTLbH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Oct 2020 07:31:07 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:43832 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbgJTLbH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Oct 2020 07:31:07 -0400
Received: from tomoyo.flets-east.jp ([153.230.197.127])
        by mwinf5d14 with ME
        id iBWu2300R2lQRaH03BX2mP; Tue, 20 Oct 2020 13:31:05 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Oct 2020 13:31:05 +0200
X-ME-IP: 153.230.197.127
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>, kernel@pengutronix.de
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to get the correct length of Classical frames
Date:   Tue, 20 Oct 2020 20:30:23 +0900
Message-Id: <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
References: <20201019190524.1285319-1-mkl@pengutronix.de> <20201019190524.1285319-5-mkl@pengutronix.de> <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net> <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> On 19.10.20 21:05, Marc Kleine-Budde wrote:
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > In classical CAN, the length of the data (i.e. CAN payload) is not
> > always equal to the DLC! If the frame is a Remote Transmission Request
> > (RTR), data length is always zero regardless of DLC value and else, if
> > the DLC is greater than 8, the length is 8. Contrary to common belief,
> > ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow DLCs greater than 8
> > for Classical Frames and specifies that those DLCs shall indicate that
> > the data field is 8 bytes long.
> >
> > Above facts are widely unknown and so many developpers uses the "len"
> > field of "struct canfd_frame" to get the length of classical CAN
> > frames: this is incorrect!
> >
> > This patch introduces function get_can_len() which can be used in
> > remediation. The function takes the SKB as an input in order to be
> > able to determine if the frame is classical or FD.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Link: https://lore.kernel.org/r/20201002154219.4887-4-mailhol.vincent@wanadoo.fr
> > [mkl: renamed get_can_len() -> can_get_len()]
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >   include/linux/can/dev.h | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> > index 41ff31795320..2bb132fc6d88 100644
> > --- a/include/linux/can/dev.h
> > +++ b/include/linux/can/dev.h
> > @@ -192,6 +192,29 @@ u8 can_dlc2len(u8 can_dlc);
> >   /* map the sanitized data length to an appropriate data length code */
> >   u8 can_len2dlc(u8 len);
> >   
> > +/*
> > + * can_get_len(skb) - get the length of the CAN payload.
> > + *
> > + * In classical CAN, the length of the data (i.e. CAN payload) is not
> > + * always equal to the DLC! If the frame is a Remote Transmission
> > + * Request (RTR), data length is always zero regardless of DLC value
> > + * and else, if the DLC is greater than 8, the length is 8. Contrary
> > + * to common belief, ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow
> > + * DLCs greater than 8 for Classical Frames and specifies that those
> > + * DLCs shall indicate that the data field is 8 bytes long.
> > + */
> > +static inline u8 can_get_len(const struct sk_buff *skb)
> > +{
> > +     const struct canfd_frame *cf = (const struct canfd_frame *)skb->data;
> > +
> > +     if (can_is_canfd_skb(skb))
> > +             return min_t(u8, cf->len, CANFD_MAX_DLEN);
> > +     else if (cf->can_id & CAN_RTR_FLAG)
> > +             return 0;
> > +     else
> > +             return min_t(u8, cf->len, CAN_MAX_DLEN);
> > +}
> 
> The main idea behind this patch and patch 05/16 is to provide a correct
> statistic in the tx bytes, right?
>
> A simple test for the CAN_RTR_FLAG will do the job as all the length
> sanitizing is already done in the tx path by can_dropped_invalid_skb()
> in all known drivers right *before* the skb is stored in the echo skb array.
>
> IMO there's no need for a separate helper function. Maybe a macro which
> should have something with 'payload' in its name - to determine the tx
> byte statistics based on CAN_RTR_FLAG ...

Actually, the main idea is not only to provide a valid length for the
tx statistics.

First fact is that many of the drivers (if not all?) will have the
same issue for the rx statistics as well, so this helper function can
be beneficial in other locations as well but that is not yet the main
point.

What bugs me the most, is that there is a global misunderstanding of
the definition of the Classical CAN frame's DLC in the kernel.

ISO 11898-1:2015 tells us in section 8.4.2.4 "DLC field" that, I
quote: "[...]  *This DLC shall consist of 4 bit*. The admissible
number of data bytes for Classical Frames shall range from 0 to
8. DLCs in the range of 0 to 7 shall indicate data fields of length of
0 byte to 7 byte. In Classical Frames, *all other DLCs shall indicate
that the data field is 8 bytes long*. [...]"

So the DLC is a 4 bits value (meaning from 0 to 15) and all values
from 8 to 15 designate a data length of 8.

The real idea is to have an ISO 11898-1 compliant function to retrieve
the length.

That said, I hear your comment that the DLC is sanitized in
can_dropped_invalid_skb(). However, what bothers me is that this
sanitazation is done on false assumptions: Classical frames with DLC
greater than 8 and lower or equal to 15, which are valid by the
standard, are being discarded.

To give you the full picture, I plan to send a RFC to fix this DLC
issue to allow Classical CAN frame with DLCs between 9 and 15 to be
sent and received in Socket CAN.  This can_get_len() function is one
piece of it, however, because I also found the bad RTR length issue, I
thought to introduce this one in advance. Sorry for the lack of
context.

The RFC I am thinking of will not be trivial. The main reason is that
the macro CAN_MAX_DLC which is incorrectly set to 8 instead of 15 is
exposed to the user land in include/linux/can.h. Modifying it would be
a no-go because we do not want to break user space. The direction
would be to have a socket option to set the maximum DLC to 15 on
demand and to keep it to 8 by default (this way, niche users who needs
this can do so but other people are not impacted).

One question you might ask is: "why should be allow DLC greater than
8?". One concrete use case is security testing. In order to check for
vulnerabilities, we want to send such frames for test coverage
(especially during fuzz testing). Aside of that I do not know other
use cases. I am not aware of any OEM that would use this in production
but I still want to push to have this option in the kernel just for
the security testing reason.

I hope that you now understand the full idea behind this patch. If you
agree with my comments, please reconsider adding that patch. If I
failed to convince you and if you prefer to first see the full
picture, then I am OK to go with the simple test for the CAN_RTR_FLAG
as you suggested in your other patch and will come back to you later
on the MAX DLC topic when ready.

Thanks for reading me until the end!


Yours sincerely,
Vincent Mailhol
