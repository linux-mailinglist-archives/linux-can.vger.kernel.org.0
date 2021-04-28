Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE536D5BD
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhD1KZV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 06:25:21 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:26215 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhD1KZV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 06:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619605472; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ddSTUyNWy7azvoieJiLW8l8qmr4GPBOyaqzuaokaksStCnjuX9ccb0dMRmAHAWAW7N
    10CkknW+jrC/YwlY3W2D5UF+y2eriMtBHezgc5IqBEgS/oeNtbZvXu7BqLJCGvU1S2L5
    zjjk+KvgZ/Ks0HLPBzktLXO1VZSOpVkhnBMrOKsSh+CQCqh9Dnz/CHn2zeYr3owE7A/+
    Z83WaiJvXIvqUiQARqyOcKPi36hmTYX5KLIWQYYGsn0hCcHxrNEVD19d74P56kFs1a2c
    34v4BJr4mgyS/Mlxfc+ryZcWtU0pnKAO+q7EpkxEUK5Bs4soMbe3jOhS3swag7+XDUN+
    rvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619605472;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GDOQyIm5TuoQBNCiBmh8FNBsISI6DrTd/1oedXNaYcE=;
    b=aioPV86SftEO46VNtcO+/6ApRXZ5WM6ZIdcuRVeT8J+T37gR+/MEoUaC7FfF5JTsmJ
    zHHr7c3XQJSBYJoGbwXrHzRni5wiYWF0S2e5p2xcTeGlGdGGr/TeDn7KSnWBZW1lxF22
    A2MoHJcLhTMYrDnVDJDnvoMvQBQV9mU/1GeLqvSGIw+JTZfNm494XBTmszcN38MWegH/
    HqC1o/Jw58Xl2kQX9e/fiWHIfmHn/+nEwDMEPvdIgrpBlavKgCOR0Aur4PztTCdxwNei
    aCDqqrAHq/kb8+Ik+20gfCDHX+16OKFyoaPJznz7r8YBqG0CQ2Z3yWlFpzul3foIpIS7
    ozng==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619605472;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GDOQyIm5TuoQBNCiBmh8FNBsISI6DrTd/1oedXNaYcE=;
    b=rT2XAfsIRls/vqX1ut/GNFd1uchoqbGSZrS7ak25Kf0r/oi6lUtVlLAdgeFeVtJFCq
    ypIflM6stWryr/NZRMdD35FDo3yi84w8J7K8twEKOGWzMvS4nO3T1whDowBM4aoax3oB
    7Kqpctfi6/duB9AfDlOd2iiJA51jfG/nu2ovyTCesuWneMS3EL73ShZi9Q9YID7Jo3Cf
    08jRCVUh7WuaCkyLyHUt7+QTBraVLJYht3gJQ35kJCZDRHOsOUgdT3BB6ndWCAeied4q
    irCBPNDCuyl0CFRJ6A8315Go1q6Cl9W8E18OuVs4J/U/8V9HheMYNqcHvHA//R8at3rZ
    BB3w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.25.2 DYNA|AUTH)
    with ESMTPSA id f0a856x3SAOW3O2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Apr 2021 12:24:32 +0200 (CEST)
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
References: <20210428090914.252967-1-mkl@pengutronix.de>
 <20210428091224.lsqf4tttd7uijdms@pengutronix.de>
 <f18cb9ce-4bab-80b2-ccc7-37fbafe04995@hartkopp.net>
Message-ID: <f81170bc-b6d2-37c0-a6b0-86fb9570407c@hartkopp.net>
Date:   Wed, 28 Apr 2021 12:24:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f18cb9ce-4bab-80b2-ccc7-37fbafe04995@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28.04.21 11:26, Oliver Hartkopp wrote:
> On 28.04.21 11:12, Marc Kleine-Budde wrote:
>> On 28.04.2021 11:09:14, Marc Kleine-Budde wrote:

>>> @@ -756,6 +762,10 @@ static enum hrtimer_restart 
>>> isotp_tx_timer_handler(struct hrtimer *hrtimer)
>>
>>>                sk->sk_err = ECOMM;
>>>           if (!sock_flag(sk, SOCK_DEAD))
>>>               sk->sk_error_report(sk);
>>
>> I think the idea is that sk_error_report takes care of propagation of
>> the error to the user space. I don't know why it's not working as
>> expected.
> 
> Yes, I fact I was thinking about this question too.
> 
>>
>>> +        /* set error flag in order to consume it later in the
>>> +         * isotp_sendmsg function */
>>> +        so->tx.error = ISOTP_ERR_FC_TIMEOUT;
>>> +
>>>           /* reset tx state */
>>>           so->tx.state = ISOTP_IDLE;
>>>           wake_up_interruptible(&so->wait);
>>> @@ -954,6 +964,13 @@ static int isotp_sendmsg(struct socket *sock, 
>>> struct msghdr *msg, size_t size)
>>>       if (wait_tx_done) {
>>>           /* wait for complete transmission of current pdu */
>>>           wait_event_interruptible(so->wait, so->tx.state == 
>>> ISOTP_IDLE);
>>> +
>>> +        /* check if an error has been raised in the timer
>>> +         * function handler */
>>> +        if (so->tx.error == ISOTP_ERR_FC_TIMEOUT) {
>>> +            so->tx.error = ISOTP_ERR_NO_ERROR;
>>> +            return -ECOMM;
> 
> Maybe the way to trigger the sk_error_report(sk) we might return '-1' 
> while the error is then propagated inside errno.

I added some debug print in isotpsend:

diff --git a/isotpsend.c b/isotpsend.c
index 3ea574c..c2937fa 100644
--- a/isotpsend.c
+++ b/isotpsend.c
@@ -45,10 +45,11 @@
  #include <libgen.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <unistd.h>
+#include <errno.h>

  #include <net/if.h>
  #include <sys/ioctl.h>
  #include <sys/socket.h>
  #include <sys/types.h>
@@ -252,10 +253,11 @@ int main(int argc, char **argv)
                     buf[buflen] = ((buflen % 0xFF) + 1) & 0xFF;
      }


      retval = write(s, buf, buflen);
+    printf("retval %d errno %d\n", retval, errno);
      if (retval < 0) {
             perror("write");
             return retval;
      }


$ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
43.269173590
retval 44 errno 0
44.271162277

So it waits for the timeout as required by the '-b' option - but the 
errno is not set :-/

> 
> But I haven't checked that myself so far.
> 
> The reason why this return value is not that important is that ISO-TP is 
> an (unreliable!) UDP like protocol where the application checks for an 
> application response timeout.
> 
> Having the information of a FF timeout only makes sense when 
> CAN_ISOTP_WAIT_TX_DONE is enabled to assign the timeout to a that 
> specific PDU.
> 
> Best,
> Oliver
> 
>>> +        }
>>>       }
>>>       return size;
>>> @@ -1371,6 +1388,9 @@ static int isotp_init(struct sock *sk)
>>>       so->tx.state = ISOTP_IDLE;
>>>       hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, 
>>> HRTIMER_MODE_REL_SOFT);
>>> +
>>> +    so->tx.error = ISOTP_ERR_NO_ERROR;
>>> +    so->rx.error = ISOTP_ERR_NO_ERROR;
>>>       so->rxtimer.function = isotp_rx_timer_handler;
>>>       hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, 
>>> HRTIMER_MODE_REL_SOFT);
>>>       so->txtimer.function = isotp_tx_timer_handler;
>>
>>
>> Marc
>>
