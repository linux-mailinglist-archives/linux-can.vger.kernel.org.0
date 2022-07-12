Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FDE571CAA
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiGLObf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiGLObe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 10:31:34 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E07B33A19
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 07:31:32 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31caffa4a45so82998147b3.3
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2Uo8jfEkorXJmfvAUUhr2TP1Aufd2xGoHuRLCauSOY=;
        b=Xt54v7sLNHMuaI5Eegr/eGnH4gcSzP1GMAIEBW/cB+Y+FYsKnRP22F/IftVhVWokYO
         VcwvZ2sqcNVpUUGKnzN8GTSOeMbXplaEoppkWdzCGn+tPZJfxCjSMTRtqp1KGNSj8hVg
         v+l9/QFgvD7VD3oQggvkAOYhhScB5a8cDQmK44KphWVwza+9JmzqEgfBzcDZfMapjrBi
         XAe51O7ZSaInEKPjqPGStvsJH6D4GLY4tLvv3izYpkQ+3eV2eNHAu3A/6ohOMcEL1gyR
         XwmS8Rx8OUu4QKAuh33ZxFpaukhsQsq4PzYItBnKubsnmdJHIWz4zVZ/P8tNHJ67ATLQ
         AteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2Uo8jfEkorXJmfvAUUhr2TP1Aufd2xGoHuRLCauSOY=;
        b=T+5+OasA1EazkRCaKjbQmCBrAScwqSN04A7bTxC7xTqCIVjGnHEPyne/pKTCo4n17c
         sfo018F9cq4F3O0ryAmVf9IMfz5l2s7ud+r5lhpVOqYVdGL1rhS9zjTZa6Dvr6SoAgbI
         BFbT0LMM0rEK2rdsO9kV9Mt2tRtMJkx+iMCNxTKtsu6TwIr4B9SocOpdEkAj98HCVm+6
         dg5NLWYeikBYxN28joCJ6EYtcNKc4kV23e8GyTUJk8SH5kypBQv0zOq4+Ii6mhj4nKfH
         Y4iTbHyCXYBEyBzp9kMMvdGSuMls2G6Tiozj1KushwyxLie2aJKANHRo2elozRMPXYvh
         r6JQ==
X-Gm-Message-State: AJIora/oVFVxlVF9y8h+XAyJ1TqPMbeTIUkw5WyZl2vVm8uf0JP8/uSF
        3TDt+miHmUMh+h/JL3gseHvkaWHFwysQcTsAAkl1qMB+39Q=
X-Google-Smtp-Source: AGRyM1sDEyBhCCYiZYmmSPe+figA/pPJrvTxkGLPNlL4/GgT1ue5T2iv/HAow27FnRLskwIVpJtmc7c5zyu4avbvzU0=
X-Received: by 2002:a0d:fd05:0:b0:31c:ad0f:331d with SMTP id
 n5-20020a0dfd05000000b0031cad0f331dmr26198395ywf.220.1657636291144; Tue, 12
 Jul 2022 07:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-2-socketcan@hartkopp.net> <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
 <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net> <CAMZ6RqLVvYCoBF67VtqUSJHAxBHvEmK2-o8NCD7REZj1ywXf7w@mail.gmail.com>
 <521fe0a3-a9ad-60ac-3ec6-30f0da228032@hartkopp.net> <CAMZ6RqJhjkVgZgmfk7btYK+bLtqnbvGBYTnssy28ZWqyfyqppw@mail.gmail.com>
 <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net>
In-Reply-To: <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 12 Jul 2022 23:31:19 +0900
Message-ID: <CAMZ6Rq+LqfUhLcg6909=239a+Asm6aO-bPqpar2tQ_fs0EmiUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 12 Jul. 2022 at 21:30, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 12.07.22 12:19, Vincent Mailhol wrote:
> > On Tue. 12 Jul. 2022 at 18:31, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> >>>> +/* truncated CAN XL structs must contain at least 64 data bytes */
> >>>> +#define CANXL_MINTU    (CANXL_MTU - CANXL_MAX_DLEN + CANFD_MAX_DLEN)
> >>>
> >>> I did not get the concept of the "truncated CAN XL structs". The valid
> >>> data field lengths are 1 to 2048, right? I did not get where this 64
> >>> comes from.
> >>> Your formula is equivalent to
> >>> #define CANXL_MINTU    (sizeof(struct canxl_frame) + CANFD_MAX_DLEN)
> >>
> >> No. CANXL_MINTU becomes sizeof(struct canfd_frame) + sizeof(af)
> >>
> >> So I wanted some size value that is 'more than' CANFD_MTU so that you
> >> know that you have read a CANXL frame.
> >>
> >> Even if the cxf->len would be 14 you would at least copy a struct
> >> canxl_frame with data[64].
> >
> > OK, I finally got your point. Your concern is that if skb->len could
> > be equal or less than CANFD_MTU, then there would be a collision.
> >
> > My approach here would be to stop using the MTU correlation to
> > differentiate between CAN(-FD) and CANXL. Instead, I suggest using
> > can{fd,xl}_frame::flags. If can{fd,xl}_frame has a CANXL flag set,
> > then it is a CANXL frame regardless of the value of skb->len. If the
> > CANXL flag is not set, then skb->len is used to differentiate between
> > Classic CAN and CAN FD (so that we remain compatible with the
> > existing). That way, no need to impose a minimum length of
> > CANFD_MAX_DLEN.
>
> Hm, that sounds interesting! I like that as it looks clear and simple.
>
> Need to pick a coffee

Two years ago, it was a beer:
https://lore.kernel.org/linux-can/a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net/

