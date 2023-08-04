Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0015F770519
	for <lists+linux-can@lfdr.de>; Fri,  4 Aug 2023 17:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHDPrO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Aug 2023 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjHDPrN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Aug 2023 11:47:13 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5182D71
        for <linux-can@vger.kernel.org>; Fri,  4 Aug 2023 08:47:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691164016; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kNGLDoQLTdTTnpWFgCQCDkFVzUMBNGFcR2aSErcGmbPK9TRUaGr5p39YUQJPjropOL
    Tf5d6D4VL0QwtJ+MdrrgfcRSNihtVT7A7+IbE+2uZKCQLlNErAW+gbJemsOyTlqhfpXn
    Wc4Juzvv6p3GVMlkOW3xoJYT4hQkvtM33dDUeCSGznPLzUfdrH9pecuBz9J9B+uzbKQH
    cOvUUdaWj5/w7+KsjsiKsynA6MNrUvUaK7rgf4J3cNP8TWoj7nqfStf++MCV0Fl6v1mV
    72oBlQ72rT2sThahRTQ+WCrGT5eu+rzK/QoTY3gFKVNAOU8jofDIdtOGLQWICmH62N+M
    pfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691164016;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jjY3l7ZUF5h15x2eizztZZi9g4rWsdihNR8aUAxDu2A=;
    b=hWZBVcrnZaOklMqRjJQ2RjVp+7KeWmx/DexotSvfbljh8inlihxvG/42K+bXWWnb+v
    6dQ+PxRj3GBYM+i8l1CN5S07MIjDkuR/lH7FSg8/zkFmZzusdXzr8bp+38loE4TPEPJn
    G5Q7fhxezrwaDUcheuOToi3i6DLNnIhtoAioQzBOvUJSSgBvoEZIt0JcV6Tb3AnTcPDh
    AOJivy/aLJT4fiCUdXTlaa464hUgmuq6qWRotxo9Db41RxkJ9U6KSPWdyiIk68WsbAEj
    aOmt6/TmVLsKig++gE2g0tBRQ5nChfkWpDYfQdsFylAo++2EkZ10NA92jkYncOIpRSXb
    WnuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691164016;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jjY3l7ZUF5h15x2eizztZZi9g4rWsdihNR8aUAxDu2A=;
    b=FNgYC1UC32xMhDGlrv+dChrf0ps/61dGHU3rBH2ulN2XGT7WY4M+xrmtTtoKorrUTh
    7pYS/nv868De9DZ5pnZVtJDu7EDN0AuoUeulSeOmQ7NnOFKjExVyBNhnmYEI4WLeDyqU
    3y1MNckKG1rX/ZJZ/mOnQnBZ3vcbM9D75O4LdE77J3NnvvM6Fda4zeJQyu5eywMzoZbH
    MzYodprPAzanyI8Pd7pXgJQtViZLt2fNHlN9XgfNq68cDERAZXyg/QUtKQBQv8lxNYjR
    ICGzFVE4P17SJjowK1JMKAn0f7T75Iw+3RDRlhblNmUj/k/SyOeWZMRmcRJK/h1uyoap
    xyKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691164016;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jjY3l7ZUF5h15x2eizztZZi9g4rWsdihNR8aUAxDu2A=;
    b=wDSz8dBgLlcKiAlX3Glh/rLvTkTvxi9m03cqweVKeBs/gqI2Ocubdast9LdApvFQvK
    pU1ytOQQOgQ+5+bIA8Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id 69691ez74FktRx1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 4 Aug 2023 17:46:55 +0200 (CEST)
Message-ID: <e1826185-af12-c32a-6664-5080af03824d@hartkopp.net>
Date:   Fri, 4 Aug 2023 17:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [RFC PATCH] can: raw: add missing refcount for memory leak fix
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-can@vger.kernel.org,
        Ziyang Xuan <william.xuanziyang@huawei.com>
References: <20230804112811.42259-1-socketcan@hartkopp.net>
 <CANn89iJKNSOp+1SQuD_T3M2TQo-4HOsYVV6MwoPVwQjdrb7JKQ@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CANn89iJKNSOp+1SQuD_T3M2TQo-4HOsYVV6MwoPVwQjdrb7JKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04.08.23 14:12, Eric Dumazet wrote:
