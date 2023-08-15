Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32B677D0F6
	for <lists+linux-can@lfdr.de>; Tue, 15 Aug 2023 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjHOR0c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Aug 2023 13:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbjHOR0M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Aug 2023 13:26:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A09F1BD9
        for <linux-can@vger.kernel.org>; Tue, 15 Aug 2023 10:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692120068; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LAvUpZooNxRTJAts+BA4rYKaDknfmjgtn/ik5SsyEifJDSDvXVRN154ffaYkmgGOky
    q1PazsytRlQHDLx2DZ3pgLORCB49MX16izJKd2bcFDjixQb1eI8dmorivzZ1Vli2Wux2
    0QRtLvopkPf/OG1YmiQz5lC5ZwtcTbDLiuR3j87L+/iSwIClcahQ9XSnRA4oAd/YTDYo
    UarO/SPjUeEqoGktYlywd84wXmKeqStpt1/PvMYYoM83SMP6z6XMI5OhlJEZlW+1wqBu
    aUxcEhuLFGro4z1MC3rSP5weSz5LZz+87JV6lr8bSD6fojWeiEAsl3VGs1e4mfhYqXzg
    T2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120068;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NZxOnl5hRnA2DJZAtxpIuCxFZE+Ath4s6XOljU5RpQM=;
    b=BybxN43S+ZWO2ZrVpRd7+0TdDm5fdivEiQlubuwZzgZv9BUjhqc4PpikYyCEwESu6g
    QGYdaq9SkjuW9W66g1tRnufW90t4sH9VjqJuUTBgcUFX0FyacnhpjyqjvFTCgG8p7x3e
    aMwdnz6IWmlhqPFjFQvdF+x3eFj/LTM6Q2LtYuSDWnWdRhUMQ34g1H2i3zNwUVWHncmU
    aQk3S/vb6Zy3Egw+bCzF05z5u1ut/YrHr9C/SvARC9ZGHaSDuabjaxeTQ9AFAuS8YZta
    NQIXtOUz/Ll3nFfNHqKyg5JJlqUsBpwcjU2POFFTnV834ZFYebGo3cYoyy0UlXomLDFL
    o0EQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120068;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NZxOnl5hRnA2DJZAtxpIuCxFZE+Ath4s6XOljU5RpQM=;
    b=WzAoLCtDHyXyojPHQWM5KJETcASRKc1vznErYAlvXwma4kZd2oQUC0bsRqMzNiWRDc
    Dw42njsl0NxczFWlMbJqwVpFRz6gu5/I7KePwx+S9BIjXsDAYjXzF3nPNk+E5bpxz4vP
    M3yRIKKfWXNTYWnokMKlDz+rHGkJ6L7euSaKGZ6Iv2omFnEqRXqHAeV07TktOGIt9a8i
    ze4LBnbvQhv11esCHyZzbHj20+jBlz5g402ry1VH2dW7GPU7SzLOaGuI8YvqjVcQDDpp
    Eh8MjUtMig8sZhoCB1UEv7E9G5c+MbaTObRJrSmrgQmZyd9xqZXZk4Uq/o69TgnVrbsV
    Ntzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692120068;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NZxOnl5hRnA2DJZAtxpIuCxFZE+Ath4s6XOljU5RpQM=;
    b=hNkWk+nBfWfYHsrKDQBgATDiWtntvW50JbkivswfbLKP7zhM++F/mG6Mj1ICVQOpnh
    ObvU4La6+dU0tm++3KBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.8.0 AUTH)
    with ESMTPSA id D79666z7FHL80At
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 15 Aug 2023 19:21:08 +0200 (CEST)
Message-ID: <c509c99f-0a05-da44-df69-4c1fe39bd40d@hartkopp.net>
Date:   Tue, 15 Aug 2023 19:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [RFC PATCH] can: raw: add missing refcount for memory leak fix
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-can@vger.kernel.org,
        Ziyang Xuan <william.xuanziyang@huawei.com>
References: <20230804112811.42259-1-socketcan@hartkopp.net>
 <CANn89iJKNSOp+1SQuD_T3M2TQo-4HOsYVV6MwoPVwQjdrb7JKQ@mail.gmail.com>
 <e1826185-af12-c32a-6664-5080af03824d@hartkopp.net>
 <CANn89iLWfZyDb2CMUjaKn7GW9nQE4M85=sWN_6Lk=pqNH+g=+Q@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CANn89iLWfZyDb2CMUjaKn7GW9nQE4M85=sWN_6Lk=pqNH+g=+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Eric,

On 04.08.23 17:59, Eric Dumazet wrote:

>>> Hi Olivier
>>>
>>> I would feel a bit safer with new longterm device references if you
>>> could add an ro->dev_tracker and use netdev_put() netdev_hold() and
>>> friends ;)
>>>
>>> Thanks !
>>>
>>
>> Hi Eric,
>>
>> the netdev_hold() mechanic has been introduced in Linux 6.0.
>>
>> Would it make sense to take this patch as fix for all the current stable
>> kernels and move to the dev-tracker as improvement via net-next as usual?
> 
> Good question.
> 
> My take on this, but others might disagree :
> 
> I think it is better to cook a patch for current upstream kernels.
> 
> Then we will adapt it when backporting to old ones, it should be
> relatively easy.

I implemented both versions with dev tracker and without dev tracker.

It was just the renaming of (net)dev_[hold|put] and having the 
dev_tracker element in the raw_sock data structure.

The new patch is here:
https://lore.kernel.org/linux-can/20230815171447.10879-1-socketcan@hartkopp.net/T/#u

I would appreciate if you could take a short look at it.

Many thanks,
Oliver

