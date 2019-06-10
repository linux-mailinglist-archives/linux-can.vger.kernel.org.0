Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4893B84E
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2019 17:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391191AbfFJP1u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jun 2019 11:27:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:17605 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390177AbfFJP1u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2019 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1560180467;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:Cc:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WltCg+Eta+B1IVqI3OIVubPZYI7sVaKi6ePDfhb+AXs=;
        b=INAFpVPzhb+ZqlQybct2x0lsQ1h+05KtoED6EITgHQu8cJAdXcby8FevK2Yo8hk42t
        quhGf2smeWaKDzLrkJ6FRR7NPTN+cN5skBXNMuaVpCfOh9ZD6a5CWz1z9l7Vy+1lVwAr
        8zPclQuzXeGDDRrhWmrg7lHRe8Ol8g8OC5ynx3vOh5siWXvEvt++R3z+EZx0HAftmcAM
        A5yRfcLbfzUjiueXrFEUglte/bnYkIEhfMzfeJpRcYJG85ry4IK5THNiZE6q9eNZ113X
        qAWajaYICp8BU/wA6qhMJLCyB/OWo+lZn60rru+2AVZi6nS7SYOwWwMgMjg5d0Mzx6ug
        t6Nw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUch5kUoA"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.200]
        by smtp.strato.de (RZmta 44.23 DYNA|AUTH)
        with ESMTPSA id x0813dv5AFLNL7l
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 10 Jun 2019 17:21:23 +0200 (CEST)
Subject: Re: SocketCAN driver for ELM327
To:     Max Staudt <max-linux@enpas.org>
References: <0d6aff76-d2e6-0807-5919-14eb7337f560@enpas.org>
 <9315b538-d274-dc4e-0098-a4a75fd7cfc4@hartkopp.net>
 <8465897b-8fe8-4222-9c78-846d6ab07ce8@enpas.org>
 <7ff37120-8cd0-8ec1-c9da-ce4d4084012c@enpas.org>
 <ee3aff46-74d4-170c-c0b6-22b6f4930511@hartkopp.net>
 <90807e22-4666-fab6-59ba-c17ec1514e5a@hartkopp.net>
 <b8224669-180e-1177-1993-1aba69e64860@enpas.org>
 <ad31dfa0-7f6c-34b8-0dc6-1a7b23807022@hartkopp.net>
 <ae934287-b8a5-b16e-9a95-03abeb62b620@enpas.org>
 <95af30cf-41b9-dc38-2f4b-f6c733c20520@enpas.org>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0be61666-2f27-7c33-5bbb-6e02f49fdf07@hartkopp.net>
Date:   Mon, 10 Jun 2019 17:21:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <95af30cf-41b9-dc38-2f4b-f6c733c20520@enpas.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

+CAN Mailinglist

Hi Max,

On 31.05.19 00:03, Max Staudt wrote:

> Do you happen to have new feedback on the elmcan driver?

Not really. IMO using the ELM327 chip as a 'native SocketCAN' interface 
at https://github.com/norly/elmcan is really cool.

But I wonder if the limitations of the ELM327 chip to make it act like a 
raw CAN interface can justify to put this driver into mainline kernel.

Best regards,
Oliver

> 
> On 04/06/2019 08:55 PM, Max Staudt wrote:
>> Hi Oliver,
>>
>>
>> On 04/06/2019 08:24 PM, Oliver Hartkopp wrote:
>>> is it possible to increase the 38400 bits/s to some higher bitrate
>>
>> Yes, this is something that a custom attachment tool (in the spirit of slcan_attach) could do. I haven't tried it yet. The problem is that it's either a permanent change that's stored in the ELM's EEPROM, or it has to be done in an automated fashion because of a safeguard in its software.
>>
>> The kernel driver itself does not care about the baud rate.
>>
>> May I suggest looking into the ELM manual?
>>
>>    https://www.elmelectronics.com/wp-content/uploads/2017/01/ELM327DS.pdf
>>
>> The command "AT BRD" allows temporary changes, but needs to be ACKed by a computer program. And "AT PP 0C ..." changes the EEPROM, which I wouldn't want to do in any generic driver code. But as long as you remember how you've configured your own ELM, you are free to use whichever baudrate you like. Again, I haven't tried this, please don't brick your ELM ;)
>>
>> Also, what may be the limits of the PIC (clone?) and the USB-Serial bridge (clone?) in these adapters...
>>
>>
>>> to be able to capture 500kbit/s CAN traffic load?
>>
>> Hahahah, unfortunately that will never be possible at full 500kbit/s CAN load, because the RS232 interface will always be slower and the buffer will overflow. The driver will emit an error frame and restart listening, but that's all we can do really.
>>
>>
>>>> This is key, and fully expected behaviour. Yes, the ELM does not ACK when in monitoring mode. Unfortunately, we have no choice but to use this mode in long idle periods. The only situation when it will ACK is for about 1-2 seconds immediately after the ELM sends a frame. Afterwards, it goes back into monitoring mode, where it will not ACK any frames (like "listen-only" in the 8devices USB2CAN).
>>>
>>> Ugh! That's really a hard limitation. And now I also understand the corresponding line in  "Known limitations of the controller" ;-)
>>
>> Yeah, sorry, I really mean it when I say that I'm making the best of a bad situation :D
>>
>>
>>>> The fact that you're surprised about this tells me that there are two possible things that may have gone wrong. Since you've read the documentation, the only remaining explanation is that it sucks and I need to rewrite it. Because this is actually expected behaviour :)
>>>
>>> ... from the ELM - but how do you think that you can solve that?
>>
>> Umm... you mean how can I solve hard to understand documentation? I can try to rewrite it... nothing I can do about the ELM though, I'm afraid! You can either buy an OBD adapter with a modern authentic chip (and then you may as well get a USB2CAN), or live with the limitations of the clones.
>>
>> In fact, do you think I should rewrite the doc, or is it okay as-is?
>>
>> As for the ACKing. Think of it this way: If you hook it onto an existing CAN bus, you can use it to listen in and send the occasional frame. There will be enough other devices to ACK frames.
>>
>>
>>
>> Thanks a lot for your feedback, I greatly appreciate you taking the time to look into this! :)
>>
>> Max
>>
> 
