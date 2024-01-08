Return-Path: <linux-can+bounces-116-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F31826976
	for <lists+linux-can@lfdr.de>; Mon,  8 Jan 2024 09:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D21DB216B6
	for <lists+linux-can@lfdr.de>; Mon,  8 Jan 2024 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382913AC7;
	Mon,  8 Jan 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XHiKgfTB";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Q5YvZhPB"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04713ADD
	for <linux-can@vger.kernel.org>; Mon,  8 Jan 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1704702421; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E2VJofOw3BIAIxO7132hUARBIzdC8v7Do8ZTq/EtnLjFU0bkZKztrReVsaxODogRM2
    8jBde11tHTbzuCWDRv6ALSjp4fCuaeEH3C1UJW0B9jZhCCSNPsoJaTNVcVPU33caNsN/
    /HFzqF+/Nn0dvWbwLvN/wqMp+B7PbghJyC7nBQsbnPT0cqrTUxsLQkb+PkPniSFikLCW
    rGCpc5cH38n88AUDsLSk5bEqBl11slE3sgDylLtSRYJmvGQGbEEM/qMen27uXNBf74Ed
    EM6rlXoBjJrnA34Qvti4BEiZj9khO7qRfHEFDHoPTvuZl7gtRhyd6nsel4zAaZXr0s5y
    fKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704702421;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=o+AXcFJc9N5oR7shGk2fX21RnQMuwlzrqgnyT3PQuZQ=;
    b=rlq5VZ9uCPppEjDsgFnV/I92/3PX4vlm/B5/36/M4Moa6NjrZLxIWDW5cK8pwSjIxm
    v1WvNd9PoC8OOLdPDAuaikhmyvrf5j7G3phA3oE0CiyZBnwL3s6NzRWc8aWq9Btk4Fwm
    1y59bmK2+KFSWPGzk0qEzkYPSTW0gYEgQOSMqL3ruxMB0JhebiTu929bitazvaIYYHwe
    IV3Q0fsWNTF+BZT0wx5Lef23eT0luGKr8im9OaGNlFUPw4rcugefcWHOD6t/3LoHV5LE
    76k3kT87kyBvpUds+byZdGugIF0rmYEBOOqj9/2q3ogJRoSMigf40z4URMREjDk3Xc92
    ALkg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704702421;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=o+AXcFJc9N5oR7shGk2fX21RnQMuwlzrqgnyT3PQuZQ=;
    b=XHiKgfTBtYXnn8qi2m/ksMRXnpyd4FnzGLtxdWXAy4a+4EbKrKgCGRHiSzGTJfLK0n
    JV1BmsLE52f6F+8FbsvmFDGsXebvkTlrq0FXYrYvuw26owdKiC9jPblXX5UUQlZGSmM3
    X0W64z3WxySiLXtltUy1p6kcQOJsR71qT9irlYF4Fr1P9oH8Ecm4Og3ULFl67eg97k2f
    nY+4CZUAT569PRjicaHkwpJi49qFpDUKoMtFziooRox65zpLVtwj5qUs4yzNtp5S4blv
    9pgeHceagK26Vqez2ncXBzTUVxnAZA2DNiXldzm0xaRM599LCepn/mk+09q5PkkWhjsB
    PFDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704702421;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=o+AXcFJc9N5oR7shGk2fX21RnQMuwlzrqgnyT3PQuZQ=;
    b=Q5YvZhPB7FAODBofcpl7G4loqqNTVCSALbWZ/BTxN+FA1Ug1oF4Cl1oPXvrOAEea/T
    kL+IfE7QolR8YpwPvKDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0UTfMPyErpBIM2Ca9aGiq7rPTvgZ5w=="
