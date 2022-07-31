Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D4585D0B
	for <lists+linux-can@lfdr.de>; Sun, 31 Jul 2022 05:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiGaDUH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 30 Jul 2022 23:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiGaDUG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 30 Jul 2022 23:20:06 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E912ACB
        for <linux-can@vger.kernel.org>; Sat, 30 Jul 2022 20:20:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31d85f82f0bso82614797b3.7
        for <linux-can@vger.kernel.org>; Sat, 30 Jul 2022 20:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stpSNHhqTqkc+7VUitxuGVpqx+n+ARKyZWXmCfHPU88=;
        b=WQsAM+zEBeQgFO3FLfw2xPtmDqijf+cRUHGO802PQiSmr0r5m3F93U2Ac+A7xVNr3D
         o6H31xUtoUWHvxBtdhryYw+np+OpQa0g5qX22j26rfAv0+VKGmBjZgFy4ORfDLSnKE59
         /K6+Dj8hEMD8Swpw1xl4WMSyyOgNXozpsPoBdFMDXSVC2yP/inBinAkvi57fyAolhZui
         p3bcaWYnCveSKIxyTl6yQKWbu2xNGKdPM9OnlDdP9o8OyClMKO5pYSNImuk/sG0VaZGo
         5PohxuyZuWq/VWVdCD2VJbNfxLsylBqtZJL6qL23lSmZD5M8Au1EPuVLD/1blhQWNHWv
         p3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stpSNHhqTqkc+7VUitxuGVpqx+n+ARKyZWXmCfHPU88=;
        b=ZVHqjIxxGOFvvCpiDfxWRCXyPbrQRB7Oi5B6cMspyG5jsBUI90sYuwS12FtTCU9LPG
         euP3u2t6o7ukaZkQtdN5fgOrE/ukiUjys9zicbi0nzO8r7T3jGbklYWm2SSztXafjgos
         l4wol/HHRmpE1dPlY/tuA5dFojBZc2A1P/mX7QQ4U+JD8U8nD93Y2Wsd3834FLNQxHjE
         Q1BSAjO9PDhn03wYRw7gpNisUai01XnXrmhMdZzmhqO+jh7nTJWAnPp/Pz6Wq6yIjrJ+
         oiNvwH7huFEnx0xL0L40BMKOX1WviDR/V+GKAQGqgRU1C9nVj9g+7VRsTM0cmL1FAJxC
         rR4w==
X-Gm-Message-State: ACgBeo3NTKRQR0EwP0iJ+m9afGfN5FVeaw2tjUCYcFGte/XCSmmgwSz7
        NoRYPiyDsd+kGgvBY7xkO5/Ev/fm9jIHZOmmkMFJtMVCLWFrrg==
X-Google-Smtp-Source: AA6agR5O/4dhTLLCYe1IhsRxF1g6Enk+VSP8ycKDFnM55LlPQ+SLiH0lX9dkRB4js1fFAB88SdcSwoSdS9K8bU+BZJw=
X-Received: by 2002:a0d:dfcc:0:b0:322:f812:f379 with SMTP id
 i195-20020a0ddfcc000000b00322f812f379mr8630610ywe.172.1659237604870; Sat, 30
 Jul 2022 20:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154107.1875-1-socketcan@hartkopp.net> <20220729154107.1875-5-socketcan@hartkopp.net>
 <CAMZ6RqKMtoo56OtaYG7Quoky+95hvfQaiFi+nDqez=+hMUMhHg@mail.gmail.com>
 <c2bf9e37-3c52-559a-a76c-b1cf99b0d698@hartkopp.net> <CAMZ6RqL5_WxgT4iJy5tKW1PUBGSCr9R+YbMqVxrTiGSRV+7bCg@mail.gmail.com>
 <e05843e0-8e68-e91b-78ad-60d44f421ae2@hartkopp.net>
