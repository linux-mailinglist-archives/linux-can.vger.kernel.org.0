Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACE7682C17
	for <lists+linux-can@lfdr.de>; Tue, 31 Jan 2023 13:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjAaMAt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Jan 2023 07:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaMAs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2023 07:00:48 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AD0193D7
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 04:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675166445; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fw3fBWlmL+pMUNW6YE1RPjKGrDSHg94D47PbRgk5lI4tvOgL8dIaG+Doc8i3QeefPz
    UdJ01PZycJXa0FabaqGzOcY2ICIIA2k57axhuUqw374NsZJxrshhEz31Tx1zU8gXVc3o
    kXabIdWf8zez/CxZv93KBTP6dozgfqag7xrz4W1McotH1y/srDK7z2k8tHkPBhmCuG3b
    CH31oI7ob/T+lVfiixYqHfVG9Xc+EOqM+uLQElc74i/tf7ixKYMbABW3UgXs2e1hGogH
    MAaYRtUAxVW2YEC29Hr3deWPB7QQ111P8/tryHvAwWj6dQmf/Wn9YnOr8yjaf361LeWc
    Wu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675166445;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DHUmUtH2DIm0GPE0SzcBKpuPKs9r6/UtjX5oMDzHWa8=;
    b=Kii2vqGZWcNj3U4Gy4FFUuWTUJULorNd+LlvlNDkgOgBeoUj2Q/H05bCD8OZeDgL7k
    fQW9bUa6mAoYA8+NEM/Gll+UlAVIM4Ca2ZaXnSqtdAPHiuikWCxNu3Ql0CvvDga5PD3b
    wCs0SLrVAr8iCvWP7kK6rKjvIQo0qglMfPCeygXCfzEsANVcrRHmFOVmX4d/T+bAf/n/
    meqi5k55czuLxlFVX7DVMnCxVOv9A2AITcBD4QZ1PEzc4+gFI7vex0s77VuYCPzoVnkb
    DY7jYOLWUYb+TyL3rAmIfFElBWe0sCA82Stc8lD9r7Iu7A1jbc444pyQTPf98eUZjP99
    8oEw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675166445;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DHUmUtH2DIm0GPE0SzcBKpuPKs9r6/UtjX5oMDzHWa8=;
    b=DJw15VSJ90JzLup1h4Thv3MJWtf3IYCZISNgr/twEIjyxeyExbslZa1lmyMgfKFWHz
    CcZD2L7Qgn7RaNoRcqEviPU09W0c9OZMTe3r3LzInx5R9V8IVzPCqLOS/Nre2Ok9kko1
    B7GZ7QkO+UJyayB6jNauwZsz0o7X2Kr3Gmdo4CkJxhugSrHo0+kEZEzDbZ7KVDBgY6Zg
    +Fh6UXVgdEAb0jUD1F7hxLlZT244VEUdWqV4ShbBiEgVBIO2a2zlaDlaR02ONcWNdkJX
    dDLhb8sLpdCoi0XR9rPZr9KhUEzqRvIQe4ex3sDyStFpOB9OabNkq7LgSNCoF/Oo2sUV
    ZRwA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0UTbYtdmpQlYoKzCdIeiRLG7hkJhmg=="
Received: from [IPV6:2a00:6020:4a8e:5000:e7bf:79b1:e026:caf7]
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z0VC0jJIc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Jan 2023 13:00:45 +0100 (CET)
Message-ID: <a55948f5-652c-c62f-a1e5-e280868c5071@hartkopp.net>
Date:   Tue, 31 Jan 2023 13:00:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] can: raw: fix CAN FD frame transmissions over CAN XL
 devices
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20230131091824.51026-1-socketcan@hartkopp.net>
 <20230131110600.pfydrujxthmokmsc@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230131110600.pfydrujxthmokmsc@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 1/31/23 12:06, Marc Kleine-Budde wrote:
> On 31.01.2023 10:18:24, Oliver Hartkopp wrote:
>> A CAN XL device is always capable to process CAN FD frames. The former
>> check when sending CAN FD frames relied on the existence of a CAN FD
>> device and did not check for a CAN XL device that would be correct too.
>>
>> With this patch the CAN FD feature is enabled automatically when CAN XL
>> is switched on - and CAN FD cannot be switch off while CAN XL is enabled.
>>
>> This precondition also leads to a clean up and reduction of checks in the
>> hot path in raw_rcv() and raw_sendmsg().
>>
>> Fixes: 626332696d75 ("can: raw: add CAN XL support")
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>
>> V2: fixed typo: devive -> device
>>
>> net/can/raw.c | 45 ++++++++++++++++++++++++++++++---------------
>>   1 file changed, 30 insertions(+), 15 deletions(-)
>>
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 81071cdb0301..c505d315a7a9 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -130,11 +130,11 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>>   	/* check the received tx sock reference */
>>   	if (!ro->recv_own_msgs && oskb->sk == sk)
>>   		return;
>>   
>>   	/* make sure to not pass oversized frames to the socket */
>> -	if ((can_is_canfd_skb(oskb) && !ro->fd_frames && !ro->xl_frames) ||
>> +	if ((can_is_canfd_skb(oskb) && !ro->fd_frames) ||
>>   	    (can_is_canxl_skb(oskb) && !ro->xl_frames))
>>   		return;
>>   
>>   	/* eliminate multiple filter matches for the same skb */
>>   	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
>> @@ -668,19 +668,27 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>   			return -EINVAL;
>>   
>>   		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
>>   			return -EFAULT;
>>   
>> +		/* Enabling CAN XL includes CAN FD */
>> +		if (ro->xl_frames && !ro->fd_frames) {
>> +			ro->fd_frames = ro->xl_frames;
>> +			return -EINVAL;
>> +		}
> 
> This looks a bit weird. Maybe copy to a local variable first, then
> check, then assign ->fd_frames or exit with error (instead of rolling
> back)?
>

Changed in V4.

Thanks & BR,
Oliver
