Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2CE294E3C
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 16:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443235AbgJUOH5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 10:07:57 -0400
Received: from mail.iot.bzh ([51.75.236.24]:17838 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443234AbgJUOH5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 21 Oct 2020 10:07:57 -0400
Received: from [10.18.0.158] (112.6.193.77.rev.sfr.net [77.193.6.112])
        by mail.iot.bzh (Postfix) with ESMTPSA id 11D9140095;
        Wed, 21 Oct 2020 16:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1603289265; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9oXZjcgiyLMU033KKZMSYJBBS9HhDmx4rYnBl6Kg+4=;
        b=vqtNM9ep8o/aEha92TNLeuMESmqraYdU0MIL5gOMSvVeiHWFaDEZ+HDvy5riEFLbS/6fjX
        DrrvGq5/8qdbcmUtrpEbvanbHQ0rVIHo20/wQWwAuEVi08GCo+Ab2nJ4oIwyG0lGplWZ8L
        yEuDI+sVEXxiNccH4QBU9hazevD5Q33yS3wYiYCcCL7207VIjzQxtTpPjzynLxNKLHfPv6
        CWtl+SKnK12nQmNgA9NprZgoYX2O24Mg0rNvtNsvWnci8cjli7PFF0156KoQQ2gmJgNfW2
        svXD4ftjtQCfQ/KMpsqkX1lMnbwzEnH/VL8geWQsr58lXl1cJBqSanONcijVOA==
Subject: Re: Questions around J1939 backport to old kernel
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
To:     Arnej <arnejduranovic@protonmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
 <20191018145333.a27j7d7f4zf3bqjd@pengutronix.de>
 <72a6f8b2-38e3-a54b-d719-10471d4d260b@iot.bzh>
 <20191025093949.ijb5qt5beq4qavnk@pengutronix.de>
 <aHcanZVhvgbO9XqQBg9c6QdeJZmy9g5O5w9yK83_VqiUuKYCBe2Uh_1S7oaPDQq85QTPEgQME2WTpi96iTO0yzSYRIxYQ-L8VcC8oyR591E=@protonmail.com>
 <cb1b1825-e290-1bfd-6feb-bc997b21416f@iot.bzh>
Organization: IOTBZH
Message-ID: <8034ebaa-39f2-341c-ef72-10c85646adf6@iot.bzh>
Date:   Wed, 21 Oct 2020 16:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cb1b1825-e290-1bfd-6feb-bc997b21416f@iot.bzh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I've just remind that the mailing list do not accept attached document 
and then my patches hasn't been published on it.

What it is the correct way to do it ?

Thanks.

Regards.

Romain Forlot.

On 28/09/2020 13:17, Romain Forlot [IoT.bzh] wrote:
> Hello,
>
> I almost forgot, here is the result of my work about the backport of 
> j1939 protocol for the kernel v4.14. It isn't perfect, but we were 
> able to use j1939 with some warning but it was functional.
>
> This work was mainly made for our Redpesk linux distribution for a CES 
> demo. Hoping that it could be improved and be useful to you.
>
> Best regards.
>
> Romain Forlot.
>
> On 25/10/2019 21:49, Arnej wrote:
>> Hello,
>>
>> I am also very interested in back-porting. My project is currently on 
>> 4.9.9 and it is not possible to upgrade to the latest kernel at this 
>> time. I was wondering if you had any thoughts on what is required to 
>> achieve this? For example, it seems that the net stack in 5.4 is very 
>> different from 4.9 (even more so compared to 4.14) and I am having 
>> difficulties getting the kernel to compile after following your 
>> cherry-pick suggestion. I'm wondering if you are familiar with the 
>> net changes and would know if it is a good idea to continue to try 
>> back-porting (is it even possible?) or if you know of any other option?
>>
>> Best Regards,
>>
>> Arnej Duranovic
>>
>> On Friday, October 25, 2019 4:39 AM, Oleksij Rempel 
>> <o.rempel@pengutronix.de> wrote:
>>
>>> On Fri, Oct 25, 2019 at 09:38:39AM +0200, Romain Forlot [IoT.bzh] 
>>> wrote:
>>>
>>>> I used it in the mainline kernel without troubles. This is a a very 
>>>> good
>>>> job, thanks.
>>>> Ok, thanks for the answer. May be I  will work on it in the next 
>>>> few months.
>>>> Let's see. I'll keep you informed.
>>> Thank you for testing. I hope to get more feed back :)
>>>
>>>> Regards.
>>>> On 18/10/2019 16:53, Oleksij Rempel wrote:
>>>>
>>>>> Hi,
>>>>> On Fri, Oct 18, 2019 at 12:07:34PM +0200, Romain Forlot [IoT.bzh] 
>>>>> wrote:
>>>>>
>>>>>> Hi,
>>>>>> I am wondering what the cost is to backport the j1939 module to 
>>>>>> an old
>>>>>> version like a v4.14 LTSI version.
>>>>>> The backport should be quite easy:
>>>>> git cherry-pick -sx `git rev-list --reverse 
>>>>> 2c1f9e26344483e2c74e80ef708d9c7fd2e543f4..9d71dd0c70099914fcd063135da3c580865e924c`
>>>>> ...but it isn't :/ Some CAN patches are missing. We'll backport 
>>>>> the stack to
>>>>> v4.14.150 (or newer) and send a follow up mail.
>>>>> However, the driver for the CAN adapter needs proper RX/TX frame 
>>>>> ordering,
>>>>> otherwise the stack will explode.
>>>>> This is fixed in flexcan mainline. And involves a handful of 
>>>>> patches. Other
>>>>> drivers probably need more fixing. Some CAN hardware may even lack 
>>>>> the hardware
>>>>> support for proper ordering, that is time stamping registers.
>>>>>
>>>>>> And what the impact is of backporting the whole CAN stack on the 
>>>>>> CAN drivers?
>>>>>> The stack has no impact on the drivers, but requirements on 
>>>>>> proper RX/TX
>>>>>> ordering, see above.
>>>>>> Are there any modifications to drivers once the CAN stack is 
>>>>>> updated ?
>>>>>> Yes, as long as they don't have proper RX/TX ordering.
>>>>> So, which CAN driver are you planing to use?
>>>>> Regards,
>>>>> Oleksij & Marc
>>>> -- 
>>>> Romain Forlot - Embedded Engineer - IoT.bzh
>>>> romain.forlot@iot.bzh - www.iot.bzh - +33675142438
>>> -- 
>>>
>>> Pengutronix e.K. | |
>>> Industrial Linux Solutions | http://www.pengutronix.de/ |
>>> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 |
>>> Amtsgericht Hildesheim, HRA 2686 | Fax: +49-5121-206917-5555 |
>>
-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438

