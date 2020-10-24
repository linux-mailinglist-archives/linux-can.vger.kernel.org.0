Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6622297AE8
	for <lists+linux-can@lfdr.de>; Sat, 24 Oct 2020 07:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759588AbgJXFZ5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Oct 2020 01:25:57 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36891 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759587AbgJXFZ5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Oct 2020 01:25:57 -0400
Received: by mail-yb1-f196.google.com with SMTP id h196so3025697ybg.4
        for <linux-can@vger.kernel.org>; Fri, 23 Oct 2020 22:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XymniueHOTHVvdwmQT3Wz059a5doNPFg4LnqRCizeP0=;
        b=o+FPWvr928ih2Mb+NbDFQL1Fmrus9f6b61u0HHhpz+DnXqFv4U957bJJfPpFxCi/jW
         oqmGlOG2FftqV6bGlwdlZ0R3VqKUyZqKoa/PZOIPoLwWSOxq3CxVUW+vl8h47zFZlJ0n
         qwrVdPg8L2DjlvjjlG8cCkm92wglAwrNZyXiCUFsv6pjnMGvjdajNrUwKmj8qpYhkcBg
         /nsBwJXdkJYI58C2HfXfNHQbul5FCHvYCti8LV6lIc8HfwOuXlVXxl19Z/Ywr5MnCm1y
         2zPqJYVjwTKS7PdyzNUqgvsw2oeS3oGpBxlAXVmlBn3LIj4YqkLbd8lT3OytJf4PgHK2
         C+ag==
X-Gm-Message-State: AOAM530D62PNUIsmPOleFYwoQN/yGWrQ5vcIsezGywmvrjDjeHtXxgcy
        JnMoar7Yw7QVE14C5CpBThAOpDdR0Hn4R5lsK8k=
X-Google-Smtp-Source: ABdhPJzsq49irGQ0c0HlaUitCxE5TRfC8Gzf9h1SqyGM0GzoCvHlrxC2Q6+GUwFEnDUU9U7+ThusCl80KnNXfDvnAGM=
X-Received: by 2002:a25:15c9:: with SMTP id 192mr7367330ybv.145.1603517155381;
 Fri, 23 Oct 2020 22:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201019190524.1285319-1-mkl@pengutronix.de> <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net> <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
 <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net> <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net> <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
 <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net> <CAMZ6RqJ8=T8CAhYaa8PZs5-d2zhx1_15wMe7ohUZovvqTcgW0w@mail.gmail.com>
 <0087f8a4-c77c-cc13-b17d-bd9666837ee3@hartkopp.net> <CAMZ6Rq+nHk1ZNzAGbwetEBULq8u_rsUYCd7FYj2HcQ-ejNC+Tw@mail.gmail.com>
 <d3dda30a-3f22-4824-71be-f8520b3714b2@hartkopp.net> <CAMZ6RqJrpwOkFPNDNdUU=g=p_VwuPW5erGfj-bk0quKQYsCcXQ@mail.gmail.com>
 <adabe4ca-7065-0aa7-7654-51f77d9b2916@hartkopp.net> <CAMZ6RqL2OtSfFp92D0p3RUfeWYgvCb8Aib6=hF-QA0DZTyEqog@mail.gmail.com>
 <e0678150-188a-7e6e-6e52-9b74e0c6068c@hartkopp.net>
