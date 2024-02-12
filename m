Return-Path: <linux-can+bounces-231-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BD851F39
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 22:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC7A1F22BB5
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346414CE04;
	Mon, 12 Feb 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lvsI3l+x";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SsSWPyni"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D84CE02
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772157; cv=pass; b=I/7ui79M818R0gB3TpwRlNENxRMYNhZCAfnIu6K1x6ID2boCDoDKUEDYIAgV0jYpegvnEvcbFO2CoaHllviy6kmFOoYQ3+RB2fjliU8eVgkfH0yXWYH/7Kg+6httQjkzSniNpR4PNY6Q64PQ5dGxakAPfcLAY0komr3oxFw3JwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772157; c=relaxed/simple;
	bh=a0PD0qJPDhp0x0gmoexTNh4zQ8JRmX+/VmSgKtRN9Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJlV39AbIfubOaEZCNy9sda+e6iJzV1bar0Qy1HPpwsIQDtl2esfcnpQU3AP1Fj98rQmSMK4pYwWiManJKFkERyrETNzUr9v67pEpKCypQn1mxnsPf5cU8uTQlcQt+CtKiQNSklKL2Lwd3kWNiRMurVqxpD6UiXElNq1rrNXSfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lvsI3l+x; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SsSWPyni; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707771972; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R2aC70L+HxQQVnKnHBrzEyTSFbkDG/epXFysS0RgJ6AIy+H9GeCL4AtaE7pbIU/wLs
    IeoiccWPk1azeOOaQP8Blql+20ngwiTYZJiAEwIdgBq7MC0VLyKDIhjv9HoA2HhTv/ty
    kD/sSutTv/33Oc4sId7GyV5kEgAd3MNhAwfQ2a8oEHhhvolGlPQPK30NXFE/FzXmWEkd
    89sDp9r3DWS5ZpVOh0LAXLVnr7JSw0if9K6fnjNZFMcjemhkAX7pKVqm0zL34A/YtZTS
    eeP7MWPGYueB/8xKYXWvo7qGzZV67GgfbOeZKdQPCJ1zQITvGkF8ri2wnu6CG1B45mDa
    RdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707771972;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=H74lY4ej9nveLnSP2zj4noebJ+LlwsnEqOvScqWumd0=;
    b=TU+8Fpo8UgDn8qfJkzNIXTK7e+0QnsIUW1AJpf6jryqsuBVB7tlgfFO+cGm9DwyS+z
    JePFxkl0i59dPr7y7AR/b79iS8vsTv76b5yL/px43rpbhgp+7uHl8/xRyy73OClVjyp0
    6JNVixRxC/rJP9uP9+32AgjpTL/YZHM3M9r33CmI4sBXKVY57v/prSLbQCvugGn2O3q5
    ZE2vMsu61HKkejfhukiBsYsKa1d2J6Oug7gW1CifkhfW4CsEpqYzUmRXJW6BOiuKq6N9
    4buP4cSdz2qd8QVG8tWRTcRRyLnmm1Kih3xpKnHy2HpQFaSmBBudF8LXV7tpZDLrlQkP
    wU/A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707771972;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=H74lY4ej9nveLnSP2zj4noebJ+LlwsnEqOvScqWumd0=;
    b=lvsI3l+x5Rfi6T34X6sX1xi41JDH/LnfCFu/tnRkZ8Gj9xaZAarNVFec+j4d33BS4l
    bxRH+NlQXXVmGchLnAFJw2mA6q7vfj4FlnhcCmg3z3MJJ/HDrjHutEvkj6o92bV3OwJ7
    8M7BQ8Yt25lv+HZCmYZyD6AyckWloIXnUGz2pY4dxL0s/wPc2d4+thzet1ls9DdvmqGW
    J8vPuDIjakH4lde4YHkwM9rNjx13zopiNtY+24O1KyPp4ua/fSHaCMobU9/tmv2JYisF
    5q0X8K+0xKcCn9LScOi4u9UWzZYLaqQXBFGYQtCPliT7ZpWaEUzin2TO3QaQAPrWFq57
    H+wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707771972;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=H74lY4ej9nveLnSP2zj4noebJ+LlwsnEqOvScqWumd0=;
    b=SsSWPyniqIurLxEF8W9ykhvRXbU7hcXEr4LQNRmPnkGOfQwNhwtvdnS/8ydvlGTdNr
    HdhwRSyQXFAKtyc3DlBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0UTdZN2ev5sXf6MYjxZMlcnNBKrzRQ=="
