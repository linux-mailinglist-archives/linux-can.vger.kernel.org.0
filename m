Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0C3296CF4
	for <lists+linux-can@lfdr.de>; Fri, 23 Oct 2020 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461728AbgJWKhO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Oct 2020 06:37:14 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45958 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461853AbgJWKhN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Oct 2020 06:37:13 -0400
Received: by mail-yb1-f193.google.com with SMTP id s89so784442ybi.12
        for <linux-can@vger.kernel.org>; Fri, 23 Oct 2020 03:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNFSJLwEjsEzSOIxtxKD06Hw7ziA3nJQuJuP1VPikpc=;
        b=Sjyz0HNpU5Ich9yrvlWQgYJwVMB2Fo0wVMpcg95QGWg0z0UDj3EzK2oTmlsoUN11GA
         Ldk09hwLDz+mgSY70ObHp41j+nAo5QZeANpp6rxSrtzjhG1YdMnnuXyhZRpVOK22lkGG
         x+LOAdE+nVsbR+x+bqnOFZiiLRZqPdxYNfXF4nN7r2lKxWcjYpSgJOw+QkrScvfIwsYz
         QVE087+v6rpOMvI8XBWsrhYMEe4/78FjY7Yw5ZzYPNVIWaFu7j5VaSx+BryvW9G4TXKB
         jLPaaq1QsyRG3LOHt37zv4BourqNObHtw8+eyxOAIVbbcvvO3VsIbPbzFWMDoAULkf2N
         pbww==
X-Gm-Message-State: AOAM5338M4hR+BptglqwhNJ5OUV6ooAGjEk1+FvQAP2dEN9MYON8jW6r
        HOpJPcR2bH4xsRTLyXW6o0heYqQK5JPzpDb/hetWi3llsI3/PQ==
X-Google-Smtp-Source: ABdhPJyRPzTpZeSe+QsvLqL3fEKDOcqGP4iuT6Wrsdl+/Cx8pXkzEWVIowJ6WTvCUoU/VAZzFpFNxA3LrPRsEhef1Qc=
X-Received: by 2002:a25:4091:: with SMTP id n139mr2620120yba.226.1603449431663;
 Fri, 23 Oct 2020 03:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201019190524.1285319-1-mkl@pengutronix.de> <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de> <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net> <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
 <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net> <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net> <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
 <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net> <CAMZ6RqJ8=T8CAhYaa8PZs5-d2zhx1_15wMe7ohUZovvqTcgW0w@mail.gmail.com>
 <0087f8a4-c77c-cc13-b17d-bd9666837ee3@hartkopp.net> <CAMZ6Rq+nHk1ZNzAGbwetEBULq8u_rsUYCd7FYj2HcQ-ejNC+Tw@mail.gmail.com>
 <d3dda30a-3f22-4824-71be-f8520b3714b2@hartkopp.net> <CAMZ6RqJrpwOkFPNDNdUU=g=p_VwuPW5erGfj-bk0quKQYsCcXQ@mail.gmail.com>
 <adabe4ca-7065-0aa7-7654-51f77d9b2916@hartkopp.net>
In-Reply-To: <adabe4ca-7065-0aa7-7654-51f77d9b2916@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 23 Oct 2020 19:36:59 +0900
Message-ID: <CAMZ6RqL2OtSfFp92D0p3RUfeWYgvCb8Aib6=hF-QA0DZTyEqog@mail.gmail.com>
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

