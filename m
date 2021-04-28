Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A036D6B7
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 13:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD1LqE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 07:46:04 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:35766 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhD1LqB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 07:46:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619610310; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GNUDXOwrbdvfoCdvI9KvekBcc4QzwgHhHNerhbLtsTWzdQVRuTP+CIDusNmN3qrMkL
    pXBw7TP88FZ2X0dFchFmNKb9/Lpgrpdv/KferyuiIWFQFikc2uDm7R2RofccHZ1ep1rn
    u5GmrxBGxeGxEQ+8dgbc5qFJr1+rifpebY9Q2cDqKiyONZ9gKd6HDU0HmX+iCaCBk0ij
    n/PaTlebmphAdqXcK2QAAmpP5HmEG8VqrWp+ZxRpYiuZHpZXfHklGAcxcWKB/C696WC2
    rNUzAu1h0WZBmhn+zl2MFeMhrv4mMUoxAFHHJ+niK1u6om8M4AbOIexEzGu2Kbgj2t5k
    CXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619610310;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XmzhRPX2pBqwqGxSvzPzgJCjNqTK9GIPh6LkutfCvPc=;
    b=Ey7+SKtZB3STZE7M/ZLUgcAjMhdeAiP495SLIg1XKhxpYxZ27Cq8FciGP8z7jjI6n5
    c3MsRQvWiQtelRRMgV457dzOo0j3lDe+7Fr7C1t5ewMjM08WoZf8GJvENbSwk9UFmTQu
    18vN0ZzGew07lJ3x9BvRmazS2mvUD3ac7rimbsIXrEe3aehc1StlBts4qsxpPsKxP1Vg
    HK1Ol2S2y23pEbbFuD5wnLLMKczNz2QJI8QiBSrcmizniMSwl/Pq/oQVt5LTxHin0O45
    fr4Gokk/zOOHfoTdU3DHYfqkHDCY6vRy4uaG+/Dku1TCwyAyXAPOoT9CvYbitHSDI6Pb
    mwAw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619610310;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XmzhRPX2pBqwqGxSvzPzgJCjNqTK9GIPh6LkutfCvPc=;
    b=hkwWp2DaNfn0PhtZrqtWgsMqynrmk4gemISINVJEFdVeS12yu6ICKqFrzukEXenCI9
    tTNumx8ZtN3fRxMgsDZeCiV6kP+USecwpfaes+gQINlj8C+3j5mcP47NnnD5vs9J6f6z
    j4H/kNFyAOtcvWYaUglpUeKYTCjIPb95rU8vs3U7A6lHVMPMwoq4W0wb49BeROJfUzjU
    mHDnoYI5+B465enpB/xAiUn0is49UTNnS2i6jOPJIwixYyHJJUDB6i6hiyWGT/hwp3Ps
    XuE1p71eqeaLV/ILtoXXIba1DanfErlsfmwtwKg7uslgiKbhpISpqWmSfSp0CteVcSX9
    f9tA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.25.2 DYNA|AUTH)
    with ESMTPSA id f0a856x3SBjA3hH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Apr 2021 13:45:10 +0200 (CEST)
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
References: <20210428090914.252967-1-mkl@pengutronix.de>
 <20210428091224.lsqf4tttd7uijdms@pengutronix.de>
 <f18cb9ce-4bab-80b2-ccc7-37fbafe04995@hartkopp.net>
 <f81170bc-b6d2-37c0-a6b0-86fb9570407c@hartkopp.net>
 <20210428104732.bbmklgyuto5oi3kd@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ee8058e0-af0a-8759-a62b-b1585c8992b3@hartkopp.net>
Date:   Wed, 28 Apr 2021 13:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428104732.bbmklgyuto5oi3kd@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28.04.21 12:47, Marc Kleine-Budde wrote:
> On 28.04.2021 12:24:32, Oliver Hartkopp wrote:
>>> Maybe the way to trigger the sk_error_report(sk) we might return '-1'
>>> while the error is then propagated inside errno.
>>
>> I added some debug print in isotpsend:
>>
>> diff --git a/isotpsend.c b/isotpsend.c
>> index 3ea574c..c2937fa 100644
>> --- a/isotpsend.c
>> +++ b/isotpsend.c
>> @@ -45,10 +45,11 @@
>>   #include <libgen.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <string.h>
>>   #include <unistd.h>
>> +#include <errno.h>
>>
>>   #include <net/if.h>
>>   #include <sys/ioctl.h>
>>   #include <sys/socket.h>
>>   #include <sys/types.h>
>> @@ -252,10 +253,11 @@ int main(int argc, char **argv)
>>                      buf[buflen] = ((buflen % 0xFF) + 1) & 0xFF;
>>       }
>>
>>
>>       retval = write(s, buf, buflen);
>> +    printf("retval %d errno %d\n", retval, errno);
> 
> Note: in user space errno is only valid if retval is "-1"...

Ok, just returned '-1' in that case of blocking write (which runs into 
the timeout) ...

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9f94ad3caee9..d5d541b4fed5 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -952,10 +952,11 @@ static int isotp_sendmsg(struct socket *sock, 
struct msghdr *msg, size_t size)
         }

         if (wait_tx_done) {
                 /* wait for complete transmission of current pdu */
                 wait_event_interruptible(so->wait, so->tx.state == 
ISOTP_IDLE);
+               return -1;
         }

         return size;
  }

And now got this:

$ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
22.411570468
retval -1 errno 1
write: Operation not permitted

So still nothing to see from "sk->sk_err = ECOMM;"

But when adding 'return -ECOMM' at the above section it works like this:

$ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
58.453452222
retval -1 errno 70
write: Communication error on send

This is obviously the expected behaviour for user space:

- get '-1' in the case of socket related errors
- get the details from errno

Maybe all that sk_err stuff is only relevant for listen/accept 
constructions for connection oriented sockets and can be removed inside 
isotp.c ...

Regards,
Oliver

> 
>>       if (retval < 0) {
>>              perror("write");
>>              return retval;
>>       }
>>
>>
>> $ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
>> 43.269173590
>> retval 44 errno 0
>> 44.271162277
>>
>> So it waits for the timeout as required by the '-b' option - but the errno
>> is not set :-/
> 
> I'm not sure what we have to return in the kernel...
> 
> Marc
> 
