Return-Path: <linux-can+bounces-111-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A548E8263BE
	for <lists+linux-can@lfdr.de>; Sun,  7 Jan 2024 11:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F82823EC
	for <lists+linux-can@lfdr.de>; Sun,  7 Jan 2024 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677FC12B7E;
	Sun,  7 Jan 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QJtWtmwO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EWmixXvk"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875F12B84
	for <linux-can@vger.kernel.org>; Sun,  7 Jan 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1704622871; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Zd8vJuTmniBlvcvppOQBmhSjJEWqKy8xXMlNEbR6INmELB5MxAKxccrvWtS+NlLtDV
    sy2+U0XvAvggoL1H2lBNh04xseyPlcWWn+6/fycb8Kp1pkBXtyavWByjpP165diYy1Vb
    4ODdzDTVKota2JpTcTDHgfkSiQfb7nkrNRR1qQHF4Np26HKm5H2DtjyiI07Xrkm01Qct
    uR9vmUBokJSt1bp0qMDGHrwe6q7SulHu+532c6OFzZJTIg2z3ThA7jPQ/6g2Zn/iecJM
    GpdAvpVG4wVSrukh2S0xbKMGL6WnOcR3qqWGbr7xrHnTVPNiLWDBMl8xppTsKOxLyQMy
    LilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704622871;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oa91potUszGG8wiGAnwzdnjLCamLqUXB6HMtE1SKerU=;
    b=jZl6A3zlP26OMAtnQwFXZOKZrl3Qho+Vr7X5eD/JFrHEoxBKw6Kpk4mlLHu7lW3Whz
    xWEgcAWmK8cBJZ/mqk+fQCIycZ2eCEgq+wFQM6Y1RpOBLc7c5rLdYhz3fjVtSBfn0R81
    MxWhZaApDkt1smaLJi4CLuyQNpmicGSrW+AQ1DGENVC+/goTHpMWVZ+p3apSRuEnednZ
    1lBfVFPh8gndoDhJfu4dc9TuzLHEWbVN5I4u+gWZ6uxTWKxPm/m+GvNolG36VPVLBqNk
    WgDUxVltT0YxTJBWvFfuD8c1GViZVppc6fRUOr3ZYZ42Ho97lvCGSaXYPCW5Mkatsxam
    wAVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704622871;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oa91potUszGG8wiGAnwzdnjLCamLqUXB6HMtE1SKerU=;
    b=QJtWtmwOYJ6ATE1pyITSFg8YXA/nIlkn98P985bmSH1G4Gachhv9w3KViAnFjrrhLb
    oDiy1/r/+a8oE+tceLh0qbxDs3MfH9g25TRugYI6/xpIi3f5K9OwcPyut4QX3jVEGZ9c
    Ohx06iqllea5rePQoNBrKfP7/UQSCo7qHTu4/QXr8zYw089rjFHrs6AjxyfzdQnSB/iR
    d+1BRwkAdgIuxf6pPL9MZJhSkSSW0ZtJJ3cqxAWAREzN4sxystIdkXP5ZNxEyXD1khBv
    juHy5USH2eNy3vZNePHoBAKss6jdhjLKjBpXP0U6wgOs0OWKULV9WD8pk6CkOp/euyw3
    eC+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704622871;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oa91potUszGG8wiGAnwzdnjLCamLqUXB6HMtE1SKerU=;
    b=EWmixXvkA2LzdwjJ8Cm/dbgT3v8kbxPPR8mLxyWgodV4WNZe5/ce2bua70aRCwBko0
    jQs8hrr5fdIw/C1zC7Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0UTfNxrVWG2Lo6Qn47bseovr792l6A=="
Received: from [IPV6:2a00:6020:4a8e:5010:abee:8cd8:5f9d:6194]
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id Kf147a007ALA9ou
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 7 Jan 2024 11:21:10 +0100 (CET)
Message-ID: <3c16cab8-b1ff-4091-9eb3-28c5051309e7@hartkopp.net>
Date: Sun, 7 Jan 2024 11:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] canxl: add virtual CAN network identifier support
Content-Language: en-US
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de
References: <20240106192836.4716-1-socketcan@hartkopp.net>
 <CAMZ6Rq+S7mUWBXQEm2uHTKt31Z5JBj1LK2WNpN7pwujx5DhSzw@mail.gmail.com>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6Rq+S7mUWBXQEm2uHTKt31Z5JBj1LK2WNpN7pwujx5DhSzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

