Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4C74AB0F
	for <lists+linux-can@lfdr.de>; Fri,  7 Jul 2023 08:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGGGXJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Jul 2023 02:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjGGGW6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Jul 2023 02:22:58 -0400
X-Greylist: delayed 42811 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 23:22:57 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19403E1;
        Thu,  6 Jul 2023 23:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688710969; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qRTCx/MgEn2PK8KaWCwWDfBOTJsSNm6YwjqVHG2MstZPNS6qUKCMaZwvkQNdUX0Kj0
    1ZHk4UWQuJ4LNo2/+7cFqCbq4pM0+j6p+gpAjOIo184PXgVwLsZRFc7b4mMmivNHdF7c
    Ay39oWWfWWpVdKTy6wbBN14UFZZpdBrbEUyaZvtdHfQ6Ceq2amiR35ccO0BrDQre7GLr
    jC8U9/DhqbNEY1X0vvoMRJU5zqZZLO3nFcb2dTDiVM56ROULEHO8bchSc6S7KOu6aNBx
    NHAHAl0SAy4tqbzsZYdxC4g42aFwj3bnWrZ6qD5Jlye+nej5Y10yjycQfkEEBV2yW+Vn
    8x/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688710969;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=r4Z8zNUbjJk0qMg28NgEMMmR0/U0tXMFYk4LiIFA+Js=;
    b=C15NQKNQxqwyQE6Rki2fiOkragnOH/tEVCUTqKMMBDHzLFnyqTH/xwdp+Z4/qAhRvQ
    SqJs+PWpe1Nj4EPztXov3Rw8k/gVqTBxt+xtgUrhED98agiYe432eDGMGcu1i5Zv+xq1
    ADqoMPy1f7/vV9YBRGffB4i8SA74nzf1oYrByiMn+daAIxI49drG3W6phG8SM/xs8c0N
    knYDQoslMUD8u3mUzxqGUXuT7p+/CAQEPb7jmvTdlYDDLtHY8jVb9pCCYoLmsXtye2FA
    /VH6AfpQ3UPWeaKYVWKx+ZBF/tFbbqr2Ky/hj0hO/mJHTV95ZscFJFKw9v2d/Npt66i/
    lFog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688710969;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=r4Z8zNUbjJk0qMg28NgEMMmR0/U0tXMFYk4LiIFA+Js=;
    b=Lc8KSJoZWUzlmrW24Tdr0XkfzJj3dQBkEnvfn3uEHCY6dniz5xFKmh3FHeNa3XFUqT
    WKrP060pQaj0CPQwVCa/hFx7Pz4YCi8Te9WJ4SnLHxkdF4SmmqoLdPExowtVW9Lt+XDq
    6KxBip7i+wTOgpUPgG66I1sjRCHpI/uZJAkc4Ux6LY4RiffXc1VKGw7+Be5Sl6OTLHlV
    64dwFJ0H3F/TGMAUSYoQCkkSNx33P2A66RcTpz2+2GVyIXgk7fdI7+CrWszKWk3wcPze
    CiyM2dueKG8VCtVPAXrucEYkh3cfrdPnW0roojwGjMv+Xcuiuh3A9sjKLzD8/T3FljyX
    YFHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688710969;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=r4Z8zNUbjJk0qMg28NgEMMmR0/U0tXMFYk4LiIFA+Js=;
    b=qtRW04UdGs4b+lpOF9LT95Ue0M3njNQ5ydFwglChpuwrJHwJmC3yQwFmT98Y9akIgw
    TnOQ++CeLpkEQHjBFcCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id J16f43z676MmFSG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 7 Jul 2023 08:22:48 +0200 (CEST)
Message-ID: <1de551fb-d4f2-d0b8-e155-a5830f4d8d62@hartkopp.net>
Date:   Fri, 7 Jul 2023 08:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] can: raw: fix receiver memory leak
To:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
References: <20230705092543.648022-1-william.xuanziyang@huawei.com>
 <2aa65b0c-2170-46c0-57a4-17b653e41f96@hartkopp.net>
 <4880eff5-1009-add8-8c58-ac31ab6771db@huawei.com>
 <2a035aab-d10a-bb6f-d056-ea93c454a51d@hartkopp.net>
 <18374b78-dd42-c096-85bf-d7dd2e9c5fe8@huawei.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <18374b78-dd42-c096-85bf-d7dd2e9c5fe8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 07.07.23 03:59, Ziyang Xuan (William) wrote:
>> On 06.07.23 14:48, Ziyang Xuan (William) wrote:
>>
>> (..)
>>
>>>>>         }
>>>>>        out:
>>>>>         release_sock(sk);
>>>>> +    rtnl_unlock();
>>>>
>>>> Would it also fix the issue when just adding the rtnl_locks to raw_bind() and raw_release() as suggested by you?
>>>
>>> This patch just add rtnl_lock in raw_bind() and raw_release(). raw_setsockopt() has rtnl_lock before this. raw_notify()
>>> is under rtnl_lock. My patch has been tested and solved the issue before send. I don't know if it answered your doubts.
>>
>> My question was whether adding rtnl_locks to raw_bind() and raw_release() would be enough to fix the issue.
>>
>> Without introducing the additional ro->dev element!?
> 
> Understand. Just add rtnl_lock to raw_bind() and raw_release() can not fix the issue. I tested.
> 
> We should understand that unregister a net device is divided into two stages generally.
> Fistly, call unregister_netdevice_many() to remove net_dev from device list and add
> net_dev to net_todo_list. Secondly, free net_dev in netdev_run_todo().
> 
> In my issue. Firstly, unregister_netdevice_many() removed can_dev from device
> list and added can_dev to net_todo_list. Then got NULL by dev_get_by_index()
> and receivers in dev_rcv_lists would not be freed in raw_release().
> After raw_release(), ro->bound would be set 0. When NETDEV_UNREGISTER event
> arrived raw_notify(), receivers in dev_rcv_lists would not be freed too
> because ro->bound was already 0. Thus receivers in dev_rcv_lists would be leaked.

Thanks for the clarification and the testing!

I really assumed rtnl_lock would do this job and also protect the entire 
sequence starting with unregister_netdevice_many() !?!

Looking forward to the V2 patch then.

Many thanks,
Oliver

> 
>               cpu0                                        cpu1
> unregister_netdevice_many(can_dev)
>    unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
>    net_set_todo(can_dev)
> 						raw_release(can_socket)
> 						  dev = dev_get_by_index(, ro->ifindex); // dev == NULL
> 						  if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
> 						    raw_disable_allfilters(, dev, );
> 						    dev_put(dev);
> 						  }
> 						...
> 						ro->bound = 0;
> 						...
> 
> netdev_wait_allrefs_any()
>    call_netdevice_notifiers(NETDEV_UNREGISTER, )
>      raw_notify(, NETDEV_UNREGISTER, )
>        if (ro->bound) // invalid because ro->bound has been set 0
>          raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed
> 
> 
> Thanks,
> William Xuan
> 
>>
>> Best regards,
>> Oliver
>> .
