Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4F15457D
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2020 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFNyc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Feb 2020 08:54:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:9877 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFNyb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2020 08:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580997265;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ave1gAK8sLZuiFoip2En3iCBvSsZ5Qzm2o3nuVsoOvM=;
        b=UEqwZZb08tjacDMEItUIAYb/P1KTTD+1rgz1jxyY2ji8vIKXMqTgszfjrtEkDsRWJI
        ++rFZMuWJB68mMKqvbBLDbusU0lSjS9nMRs+9Joh+dS+DWFCapoH5iS4tTqg9EF9f0y5
        FNt45pIS1e30+M3bu9dIBWq7ZG6LdMqQ7S67lgqIJahPXWwy7h/N0QPHxi7i7zYIznOw
        l6tbTTI2qLtVHjBoK+IWH1pcY9T9w/9UauhovYXXlDh1lsbZTqM+ZioHKwclueto1fEd
        4dsBk1xGKm46pEW8SvVvdnVota05iZrmb3gY/OOpJ1No4rVt+B3lOLVcmP1b7R4CGR2x
        NXpw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+26OxA=="
X-RZG-CLASS-ID: mo00
Received: from [10.180.51.222]
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id g084e8w16DsPJzZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 6 Feb 2020 14:54:25 +0100 (CET)
Subject: Re: Help to set up can net interface on Dell 3200 Intel Atom
To:     "Lev R. Oshvang ." <levonshe@gmail.com>
Cc:     linux-can@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>
References: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
 <f2f20f9f-7810-e555-f6d0-11fc0510491c@hartkopp.net>
 <CAP22eLE4L53Qcf0tK4X0kieKxw_=jtoh_qvnUpeq1yUy_cvBsw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ff1f70f5-55a6-d0e8-6cde-9c341226ee7f@hartkopp.net>
Date:   Thu, 6 Feb 2020 14:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP22eLE4L53Qcf0tK4X0kieKxw_=jtoh_qvnUpeq1yUy_cvBsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Lev,

On 05/02/2020 13.00, Lev R. Oshvang . wrote:

> I tried command which is proposed in Dell manual
> https://www.dell.com/support/manuals/il/en/ilbsdt1/dell-edge-gateway-3000-series/dell-edge_gateway-3002-install_manual/can-module?guid=guid-b6b7f697-0a5c-4b9c-acfe-9b436ca90bdc&lang=en-us
> 
> or i in /dev/ttyACM*; do udevadm info $i | grep -q
> 03eb_2404_USB_CAN_FD && echo "path:
>                                      /dev/$(basename $i)"; done
> 
> It prints the device  /dev/ttyACM0 is present.
> 
> Can I use it as serial CAN  device?

Looks weird.

As already answered by Yegor you might have a SLCAN device here.

> I am novice to CAN devices. Now I understand that can and can_raw are
> only generic drivers and I need real driver.
> I wrote to Microchip support, perhaps they have driver for this box.
> 
> But still I do not understand why can driver is loaded at boot time I
> used to think that only real hardware cause the driver to appear.
> 
>     16.727375] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have
> ASPM control
> [   16.742055] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have
> ASPM control
> [   16.824470] peak_usb 1-2:1.0 can0: attached to PCAN-USB channel 0
> (device 255)

But this looks like a 'real' PCAN USB adapter
https://www.peak-system.com/PCAN-USB.199.0.html

which you should be able to configure by setting a bitrate and start to 
work.

Can you post the output of

ip -det link show can0

and

lsmod | grep can

and

lsmod | grep peak

?

Regards,
Oliver


> [   30.661705] can: controller area network core (rev 20120528 abi 9)
> [   30.678155] can: raw protocol (rev 20120528)
> 
> I saw these lines in dmesg and now I thing they apperead because CAN
> support was not a module but built-in in kernel configuration.
> Regards,
> Lev
> 
> On Tue, Feb 4, 2020 at 6:08 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> On 04/02/2020 14.07, Lev R. Oshvang . wrote:
>>
>>> I have with DELL 3002 Edge server
>>> It has can and can_raw drivers loaded at boot time
>>> It does not have /boot/config.txt file
>>>
>>> Unfortunately, I do not have kernel sources and kernel config file is
>>> not present in /proc, so I do not know which exactly chip is on b
>>> oard and board specs says only:
>>>
>>> (CAN2.0 A/B/FD) 1Mbps (CAN2.0), 5Mbps (CAN-FD).
>>
>> https://topics-cdn.dell.com/pdf/dell-edge-gateway-3000-series_Specifications2_de-de.pdf
>> says that there is a
>> https://www.microchip.com/wwwproducts/en/ATSAME70N19 Cortex-M7 which
>> handles the CAN FD controller.
>>
>> The ATSAME70N19 is connected somehow to the Intel Atom-Prozessor E3805.
>>
>> So I won't assume, that you can access the CAN controller from the Intel
>> CPU.
>>
>>> I tried to set it up but get the following error
>>>
>>>
>>> root@5HCF902:~# ip link add dev can0 type can
>>> RTNETLINK answers: Operation not supported
>>
>> You can not "add" a real CAN interface with "ip link add ..." - this
>> works only for virtual CANs.
>>
>> Try
>>
>> ip -det link show
>>
>> where some CAN interface (e.g. can0) should be visible, if you have one.
>>
>> Regards,
>> Oliver
>>
