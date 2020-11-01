Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B502A1ECA
	for <lists+linux-can@lfdr.de>; Sun,  1 Nov 2020 15:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKAOul (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Nov 2020 09:50:41 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34695 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAOuk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 09:50:40 -0500
Received: by mail-yb1-f196.google.com with SMTP id o70so9499942ybc.1
        for <linux-can@vger.kernel.org>; Sun, 01 Nov 2020 06:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1PCYaO6ohKwX0jI4PHst25ojHj/4HaPhg3YhYBeh68=;
        b=YyMPh5ROVyMNyIKInsn6FE3drBrm8OSuBXr+WpmVOXsxmt0VTWjyiLvsnroHcB7iG0
         eEzPeUKmMf4m/TdcNspmBVgKMGx+/zwF8XrsEyytdhiqd996zw1t5m7n+CMSq0wWnN/S
         H9kRbXG3VSsas7MhvoCfIQRtLhAoXJe2Scx2/zsbBqOG4vBD++7f+TtJHwIPOQl3ESne
         V6L2GT+NdSWByb6EKYByKRMzS40F+W9MOgUixIIUSVtoFWhJG4ZxKvJV/mezOb6bkRAB
         Bu+IeKa+MxjjYqnWbyHBD2oAQcStd9wtnAGlVMItizbGOgTz7Fvorfm99QVTdnld6tP5
         ILgg==
X-Gm-Message-State: AOAM530v0jgl5OD0huFzrsTz+RKXfxdpTJw0Ewu2R7OHoNq4mJE2mVfZ
        fcRElPlsOBGkpY1esfgr7rDP7MDV08+EGCdqhnLXNL3B8Ak=
X-Google-Smtp-Source: ABdhPJws40z0AK6DBQ0yuXN2SpWoYtY9QrDR0eCBFtZFQl2tIsqFAmIEYz3xXP4iCtwL2+W2msDrJMkmZU3Sto1kbMc=
X-Received: by 2002:a25:4091:: with SMTP id n139mr16700605yba.226.1604242238790;
 Sun, 01 Nov 2020 06:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20201023203017.3485-1-socketcan@hartkopp.net> <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
 <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net> <6bfdc3db-5aaf-b492-dc24-fb5d73cd3b23@hartkopp.net>
In-Reply-To: <6bfdc3db-5aaf-b492-dc24-fb5d73cd3b23@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 1 Nov 2020 23:50:27 +0900
Message-ID: <CAMZ6Rq+UY6SJxDJ15jx1vmSFUk9YHWx+Rf5dZiC9OY+6RO9QXg@mail.gmail.com>
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 30.10.20 06:33, Oliver Hartkopp wrote:
> Hi Vincent,
>
> On 24.10.20 15:00, Oliver Hartkopp wrote:
>> On 24.10.20 14:00, Vincent MAILHOL wrote:
>
>>>    * Set up two channels can0 and can1 and connected those to the same
>>>      bus.
>>>
>>>    * Ran 'cangen can0' and 'candump any' simultaneously.
>>>
>>>
>>> Results of candump:
>>>    can0  539   [8]  05 21 8C 5C F7 B0 7C 69
>>>    can1  539   [8]  05 21 8C 5C F7 B0 7C 69
>>>    can0  47E   [1]  53
>>>    can1  47E   [1]  53
>>>    can0  317   [6]  E5 00 B5 73 66 CF
>>>    can1  317   [6]  E5 00 B5 73 66 CF
>>>    can0  524   [E]  64 C3 B0 6E 55 7A D7 2E
>>>    can1  524   [E]  64 C3 B0 6E 55 7A D7 2E
>>>    can0  39C   [D]  63 18 96 69 F6 7A AB 36
>>>    can1  39C   [D]  63 18 96 69 F6 7A AB 36
>>>    can0  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>>>    can1  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>>>    can0  5DD   [9]  7E 55 56 5B C0 23 B0 53
>>>    can1  5DD   [9]  7E 55 56 5B C0 23 B0 53
>>>    can0  573   [E]  20 8E A3 31 1B 54 B2 16
>>>    can1  573   [E]  20 8E A3 31 1B 54 B2 16
>>>    can0  470   [3]  31 9C 06
>>>    can1  470   [3]  31 9C 06
>>>    can0  465   [4]  93 75 A2 08
>>>    can1  465   [4]  93 75 A2 08
>>>
>>>
>>> Works fine :-)
>
> I'm not really sure about the view of Classical CAN DLCs in this 'long'
> candump representation.
>
> There are people that use this format as base for further processing -
> instead of the logfile format m(
> So it may be a bad decision to put the DLC value in the length position
> here.

There was actually zero thought when I wrote this. I just wanted to
test the kernel land and this was the first hack which came to my
mind.

candump is not an easy one to modify. When putting the DLC in the
picture, I can see three option:

  1. Do not modify the format. Nothing will break but it would be
     impossible to know the actual DLC value of a Classical CAN frame
     of length 8.

  2. Ask people doing processing on the candump output to modify their
     tool if they want to use the cc-len8-dlc switch (if not using it,
     should not break).

  3. The in-between solution: use a command line switch (e.g. candump
     -8 any) select option 1 or 2 at run time.

None of the solution is perfect.

I personally do not like option 3. So far, the command "candump any"
would capture all the information. For example, their is no switch to
enable/disable the capture of CAN-FD frames so it would seems odd to
me to have it only for the DLC.

Option 1 would be inconvenient for people who have needs similar to
mine. Option 2 would be inconvenient for people who want to use
cc-len8-dlc but do not want to touch their tools built on top of
candump.

At the end of the day, I can not think of a perfect solution but I
actually liked your previous idea of using parenthesis. The rule would
be that [x] would designate a DLC of len2dlc(x) and a length of x; and
(x) would designate a DLC of x and length of 8. On a security point of
view, I think that the impact would be minimal. If we change the
format form [x] to (x), parsing tools build on top should directly
crash and the user should notice directly.

> I changed the logfile format in a backward compatible way and therefore
> the cansend command line format too:
>
> (1604004658.444168) vcan0 2C0##02643
> (1604004658.494492) vcan0 615#R8_9
> (1604004658.645395) vcan0 6FF#
> (1604004658.695682) vcan0 623##318F88F7043C0
> (1604004658.746046) vcan0 63A##28D1F37
> (1604004658.796214) vcan0 1117DEA5##0BC281D711098
> (1604004658.846397) vcan0 1490B893#R8_F
> (1604004658.896585) vcan0 1F494EC8##39C47E2
> (1604004658.947142) vcan0 1D1EC448#3DC1C81345D7ED7E_D
> (1604004658.997689) vcan0 1C8661BB##14DEA7568D459160D
> (1604004659.047851) vcan0 2D8#AFE0546E6522130D_E
> (1604004659.098216) vcan0 1596E833##3E6789514EF10B466E6789514EF10B466

Not the most sexy solution but I have to admit that it does the job
and fits well with the other tools. Also, I am not able to think of a
better solutions.

Not sure if anyone also uses this log format as base for further
processing. Somewhere, someone might be impacted as well. But there is
probably nothing that we can do about that.

> My can-utils len8_dlc test setup is here:
> https://github.com/hartkopp/can-utils
>
> Feel free to do some tests, e.g. with cangen, candump, canplayer.
> Feedback is appreciated.

Sorry for the late feedback. I applied all the changes on the user
land and just started the tests.  First results are good :)

So far, I found a minor issue in cangen.c, will send you a patch in an
other email right after.

I will need more time to complete a full test and review.

Overall, I think that you did a good job in the naming convention and
the choice of the command line options.

Thanks a lot!


Yours sincerely,
Vincent Mailhol
