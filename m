Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1D2974D6
	for <lists+linux-can@lfdr.de>; Fri, 23 Oct 2020 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465499AbgJWQsJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Oct 2020 12:48:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:9662 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460892AbgJWQsJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Oct 2020 12:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603471685;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=q5+Y2D3DTcCS97CTMyfCwlOiR16+G5ZqpwGBymPLxHw=;
        b=Vt3U+Txcs9GFZSi2fk4hyrL0RZAWmZSRxJIMms9Y/uRThssCmu6BvrC4eGY/T/B+WU
        W2lYB9vVO8clUl4WnSASs+jPqtn1tan4DhoVoDQc/1Th53NgmDziVqbNWx03CXxLr8eK
        IpcxRG7ZDxWE1L5gIhJRybe87lcIQYPdiCuZW8nEVfyH5pSoSzOhzfhrLUqeNjYh6NPa
        AZBPJUzUnLvhK3Alda8/G+2gXAS1/CxMD2XhmdGCxvralRCEsIU4THw9gVdXqY6vNHWN
        ehMuOmrCB80PeS0NHZyuPNNRpXtrr0XTto1MicFLC0kxweh9bbvC/o3qcTIllAhI6xxO
        YmTA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVsh5lkRL"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9NGm2zgb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 23 Oct 2020 18:48:02 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
 <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
 <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
 <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net>
 <CAMZ6RqJ8=T8CAhYaa8PZs5-d2zhx1_15wMe7ohUZovvqTcgW0w@mail.gmail.com>
 <0087f8a4-c77c-cc13-b17d-bd9666837ee3@hartkopp.net>
 <CAMZ6Rq+nHk1ZNzAGbwetEBULq8u_rsUYCd7FYj2HcQ-ejNC+Tw@mail.gmail.com>
 <d3dda30a-3f22-4824-71be-f8520b3714b2@hartkopp.net>
 <CAMZ6RqJrpwOkFPNDNdUU=g=p_VwuPW5erGfj-bk0quKQYsCcXQ@mail.gmail.com>
 <adabe4ca-7065-0aa7-7654-51f77d9b2916@hartkopp.net>
 <CAMZ6RqL2OtSfFp92D0p3RUfeWYgvCb8Aib6=hF-QA0DZTyEqog@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <e0678150-188a-7e6e-6e52-9b74e0c6068c@hartkopp.net>
Date:   Fri, 23 Oct 2020 18:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqL2OtSfFp92D0p3RUfeWYgvCb8Aib6=hF-QA0DZTyEqog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 23.10.20 12:36, Vincent MAILHOL wrote:
> On 23.10.20 02:06, Oliver Hartkopp wrote:
>> On 22.10.20 17:46, Vincent MAILHOL wrote:

>> And what do you mean with "if the device has a DLC filter"?
> 
> A DLC filter is a sub-component of a CAN frame filter which is a type
> of Intrusion Prevention System (IPS). The CAN frame filter consists of
> an allow list which entries are usually CAN IDs and DLCs. If the CAN
> ID and DLC of a received frame do not match any of the entries in the
> allow list, the frame is directly discarded. This is also sometimes
> referred to as CAN firewall. Modern CAN gateways are starting to implement
> such protection mechanism (in addition to the IDS).
> 
> If an ECU has a filter rule to only allow DLC equal to 8, it would
> discard a frame with a DLC greater than 8 even if the length is
> actually 8.

Yes, which is fine. If you want your CAN network work as expected, do 
not enable CAN_CTRLMODE_RAW_DLC.

If you want to test the behaviour of other nodes in your network enable 
CAN_CTRLMODE_RAW_DLC.

>> You told me the DLCs from 9..15 are correct from the ISO standpoint.
>> That a good programmer checks the DLC and makes sure he only processes
>> max. 8 bytes is a common thing and no 'filtering'.
>>
>> You might introduce CAN_RAW_RAW_DLC sockopt for CAN_RAW sockets but when
>> you use packet sockets e.g. with Wireshark and forge some CAN frames
>> there your only chance to have proper 0..8 DLCs is to disable
>> CAN_CTRLMODE_RAW_DLC.
> 
> Did not think of that use case but yes, I agree that
> CAN_CTRLMODE_RAW_DLC is needed. I see CAN_RAW_RAW_DLC as an addition,
> not a replacement.

Yes. And CAN_RAW_RAW_DLC is also pretty easy to implement on the tx 
side. But as I already wrote: It still does not help with AF_PACKET sockets.

>> Btw. do you really see any legacy SocketCAN applications (*together*
>> with your testing application on the same Linux host) where you don't
>> have the source code to check whether they properly initialize the
>> reserved/padding bytes?

Do you?