In-Reply-To: <e05843e0-8e68-e91b-78ad-60d44f421ae2@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sun, 31 Jul 2022 12:19:53 +0900
Message-ID: <CAMZ6RqJmOS6KVv1+BWTOSNHUwMinRPh4Pdvb997oC9NU9TY1jg@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 31 Jul. 2022 at 06:05, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 30.07.22 15:16, Vincent Mailhol wrote:
> > On Sat. 30 juil. 2022 at 21:06, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> >>> Existing applications are exempted from this risk: the
> >>> CAN_RAW_XL_FRAMES socket option will prevent the collision from
> >>> happening. To summarise, the collision will only occur if below
> >>> criteria are met:
> >>>
> >>>     * The user allocates a can_frame without zeroing it (typical use
> >>> cases are stack declaration or malloc()).
> >>>     * The user activates the CAN_RAW_XL_FRAMES socket option.
> >>>     * Garbage value results in can_frame::__pad & CANXL_XLF being set.
> >>>
> >>> So if going in that direction, we would have to update the
> >>> documentation (header files and kernel doc) to point at this pitfall
> >>> and specify that can_frame::__pad shall always be zeroed for mix
> >>> usages.
> >>
> >> But you would add this recommendation to a *very late point* - namely
> >> after 14 years of SocketCAN in the mainline kernel.
> >>
> >> If you think about the rule "never break user space" I wonder if the
> >> risk turns out to be higher when people enable CAN_RAW_XL_FRAMES ("as
> >> seen on Stackoverflow") and not read the kernel doc recommendations to
> >> review/update their existing code.
> >
> > In which aspect does this break the user space? It doesn't.
>
> It does in the way that you need to zero-initialize structures now.
>
> > Enabling CAN_RAW_XL_FRAMES marks a clear transition between the 14
> > years old Classical CAN API and the new use case of mixed CAN(-FD) and
> > CAN XL frames.
>
> You are seriously telling me that CAN_RAW_XL_FRAMES is a clear
> transition and people will automatically review and rework their former
> CAN/CANFD code to zero-initialize padding bytes?
>
> There is a much higher risk that this does not happen than telling
> people to check for CANXL_XLF first after reading from the socket!
>
> > For the issue to occur, developers have to incorrectly modify their
> > application, I do not call this a break in user space if only the
> > yet-to-be-created programs are impacted.
>
> I don't know about your thresholds but I call this a break in user
> space. Yet-to-be-created programs will likely copy old code.
>
> > The argument that people do not read the kernel doc apply to both
> > cases: some people will not initialise variables, some people will not
> > do the "if" checks in the right order.
>
> To make it simple: The difference between CAN XL and (old) CAN/CANFD
> handling is CANXL_XLF.
>
> I'm really tired about your constructed case that people would be too
> dumb to check for CANXL_XLF first.
>
> This CANFD_FDF check is a new optional(!) possibility, which we do not
> need to promote. This could become a power user trick for people that
> are obviously "smart enough" to put if-statements in the right order.
>
> The correct and safe check that should be documented and suggested looks
> like this:
>
> if (can.xl.flags & CANXL_XLF)
>       /* Handle CAN XL frame */
> else if (nbytes == CANFD_MTU)
>       /* Handle CAN FD frame */
> else if (nbytes == CAN_MTU) /* paranoid */
>       /* Handle Classic CAN frame */
> else
>       /* error */

After a good night of sleep, I found a use case which destroys my idea:

int main()
{
    static union can can;

    can.xl.flags = CANXL_XLF;
    /* set other fields, open socket... */
    write(s, &can.xl, CANXL_HD_SIZE + can.xl.len);

    can.cc.len = 8;
    /* set other field but leave can.cc._pad untouched */
    write(s, &can.cc, sizeof(can.cc));

    /* ... */
}

Here, we have a static declaration so the frame is guaranteed to be
zero initialized. The user then sends a CAN XL frame (and thus sets
the CANXL_XLF flag). Then the user sends a Classic CAN frame. However,
can.cc._pad still contains the CANXL_XLF flag set. I stay in my
position that asking to zero initialize variables for mix usage is
acceptable. But requiring to reset the can.cc._pad to zero in the
middle of the run time is too much.
This is a very bad foot gun. So let me withdraw my idea. Using the
0x80 flag on the can(fd)_frame.len is the best.


Yours sincerely,
Vincent Mailhol
