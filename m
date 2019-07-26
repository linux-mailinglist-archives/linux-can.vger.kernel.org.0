Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5876727
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2019 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfGZNTI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Jul 2019 09:19:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:15798 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGZNTI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Jul 2019 09:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1564147146;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=0fl7IctgKaWZ7/cjHR9L4buQUqbQMFQJAC68kVpk3zk=;
        b=tve+yohiiY9Z1PdIrzmAYWK632wvDFJrhANiLOPgK0TM8eDKHJmsFVu4M3QHGrb3uC
        zWnmRJRgGRfeI1FXlsNt41WXtV16USSKue7dKiAeXCgfCjfBntKGQ91tIvkLPJuWXhLR
        YrzaWAI0yQJzZ1qkI5Rqy2htdSs/Y63K4IjQK07wkSfqT13AjzhxflCQhmzFmGDdJ/Et
        fW9tRwb1bTDv26wvWp+3TOFqqWzZirxwfCTm7041CNLjCXDzziER9b8kgd7l/vRzYinE
        /jbFHIJGEVeFCNoYJd0Mmhox1lWtNMUBf1AYycqrIk8X/zJug60W2XwJUDPOiIl5OBRl
        Iabg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJU8h5k0VR"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6QDJ3nbW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 26 Jul 2019 15:19:03 +0200 (CEST)
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
 <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
 <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
 <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
 <1684a411-e05c-a7a0-2b65-ceefc68e6b12@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <727ad8d4-acc3-d72d-613e-fb3429f670f6@hartkopp.net>
Date:   Fri, 26 Jul 2019 15:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1684a411-e05c-a7a0-2b65-ceefc68e6b12@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 25/07/2019 16.45, Marc Kleine-Budde wrote:

> I don't know if this is possible with can-gw, but can you do other
> calculations based on the len, so you might need the sanitized length.

You can to AND/OR/XOR/SET operations but no arithmetic calculations.

> Every user can generate such frames and the drivers have to deal with it
> anyways.
> 
>> Neither the CAN controller
> 
> In the TX path the CAN controller driver will translate the len into the
> dlc, so the CAN _controller_ will not see the wrong length of e.g. 13.
> 
>> nor the user reading from a socket should ever get an invalid CAN FD
>> frame.
> 
> What happens if the user sends a CAN FD frame with len == 13? All hw
> drivers will convert this into a DLC.

Right.

> What about the loopback'ed frames?
> I don't have CAN FD hardware, so I cannot test.
> What about vcan?

They all use can_dropped_invalid_skb() which only checks the length 
boundary of 8 resp. 64 byte.

There's no check whether the CAN FD specific length values are met.

> vcan doesn't do the len -> dlc -> len conversion:
> 
> I manupulated the cansend to send a CANFD frame with the non sanitized len:
> 

(..)

> Which is then displayed as:
> 
>>    vcan0  5A1  [10]  11 22 33 44 55 66 77 88 99 AA
> 
> Do we need to sanitize the CAN FD frames somewhere in the stack? Note
> you can completely bypass the PF_CAN and insert the frames into the
> packet scheduler so they end up unchanged in the driver.

Right.

In fact the only point where can_len2dlc() is active is when the CAN 
frame is sent with a real CAN (FD) controller.

Maybe it would make sense to create a special flag for the can-gw 
modifications like CGW_FLAGS_CAN_FD_SANITIZE_LEN.

So we could point out that the CAN FD length information is manipulated 
and that we offer to round the values or not.

Regards,
Oliver