Received: from [IPV6:2a00:6020:4a8e:5010:c146:e68c:3727:99ca]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01CL6CqA7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Feb 2024 22:06:12 +0100 (CET)
Message-ID: <dec6ca6e-c768-4537-ac56-2cbafac583d4@hartkopp.net>
Date: Mon, 12 Feb 2024 22:06:11 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rework v1] canxl: add virtual CAN network identifier
 support
Content-Language: en-US
To: Guy Harris <gharris@sonic.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <vincent.mailhol@gmail.com>, linux-can@vger.kernel.org
References: <20240212151404.60828-1-socketcan@hartkopp.net>
 <4a3f3605-6a54-4ca0-9581-eff900e6b169@hartkopp.net>
 <94162CA9-1EDC-4DD9-854D-48125819D2E2@sonic.net>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <94162CA9-1EDC-4DD9-854D-48125819D2E2@sonic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Guy,

On 2024-02-12 20:27, Guy Harris wrote:
> On Feb 12, 2024, at 7:26 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
>> I'm currently in discussion with Guy Harris who's working on the Linux-CAN support in Wireshark.
> 
> *AND* in libpcap.  Note that anything done with the metadata headers of SocketCAN packets affects both of them - and any programs *other* than Wireshark that capture on SocketCAN adapters or read pcap or pcapng files with SocketCAN packets.

Right.

>> We current have two approaches how to integrate the VCID into the struct canxl_frame:
>>
>> 1. Add the VCID at a specific 16 bit offset (above the 11 bit Prio ID)
>> 2. Create a endian-dependent data structure with a separate uint8 VCID
>>
>> 1: https://lore.kernel.org/linux-can/20240212151404.60828-1-socketcan@hartkopp.net/
>> 2: https://lore.kernel.org/linux-can/20240128183758.68401-1-socketcan@hartkopp.net/
>>
>> The endian-dependent data structure looks like this:
>>
>> struct canxl_frame {
>> #if defined(__LITTLE_ENDIAN)
>>         __u16 prio;   /* 11 bit priority for arbitration */
>>         __u8  vcid;   /* virtual CAN network identifier */
>>         __u8  __res0; /* reserved / padding must be set to zero */
>> #elif defined(__BIG_ENDIAN)
>>         __u8  __res0; /* reserved / padding must be set to zero */
>>         __u8  vcid;   /* virtual CAN network identifier */
>>         __u16 prio;   /* 11 bit priority for arbitration */
>> #else
>> #error "Unknown endianness"
>> #endif
>>         __u8  flags;  /* additional flags for CAN XL */
>>         __u8  sdt;    /* SDU (service data unit) type */
>>         __u16 len;    /* frame payload length in byte */
>>         __u32 af;     /* acceptance field */
>>         __u8  data[CANXL_MAX_DLEN];
>> };
>>
>> @Guy: Besides the fact that suggestion 2 does not win a design prize I'm not sure whether solution 1 or 2 are better to maintain over lifetime.
> 
> The first question to ask is "which solution breaks less existing source and binary code"?

Although the CAN XL support was introduced in Linux 6.1, there is no 
hardware CAN XL driver available today and only a low 1-digit number of 
developers working on PoC code for CAN CiA protocols on virtual CAN 
interfaces.

We would not break any user space programs BUT the ABI and the socket 
API should be maintained as we can not change the uapi defines down to 
Linux 6.1.