>> You can also use the can-gw to let 'malicious' CAN apps run on a private
>> virtual CAN. Forwarded modified CAN frames definitely initialize the
>> reserved/padding bytes.
> 
> Here, I am replying to you about the case of the 'legacy' applications
> with uninitialized raw_dlc send CAN frames.
> 
> Even if this is *my* intention, is it the intention of every other
> user activating CAN_CTRLMODE_RAW_DLC?
> 
> Consider either of:
> 
>    * the newbie user who just wants a normal netlink configuration but
>      copy/pasted the command from the internet without realising the
>      raw_dlc option is here.

You can enable the option only as root user. You can not protect every 
noob. If you fiddle with things you have no clue about, you can fail. 
That is a learning curve :-)

We provide reasonable defaults.

>    * the 'more helps more' guys that switch everything to 'on' which
>      you mentioned before. This guys does not understand the RAW_DLC
>      thing but yet activated it.
> 
>    * the expert user who turned on the feature for tests but also runs
>      legacy applications in parallel or after doing the tests.

Again, as I asked before: What legacy applications for the (Open Source) 
SocketCAN could there be on an *experts* system where he could not look 
into to search uninitialized CAN frame structs?

IMO this is an academical question without value.

> 
> All of these users are subjected to the issue on the legacy
> application I explained. It is not their intention to send DLC greater
> than 8.

Then they should not enable CAN_CTRLMODE_RAW_DLC.

> Furthermore, the first two users do not necessarily know how to
> program. They are using downloaded application and do not have the
> knowledge to check for the issue nor to even understand it. (The third
> user should understand. Maybe he or she is not the best example, wish
> I had started my argumentation with the first two user cases).
> 
> I see two options:
> 
>    1. The user used an expert command, it is his responsibility: we do
>       not care, it is his fault.
> 
>    2. We (as kernel hackers) bare responsibility for all usage scenario
>       of the "ip addr set canX..." options and do not allow a scenario
>       which can break an existing application.
> 
> My vote is 2. I draw the line at the code level: user (as a
> programmer) is responsible for the code he or she writes but we (as
> kernel hackers) try to prevent any system configuration from breaking
> existing applications which are working fine.

By default CAN_CTRLMODE_RAW_DLC is disabled.

Even with CAN_CTRLMODE_RAW_DLC enabled all existing applications would 
still work fine.

They will still be able to send and receive CAN frames having proper 
length information in can_dlc - so nothing breaks.

The only thing that could happen is, that their sent CAN frames with 8 
bytes of payload may have a DLC from 8..15 which is still covered by the 
ISO standard. This is no fault.

You can not take responsibility for broken implementations on other ECUs.

>>> You won :-)
>>> Sorry for the long exchange and thank you for your patience.
>>
>> I really don't want to 'win'. But by the time the features and
>> functionalities have been grown and many people rely on its
>> functionality and performance.
>>
>> The discussion helps to find the hopefully best solution and brings all
>> of us to new insights.
>>
>> The difference is to make a new door into a house or to replace its
>> entire water system. You need a VERY good reason to replace the water
>> system ... when you want a new door.
> 
> OK then let me try to re-explain another point.
> 
> I understand that you do not want to drop malformed frames so I stop
> replying on that because I feel that I would only annoy you more. But
> in reality I do not yet understand why you do not want to.
> 
> Below are all the valid pairs of Lengths and DLCs. Every pair outside
> of the table is incorrect.
> 
>      +-----------+-----------+
>      | Length    | DLC       |
>      | (can_dlc) | (raw_dlc) |
>      +-----------+-----------+
>      | 0         | 0         |
>      | 1         | 1         |
>      | 2         | 2         |
>      | 3         | 3         |
>      | 4         | 4         |
>      | 5         | 5         |
>      | 6         | 6         |
>      | 7         | 7         |
>      | 8         | 8..15     |
>      +-----------+-----------+
> 
> If the user sets, let say, can_dlc to 8 and raw_dlc to 2, he expects
> to send a frame of length 8 and *DLC 2*.

This is BS! How can you create such an impossible case after all of our 
discussions?

I write it AGAIN, ONLY FOR YOU:

if (can_dlc == 8) && (raw_dlc > 8 && raw_dlc <= 15)
     dlc = raw_dlc;
else
     dlc = can_dlc;

can_dlc == 8 is the entry door to write dlc values from 9..15 into the 
controller register.
Which always leads to a valid CAN frame with 8 bytes.

So what is so hard to write this into the documentation then?

There is no expectation that anything else then can_dlc is used when 
raw_dlc is set to 2.

And therefore there will never be an invalid frame.

Regards,
Oliver


> Such a frame does not exist
> and is malformed. Your code lets this frame pass through and
> eventually, the driver sends a frame of length 8 and *DLC 8* on the
> wire: not what the user requested.
> 
> My point is why send something different than requested. If it is
> malformed, refuse to send and tell the user "hey this is wrong".
> 
> What is the rationale for not dropping invalid frames?
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 