> On Fri, Aug 4, 2023 at 1:28 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
>> a new reference to the CAN netdevice that has assigned CAN filters.
>> But this new ro->dev reference did not maintain its own refcount which
>> lead to another KASAN use-after-free splat found by Eric Dumazet.
>>
>> This patch ensures a proper refcount for the CAN nedevice.
> 
> Hi Olivier
> 
> I would feel a bit safer with new longterm device references if you
> could add an ro->dev_tracker and use netdev_put() netdev_hold() and
> friends ;)
> 
> Thanks !
> 

Hi Eric,

the netdev_hold() mechanic has been introduced in Linux 6.0.

Would it make sense to take this patch as fix for all the current stable 
kernels and move to the dev-tracker as improvement via net-next as usual?

Best,
Oliver

>>
>> Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
>> Reported-by: Eric Dumazet <edumazet@google.com>
>> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   net/can/raw.c | 31 +++++++++++++++++++++----------
>>   1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index e10f59375659..a61c417fdd27 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -283,12 +283,14 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>>
>>          switch (msg) {
>>          case NETDEV_UNREGISTER:
>>                  lock_sock(sk);
>>                  /* remove current filters & unregister */
>> -               if (ro->bound)
>> +               if (ro->bound) {
>>                          raw_disable_allfilters(dev_net(dev), dev, sk);
>> +                       dev_put(dev);
>> +               }
>>
>>                  if (ro->count > 1)
>>                          kfree(ro->filter);
>>
>>                  ro->ifindex = 0;
>> @@ -389,14 +391,16 @@ static int raw_release(struct socket *sock)
>>          rtnl_lock();
>>          lock_sock(sk);
>>
>>          /* remove current filters & unregister */
>>          if (ro->bound) {
>> -               if (ro->dev)
>> +               if (ro->dev) {
>>                          raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
>> -               else
>> +                       dev_put(ro->dev);
>> +               } else {
>>                          raw_disable_allfilters(sock_net(sk), NULL, sk);
>> +               }
>>          }
>>
>>          if (ro->count > 1)
>>                  kfree(ro->filter);
>>
>> @@ -447,36 +451,43 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>                  if (dev->type != ARPHRD_CAN) {
>>                          dev_put(dev);
>>                          err = -ENODEV;
>>                          goto out;
>>                  }
>> -               if (!(dev->flags & IFF_UP))
>> -                       notify_enetdown = 1;
>> -
>> -               ifindex = dev->ifindex;
>>
>>                  /* filters set by default/setsockopt */
>>                  err = raw_enable_allfilters(sock_net(sk), dev, sk);
>> -               dev_put(dev);
>> +               if (err) {
>> +                       dev_put(dev);
>> +                       goto out;
>> +               }
>> +
>> +               ifindex = dev->ifindex;
>> +               if (!(dev->flags & IFF_UP))
>> +                       notify_enetdown = 1;
>>          } else {
>>                  ifindex = 0;
>>
>>                  /* filters set by default/setsockopt */
>>                  err = raw_enable_allfilters(sock_net(sk), NULL, sk);
>>          }
>>
>>          if (!err) {
>>                  if (ro->bound) {
>>                          /* unregister old filters */
>> -                       if (ro->dev)
>> +                       if (ro->dev) {
>>                                  raw_disable_allfilters(dev_net(ro->dev),
>>                                                         ro->dev, sk);
>> -                       else
>> +                               /* drop reference to old ro->dev */
>> +                               dev_put(ro->dev);
>> +                       } else {
>>                                  raw_disable_allfilters(sock_net(sk), NULL, sk);
>> +                       }
>>                  }
>>                  ro->ifindex = ifindex;
>>                  ro->bound = 1;
>> +               /* bind() ok -> holding a reference to new ro->dev */
>>                  ro->dev = dev;
>>          }
>>
>>    out:
>>          release_sock(sk);
>> --
>> 2.39.2
>>
