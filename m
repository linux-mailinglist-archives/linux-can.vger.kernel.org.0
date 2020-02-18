Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9578A16215D
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2020 08:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgBRHLZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Feb 2020 02:11:25 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:27437 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgBRHLZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Feb 2020 02:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582009883;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JIzTx5A3b0OKXSP6/jpujT4kYgXb0s0E2xY3OMnfuXU=;
        b=WER4rLQtGube6RKpHsXyxJvh9oA6kC5RnAQ6N+RAO87kfBvo1FeUOwfHi/XTklHVb+
        2xee0u8UL/KY36FOy9z1xwEeNaavdWu62maaqoSdkE/IT7aC2j4mVHFpZGrn9BKZF9DL
        qdtDgqdY0C86J/5q9VccdDhVM3f5WPrDNj9UeISWPs7DbEFXv0rUCrBus9u1hOWHJMLv
        MJZB3vcgRaiFiJ5j54e0rUld+K//EqIknJxyfjm401d8+Z2JCTBXaOMrnIwb0Z3wXpJG
        BqT6ZnPyt/43B8aeyV8WLMkccc40FVwv+vIRv9aS+qBicG/TIOPHEfa9/bA3ZJa33OIQ
        1row==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJX8h6lUVJ"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id g084e8w1I7BMqpQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 18 Feb 2020 08:11:22 +0100 (CET)
Subject: Re: canfd through slcan via SocketCAN
To:     Chris Morgan <chmorgan@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
 <ca7db9dc-991e-e2f7-a3a7-dc13a0880581@hartkopp.net>
 <81FEDC66-54A7-4B53-911E-80122446A453@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4ba5c9cc-fbef-1e31-2fd2-51dd50029ac5@hartkopp.net>
Date:   Tue, 18 Feb 2020 08:11:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <81FEDC66-54A7-4B53-911E-80122446A453@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 18/02/2020 01.01, Chris Morgan wrote:
> HI Oliver.
> 
>> On Feb 17, 2020, at 3:16 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> Hi Chris,
>>
>> On 16/02/2020 14.43, Chris Morgan wrote:
>>
>>> I’m looking at options to add canfd support to embedded processors via serial using slcan. I’d like the devices to be available via socketcan. Looking at the slcan driver it looks like the MTU is something around 30 bytes and there isn’t any mention of canfd in the driver or in the userspace utilities. Am I missing something with this support? If slcan doesn’t support canfd yet is anyone working to add any?
>>
>> The slcan driver implements the SLCAN aka Lawicel protocol, originally provided by http://www.can232.com/
>>
>> See documentation at:
>> http://www.can232.com/docs/can232_v3.pdf
>>
> 
> This is super helpful, thanks for the pointer there. I didn’t realize so many letters were already in use but it looks like there are some openings in the protocol.
> 
> 
>> Other low cost serial CAN adapters adopted this simple protocol, see this overview:
>>
>> https://github.com/linux-can/can-misc/blob/master/docs/SLCAN-API.pdf
>>
>> By today there is no CAN FD capable CAN interface using the SLCAN protocol on the market!!
>>
>> You would need to set a second bitrate (data bitrate) and you would need a separated data frame identifier for CAN FD frames.
>>
>> Today:
>>
>> t/T -> Classic CAN data frame
>> r/R -> Classic CAN rtr frame (not in CAN FD)
>>
>> According to the above documents we would been able to use:
>>
>> d/D -> CAN FD data frame (with BRS/ESI flags!)
>> k/K -> set FD data bitrates (analogue to s/S)
>>
>> The biggest problem with defining these values/characters and adding them to the slcan driver in the Linux kernel, is that WE DO NOT KNOW whether future serial CAN FD interfaces will follow our suggestion.
>>
>> Usually you have a hardware providing an API/protocol and THEN the driver developers write the driver - and not the other way around ;-)
>>
> 
> Heh. I can appreciate that.
> 
> I’m working with a MT7688 platform that only supports half duplex spi and looking for a low cost canfd solution for that platform. I’m not sure exactly if that prevents me from using an existing MCP251x driver or not but I’ve heard this is the case. There is also a software spi driver, spi-gpio-custom in openwrt that is an option.
> 
> The idea with slcan would be to use a SAM21 microcontroller with dual canfd controllers to provide canfd functionality, implementing the slcan client in the SAM21 firmware.
> 
> I’m still not sure what the best approach might be. I am hesitating to use a usb based adapter but that’s another option as well.

IMO the SLCAN protocol is a simple but not that reliable, efficient and 
fast protocol.

I would not recommend to take it as a basis for a new design. Therefore 
I would either try to make the SPI working or to go with an USB 
solution, which handles CAN frames directly (meaning without a SLCAN 
protocol).

Regards,
Oliver