On 23.10.20 02:06, Oliver Hartkopp wrote:
> On 22.10.20 17:46, Vincent MAILHOL wrote:
>> On 22.10.20 22:28, Oliver Hartkopp wrote:
>>> On 22.10.20 14:23, Vincent MAILHOL wrote:
>
>>>>> The above pseudo code together with CAN_CTRLMODE_RAW_DLC seems to be a
>>>>> pretty safe option to me. Even if 'legacy' applications with
>>>>> uninitialized raw_dlc send CAN frames or AF_PACKET users enable
>>>>> CAN_CTRLMODE_RAW_DLC we always end up with a proper can_dlc == 8  and a
>>>>> fitting valid raw_dlc.
>>>>
>>>> But what if that "fitting valid raw_dlc" is greater than 8?
>>>
>>> This is the plan!
>>>
>>>> The kernel
>>>
>>> the CAN driver
>>>
>>>> would see that frame as valid, a frame with a DLC greater than 8 will
>>>> be sent on the wire and received by the other devices than might be
>>>> connected on the CAN bus.
>>>
>>> Exactly.
>>
>> And this is my point. The legacy application intended to send a frame
>> of 8 bytes with a DLC of 8 but on the wire, there is a frame of 8
>> bytes with a DLC greater than 8. The other devices on the CAN bus
>> might ignore it (if the device has a DLC filter) or might crash if
>> there is a vulnerability in DLC handling.
>
> But this is your intention, right?
>
> You wanted to test this behaviour. This is no normal operation - it's a
> *test* mode to detect said vulnerabilities in DLC handling.
>
> And what do you mean with "if the device has a DLC filter"?

A DLC filter is a sub-component of a CAN frame filter which is a type
of Intrusion Prevention System (IPS). The CAN frame filter consists of
an allow list which entries are usually CAN IDs and DLCs. If the CAN
ID and DLC of a received frame do not match any of the entries in the
allow list, the frame is directly discarded. This is also sometimes
referred to as CAN firewall. Modern CAN gateways are starting to implement
such protection mechanism (in addition to the IDS).

If an ECU has a filter rule to only allow DLC equal to 8, it would
discard a frame with a DLC greater than 8 even if the length is
actually 8.

> You told me the DLCs from 9..15 are correct from the ISO standpoint.
> That a good programmer checks the DLC and makes sure he only processes
> max. 8 bytes is a common thing and no 'filtering'.
>
> You might introduce CAN_RAW_RAW_DLC sockopt for CAN_RAW sockets but when
> you use packet sockets e.g. with Wireshark and forge some CAN frames
> there your only chance to have proper 0..8 DLCs is to disable
> CAN_CTRLMODE_RAW_DLC.

Did not think of that use case but yes, I agree that
CAN_CTRLMODE_RAW_DLC is needed. I see CAN_RAW_RAW_DLC as an addition,
not a replacement.

> Btw. do you really see any legacy SocketCAN applications (*together*
> with your testing application on the same Linux host) where you don't
> have the source code to check whether they properly initialize the
> reserved/padding bytes?
>
> You can also use the can-gw to let 'malicious' CAN apps run on a private
> virtual CAN. Forwarded modified CAN frames definitely initialize the
> reserved/padding bytes.

Here, I am replying to you about the case of the 'legacy' applications
with uninitialized raw_dlc send CAN frames.

Even if this is *my* intention, is it the intention of every other
user activating CAN_CTRLMODE_RAW_DLC?

Consider either of:

  * the newbie user who just wants a normal netlink configuration but
    copy/pasted the command from the internet without realising the
    raw_dlc option is here.

  * the 'more helps more' guys that switch everything to 'on' which
    you mentioned before. This guys does not understand the RAW_DLC
    thing but yet activated it.

  * the expert user who turned on the feature for tests but also runs
    legacy applications in parallel or after doing the tests.

All of these users are subjected to the issue on the legacy
application I explained. It is not their intention to send DLC greater
than 8.

Furthermore, the first two users do not necessarily know how to
program. They are using downloaded application and do not have the
knowledge to check for the issue nor to even understand it. (The third
user should understand. Maybe he or she is not the best example, wish
I had started my argumentation with the first two user cases).

I see two options:

  1. The user used an expert command, it is his responsibility: we do
     not care, it is his fault.

  2. We (as kernel hackers) bare responsibility for all usage scenario
     of the "ip addr set canX..." options and do not allow a scenario
     which can break an existing application.

My vote is 2. I draw the line at the code level: user (as a
programmer) is responsible for the code he or she writes but we (as
kernel hackers) try to prevent any system configuration from breaking
existing applications which are working fine.

This my interpretation of the "do not break user land" rule.

