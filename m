Return-Path: <linux-can+bounces-139-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E483551A
	for <lists+linux-can@lfdr.de>; Sun, 21 Jan 2024 11:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859EB2823FB
	for <lists+linux-can@lfdr.de>; Sun, 21 Jan 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553C4364B7;
	Sun, 21 Jan 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lGLJkTYh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="5bXckpJ1"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62790364B6
	for <linux-can@vger.kernel.org>; Sun, 21 Jan 2024 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832197; cv=pass; b=jSVtzdCMS/+nOpxXmurkvqtQygmSlzIDYitSpJGOV6Er8y9fWSk2EjASdoxb/SuMjj2zNNPUkDH8BXGiBJb9zaoF1wb7RekOYG//qTCKN2OOmThg7LSWZRHJ1NgefYBDKnbxVhYCPJOR2qoC7NyDd2QRG4zaQ7s47tOo2KBddA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832197; c=relaxed/simple;
	bh=U+P7ST2fR/nL2EGQgX5ZHixLCmnSP++nFzB2EZYpqAE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kpwJTQthmLI2O1Od8GefXX0zxqv/vRj/kfSnVJfUX4CCz5ewQ05Ha7juH+nqbSih+4aFAO48gqKUXysWFo8lD4e7fOHAcBULQjyQuqRU2rThC17O8cYh57CaDtWfeIinOzFSSXryN+E4+dQpjfAyWHgmz+RDynw8Mp8nftRfa64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lGLJkTYh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=5bXckpJ1; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1705832003; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UA9yYrmNZt3XueFPGdq78UcNvtBybJskps4WgMKPeDoJNMPdXqz9+zNVArM/RpqXRe
    sx8BsC2d1ffLZfADeKCFFH70sTncz+oFwnIQOFiZylPtkz9jW0QrIYFpId3cm02/DIPZ
    Yt7XnSK5NBe/lZcomN5efCnb6pDI80RC+I9g+JU43oEDyxG8jB7NUkULRaebXuAt1kTY
    RsRXt/NHPoXMmAeBUXpquojAhAh5jc4OgvAHADS29heHlVmkU2tOKBbrKWS4mtHNKtDa
    pbFV+h5P3rK5I+rJQ9CZZejMslYpF49oMyhqmDwA1D7LLXodLysnHAtejCB89if52bhc
    5cfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705832003;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZKqwIpeRhnfX8xE8U+R+UUsZORfRDZQA8Ved5JOpvrw=;
    b=H2CNyZSUyKI+fvcfuRag0W//VYqY4qYKdlqWbZMPRfi6UG2eAhBE8v1YRTmU2wm1sK
    QHvf8FCNZ5/lBCuLS4cgQJckl+zYSRWixP1GODo/TmY1mXbiKJeFKa/C2tuk9j1MBhq+
    AbKoOFrEeHkeERpYHbBLyE3mD46aAm/PKwDue9eac8B0wmzsILO41J1KrvPkH4ipLP/Z
    0MdgJLJZaKXUdr5JpLtV4nBapAJSZ4hodwwezYtadNc93r+akKsxFrhYkv5yvOEaoSAE
    bAJNmM9iF0uPqzms0hqAwWqqf9t/GfR0eNRZDWpiBsHEi20/4RTKC+TbT5LC4rYVKK45
    WAQg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705832003;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZKqwIpeRhnfX8xE8U+R+UUsZORfRDZQA8Ved5JOpvrw=;
    b=lGLJkTYhF+bppw3v+BJMiKIyYrXxKYLtUWKxbX7oJotBMSfq/hY94qJO1QERlFs1OF
    NELtv0RLllCZecEQsd/It0OkoELVs4it+nSQc9JyPoZJuQ0GCa6aE5fhR178MIbUgIJ8
    yhTXKryaaRDA0c8/ASpIChi9l9KifA5lvlynkQkemODxhLq7/vdPfSJppGnVuhSRvR0L
    aI79a4gkaEIhNXCFfywvAXWY+8OnrRWv8zO9wVTC3nFZPIaJpM1v/RJsaSO5fWuW4WH3
    qAeiocWp4g16b0RFIjRxjDnNr0SdcCouCMzLwsYrCEEo0FsIPSuvXiJtzjXUF6NTyNj8
    fcEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705832003;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZKqwIpeRhnfX8xE8U+R+UUsZORfRDZQA8Ved5JOpvrw=;
    b=5bXckpJ1ahKMDGEW1Z8+m2mcGUYA7IltlSBhCKn/1p52XP9eDZKmpb99vRSVcwpMO9
    J1jJXBHjqzHY0ZI3cfAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id K7b2c200LADNcFK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 21 Jan 2024 11:13:23 +0100 (CET)
Message-ID: <2c9f7052-c2bb-4d76-bf58-714103fc6d71@hartkopp.net>
Date: Sun, 21 Jan 2024 11:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] canxl: add virtual CAN network identifier support
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de
References: <20240107171401.2339-1-socketcan@hartkopp.net>
 <CAMZ6RqKoAyh_ow_rsPWMqe_jzQkAjvBitzHPY6-G4YhyEqw7ag@mail.gmail.com>
 <4a80e73c-0c53-406f-bb81-0ea552480b74@hartkopp.net>
