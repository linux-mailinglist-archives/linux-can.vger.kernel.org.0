Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9D348448
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 23:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhCXWAM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Mar 2021 18:00:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:31630 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhCXV74 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 17:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616623182; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G0ROhRKy3jqTyoSEcnrW/D1xD2DWyu9D7QO2dY+BC4wca2NS2KDoVYGHdIlbFMx8hV
    qgK+4OA90wZWF0rwlIMPVwGI+Z6injW/8IjAm1/ppynJ0m3E3LxgKQsW665/tuctRx78
    d113elk7p5NZLoQt5WgWpvKVcNn09J0pn38OC+dDl39TlUnS3G9eEmLIyOSTHRT8yle/
    cirmyuOsX3tti+d0fni+pBQNok5QvDBXnaMrGhnUmsmhzXC+Plf/aliHYGBGuELREm18
    cIxB9OBTyqyApjJSMDeH6iht94WXksXz8w7hahZe2+PatjgxZQ8GcNDE5WSPHWvSsbI4
    aUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616623182;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:Cc:References:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=lhu5o+yqATwAvjjpP7DpaNZc3kAfKLtu4WmwmXJBBx8=;
    b=XoAzG89AHsin8ZA7ou9j//jCwyJbUvrymH9B08d/N6AJCQj4MWbmK4bjUmgsWvZWCw
    Y4S+DnbvMYK4zzmVaSHMAR9yZES7ua4DvZTUd2SSH1u2vwvK3zvbPKZtMyGQVhi0yMwb
    R2Md6qoAjpfAMd5SImUQI96l7O4NPz3tCi8LQP00LVmogxaMLZb/5O8w5/5EtsHSK4Vv
    xtWBF+wMqIT8Y/2nxxrDaiKOcNpwCVwrezh+dPDJUyn/+Tv1EA/jOeFmZBDElOazl3Am
    llfsdma0OxA01MPD+N8jS2O80S0OOLVSMr4WGXw9mJo9m9uyDUHtBsHwLWzTMcLfkong
    2JUQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616623182;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:Cc:References:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=lhu5o+yqATwAvjjpP7DpaNZc3kAfKLtu4WmwmXJBBx8=;
    b=UoAPIYop7YrDljIXRC68g4mRgYDx5hBt8TSbZaz1veety0FUEx+3k/jRT+FAZg0Lqa
    1TEPsf3l1BW31HiuzebWxaLlArTxCybuf6GobTSlJXye1hap7d4tVAXh/8yfi1WnAYUx
    TjuxyfVE+z8PnD8W/qJwBAqDbsHzA6+scc0+u3MorMiuik7I0OkJG82zCbnUoS/7BPCd
    FxFeHsdHR9MeoRnwzx1u7yqeL6bJZgQ358qq7w4+ZV0SFfOXLJSoEwJj598URmfhh+3B
    NUuHhhONEmIoSRDy/7kihQMHoAVXOgKZqR2ScjUDM0lR7jTzQ0Wde4rljvL3z9/X26L+
    psRQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKNNeVT9I="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id z00fabx2OLxg2ED
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 24 Mar 2021 22:59:42 +0100 (CET)
Subject: Re: PATCH: Breaking UAPI change?
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Richard Weinberger <richard@nod.at>
References: <1883346738.111675.1616599858539.JavaMail.zimbra@nod.at>
 <20210324190104.GB3342@x1.vandijck-laurijssen.be>
 <1135648123.112255.1616613706554.JavaMail.zimbra@nod.at>
 <20210324192746.GA7408@x1.vandijck-laurijssen.be>
 <26bf9711-9fe4-f7fe-22fe-750cf93bd760@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Message-ID: <1551165a-0f19-cffb-750a-0af36e2a68b6@hartkopp.net>
Date:   Wed, 24 Mar 2021 22:59:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <26bf9711-9fe4-f7fe-22fe-750cf93bd760@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Kurt,

I sent a patch which addresses the msg_name issue in all missing CAN 
protocols.

https://lore.kernel.org/linux-can/20210324215442.44537-1-socketcan@hartkopp.net/T/#u

Can you please check, if we should go for this approach?

@Richard: Can you please test this patch if it fixes your issue?

Regards,
Oliver