Received: from [IPV6:2a00:6020:4a8e:5010:aed5:1289:f931:3eb9]
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id Kf147a0088R1BJu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Jan 2024 09:27:01 +0100 (CET)
Message-ID: <4a80e73c-0c53-406f-bb81-0ea552480b74@hartkopp.net>
Date: Mon, 8 Jan 2024 09:26:55 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] canxl: add virtual CAN network identifier support
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de
References: <20240107171401.2339-1-socketcan@hartkopp.net>
 <CAMZ6RqKoAyh_ow_rsPWMqe_jzQkAjvBitzHPY6-G4YhyEqw7ag@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKoAyh_ow_rsPWMqe_jzQkAjvBitzHPY6-G4YhyEqw7ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.01.24 06:46, Vincent MAILHOL wrote:

> I have not yet reviewed the net/can/raw.c part. It will take me more
> time. I will do it later (we are the first day of the merge window, so
> that leaves me time!)

The raw.c changes have become very easy to review since the introduction 
of the vcid element - no hurry ;-)

> 
> Question: do you think this should also go to stable?
> 

I would have no objections, but I'm not sure whether we can convince the 
stable maintainers to change the UAPI and slightly extend the ABI in 
stable kernels? Let's see.

> More a matter of principle, but you should
> 
>    #include <asm/byteorder.h>
> 
> c.f. https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ip.h#L22

Yes. I already prepared this change for the next patch cycle yesterday:
 
https://github.com/hartkopp/canxl-utils/commit/9ac1b75b59ccbf668fec4bd5c846542ad0073da0

>> @@ -193,26 +193,39 @@ struct canfd_frame {
>>   #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
>>   #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
>>
>>   /**
>>    * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
>> - * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
>> - * @flags: additional flags for CAN XL
>> - * @sdt:   SDU (service data unit) type
>> - * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
>> - * @af:    acceptance field
>> - * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
>> + * @prio:   11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> 
> Now that prio is a __u16, the CAN_*_FLAG flags fall outside prio width
> (in __res0 as you mentioned below). So I would rather remove the
> latter part of this sentence. You may instead specify that bits
> outside of the CANXL_PRIO_MASK shall be zeroed.

Right. Will change that.

>> + * @vcid:   virtual CAN network identifier
> 
> Maybe say that this field is valid only if enabled through
> CAN_RAW_XL_VCID_OPTS, else should be zero.

No. This is a data structure definition and not the CAN_RAW socket 
documentation. But it has definitely to be mentioned somewhere.

>> - * @prio shares the same position as @can_id from struct can[fd]_frame.
>> + * @prio shares the lower 16 bits of @can_id from struct can[fd]_frame.
>> + * @__res0 holds the @can_id flags CAN_xxx_FLAG and has to be set to zero
> 
> Just realized now, but I would have personally preferred to merge
> those two sentences within their respective field documentation. Just
> feels odd to me to have the information on the prio and __res0 field
> are scattered in two different locations. Well this is just a nitpick,
> at the end, just choose which one seems good to you.

Ok. I always tried to get only one line for the element description. But 
this could be changed. No problem.

>> +struct can_raw_vcid_options {
>> +
>> +       __u8 flags;             /* flags for vcid (filter) behaviour */
>> +       __u8 tx_vcid;           /* VCID value set into canxl_frame.prio */
>> +       __u8 rx_vcid;           /* VCID value for VCID filter */
>> +       __u8 rx_vcid_mask;      /* VCID mask for VCID filter */
>> +
> 
> Why the newlines before and after the struct members? This style is
> not consistent with the other CAN headers.

Ok. Will remove them.

>>          /* check for correct padding to be able to use the structs similarly */
>>          BUILD_BUG_ON(offsetof(struct can_frame, len) !=
>>                       offsetof(struct canfd_frame, len) ||
>> +                    offsetof(struct can_frame, len) !=
>> +                    offsetof(struct canxl_frame, flags) ||
>>                       offsetof(struct can_frame, data) !=
>>                       offsetof(struct canfd_frame, data));
> 
> Nitpick: I would expect to see the code structured in this order:
> check Classical CAN first, then CAN-FD and finally CAN-XL. Not sure
> why the CAN-XL is in the middle. If the only reason is to minimize the
> patch diff, then no.

The reason is to check the offset to struct can_frame.len - so all these 
checks are sorted by the first element to be checked.

Thanks for the feedback!

Oliver

