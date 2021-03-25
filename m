Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7CB348B5E
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 09:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCYIRP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 04:17:15 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:23127 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCYIQ6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 04:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616660217; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=moU/+j7X4H3tTztNL+cwAGX/V0rXhjiknLqUh/APfhjadjytgvZqAZWbQ/ty3axII+
    bUzuYwR36TfLGfRS46wMdTntQZNhSbZRSlAPU/VlJdUXa3lZ07rLxQPAcInBmoLp/JXL
    JuSkQwAzh8pC/fA6zkzbstiE9/oJOx9HyGzjn0ye1Ws8WFEdBr88mO6ya7ZEgQmABvST
    9JF66tbcm5qCdBs1khZIt2tX/SCf1I4cuKdKNBlBovBlunMvyvXyWFvt9uqZK0WWaR0a
    Uu0OZ3DK5eMkS48u1+Vc2C0XEKb00VHQTw+KLKFQX0pe3izLq2af49QB7prLxWaLdcoW
    +zYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616660217;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=s6PAIadZoNVh61X6DTkwXkm+mxxjDGYyGKzuXd+KUXI=;
    b=VAHskUJMcsSOxe9B5J4W4pxYid1PtW5WK+gQp5uXCagcGy/uibP1/7i4jgSYZhxF3P
    UzYNFIXeugUx6Z4PQvPf7k+5m3dYiLmg7X0Afd9gqQnDyiXoyiw0BvYsXslCVH/kpg9g
    RWCuVsW4VWrCdi17ujsjFbTOF8tIH7jN5tiVLTdOwEmwDTJPlqPkqdmB4bOFca97UMbt
    zzXjKiI+PK0zKRTnkh2NMK5ynm1WCS1erm8MvvCU9WV6IvhHgu8tyatbL2vz6r3RzJ7j
    y3v8o5aJfWOahW3yvX7Xezsqa2Q6LySr3NW+aK69JBE9Dc1IyplcDRT3LfsXlRLtJ2GV
    0dMg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616660217;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=s6PAIadZoNVh61X6DTkwXkm+mxxjDGYyGKzuXd+KUXI=;
    b=XqE/9mm4clkVTPwbEn0NSJgmoKtTe1L/rPPriIQY861BCz/x4iNglTvuRfdxPs+kEK
    bWP6bxLZ5uZ3w1DtBknsj/ZsR9ag5SZGgtGFVkrSWj5rpUMXkwMDV8gE2k1mXqfFe97D
    oMGjRJ6WfcfYbaN6tEofurShgT8g2iv2ojkhsLHzDVXTGAtL6+yO2UHAoPNu0aDu6+F0
    FRqtIjgIaenp5EfOioElhl2Eh9Yosgi5Mj7jgaD8UnYP3f9pqp1qz+v60+RJkYSnhHKZ
    JRpzB9bEa+ldaCVuRv2lH6c0GGuiFjadjTJ0BFUTrJoBr5EtpHRWb3BQB9nztSUxWo+F
    eWDw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id z00fabx2P8Gv2uD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 25 Mar 2021 09:16:57 +0100 (CET)
Subject: Re: [PATCH] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
To:     linux-can@vger.kernel.org, Richard Weinberger <richard@nod.at>
References: <20210324215442.44537-1-socketcan@hartkopp.net>
 <20210325081315.GC8446@x1.vandijck-laurijssen.be>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <5598bb66-9f17-a95a-61c6-cc8f13edcb93@hartkopp.net>
Date:   Thu, 25 Mar 2021 09:16:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325081315.GC8446@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 25.03.21 09:13, Kurt Van Dijck wrote:
> On Wed, 24 Mar 2021 22:54:42 +0100, Oliver Hartkopp wrote:
>> Since commit f5223e9eee65 ("can: extend sockaddr_can to include j1939
>> members") the sockaddr_can has been extended in size and a new
>> CAN_REQUIRED_SIZE macro has been introduced to calculate the protocol
>> specific needed size.
>>
>> The ABI for the msg_name and msg_namelen has not been adapted to the
>> new CAN_REQUIRED_SIZE macro which leads to a problem when an existing
>> binary reads the (increased) struct sockaddr_can in msg_name.
>>
>> Fixes: f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
>> Link: https://lore.kernel.org/linux-can/1135648123.112255.1616613706554.JavaMail.zimbra@nod.at/T/#t
>> Reported-by: Richard Weinberger <richard@nod.at>
>> Suggested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   net/can/bcm.c   | 14 ++++++++++----
>>   net/can/isotp.c | 14 ++++++++++----
>>   net/can/raw.c   | 17 +++++++++++------
>>   3 files changed, 31 insertions(+), 14 deletions(-)
>>
> ...
>> @@ -808,10 +810,13 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>>   	int noblock;
>>   
>>   	noblock = flags & MSG_DONTWAIT;
>>   	flags &= ~MSG_DONTWAIT;
>>   
>> +	if (msg->msg_name && msg->msg_namelen < RAW_MIN_NAMELEN)
>> +		return -EINVAL;
>> +
>>   	if (flags & MSG_ERRQUEUE)
>>   		return sock_recv_errqueue(sk, msg, size,
>>   					  SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
>>   
>>   	skb = skb_recv_datagram(sk, flags, noblock, &err);
>> @@ -830,12 +835,12 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>>   	}
>>   
>>   	sock_recv_ts_and_drops(msg, sk, skb);
>>   
>>   	if (msg->msg_name) {
>> -		__sockaddr_check_size(sizeof(struct sockaddr_can));
>> -		msg->msg_namelen = sizeof(struct sockaddr_can);
>> +		__sockaddr_check_size(RAW_MIN_NAMELEN);
>> +		msg->msg_namelen = RAW_MIN_NAMELEN;
> 
> Why not fill up to MIN(msg->msg_namelen, sizeof(struct sockaddr_can))?
> 

I checked that in j1939/socket.c and there the content is also reduced 
to the minimum size.

At least that makes sense to me to have that consistent.

Regards,
Oliver

>>   		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>>   	}
>>   
>>   	/* assign the flags that have been recorded in raw_rcv() */
>>   	msg->msg_flags |= *(raw_flags(skb));
>> -- 
>> 2.30.2
>>