On 24.03.21 21:26, Oliver Hartkopp wrote:
> 
> 
> On 24.03.21 20:27, Kurt Van Dijck wrote:
>>> ----- Ursprüngliche Mail -----
>>>>> commit f5223e9eee65 ("can: extend sockaddr_can to include j1939 
>>>>> members")
>>>>> increased the size of
>>>>> struct sockaddr_can.
>>>>> This is a problem for applications which use recvfrom() with 
>>>>> addrlen being
>>>>> sizeof(struct sockaddr_can)
>>>>> or sizeof(struct sockaddr).
>>>>> If such an application was built before the change it will no 
>>>>> longer function
>>>>> correctly on newer kernels.
>>>>
>>>> This scenario was identified, and explicitely dealt with.
>>>> This requires a tiny bit different code, i.e. net/can/raw.c should use
>>>> REQUIRED_SIZE() instead of sizeof() for testing the size of the address
>>>> structure.
>>>>
>>>>> In fact I ran into such a scenario and found the said commit later 
>>>>> that day.
>>>>
>>>> Looking to the v5.10 kernel (which I happen to have checked out),
>>>> your claim indeed seems true, the raw_recvmsg does not (raw_bind and
>>>> raw_sendmsg work correct, but that's not important for your problem).
>>>>
>>>>>
>>>>> Is this a known issue?
>>>>
>>>> It wasn't, until you found it :-)
>>>
>>> Thanks for the prompt reply!
>>>>> Or is this allowed and application must not use sizeof(struct 
>>>>> sockaddr_can) as
>>>>> addrlen?
>>>>
>>>> sizeof(struct sockaddr_can). As you already mentioned, applications 
>>>> may have
>>>> been built
>>>> before the size increase, and so they should not be recompiled.
>>>>
>>>>
>>>>> If so, what is the proposed way to avoid future breakage?
>>>>
>>>> Your application should not change. Kernel must be fixed.
>>>
>>> Feel free to CC me when you submit a patch, I'll happily test it.
>>
>> Here it goes.
>> Even not compile tested :-( on my v5.10, at this hour.
>> I spotted a similar problem in getsockname/getpeername calls.
>>
>> The patch will test for minimum required size before touching anything,
>> later on, the maximum size will be evaluated.
>>
>> Happy testing?
>>
>> commit 124900109ca88d29382ef2e2b848d3a2f9d67b98
>> Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>> Date:   Wed Mar 24 20:08:50 2021
>>
>>      can raw: don't increase provided name length
>>      The length of the buffer is known by the application,
>>      not the kernel. Kernel is supposed to return only the
>>      size of used bytes.
>>      There is a minimum required size for the struct sockaddr_can
>>      to be usefull for can_raw, so errors are returned when
>>      the provided size is lower
>>      Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>>
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 6ec8aa1d0da4..00d352ae221e 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -475,7 +475,7 @@ static int raw_getname(struct socket *sock, struct 
>> sockaddr *uaddr,
>>       if (peer)
>>           return -EOPNOTSUPP;
>> -    memset(addr, 0, sizeof(*addr));
>> +    memset(addr, 0, CAN_REQUIRED_SIZE(*addr, ifindex));
>>       addr->can_family  = AF_CAN;
>>       addr->can_ifindex = ro->ifindex;
> 
> Is there no need to adapt the return value then?
> 
> - return sizeof(*addr);
> + return CAN_REQUIRED_SIZE(*addr, ifindex);
> 
> Regards,
> Oliver
> 
> ps. If so, I need to go through isotp_getname() too ...
> 
> 
>> @@ -806,6 +806,10 @@ static int raw_recvmsg(struct socket *sock, 
>> struct msghdr *msg, size_t size,
>>           return sock_recv_errqueue(sk, msg, size,
>>                         SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
>> +    if (msg->name && msg->msg_namelen <
>> +            CAN_REQUIRED_SIZE(struct sockaddr_can, ifindex))
>> +        return -EINVAL;
>> +
>>       skb = skb_recv_datagram(sk, flags, noblock, &err);
>>       if (!skb)
>>           return err;
>> @@ -825,7 +829,8 @@ static int raw_recvmsg(struct socket *sock, struct 
>> msghdr *msg, size_t size,
>>       if (msg->msg_name) {
>>           __sockaddr_check_size(sizeof(struct sockaddr_can));
>> -        msg->msg_namelen = sizeof(struct sockaddr_can);
>> +        if (msg->msg_namelen > sizeof(struct sockaddr_can))
>> +            msg->msg_namelen = sizeof(struct sockaddr_can);
>>           memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>>       }
>>
