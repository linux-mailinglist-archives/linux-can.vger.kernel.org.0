Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE352A1F71
	for <lists+linux-can@lfdr.de>; Sun,  1 Nov 2020 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKAQM4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Nov 2020 11:12:56 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:8659 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgKAQM4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 11:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604247172;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=qfm0MNpkY94nh7qvcsztIc2911Y0hRR/4fbeDtwrcDM=;
        b=d3HfFpajUx5upwzMyX6rzkFLrtP97oVzWszrRIz10/6eYl1zM8RlAun3iXkwx+DuhV
        isMAHGrlrS1lBHJGFiupuccwIEOjpy0ZxqOS/UmrgSEAEUSBN76S8LS1mPVP6UbBZ+q3
        Qu+XeINRPi0PREIiP00b5GrKb/cSNvGzDTGi3SFDJuFmXZnunF6Tf1tdd7IxYLOkIUR5
        C1bbGW7yNWPqM/K94jLK67z0VwTl0sOB/cygPxfLX4Yfd49OiEDu9LW+7UH+fWx9ZgXO
        TNk8Pv7mJAyH4fxH8CEDQp12TPiuK/+2hClA9oeyQb744S/l3SFfEcb6ka++ix7S6KWN
        DOSQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xtpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA1GCn8QI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 1 Nov 2020 17:12:49 +0100 (CET)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
 <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net>
 <6bfdc3db-5aaf-b492-dc24-fb5d73cd3b23@hartkopp.net>
 <CAMZ6Rq+UY6SJxDJ15jx1vmSFUk9YHWx+Rf5dZiC9OY+6RO9QXg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <e2e5e78e-5de8-9a36-ae6c-191518b3bba3@hartkopp.net>
Date:   Sun, 1 Nov 2020 17:12:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+UY6SJxDJ15jx1vmSFUk9YHWx+Rf5dZiC9OY+6RO9QXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 01.11.20 15:50, Vincent MAILHOL wrote:
> On 30.10.20 06:33, Oliver Hartkopp wrote:
>>>>     can0  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>>>>     can1  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>>>>     can0  5DD   [9]  7E 55 56 5B C0 23 B0 53
>>>>     can1  5DD   [9]  7E 55 56 5B C0 23 B0 53
>>>>     can0  573   [E]  20 8E A3 31 1B 54 B2 16
>>>>     can1  573   [E]  20 8E A3 31 1B 54 B2 16
>>>>     can0  470   [3]  31 9C 06
>>>>     can1  470   [3]  31 9C 06
>>>>     can0  465   [4]  93 75 A2 08
>>>>     can1  465   [4]  93 75 A2 08
>>>>
>>>>
>>>> Works fine :-)
>>
>> I'm not really sure about the view of Classical CAN DLCs in this 'long'
>> candump representation.
>>
>> There are people that use this format as base for further processing -
>> instead of the logfile format m(
>> So it may be a bad decision to put the DLC value in the length position
>> here.
> 
> There was actually zero thought when I wrote this. I just wanted to
> test the kernel land and this was the first hack which came to my
> mind.

No problem. I would have chosen the same approach ...

> candump is not an easy one to modify. When putting the DLC in the
> picture, I can see three option:
> 
>    1. Do not modify the format. Nothing will break but it would be
>       impossible to know the actual DLC value of a Classical CAN frame
>       of length 8.
> 
>    2. Ask people doing processing on the candump output to modify their
>       tool if they want to use the cc-len8-dlc switch (if not using it,
>       should not break).
> 
>    3. The in-between solution: use a command line switch (e.g. candump
>       -8 any) select option 1 or 2 at run time.
> 
> None of the solution is perfect.

Right.

> I personally do not like option 3. So far, the command "candump any"
> would capture all the information. For example, their is no switch to
> enable/disable the capture of CAN-FD frames so it would seems odd to
> me to have it only for the DLC.

In fact candump tries to switch the socket into CAN FD mode and when it 
fails -> ¯\_(ツ)_/¯

But there is a difference in the standard output:
CAN FD frames have always two digits for the length, e.g. [32] or [04] 
while the standard Classical CAN frame has one digit, e.g. [5] or [0]

> Option 1 would be inconvenient for people who have needs similar to
> mine. Option 2 would be inconvenient for people who want to use
> cc-len8-dlc but do not want to touch their tools built on top of
> candump.
> 
> At the end of the day, I can not think of a perfect solution but I
> actually liked your previous idea of using parenthesis. The rule would
> be that [x] would designate a DLC of len2dlc(x) and a length of x; and
> (x) would designate a DLC of x and length of 8. On a security point of
> view, I think that the impact would be minimal. If we change the
> format form [x] to (x), parsing tools build on top should directly
> crash and the user should notice directly.

Yes. After you shared your thoughts I would indeed tend to provide an 
option '-8' and then always print the raw DLC in parenthesis e.g. (0) or 
(F).

IMO this len8_dlc stuff is an expert feature that normal users do not 
care about. Therefore it should be disabled by default.

>> I changed the logfile format in a backward compatible way and therefore
>> the cansend command line format too:
>>
>> (1604004658.444168) vcan0 2C0##02643
>> (1604004658.494492) vcan0 615#R8_9
>> (1604004658.645395) vcan0 6FF#
>> (1604004658.695682) vcan0 623##318F88F7043C0
>> (1604004658.746046) vcan0 63A##28D1F37
>> (1604004658.796214) vcan0 1117DEA5##0BC281D711098
>> (1604004658.846397) vcan0 1490B893#R8_F
>> (1604004658.896585) vcan0 1F494EC8##39C47E2
>> (1604004658.947142) vcan0 1D1EC448#3DC1C81345D7ED7E_D
>> (1604004658.997689) vcan0 1C8661BB##14DEA7568D459160D
>> (1604004659.047851) vcan0 2D8#AFE0546E6522130D_E
>> (1604004659.098216) vcan0 1596E833##3E6789514EF10B466E6789514EF10B466
> 
> Not the most sexy solution but I have to admit that it does the job
> and fits well with the other tools. Also, I am not able to think of a
> better solutions.

At least is is backwards compatible with older versions of canplayer and 
log2asc.

It doesn't win a design price but I asked my wife what to put as a 
len8_dlc delimiter. And the '_' won as it was still good to distinguish 
when looking at the log file format output.

> Not sure if anyone also uses this log format as base for further
> processing. Somewhere, someone might be impacted as well. But there is
> probably nothing that we can do about that.

Yes, I know people using the log file format - and lib.h and lib.c

> I will need more time to complete a full test and review.
> 
> Overall, I think that you did a good job in the naming convention and
> the choice of the command line options.

Thanks!

Best regards,
Oliver
