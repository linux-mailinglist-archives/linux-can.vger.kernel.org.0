Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91209297C1C
	for <lists+linux-can@lfdr.de>; Sat, 24 Oct 2020 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759683AbgJXLbP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Oct 2020 07:31:15 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:14063 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759680AbgJXLbO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Oct 2020 07:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603539073;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=oD6OWUZ8wSSIaq2k+xqjFm/C8b6byI5YIyU1J9nlHD8=;
        b=T0Z/D83dVo5X/g8F3zIixpWL0MDjitPH5RtLvFjBNntGqFhIiWivkvR2voeIQJjmmV
        No4nbF7Q725C9hKp3l/+2F/PLX1LQHxZl+lK5n7yUCTzdnVHMw3y41vNgDVMWpDQB+nB
        ENyi/ffRQ3mNUvFAS/TQofafYJar3o0+nle9+prTHVPi/dQ6Gq7OYPG/6Jwt+euR/2Im
        rjTDL5AgCrlNS1QvcJLK7k2AyNMQwUDRLBjEATePXJHDY/fKp2tYUJx1Fh6VovG9U2sQ
        /bfii1jnmrL1aoJx5AdgZS0uKSvp5EGGOB/gfRsLA0thgjfeLGsx+/J0hVyjKw1i1WJY
        +Kwg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKN9eTSLsO"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9OBVB0pD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 24 Oct 2020 13:31:11 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
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
 <e0678150-188a-7e6e-6e52-9b74e0c6068c@hartkopp.net>
 <CAMZ6Rq+tx93DuRYsLOpcxjRDOJxUTh-czntEYSv7tDMOwoaLQw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <358352d1-2428-0909-9bfe-a62e68f47e28@hartkopp.net>
Date:   Sat, 24 Oct 2020 13:31:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+tx93DuRYsLOpcxjRDOJxUTh-czntEYSv7tDMOwoaLQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 24.10.20 07:25, Vincent MAILHOL wrote:
> On 24.10.20 01:47, Oliver Hartkopp wrote:

>>>> Btw. do you really see any legacy SocketCAN applications (*together*
>>>> with your testing application on the same Linux host) where you don't
>>>> have the source code to check whether they properly initialize the
>>>> reserved/padding bytes?
>>
>> Do you?

You still didn't answer this hypothetical question. There must be a 
reason behind .. :-D

>> You can not take responsibility for broken implementations on other ECUs.
> 
> We clearly share a difference stance on this subject, I think it is
> time to close the debate. I agree to go with your solution.

Ok, together with this answer I also can close the debate :-)

> I saw your patch. Changing the name from raw_can to len8_dlc clears
> the concerns I had for invalid frames. Thank you.

Great! In fact it cost some time in the night where I woke up from sleep 
and think about "the overall goal what we want to archive" ;-)

The right naming lets developers make right assumptions about the 
functionality. Therefore it always remains tricky - and discussions like 
these. I needed two hours to write an rephrase the patch again and again ...

Also the ctrlmode has now a clear target of Classic CAN (CC) in its 
name: CC_LEN8_DLC

> Thank you also for depreciating the can_dlc field and introducing the
> len field in struct can_frame. It is a smart change.

Thanks. I always had the idea to fix this up after the introduction of 
CAN FD which uses a 'len' element too. I discovered myself at that time, 
that can_dlc was not the best matching choice - but Kernel APIs are 
written in stone for a good reason.

So I've checked what people do, when they need to rename structure 
elements in the Kernel API in the uapi section and found this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31ba514b2fd0495796

> I will now test the patch.

So far it only is an idea for naming 'things' - but I'm happy you like it!

IMO we could continue with enabling a CAN driver to support 
CAN_CTRLMODE_CC_LEN8_DLC and see how it works in reality with CAN_RAW 
and AF_PACKET - and if we would finally need CAN_RAW_LEN8_DLC or not.

Best,
Oliver