>>>> Basically, that would replace the use of the can_len2dlc() function.
>>>>
>>>> I also think it should be extended to CAN-FD, but no need to elaborate
>>>> more on this at the moment: let's keep the discussion focused on
>>>> classical CAN and tackle this later.
>>>
>>> Why do you want this?
>>>
>>> You get of the bike and push your bicycle for what reason?
>>>
>>> No.
>>
>> Pushing the bike: yes, that was actually my motivation. One more time,
>> I am not telling you are wrong, just that I would do it in a different
>> way. I explained my view and you read it. I do not have more arguments
>> to bring.
>
> /me either ...
>
> https://youtu.be/aKnX5wci404?t=34
>
>>>>> Ok, let me rephrase: Filling can_dlc with something else than a plain
>>>>> length information 0..8 ;-)
>>>>
>>>> Got it :-)
>>>>
>>>>   From my preliminary study, not so much changes or sanity check would
>>>> need to be added:
>>>>
>>>>     1. The current can_dlc sanity checks in can_send() and can_rcv() in
>>>>        net/can/af_can.c definitely needs to be adjusted (but this would
>>>>        also be the case for the raw_dlc field solution).
>>>>
>>>>     2. In the kernel Rx and Tx paths: the length should not be accessed
>>>>        directly anymore but through a getter function.
>>>>
>>>>     3. In the kernel: drivers "DLC aware" need to adapt their code and
>>>>        use the length getter function.
>>>>
>>>>     4. In user land: new "DLC aware" code should always use struct
>>>>        can_frame for classical CAN and check whether can_dlc is greater
>>>>        that CAN_MAX_DLEN before accessing data.
>>>>
>>>> That's mostly all that would have to be adjusted.
>>>>
>>>
>>> No, it is not.
>>> You have to go through all protocols, e.g. raw.c, bcm.c, gw.c, j1939,
>>> isotp.c which get a skb to be (sometimes) cloned by them. And when they
>>> need to modify the can_dlc value to send it to the userspace or
>>> whatever, you need to modify skb->data - and then you can't clone it
>>> anymore but need to skbcopy() them.
>>> HERE you will get a really big effort. Occasionally I was also thinking
>>> using can_dlc would be nice but then I looked into above code and your
>>> use-case does not justify that effort/ risk and performance impact.
>>
>> I naively thought this part would not get impacted. I have yet to
>> understand the full impact in detail but you made your point clear.
>>
>> You won :-)
>> Sorry for the long exchange and thank you for your patience.
>
> I really don't want to 'win'. But by the time the features and
> functionalities have been grown and many people rely on its
> functionality and performance.
>
> The discussion helps to find the hopefully best solution and brings all
> of us to new insights.
>
> The difference is to make a new door into a house or to replace its
> entire water system. You need a VERY good reason to replace the water
> system ... when you want a new door.

OK then let me try to re-explain another point.

I understand that you do not want to drop malformed frames so I stop
replying on that because I feel that I would only annoy you more. But
in reality I do not yet understand why you do not want to.

Below are all the valid pairs of Lengths and DLCs. Every pair outside
of the table is incorrect.

    +-----------+-----------+
    | Length    | DLC       |
    | (can_dlc) | (raw_dlc) |
    +-----------+-----------+
    | 0         | 0         |
    | 1         | 1         |
    | 2         | 2         |
    | 3         | 3         |
    | 4         | 4         |
    | 5         | 5         |
    | 6         | 6         |
    | 7         | 7         |
    | 8         | 8..15     |
    +-----------+-----------+

If the user sets, let say, can_dlc to 8 and raw_dlc to 2, he expects
to send a frame of length 8 and *DLC 2*. Such a frame does not exist
and is malformed. Your code lets this frame pass through and
eventually, the driver sends a frame of length 8 and *DLC 8* on the
wire: not what the user requested.

My point is why send something different than requested. If it is
malformed, refuse to send and tell the user "hey this is wrong".

What is the rationale for not dropping invalid frames?


Yours sincerely,
Vincent Mailhol
