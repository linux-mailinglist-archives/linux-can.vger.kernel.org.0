Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A262615297E
	for <lists+linux-can@lfdr.de>; Wed,  5 Feb 2020 11:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBEK7J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Feb 2020 05:59:09 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:30199 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgBEK7J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Feb 2020 05:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580900344;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ON+SE/dbY9jNeXiCw6HJVP2NphqizN9nGH/HUUCa+qk=;
        b=IChmWN6ogjYx6RLTffM2B3qb8C4SPUVVJmmCBz+aWwScV/jFmPB5xzJKQWaLh15HvM
        3ZcBllKN/oFeISZV/AhM6+G0yWnxHpOULiuH5nXoGSTLZ9lGkNRTH58oGmF2w/1QN4Mz
        Yqy7EccxXyEh7IDVM6MlBa8mgCju+u/q+z/Z+n8JtzpyyirVnuY4KVLeSoR7XlwE8VB4
        xbQGgM5xr0GU4lvtrj4ZSIQ+UzY0Wes7Hrd+aybRrSGGyJ/ErJ/A3nj3NaX1Nw7c4H/h
        jznbvEGIFOjRSciB6tckVLh2deKf87VDwHTFB1AZqEnlHfPywqcNH8SkTuLsPdnIxUYp
        zqvg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVMh7kiA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id g084e8w15Ax3Fr5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 5 Feb 2020 11:59:03 +0100 (CET)
Subject: Re: usb_8dev - WARN_ON(in_irq())
To:     Gediminas Simanskis <gediminas@rusoku.com>,
        linux-can@vger.kernel.org, info@8devices.com
Cc:     Michal Sojka <michal.sojka@cvut.cz>,
        Bernd Krumboeck <b.krumboeck@gmail.com>
References: <87h8245gyv.fsf@steelpick.2x.cz>
 <7429cd37-f4dd-247c-7fa3-259801f20944@rusoku.com>
 <8aaec717-0ff7-922b-6969-482363d2790b@hartkopp.net>
 <03fe333a-7a7b-e9b6-fd9e-3d433c2f3cb3@rusoku.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <72ef9952-df01-aa84-a186-93d578b06818@hartkopp.net>
Date:   Wed, 5 Feb 2020 11:58:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <03fe333a-7a7b-e9b6-fd9e-3d433c2f3cb3@rusoku.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Gediminas,

thanks for the information!

I've put info [at] 8devices.com into the recipients list as the Linux 
driver has to do the "right thing" when it gets the "Tx URB aborted 
(-2)" information.

And so far I did not see anything like this with the old 'white' USB2CAN 
adapter with FW 1.7.

As long as we don't know how to react on this new feedback from the USB 
device, it is hard to think about a fix ...

Best regards,
Oliver


On 04/02/2020 20.54, Gediminas Simanskis wrote:
> Hi Oliver,
> 
> I remember that in some conditions usb2can began to flood with messages 
> like this (CANAL_STATUSMSG_xx).
> In normal state these messages should be disabled via init string.
> 
> I don't have acces to Korlan firmware.
> 
> Regards,
> Gediminas
> 
> On 2020-02-04 19:52, Oliver Hartkopp wrote:
>> Hello Gediminas,
>>
>> I took a look into the old firmware of the former USB_8DEV adapter 
>> with the white housing which had a CANAL_STATUSMSG_BUSLIGHT (== 0x02) 
>> return value:
>>
>> https://github.com/krumboeck/usb2can_firmware/blob/master/main.c#L227
>>
>> Is this the right place to search for the value that is checked in the 
>> kernel here:
>> https://elixir.bootlin.com/linux/v5.5.1/source/drivers/net/can/usb/usb_8dev.c#L581 
>>
>>
>> ??
>>
>> can0: Tx URB aborted (-2)
>>
>> At least the status is *only* printed in 
>> usb_8dev_write_bulk_callback() and the echo skb handling is still 
>> performed as there was a zero status (== ok?!?).
>>
>> Do you have an idea how to proceed with the driver in the case the 
>> user has the newer
>> https://www.8devices.com/products/usb2can_korlan
>> device?
>>
>> Best regards,
>> Oliver
>>
>> On 13/12/2019 18.20, Gediminas Simanskis wrote:
>>> Seems like to USB2CAN buffer overflow and firmware crashing.
>>>
>>> Gediminas
>>>
>>> On 2019-12-13 18:27, Michal Sojka wrote:
>>>> On Fri, Dec 13 2019, Michal Sojka wrote:
>>>>> Hi Oliver,
>>>>>
>>>>> On Fri, Dec 13 2019, Oliver Hartkopp wrote:
>>>>>> Did you do anything weird (e.g. pulling the USB plug on the run) 
>>>>>> to get
>>>>>> this problem?
>>>>> No, I just connected it to an ECU and started sending messages on the
>>>>> bus. The behaviour was like if the messages were not acknowledged, 
>>>>> i.e.,
>>>>> initially, candump on my laptop showed the messages sent, but after 
>>>>> some
>>>>> time (perhaps after TX buffers were full), candump stopped. I was also
>>>>> not able to see any messages sent by the ECU (both before and after I
>>>>> sent my messages).
>>>>>
>>>>> When I used the same ECU and all the wiring with peak_usb, 
>>>>> communication
>>>>> with the ECU was without any problems.
>>>> I did more investigation - I was able to fix the problem by adding a
>>>> terminator resistor to the bus.
>>>>
>>>> However, the problem can be easily reproduced by the following sequence
>>>> of commands, when the USB2CAN is not connected to any bus:
>>>>
>>>>      ip link set can0 up txqueuelen 1000 type can bitrate 500000
>>>>      candump can0
>>>>      cangen -v -g 50 can0
>>>>
>>>> when candump stops printing the messages, run:
>>>>
>>>>      ip link set down dev can0
>>>>
>>>> and the warnings appear in dmesg. I was also trying this with latest
>>>> mainline kernel, which includes the fix for use-after-free, and the
>>>> warnings are still there.
>>>>
>>>> -Michal
