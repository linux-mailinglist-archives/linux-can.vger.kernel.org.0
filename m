Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2261D8812D
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406599AbfHIR3g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 13:29:36 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:25393 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIR3g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 13:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565371773;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=oX6nsEQsBq2eis3+TM7HkV4lnUJFdO7cahH0cYFkVNo=;
        b=BnCyBI9Ss3mRrC0oFdsCHfPECRgsHANlr+vkOlFe3j67xbVZMwoFFM38w9QjAFZTOl
        KfqK3jcF2nFOqu+OmnmLwt4c6NfgCD2o+efk1r45PSo+FQWDBXKiRJk9U+sT6xi8FPVU
        Wsh2DjT83SYjNMzM7XBeg0DwGG+HboCbkamp8pw5n7PX8zklxZ6kZt+f6SdPudSunvTH
        MLYgBk1PnISQe5BcpX55F9SbPd4PCxfV/isRk1aiLyVRX06qlZXqr1d3emgJ01FAaQh0
        o7yvFWyhaGIBuKeY6fssloD3RiAXUzx50DE32R0UNvp8C6ueEGxbnvy5f8GQpL8fksXC
        tutA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUch5l03U"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv79HTVTda
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 9 Aug 2019 19:29:31 +0200 (CEST)
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
 <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
 <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
 <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
 <1684a411-e05c-a7a0-2b65-ceefc68e6b12@pengutronix.de>
 <727ad8d4-acc3-d72d-613e-fb3429f670f6@hartkopp.net>
 <6acd5e5b-764a-f3f9-8e2c-6dacd3923e7e@pengutronix.de>
 <9b4ca3eb-c3b9-926c-9b86-6077229791be@hartkopp.net>
 <e8b96c8b-5942-d6ff-f61f-dffd1c99c942@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <eeaf5a93-82ae-f2fb-c4cc-1c9f7f926171@hartkopp.net>
Date:   Fri, 9 Aug 2019 19:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e8b96c8b-5942-d6ff-f61f-dffd1c99c942@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 09/08/2019 16.27, Marc Kleine-Budde wrote:
> On 8/9/19 12:27 PM, Oliver Hartkopp wrote:

>> The problem in loopback and vcan is similar.
>>
>> But the issues that rises up when sanitizing the FD length value in
>> loopback/vcan/af_can -> we start to fiddle inside the skb data.
>>
>> When we do so, we need to skb_copy() the skb instead of working on
>> clones to prevent race conditions inside the data, see:
>>
>> https://elixir.bootlin.com/linux/v5.2.6/source/net/can/gw.c#L387
>>
>> skb_copy would have a performance impact and it would trigger a big
>> rewriting of the current code. Don't know if it's worth that.
> 
> Which race condition do you have in mind?

E.g. you create a can-gw job that forwards the incoming CAN frame to 10 
different vcan's.

These 10 skb's have been cloned which means their skb->data points to 
the exact same location. When now each vcan instance on a multicore 
system reads and writes the length info you have a classical race on 
that one memory location.

> For loopback ("can_put_echo_skb()"), I see a race condition in some CAN
> drivers: They first do a can_put_echo_skb(), then keep using the skb to
> write ->data into the hardware.
> 
> If we modify the skb in can_put_echo_skb(), then the CAN driver will see
> the sanitized struct canfd_frame::len. This means for dlc == 13, 14, 15
> the driver will write more data into the hardware than needed. It
> probably depends on the HW what the controller sends out if you have a
> dlc == 14 (which means len up to 48 bytes) but only write 33 bytes into
> the registers.

Then you have uninitialized content from the CAN registers and not from 
the skb on the wire :-)

> While other drivers don't touch the skb after can_put_echo_skb().
> 
> Can we modify the ->len in can_get_echo_skb() (or the __ variant) right
> before pushing the skv into the networking stack? We have to look at the
> data path for driver that cannot/don't use can_get_echo_skb() due to no
> TX-complete interrupt.
> 
> Looking at vcan, where's the race condition when modifying the skb in
> vcan_tx()?

As written above. Additionally the echo is mostly done in can_send() in 
af_can.c. And vcan_tx() is just a /dev/null from the packet flow 
perspective.

>> I tend to sanitize the CAN FD length values when they are introduced
>> into the system (CAN_RAW, CAN_BCM, CAN FD drivers*) and when they are
>> modified (CAN_GW).
>>
>> * = already done
> 
> You miss the datapath that directly injects packets into the networking
> stack with the mechanism that tcpdump uses but the sending into the
> kernel instead of receiving (I don't remember the exact name). This path
> skips all checks in CAN_RAW. This is why we have the
> "can_dropped_invalid_skb()" in all drivers.

I don't know whether these tools can create ethertype CAN(FD) skbs which 
is mandatory for the CAN stack to process skbs. But if so, you are right.

> So from my point of view it makes no sense to sanitize the len value in
> gw, as the drivers convert from len to dlc anyways.
> 
> What do I see when I attach a candump to the src and another one to the
> dst interface? I suspenct:
> 
> src) the unmodified canfd_frame with sanitized len, as the controller
> knowns only the dlc.
> 
> dst) the modified-by-gw canfd_frame, _after_ the loopback by the driver?
> If there's neither sanitation in the gw not in the loopback, it's the
> unsanitized len.
> 
> When I have another application sending on the dst interface, the
> candump receives the un-sanitized, as there's no sanitation in the loopback.
> 
> For me the loopback is and vcan is the part to modify, as gw is just a
> another source of unsanitized len information.
> 
>> My idea was to fix things up when someone manipulates the CAN or CAN FD
>> length field with can-gw.
> 
> For CAN you don't have to do any sanitization, only check if the len is
> <= 8.

Mapping [0..8] to [0..8] is pointless but correct :-)

>> Or do you think I should just omit it and let the data flow as-is?
> 
> ACK

Ok, will send a v2 with a removed sanitized CAN FD length. The 
boundaries of the max length information (max 8 or 64) is tested anyway.

Regards,
Oliver
