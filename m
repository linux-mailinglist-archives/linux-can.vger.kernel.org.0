Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8425F382
	for <lists+linux-can@lfdr.de>; Mon,  7 Sep 2020 09:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIGHCJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Sep 2020 03:02:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:10398 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIGHBj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Sep 2020 03:01:39 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2020 03:01:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599462080;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=uIJDWJBPwt6uoL9sB7qq40Xo/j2YOTaDiMX0qH2pINA=;
        b=BYKQVORTykh4jB9nRSf0YN/gBrPBiU45VykPYHGLdC9+a1CIHXD2IqJ2goHoqI4K2T
        R/BqUAfQ2CUd6Wim7gJhMxyq4rBtE5Jvx6NXMPlb1uXFeV88ERMZov+YfPzEwlpkvORO
        6OvdMcuz3LHtMYHzC/9aX0EkUlMP7yGJk94z4zOc1VoV9BXajPgy5IyiFyZx4sxn9ZC7
        SASeQ5lBUPKwrAQLy6xvfJoqA4CG9ODDxpVfapXmrBug534jPvHodladaoAjbs6yx1fc
        8gWWl6k2BIbhKpqwtQAM+P4TSRFWrPbwVt8NEEEDvgaRAXxbdxyySRUJFbiDYKRS0Mfq
        UQHw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUMh6mCA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id z0699dw876tKplE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 7 Sep 2020 08:55:20 +0200 (CEST)
Subject: Re: Questions about using multiple sockets
To:     tom_usenet@optusnet.com.au,
        henrique ricardo figueira <henrislip@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <CAD1tVCN7-T=FHNQEz3Bp-0Kt3H6M1RokyUuw=e9sTLdXNWB=DQ@mail.gmail.com>
 <20200903054724.x6giher7ldmuvbac@pengutronix.de>
 <1116be40-25c4-002e-8455-5d5f86ac6e03@optusnet.com.au>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ebbe3d01-f36b-78e5-3a73-eee7f868b464@hartkopp.net>
Date:   Mon, 7 Sep 2020 08:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1116be40-25c4-002e-8455-5d5f86ac6e03@optusnet.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 05.09.20 08:47, Tom Evans wrote:
> On 3/9/20 3:47 pm, Oleksij Rempel wrote:
>> Hi Henrique,
>>
>> On Wed, Sep 02, 2020 at 03:15:13PM -0300, henrique ricardo figueira 
>> wrote:
>>> Hi, I would like to know if it is possible for me to use multiple 
>>> sockets
>>> with different protocols, a CAN_RAW socket and another CAN_J1939. 
>>> Because I
>>> need to receive messages from an ECU that does not follow J1939.
>>
>> Yes, you can combine it as you wish. You can even use CAN_RAW to
>> communicate with CAN_J1939 on same or remote machine.
> 
> Yes, as long as you open the sockets on DIFFERENT CAN Buses. One for the 
> J1939 and a different bus for the ECU.
> 
> On the same bus?
> 
> CAN buses are usually "All J1939" or "All Something Else". The J1939 
> protocol uses all of the CAN ID field to mean a whole range of different 
> things that are important to the protocol.

Hi Tom,

AFAICS the question was not whether you run J1939 protocol on a specific 
bus or not.

To me the question was if a programmer can open multiple sockets from 
(potentially) different applications on a single CAN interface (on Linux).

And yes, you can do so - as we have a multi-user system on Linux and the 
'SocketCAN' approach is designed for it.

E.g. You can open different J1939 sockets for J1939 protocol traffic and 
- in parallel - you can open different CAN_RAW sockets, e.g. to read and 
store the CAN traffic with candump.

At the end you are completely right that any traffic *sent* to a J1939 
CAN interface must not interfere with the J1939 protocol expected by the 
ECUs on this bus.

The reception of 'messages from an ECU that does not follow J1939' via 
CAN_RAW sockets, as asked by Henrique, should therefore be no problem.

The 'problem' seems to be already introduced by that specific ECU ;-)

Best,
Oliver

> 
> I'd suggest you look at the Wilipedia "SAE J1939" web page, and open the 
> "Introduction to J1939 (Vector Informatik)" link. It shows you how J1939 
> uses the CAN bus addresses.
> 
> It would be difficult to guarantee that the messages from the ECU won't 
> upset one or more devices on the CAN bus.
> 
> Do you have full control of the ECU? Can you reprogram it to change the 
> CAN IDs of all the messages it sends, or was that decided by someone 
> else? If you can't change them then it is unlikely you could make it 
> "compatible".
> 
> Then ask Google. This one says:
> 
>      If you are a CAN bus system design veteran (and only then),
>      it is theoretically possible to combine them. It is a really
>      bad idea but it can be done.
> 
> https://electronics.stackexchange.com/questions/467932/is-it-possible-to-use-j1939-and-canopen-on-the-same-bus 
> 
> 
> This one says "yes, but you have to do all of this...":
> 
> http://www.microcontrol.net/download/mmc_2013_koppe_2.pdf
> 
> The above also suggests that you should use a GATEWAY device between the 
> two CAN buses. Or in your case, two buses on the computer.
> 
> I would say "yes, try this in an educational or hobby setup, but don't 
> do it in a real vehicle".
> 
> Tom