thanks for your review!

On 07.01.24 07:28, Vincent MAILHOL wrote:
> On Sun. 7 Jan. 2024 at 04:47, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>> values can be send, e.g. to replay full qualified CAN XL traffic.
>                  ^^^^
> sent
ACK

>> provided by the CAN_RAW sockets and kernel infrastruture.
>                                               ^^^^^^^^^^^^^
> infrastructure
ACK

>>   struct canxl_frame {
>> -       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>> +       canid_t prio;  /* 11 bit priority for arbitration / 8 bit VCID */
> 
> Isn't this a UAPI breaking change? Prior to this patch, the applications may do:
> 
>    canxl_frame.prio
> 
> to get the prio, but after this patch, applications are required to do:
> 
>    canxl_frame.prio & CANXL_PRIO_MASK
> 

Not really. I also thought about it but you *only* need to take care 
about the VCID content when you have enabled it explicitly with the new 
sockopt. Otherwise you will never see anything beyond the 32 bit prio.

> in order to mask out the VCID (currently, there are no requirements
> that canxl_frame.prio must be masked before use).
> In the past, I was reluctant to acknowledge the introduction of CANXL
> in the kernel prior to reading the ISO standard because I was afraid
> of such UAPI stability issues. Now we have to deal with it.

Yes, but that kind of extension would be backwards compatible.

> What do you think of:
> 
>    struct canxl_frame {
>    #if defined(__LITTLE_ENDIAN)
>            __u16 prio;  /* 11 bit priority for arbitration */
>            __u8 vcid; /* 8 bit VCID */
>            __u8 __reserved; /* must be 0 */
>           /* ... */
>    #elif defined(__BIG_ENDIAN)
>            __u8 __reserved; /* must be 0 */
>            __u8 vcid; /* 8 bit VCID */
>            __u16 prio;  /* 11 bit priority for arbitration */
>    #else
>    #error "Unknown endianness"
>    #endif
>    }
> 
> Here, canxl_frame.prio always gives a correct value without need for
> CANXL_PRIO_MASK masking. The big/little endianness checks are needed
> to maintain the ABI compatibility. Not yet tested, so forgive if there
> is a mistake. Getting the endianness logic correct on a first try is
> not easy.

Yes, I tested such approach too (with little endian only) and it worked 
great - and of course looked better in the code.

> Also, the VCID can now be accessed through canxl_frame.vcid instead of
> relying on some mask and shift logic.

Right. That looked nice.

> The drawback is that you lose the can_id type. For what I understand,
> this is only used for filtering. If we absolutely need to maintain the
> canid_t, then maybe:
> 
>    struct canxl_frame {
>            union {
>                    canid_t filter;
>                    struct {
>    #if defined(__LITTLE_ENDIAN)
>                            __u16 prio;  /* 11 bit priority for arbitration */
>                            __u8 vcid; /* 8 bit VCID */
>                            __u8 __reserved; /* must be 0 */
>    #elif defined(__BIG_ENDIAN)
>                            __u8 __reserved; /* must be 0 */
>                            __u8 vcid; /* 8 bit VCID */
>                            __u16 prio;  /* 11 bit priority for arbitration */
>    #else
>    #error "Unknown endianness"
>    #endif
>                    };
>            };
>           /* ... */
>    }
> 
> But I think it is better to drop it. If someone wants a canid_t, then
> he or she can just cast the XL frame to either struct can_frame or
> struct canfd_frame.
> 
> Though?

My only concern is that it looks really ugly :-/

The change of the prio element from u32 to u16 will also not harm anyone 
as I assume to be the only person who's currently working with CAN XL 
frames on virtual CAN interfaces:

https://github.com/hartkopp?tab=repositories&q=can-cia

I'll prepare a patch that picks up this suggestion of an __u16 prio etc.

Maybe we can add some compile time checks to ensure the correct struct 
layout for this case.

> 
>>          __u8    flags; /* additional flags for CAN XL */
> 
> If CANXL_VCID is set, can vcid be zero? If not, no need for a flag.
> Just need to check if canxl_frame.vcid is not zero.
> 

This is probably indeed a leftover which can be removed with my latest 
implementation. Will recheck.

Many thanks,
Oliver