In-Reply-To: <4a80e73c-0c53-406f-bb81-0ea552480b74@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 2024-01-08 09:26, Oliver Hartkopp wrote:
> On 08.01.24 06:46, Vincent MAILHOL wrote:
> 
>> I have not yet reviewed the net/can/raw.c part. It will take me more
>> time. I will do it later (we are the first day of the merge window, so
>> that leaves me time!)
> 
> The raw.c changes have become very easy to review since the introduction 
> of the vcid element - no hurry ;-)

Some time has already passed now. Did you find some time to take a look 
at the v4 patch?

https://lore.kernel.org/linux-can/20240108170644.1887-1-socketcan@hartkopp.net/

Best regards,
Oliver

>>
>> Question: do you think this should also go to stable?
>>
> 
> I would have no objections, but I'm not sure whether we can convince the 
> stable maintainers to change the UAPI and slightly extend the ABI in 
> stable kernels? Let's see.
> 
>> More a matter of principle, but you should
>>
>>    #include <asm/byteorder.h>
>>
>> c.f. 
>> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ip.h#L22
> 
> Yes. I already prepared this change for the next patch cycle yesterday:
> 
> https://github.com/hartkopp/canxl-utils/commit/9ac1b75b59ccbf668fec4bd5c846542ad0073da0
> 
>>> @@ -193,26 +193,39 @@ struct canfd_frame {
>>>   #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always 
>>> be set!) */
>>>   #define CANXL_SEC 0x01 /* Simple Extended Content 
>>> (security/segmentation) */
>>>
>>>   /**
>>>    * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame 
>>> structure
>>> - * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
>>> - * @flags: additional flags for CAN XL
>>> - * @sdt:   SDU (service data unit) type
>>> - * @len:   frame payload length in byte (CANXL_MIN_DLEN .. 
>>> CANXL_MAX_DLEN)
>>> - * @af:    acceptance field
>>> - * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
>>> + * @prio:   11 bit arbitration priority with zero'ed CAN_*_FLAG flags
>>
>> Now that prio is a __u16, the CAN_*_FLAG flags fall outside prio width
>> (in __res0 as you mentioned below). So I would rather remove the
>> latter part of this sentence. You may instead specify that bits
>> outside of the CANXL_PRIO_MASK shall be zeroed.
> 
> Right. Will change that.
> 
>>> + * @vcid:   virtual CAN network identifier
>>
>> Maybe say that this field is valid only if enabled through
>> CAN_RAW_XL_VCID_OPTS, else should be zero.
> 
> No. This is a data structure definition and not the CAN_RAW socket 
> documentation. But it has definitely to be mentioned somewhere.
> 
>>> - * @prio shares the same position as @can_id from struct can[fd]_frame.
>>> + * @prio shares the lower 16 bits of @can_id from struct can[fd]_frame.
>>> + * @__res0 holds the @can_id flags CAN_xxx_FLAG and has to be set to 
>>> zero
>>
>> Just realized now, but I would have personally preferred to merge
>> those two sentences within their respective field documentation. Just
>> feels odd to me to have the information on the prio and __res0 field
>> are scattered in two different locations. Well this is just a nitpick,
>> at the end, just choose which one seems good to you.
> 
> Ok. I always tried to get only one line for the element description. But 
> this could be changed. No problem.
> 
>>> +struct can_raw_vcid_options {
>>> +
>>> +       __u8 flags;             /* flags for vcid (filter) behaviour */
>>> +       __u8 tx_vcid;           /* VCID value set into 
>>> canxl_frame.prio */
>>> +       __u8 rx_vcid;           /* VCID value for VCID filter */
>>> +       __u8 rx_vcid_mask;      /* VCID mask for VCID filter */
>>> +
>>
>> Why the newlines before and after the struct members? This style is
>> not consistent with the other CAN headers.
> 
> Ok. Will remove them.
> 
>>>          /* check for correct padding to be able to use the structs 
>>> similarly */
>>>          BUILD_BUG_ON(offsetof(struct can_frame, len) !=
>>>                       offsetof(struct canfd_frame, len) ||
>>> +                    offsetof(struct can_frame, len) !=
>>> +                    offsetof(struct canxl_frame, flags) ||
>>>                       offsetof(struct can_frame, data) !=
>>>                       offsetof(struct canfd_frame, data));
>>
>> Nitpick: I would expect to see the code structured in this order:
>> check Classical CAN first, then CAN-FD and finally CAN-XL. Not sure
>> why the CAN-XL is in the middle. If the only reason is to minimize the
>> patch diff, then no.
> 
> The reason is to check the offset to struct can_frame.len - so all these 
> checks are sorted by the first element to be checked.
> 
> Thanks for the feedback!
> 
> Oliver
> 