> Currently, the SocketCAN metadata header for CAN XL frames begins with a 4-byte integral-valued field.  I'm not seeing code in the tip of the main branch, in either the git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git repository or the git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git repository, that sets or gets the prio field of the canxl_frame structure, so I'm guessing that the prio field in a canal_frame structure would be in *host* byte order when received or sent.
> 
> Presumably any software that sees that structure would either
> 
> 	1) treat the prio field as containing the priority in the low-order 11 bits and zeroes in the upper 21 bits
> 
> or
> 
> 	2) tread the prio field as containing the priority in the low-order 11 bits and would extract the priority by ANDing the prio field with CANXL_PRIO_MASK.
> 
> At the binary level, code that does 1) would be broken by putting the VCID in that field; the only way not to break it would be to add an additional field for the VCID, but *that* would change the length of the metadata header, which would break, at the binary level, any code that thinks the header is 12 bytes long, so there's nothing you can to to add the VCID without breaking that software, so that code shouldn't be taken into account.
> 
> At the *source* level, code that does 1) would be broken by putting the VCID in the 8 bits above the lower 16 bits, and wouldn't be broken by changing the structure to have the priority in a 16-bit field, with additional 8-bit vcid and reserved fields.
> 
> Code that does 2) would not be broken by *either* solution, at the source or binary level.
> 
> Having that as a 32-bit field named "priority" gives the field a name that doesn't indicate that it also includes the VCID.  Renaming of the field as "priority_vcid" would break source compatibility; adding
> 
> 	#define priority	priority_vcid
> 
> would fix that, at the expense of possibly breaking or, at least, uglifying debugging of code that has a variable or function or structure name or... named "priority".
> 
> Having that as a 16-bit field named "priority", an 8-bit field named "vcid", and an 8-bit reserved field involves, for structure layout compatibility, two different sets of structure members, with byte-order tests at compile time, which is a bit ugly, but does make it clear that one field contains the priority (and 5 reserved bits) and another field contains the VCID.
> 
> *Both* solutions result in the metadata header's first 4 bytes being:
> 
> byte 0: lower 8 bits of the priority;
> byte 1: 5 reserved bits and upper 3 bits of the priority;
> byte 2: VCID
> byte 3: 8 reserved bits
> 
> on little-endian machines and
> 
> byte 0: 8 reserved bits
> byte 1: VCID
> byte 3: 5 reserved bits and upper 3 bits of the priority;
> byte 4: lower 8 bits of the priority
> 
> on big-endian machines, i.e. the layout of the data in memory is the same for *both* structures.

Many thanks for your feedback!!

I finally have a clear view on the requirements and would finally vote 
for this patch that maintains the 32 bit prio element and "shift" the 
vcid at bit position 16:

https://lore.kernel.org/linux-can/20240212151404.60828-1-socketcan@hartkopp.net/

And here are the reasons why:

1. It doesn't break existing code and ABI
    - the applications can use the existing CAN XL frames
    - there is no VCID content visible by default
    - it is intended that applications do not necessarily know the VCID

2. So far there are no CAN XL hardware drivers which are the really 
relevant users of the VCID information

3. The user explicitly has to switch on the CAN_RAW_XL_VCID_OPTS 
sockopt() for CAN_RAW sockets to enable and handle the VCID content

By now the VCID place in the prio is always set to zero which means an 
"untagged" CAN XL frame, which is fine.

So there is a new feature which will likely emerge in Linux 6.9 which is 
not enabled by default and which does not break the existing ABI and code.

When a VCID capable application runs on an older kernel the 
CAN_RAW_XL_VCID_OPTS sockopt() will fail and there will be no VCID 
content. So it is backwards compatible.

And when the sockopt() succeeds, the (new) application knows how to 
handle the prio content.

Best regards,
Oliver


ps. @Marc: I found a small issue in the commit message of the above 
patch as I removed the obsolete CANXL_VCID from an early implementation. 
So I'll send a "rework v2" patch.