In-Reply-To: <e0678150-188a-7e6e-6e52-9b74e0c6068c@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 24 Oct 2020 14:25:44 +0900
Message-ID: <CAMZ6Rq+tx93DuRYsLOpcxjRDOJxUTh-czntEYSv7tDMOwoaLQw@mail.gmail.com>
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 24.10.20 01:47, Oliver Hartkopp wrote:
> On 23.10.20 12:36, Vincent MAILHOL wrote:
>> On 23.10.20 02:06, Oliver Hartkopp wrote:
>>> On 22.10.20 17:46, Vincent MAILHOL wrote:
>
>>> And what do you mean with "if the device has a DLC filter"?
>>
>> A DLC filter is a sub-component of a CAN frame filter which is a type
>> of Intrusion Prevention System (IPS). The CAN frame filter consists of
>> an allow list which entries are usually CAN IDs and DLCs. If the CAN
>> ID and DLC of a received frame do not match any of the entries in the
>> allow list, the frame is directly discarded. This is also sometimes
>> referred to as CAN firewall. Modern CAN gateways are starting to implement
>> such protection mechanism (in addition to the IDS).
>>
>> If an ECU has a filter rule to only allow DLC equal to 8, it would
>> discard a frame with a DLC greater than 8 even if the length is
>> actually 8.
>
> Yes, which is fine. If you want your CAN network work as expected, do
> not enable CAN_CTRLMODE_RAW_DLC.
>
> If you want to test the behaviour of other nodes in your network enable
> CAN_CTRLMODE_RAW_DLC.
>
>>> You told me the DLCs from 9..15 are correct from the ISO standpoint.
>>> That a good programmer checks the DLC and makes sure he only processes
>>> max. 8 bytes is a common thing and no 'filtering'.
>>>
>>> You might introduce CAN_RAW_RAW_DLC sockopt for CAN_RAW sockets but when
>>> you use packet sockets e.g. with Wireshark and forge some CAN frames
>>> there your only chance to have proper 0..8 DLCs is to disable
>>> CAN_CTRLMODE_RAW_DLC.
>>
>> Did not think of that use case but yes, I agree that
>> CAN_CTRLMODE_RAW_DLC is needed. I see CAN_RAW_RAW_DLC as an addition,
>> not a replacement.
>
> Yes. And CAN_RAW_RAW_DLC is also pretty easy to implement on the tx
> side. But as I already wrote: It still does not help with AF_PACKET sockets.
>
>>> Btw. do you really see any legacy SocketCAN applications (*together*
>>> with your testing application on the same Linux host) where you don't
>>> have the source code to check whether they properly initialize the
>>> reserved/padding bytes?
>
> Do you?
>
>>> You can also use the can-gw to let 'malicious' CAN apps run on a private
>>> virtual CAN. Forwarded modified CAN frames definitely initialize the
>>> reserved/padding bytes.
>>
>> Here, I am replying to you about the case of the 'legacy' applications
>> with uninitialized raw_dlc send CAN frames.
>>
>> Even if this is *my* intention, is it the intention of every other
>> user activating CAN_CTRLMODE_RAW_DLC?
>>
>> Consider either of:
>>
>>    * the newbie user who just wants a normal netlink configuration but
>>      copy/pasted the command from the internet without realising the
>>      raw_dlc option is here.
>
> You can enable the option only as root user. You can not protect every
> noob. If you fiddle with things you have no clue about, you can fail.
> That is a learning curve :-)
>
> We provide reasonable defaults.
>
>>    * the 'more helps more' guys that switch everything to 'on' which
>>      you mentioned before. This guys does not understand the RAW_DLC
>>      thing but yet activated it.
>>
>>    * the expert user who turned on the feature for tests but also runs
>>      legacy applications in parallel or after doing the tests.
>
> Again, as I asked before: What legacy applications for the (Open Source)
> SocketCAN could there be on an *experts* system where he could not look
> into to search uninitialized CAN frame structs?
>
> IMO this is an academical question without value.
>
>>
>> All of these users are subjected to the issue on the legacy
>> application I explained. It is not their intention to send DLC greater
>> than 8.
>
> Then they should not enable CAN_CTRLMODE_RAW_DLC.
>
>> Furthermore, the first two users do not necessarily know how to
>> program. They are using downloaded application and do not have the
>> knowledge to check for the issue nor to even understand it. (The third
>> user should understand. Maybe he or she is not the best example, wish
>> I had started my argumentation with the first two user cases).
>>
>> I see two options:
>>
>>    1. The user used an expert command, it is his responsibility: we do
>>       not care, it is his fault.
>>
>>    2. We (as kernel hackers) bare responsibility for all usage scenario
>>       of the "ip addr set canX..." options and do not allow a scenario
>>       which can break an existing application.
>>
>> My vote is 2. I draw the line at the code level: user (as a
>> programmer) is responsible for the code he or she writes but we (as
>> kernel hackers) try to prevent any system configuration from breaking
>> existing applications which are working fine.
>
> By default CAN_CTRLMODE_RAW_DLC is disabled.
>
> Even with CAN_CTRLMODE_RAW_DLC enabled all existing applications would
> still work fine.
>
> They will still be able to send and receive CAN frames having proper
> length information in can_dlc - so nothing breaks.
>
> The only thing that could happen is, that their sent CAN frames with 8
> bytes of payload may have a DLC from 8..15 which is still covered by the
> ISO standard. This is no fault.
>
> You can not take responsibility for broken implementations on other ECUs.

We clearly share a difference stance on this subject, I think it is
time to close the debate. I agree to go with your solution.

One more time, thank you for your time and patience :-)

>>>> You won :-)
>>>> Sorry for the long exchange and thank you for your patience.
>>>
>>> I really don't want to 'win'. But by the time the features and
>>> functionalities have been grown and many people rely on its
>>> functionality and performance.
>>>
>>> The discussion helps to find the hopefully best solution and brings all
>>> of us to new insights.
>>>
>>> The difference is to make a new door into a house or to replace its
>>> entire water system. You need a VERY good reason to replace the water
>>> system ... when you want a new door.
>>
>> OK then let me try to re-explain another point.
>>
>> I understand that you do not want to drop malformed frames so I stop
>> replying on that because I feel that I would only annoy you more. But
>> in reality I do not yet understand why you do not want to.
>>
>> Below are all the valid pairs of Lengths and DLCs. Every pair outside
>> of the table is incorrect.
>>
>>      +-----------+-----------+
>>      | Length    | DLC       |
>>      | (can_dlc) | (raw_dlc) |
>>      +-----------+-----------+
>>      | 0         | 0         |
>>      | 1         | 1         |
>>      | 2         | 2         |
>>      | 3         | 3         |
>>      | 4         | 4         |
>>      | 5         | 5         |
>>      | 6         | 6         |
>>      | 7         | 7         |
>>      | 8         | 8..15     |
>>      +-----------+-----------+
>>
>> If the user sets, let say, can_dlc to 8 and raw_dlc to 2, he expects
>> to send a frame of length 8 and *DLC 2*.
>
> This is BS! How can you create such an impossible case after all of our
> discussions?
>
> I write it AGAIN, ONLY FOR YOU:
>
> if (can_dlc == 8) && (raw_dlc > 8 && raw_dlc <= 15)
>      dlc = raw_dlc;
> else
>      dlc = can_dlc;
>
> can_dlc == 8 is the entry door to write dlc values from 9..15 into the
> controller register.
> Which always leads to a valid CAN frame with 8 bytes.
>
> So what is so hard to write this into the documentation then?
>
> There is no expectation that anything else then can_dlc is used when
> raw_dlc is set to 2.
>
> And therefore there will never be an invalid frame.

I saw your patch. Changing the name from raw_can to len8_dlc clears
the concerns I had for invalid frames. Thank you.

Thank you also for depreciating the can_dlc field and introducing the
len field in struct can_frame. It is a smart change.

I will now test the patch.


Yours sincerely,
Vincent Mailhol
