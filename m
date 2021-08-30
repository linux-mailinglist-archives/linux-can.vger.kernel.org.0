Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB313FB64C
	for <lists+linux-can@lfdr.de>; Mon, 30 Aug 2021 14:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhH3Mpr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Aug 2021 08:45:47 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:23362 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhH3Mpp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Aug 2021 08:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1630327484;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:References:To:Subject:From:Cc:Date:From:
    Subject:Sender;
    bh=8jY/a4xEDeiJ/QOE6qIwugMLibHCWfle1xnl2xy4Vyc=;
    b=JZvVuDprz1aCxPTc7La5jgCz0bc0oopG9zpPAidohfCL75knoD2f139kIIcPtqg4p5
    ZLVAq05HpRFOmoZwBpd+fNb0pPEU1KxK9HcgYlY6dgUtG24w+1wP3W7WwTBT1IGljpXX
    A4tW6hAF1IXaLk2iWhfjs5/q3GFVd+vbusvPWgfsVd2w8Q6IRHlqumVBQBwkfU64IvL5
    lX80msaySJG/Te8pWx9KIHvm5srdDRLmCmeeNfwxbkt5W2oKogfyM4pIKM51odfzY9DD
    cv7iKd3Hi1oC2rVe2ZZKrW49/bQ1fWR7YI4bQuwpjC2WYhDSlLEvWKwzKWLEu9eKLna4
    hgUg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR8J8xryV0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.31.0 DYNA|AUTH)
    with ESMTPSA id Q09fd7x7UCii1jr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Aug 2021 14:44:44 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: AW: AW: [PATCH] can: isotp: omit unintended hrtimer restart
 on socket release
To:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20210618173713.2296-1-socketcan@hartkopp.net>
 <DB8P190MB06343614CAD6B48C3EA0EF00D9C99@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <abc23fd0-9bb1-1cc7-fc67-0a3298673b86@hartkopp.net>
 <DB8P190MB0634E1A09E060C9A5A539073D9CA9@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <fa1cac52-73aa-b092-0137-2b1ed734f0ee@hartkopp.net>
 <DB8P190MB0634C90D304A2AA97F481738D9CA9@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <DB8P190MB0634D4408A4A57A74134E698D9CB9@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
Message-ID: <6f9a3a93-fa0e-f039-6332-5ac0d4064731@hartkopp.net>
Date:   Mon, 30 Aug 2021 14:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <DB8P190MB0634D4408A4A57A74134E698D9CB9@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Sven,

On 30.08.21 09:55, Sven Schuchmann wrote:

>> but if I compare the candumps I can see:
>> with the patch:
>>
>>   (000.000008)  vcan0  714   [8]  2F 01 01 01 01 01 01 01
>>   (000.000209)  vcan0  77E   [8]  30 0F 00 AA AA AA AA AA
>>   (000.000061)  vcan0  714   [8]  20 01 01 01 01 01 01 01
>>
>> and without:
>>
>>   (000.000004)  vcan0  714   [8]  2F 01 01 01 01 01 01 01
>>   (000.000069)  vcan0  77E   [8]  30 0F 00 AA AA AA AA AA
>>   (000.000017)  vcan0  714   [8]  20 01 01 01 01 01 01 01
>>
>> sorry, I missed that: Over here the delay seems to be in
>> the FC and not in the CF after the FC. This is what is
>> different compared to the real hardware.
>>
>> So to me it seems that the rcu implementation
>> has changed on the way from 5.10 to 5.14?
> 
> Just checked with a 5.14.0-rc6 which contains the patch, same result:
> 
>     93 / curr:  143 / min:  129 / max:  200 / avg:  156.2
>     94 / curr:  144 / min:  129 / max:  200 / avg:  156.0
>     95 / curr:  141 / min:  129 / max:  200 / avg:  155.9
>     96 / curr:  171 / min:  129 / max:  200 / avg:  156.0
>     97 / curr:  138 / min:  129 / max:  200 / avg:  155.8
>     98 / curr:  137 / min:  129 / max:  200 / avg:  155.6
> 
>   (000.000011)  vcan0  714   [8]  2B 01 01 01 01 01 01 01
>   (000.000193)  vcan0  77E   [8]  30 0F 00 AA AA AA AA AA
>   (000.000037)  vcan0  714   [8]  2C 01 01 01 01 01 01 01
> 
> So maybe there is something wrong on the rpi?

I see a similar difference on my i7-8650U system:

"5" without and "65" with the patch.

The problem remains to be the added time that is now introduced at 
socket close time with the rcu_synchronize().

In your script you are waiting for isotprecv process to finally end with:

	wait $rxpid

And that's the expectable effect ...

It looks like the script works fine without the 'wait' code (which does 
not wait for the process removal then).

@mkl: I assume we have to live with that increased time at socket close 
for security reasons, right?

Best regards,
Oliver

ps. Btw IMO a C program is still the better approach here. 
isotp[send|recv] open/close the sockets for each PDU in the given setup :-/