Now it is coffee. Seems that you change your drinking habits (just kidding) ;-)

> to think about potential (security) effects ... ;-)

If we require a socket option as you already did (c.f.
CAN_RAW_XL_FRAMES), I do not see a security risk.

If not using the socket option, then a user who activates CAN_XL at
the netlink level and who runs a legacy application in which struct
can_frame is declared on the stack and not initialised would be at
risk. can_frame::__pad could contain garbage data which could be
interpreted as a valid CAN_XL flag. From that point, the garbage
values in can_frame::__res0 and can_frame::len8_dlc would be
interpreted as an CANXL length.

The only requirement is that all applications which will use a mix of
CANXL and non-CANXL frames shall make sure that no garbage values are
present in can_frame::__pad or canfd_frame::flags. Coding guidelines
such as MISRA and good static analyzers should also be able to catch
this.

> E.g. we would need to keep skb->len and canxl_frame::len in sync now.

Not necessarily. The only strong condition is that:
    skb_buff::len + sizeof(struct canxl_frame) < canxl_frame::len

If it is equal, then perfect, we are optimal. If greater, it just
means that there is some garbage data. If the condition is not met, we
just drop the skb of course.

Technically, we could remove canxl_frame::len and use below formula to
derive the data length:
    len = skb_buff::len - sizeof(struct canxl_frame)

In that case, the user must do all the length calculations correctly.
This would be close to how TCP/IP frames are managed. But personally,
I do not recommend removing canxl_frame::len.

Having both skb_buff::len and canxl_frame::len in sync is a design
choice, not a necessity. I am still thinking of the implications and
what is best between allowing garbage or forcing the two lengths to be
in sync.

> >
> >>>
> >>> I would have just expected:
> >>> #define CANXL_MINTU    (sizeof(struct canxl_frame))
> >>
> >> That is CANXL_MTU (max transfer unit).
> >
> > I was writing while thinking that canxl_frame::data was a flexible
> > array member as suggested in this thread.
> > In that case canxl_frame::data counts as zero when doing sizeof(struct
> > canxl_frame). And so sizeof(struct canxl_frame) == sizeof(struct
> > canfd_frame) + sizeof(af).
> >
> > Actually, thinking twice, the Minimum transfer unit would be:
> > #define CANXL_MINLEN 1
> > #define CANXL_MINTU    (sizeof(struct canxl_frame) + CANXL_MINLEN)
> >
> > (I forgot that the length can not be zero anymore in CANXL...)
>
> I still would suggest to have the struct canxl_frame contain the 2048
> byte of data (data[CANXL_MAXDLEN]) - as the entire CAN XL frame is
> defined like this in the CAN XL spec. This would be also in common with
> CAN/CANFD.
>
> E.g. when reading into the struct canxl_frame you always have a defined
> data structure which can contain a complete CAN XL frame.

If we go this way, then I would allow the user to put garbage (i.e.
not having the two lengths in sync).
The rationale would be that we actually already allow such garbage
values for CAN and CAN-FD. Also, this way, the user who has zero clues
about the flexible array member property would simply do:

   struct canxl_frame cxl = { 0 };
    /* ... */
    write(socket, &cxl, sizeof(cxl));

and it would work. The advanced user who understand what is going on
can still do:

   struct canxl_frame cxl = { 0 };
    /* ... */
    write(socket, &cxl, CANXL_HEAD_SZ + cxl.len);

> But if you get or send less than that size (when reading/writing) this
> would be ok now (with your idea with CANXL_XLF set).
>
>
> E.g.
>
> #define CANXL_MINDLEN 1
> #define CANXL_MAXDLEN 2048

To be consistent with CAN_DLEN and CANFD_DLEN names:
#define CANXL_DLEN 2048

> #define CANXL_MTU sizeof(struct canxl_frame)
> #define CANXL_HEAD_SZ (CANXL_MTU - CANXL_MAXDLEN)
> #define CANXL_MINTU (CANXL_HEAD_SZ + CANXL_MINDLEN)

I need to think twice about all that, all the different alternatives
(allow or not garbage, data as flexible member array vs.
data[CANXL_DLEN]). Now it is a bit late, so I will continue to think
about all that tomorrow.
But overall, I like the direction this thread is taking ;-)

> >>> Here, you lost me. The only reference document I have is the Bosch
> >>> presentation you linked in the cover letter. I would need to get a
> >>> copy of the specification first to follow up on this level of details.
> >>
> >> There is a Special Interest Group for CAN XL at CAN in Automation
> >> (can-cia.org) and these doscuments are currently under development.
> >
> > I wonder how hard it is to join the group. Right now, I was thinking
> > of waiting for the ISO Final Draft International Standard (FDIS) to
> > deep dive in CANXL.
>
> I'm not sure if the SDT definitions will be part of an ISO draft as
> defining the content inside a CAN XL frame is probably not ISO standard
> relevant.
>
> The content definitions are industrial recommendations to increase
> interoperability. You are always free to put into the CAN XL frame
> whatever you want.

But then, should this be another protocol? Similar to how ISO-TP is
not part of CAN_RAW but its own protocol? (this is a naive question, I
am out of context here).

> E.g. CAN-CiA defined the pinout of the SUB-D9 connectors for CAN (Pin
> 2/7) which is not defines in ISO too.

ACK.

Unrelated to this thread but I was wondering if you saw that my
comments on the can_get_data_len() helper macro:
https://lore.kernel.org/linux-can/20220711183426.96446-1-socketcan@hartkopp.net/T/#m01645d364e92681e5b889ca5d3c9f501e5d33dc3

Yours sincerely,
Vincent Mailhol
