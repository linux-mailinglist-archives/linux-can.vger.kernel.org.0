Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7841436D4BC
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 11:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhD1J1P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 05:27:15 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:36706 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhD1J1P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 05:27:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619601982; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZiHeUSN1PsctREiRN9U0Cwtfdjn//CT3pL/xQszYYcfLwY9B9IhPkRixjE25GArka1
    o3dh1CSHjMvpI/myoiuXgGyhOosUNb3AIDgsbbW2euGAnYjnbcOx85V6q0WQWEm1EpIX
    umXQGq0C6XCtCD22OjSNwNsD2GVzm9dGxbLWcUbH9e5M4rPaJ4SlaL/wJrgF7gkuWC41
    MQP3xJpjq+qkOlqPPraMOwBXGnfP4rC3yRUczEweDPgbskTFGUi73LIluT82c2WdSr7g
    Zvnn/q5h7jks6SekPgKLwrXCor/DEljTduGvMg3RkjrJjWfSKQtlHQoHmfV/fxyMQaiU
    Ha2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619601982;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=qVWAG2ZXH1ljcsq316XGC+GGYDHFzze+DTaM6BfCEAw=;
    b=OUKBaAa7xUrT2DKMDte3He4esMoHcZB0PbNDpyp53TBR+7Q4u9M7b/WtWBLCDb0W3N
    ysg5b4PeWM1LhJwi49+nnqs3L3sNAsrp3H8D+zgWNpngj4eUJKA99Us1wZQW3EZ0+TFu
    VvJ6IeK8mLOJagam/56sL7cjnG58ezH7+IfGS0i58rw2aPhZGz8fLBn8rquAs2H8gGQk
    KTKBST6NsFVaTjbhCz9JItRnZzJhDhHiXxTZCQ3zEzdiQPswOB65hUEeH8ukq17V7KR7
    m5pwH7DuzrIiCzpdvHGygMWSYyg2hFS66BIiyK0kbc5mNrWv6Q7S9rJtpaEHkjaqkAbR
    vV6A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619601981;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=qVWAG2ZXH1ljcsq316XGC+GGYDHFzze+DTaM6BfCEAw=;
    b=owlIKHX6FUFOcWLk7JmoG2aPiAnsqm3zMAyUP+FJkszkP6AsJ5LnONCPDsP2jUzmkK
    t00wHls/RB4B5ZtMZgdcF0hreOtOcUTVc3G2OnMvyi43yMAvrln+UKJF3anHSvFku6jC
    AtlFXqwcIhN8mZgBITkZnn/HZWtctejlzPwwdmtY9XpnH5GVdN0tULFNAxymxs1Jnb9a
    eaU+BvPKgxdBnUlo3d8hSyFIB8RLveLJCPSjSR7VgVQxbB4vuqxgbkxblg+ARUpK6hGg
    JAcJqcZfoJJpyrR6Uap/b3zajPQjckBbiVJIb3SBwzKuSPQsyp+3LXpZCstmI5A6VBq2
    bJnQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.25.2 DYNA|AUTH)
    with ESMTPSA id f0a856x3S9QL387
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Apr 2021 11:26:21 +0200 (CEST)
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
References: <20210428090914.252967-1-mkl@pengutronix.de>
 <20210428091224.lsqf4tttd7uijdms@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f18cb9ce-4bab-80b2-ccc7-37fbafe04995@hartkopp.net>
Date:   Wed, 28 Apr 2021 11:26:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428091224.lsqf4tttd7uijdms@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc and Guillaume,

thanks for picking this up here. I was busy the last days.

On 28.04.21 11:12, Marc Kleine-Budde wrote:
> On 28.04.2021 11:09:14, Marc Kleine-Budde wrote:
>> From: "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
>>
>> Link: https://github.com/hartkopp/can-isotp/pull/43
>> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
>> Not-Signed-off-by: Sottas Guillaume (LMB) <Guillaume.Sottas@liebherr.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>
>> Hello,
>>
>> for better reviewing I'm posting Sottas's patch here. While porting to
>> current net/master I've fixed up the indention.
>>
>> regards,
>> Marc
>>
>>   net/can/isotp.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 9f94ad3caee9..d02e8f1f240f 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -110,6 +110,11 @@ MODULE_ALIAS("can-proto-6");
>>   #define ISOTP_FC_WT 1		/* wait */
>>   #define ISOTP_FC_OVFLW 2	/* overflow */
>>   
>> +enum {
>> +	ISOTP_ERR_NO_ERROR = 0,
>> +	ISOTP_ERR_FC_TIMEOUT,
>> +};
>> +
>>   enum {
>>   	ISOTP_IDLE = 0,
>>   	ISOTP_WAIT_FIRST_FC,
>> @@ -122,6 +127,7 @@ struct tpcon {
>>   	int idx;
>>   	int len;
>>   	u8 state;
>> +	u8 error;
>>   	u8 bs;
>>   	u8 sn;
>>   	u8 ll_dl;
>> @@ -756,6 +762,10 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
> 
>>                sk->sk_err = ECOMM;
>>   		if (!sock_flag(sk, SOCK_DEAD))
>>   			sk->sk_error_report(sk);
> 
> I think the idea is that sk_error_report takes care of propagation of
> the error to the user space. I don't know why it's not working as
> expected.

Yes, I fact I was thinking about this question too.

> 
>>   
>> +		/* set error flag in order to consume it later in the
>> +		 * isotp_sendmsg function */
>> +		so->tx.error = ISOTP_ERR_FC_TIMEOUT;
>> +
>>   		/* reset tx state */
>>   		so->tx.state = ISOTP_IDLE;
>>   		wake_up_interruptible(&so->wait);
>> @@ -954,6 +964,13 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   	if (wait_tx_done) {
>>   		/* wait for complete transmission of current pdu */
>>   		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
>> +
>> +		/* check if an error has been raised in the timer
>> +		 * function handler */
>> +		if (so->tx.error == ISOTP_ERR_FC_TIMEOUT) {
>> +			so->tx.error = ISOTP_ERR_NO_ERROR;
>> +			return -ECOMM;

Maybe the way to trigger the sk_error_report(sk) we might return '-1' 
while the error is then propagated inside errno.

But I haven't checked that myself so far.

The reason why this return value is not that important is that ISO-TP is 
an (unreliable!) UDP like protocol where the application checks for an 
application response timeout.

Having the information of a FF timeout only makes sense when 
CAN_ISOTP_WAIT_TX_DONE is enabled to assign the timeout to a that 
specific PDU.

Best,
Oliver

>> +		}
>>   	}
>>   
>>   	return size;
>> @@ -1371,6 +1388,9 @@ static int isotp_init(struct sock *sk)
>>   	so->tx.state = ISOTP_IDLE;
>>   
>>   	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>> +
>> +	so->tx.error = ISOTP_ERR_NO_ERROR;
>> +	so->rx.error = ISOTP_ERR_NO_ERROR;
>>   	so->rxtimer.function = isotp_rx_timer_handler;
>>   	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>>   	so->txtimer.function = isotp_tx_timer_handler;
> 
> 
> Marc
> 
