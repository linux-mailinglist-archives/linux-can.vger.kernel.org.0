Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4057C63E
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 10:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiGUI2j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 04:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiGUI2i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 04:28:38 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFBF7E302
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 01:28:37 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 7so1669240ybw.0
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7CRBLP6zp44Boo+ab6QJvkP0YMfHnujeDMG6PP1H8g=;
        b=WuE3N0RGMtocBkDGBYH39+92ZbX6aPf6CvTQsIaqE6NAqBHzSYu0PvrlD0YJfCy/vk
         tYyF71pyeYckFJrsmXb4sqW6MT8GDltFuKuy6SjCkE1IXKkDICJmEJJdeX7R5yVYFW+/
         XUZq3tZONat+WH7Y9wcuxixB5lFgAtyQ9zQOhFQ5NvdDt4lJPe/ByxDxJ14xZFS0Psw+
         EINx0FMf+Dk4NaBaaeLKAVdzdusgaN4SVUSR3T5o+XZGa8AnD6/do89Um7uhYaLkEHwD
         ZnTew+0gC+T7oMVVRYQAm+1tmur3uXYtDbLLfuFr3dPs0ulpb7BADM/DEt5taVlwL+72
         TiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7CRBLP6zp44Boo+ab6QJvkP0YMfHnujeDMG6PP1H8g=;
        b=nrR3FeB8tKk4On1NYB9UJfkNBn5EmQumUIeiiIUEi4wd0oipv+NMDocMZTcLPWAwJI
         aK8zqm57ElPMYalAXapfAUiwVwAqoBMZkSbbQM14N5ph1bQDOQYqi6cxI7TKCUW8kIbR
         wDVXkg0lsMzbUccPpqN7Mt6pS1FfwSnM2haZQX4UAEyfAmFizCMkZv7t60yr/LXUJer6
         /g/TnYOpaAOXgKwHUz04S1FtrXQ3zI8DTV785YpiT9GVCHqkZb13NP5WTZ0upkFQ8TW5
         CShBi0ysbpIXwfre3YcTXyABNTMhVWD5sQFACe3sAT//CoLTNi037DfHUWtlAXQlRz3T
         jrrw==
X-Gm-Message-State: AJIora/TXgcEMrmbSSf36/XpJHLyUVNjGC/n92w1xp29Z4vTbLbPULKH
        AKLGUlvxHRK6SPSE/26oANFwo7kepPm6xS2Z7PsLwyh8j80=
X-Google-Smtp-Source: AGRyM1sYAjfelvDf89oxSQeb9g5cT21Byj9WxPjUYev4QQooCnllfga4G8pG9TqXpH59zljK+VbXHRpFowPiqPyhG8E=
X-Received: by 2002:a25:72d4:0:b0:670:7c08:a9e8 with SMTP id
 n203-20020a2572d4000000b006707c08a9e8mr12976220ybc.423.1658392116688; Thu, 21
 Jul 2022 01:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220719112748.3281-1-socketcan@hartkopp.net> <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net> <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
In-Reply-To: <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 21 Jul 2022 17:28:26 +0900
Message-ID: <CAMZ6RqKbBLhEq99vesRLs-WSp5jOfwtMHDOQCjrZng4BAgK-vg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
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

On Thu. 21 Jul. 2022 at 16:36, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 21.07.22 04:37, Vincent Mailhol wrote:
> > On Wed. 21 Jul. 2022 at 01:43, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> On 19.07.22 17:16, Vincent Mailhol wrote:
> >>> On Tue 19 Jul. 2022 at 23:38, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
(...)
> I just wanted to get an impression whether it is handy to program this
> extended API or not.
>
> >> nbytes = read(s, &can.xl, sizeof(struct canxl_frame));
> >> if (nbytes < 0) {
> >>           perror("read");
> >>           return 1;
> >> }
> >> printf("nbytes = %d\n", nbytes);
> >
> > Does read() guarantee atomicity? From "man 2 read":
> > | It is not an error if [the return value] is smaller than the number
> > | of bytes requested; this may happen for example because fewer bytes
> > | are actually available right now (maybe because we were close to
> > | end-of-file, or because we are reading from a pipe, or from a
> > | terminal), *or because read() was interrupted by a signal*.
> >
> > I think the answer is yes, but I prefer to double check (I am
> > especially concerned by the signal interrupts).
>
> Hm, we are not reading from a file but from a socket here that provide
> chunks in the form of struct can_frame in raw_recvmsg(). You only get a
> MSG_TRUNC there when you provide a (buffer)size in userspace that's to
> small.
>
> I've never got any error reports on CAN_RAW reading (over 16 years) and
> all the examples contain a test for sizeof(struct can_frame) like this:
>
>  >> if (nbytes != sizeof(struct can_frame) &&
>  >>       nbytes != sizeof(struct canfd_frame)) {
>
> So we either have an error or an incomplete CAN frame which becomes an
> error too.
>
> Do you think this is still worth an investigation?

My concern is whether or not read() can really be interrupted by a signal?
But actually, even if read() were not atomic, it would still be
usable: you just have to continue reading until you get the first 64
bits, then you have all the information needed to determine the type
and the total length.

So I do not think this is a valid concern, but even if it is, it does
not invalidate current design. So OK to move on. Maybe it is just
something to add to the TODO list of the "things I yet have to
understand".


Yours sincerely,
Vincent Mailhol
