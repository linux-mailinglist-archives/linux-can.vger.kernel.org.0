Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF58348A35
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 08:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYHbz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 03:31:55 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:21245 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCYHbX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 03:31:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616657475; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ffgPBMeAkWNv4uvVgLqfQr1hRDgg5V1zOGLnWtDQKbRkC/LY4jsyvs0QkT6ZbFBn74
    psPLJyxT5Hi3mmJGmPZcA7JIGjsSiSLi4ZRrVrh2AP2vUvyStA4P0WPGJ9kaq3INfWRV
    rCIVLqKXLZ9bcvEMHUoQ80+bc1kQifNRykeWdm4mF/fqbqnYK+SIbBw6xzhG85PxGyd6
    4maMpvSeRhwyRTWpxPw/AMQprJTfbH8pFCnN7Y1PnuRWUbBHD2C/rAuhkdKArjX9hKJj
    jMnDrPWADjQ7IFtYaJJrnnzmIkpHs3oimlH7tANiat1+8YD4xZTT766wDsCb/UX54Kvg
    LfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616657475;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=tVc8yqxqCVGVQclGzYutZcYaj2Ok12d2Ye+a2Y4YSE8=;
    b=rsIIE0BDA6bh+qAWt0FJ5WplAzoy+9C547irHMXBCIjMznFhSiHWQ3O97NTyL1duZB
    SvvXr9nHpuvrTbgVp8ucDJ0D+H7eI40dkeCx7vlYzGmJMUKboDFQeLr1dYMwWB4sU/4v
    plG/IwMQfsL16JOKDNX7o7I5SpEU05RgN8nqBw71mYUT1hehY7QWXlunPrGwSdPKHacS
    HM7TSHBdQDnZNx54MK6XQ/vJRb58LtDP58gp3Vtz6vZ4xLpQNI1HL5XGVA/xDfNDl9mV
    C+Q6+lM0dm36QE9zG4Y/WIRNUHUKP89M0iXZkk3ONxzse0LxzMRnGOj90/NTK++dAqey
    n0QQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616657475;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=tVc8yqxqCVGVQclGzYutZcYaj2Ok12d2Ye+a2Y4YSE8=;
    b=lQHx/7sX0AIoJwuhUvTaQ/X6NnLyXeqFOkoFXqkN8/gwZoCk6kqzVs5Nhpte63PhY2
    ApPMCmNW22asLtweW/1bevnKwOZFWLgEITLq6CnQs1QibeZh2pFeqmAtzvq7FFzka/KI
    o1k4nya7UbCf7OME7XxEHnoUNCIVUNMdGml/1tTCw/FW+NO9QFUQ0L5UfNasg5nouFUU
    /XA+HOAy4rRnRAspybMex/ZdPWx2HctzAZYQiglColdWdyDV77RtijqjjZPG7b1bVFwq
    B3iH4/BGvsvY+Samh7b1jpDDGcCtMA7HGlJEcAl4KfC9z+fp43ZGJ/ba7gCdmI6yrpG4
    K8LQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id z00fabx2P7VE2g2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 25 Mar 2021 08:31:14 +0100 (CET)
Subject: Re: [PATCH] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
References: <20210324215442.44537-1-socketcan@hartkopp.net>
 <224900630.112641.1616624386963.JavaMail.zimbra@nod.at>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f830f92e-fc89-7e5f-29ce-e245527a1e39@hartkopp.net>
Date:   Thu, 25 Mar 2021 08:31:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <224900630.112641.1616624386963.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 24.03.21 23:19, Richard Weinberger wrote:
> Oliver,
> 
> ----- Ursprüngliche Mail -----
>> @@ -808,10 +810,13 @@ static int raw_recvmsg(struct socket *sock, struct msghdr
>> *msg, size_t size,
>> 	int noblock;
>>
>> 	noblock = flags & MSG_DONTWAIT;
>> 	flags &= ~MSG_DONTWAIT;
>>
>> +	if (msg->msg_name && msg->msg_namelen < RAW_MIN_NAMELEN)
>> +		return -EINVAL;
>> +
> 
> Like with Kurt's patch, my test fails here too because msg->msg_namelen is 0.
> ->msg_namelen is always 0 in the recvfrom() case.

Agreed!

I just adopted that part and did no more testing yesterday (needed some 
sleep).

E.g. 'candump any' also fails at CAN frame reception time due to this 
wrong check ;-)

Will send an update soon.

Regards,
Oliver
