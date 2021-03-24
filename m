Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38734742A
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 10:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhCXJJr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Mar 2021 05:09:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:17853 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhCXJJj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 05:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616576968; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CC+5+aJlJAJnVyKCI6mMkDaMcTxAy65zRZr/j9UzEa9gQ3DRkXlIHBTFT+jqfXlvCN
    nbIpt7ztdPVW7YMJfWTnetOoETFoakxzkMRaeKeaitlCjYjclhftTt+yNFDKLrrpNEdn
    gL167ZQuUPCvqPCHqTu3I7GNHnqI01gkHmQF+nbPv+I7rY00hEj+4l7AmYZeISQirU4h
    b/hdH50rr3E9ea4MRasySCoxX3mMvZo6gZ0sA//nAZNRWgG2snkEuAS+0kXEcxugbGLU
    6orW0T2uoLqAPbjtK6bDnlCEDNhhnhtmEUgM0C448p9yjl+IbZO0VAmL9Z3ZZhsCc4Lm
    Y8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616576968;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=yB/8Uhnzd1/xooMgfdD4Et3/1vkehg7i7SNI6qXYDhc=;
    b=tKH20ZL9I16xXn1tDs7qzPIJlTkqqpwrJB35PWXeHkVHXYaDrOn3+W3XIz22xv1b+j
    81xkNo0kJlwnJi6OIsiHZI2hNx+S/aZZHdGUW8F6otLg6Jvv1n1zRNyMo4XlFvQPfBMT
    jE9XdQAJ52CdkZSRQFGhg+OUbFUFH6LpgOzHxmQDJLbWtvx3CKo3lFlHuB+ADT6ry1lR
    hMU5zEZgc421Ksrqs9rY41ABCB08Cuqh7Smuk/6YAFWemCrbuizOosyoo44D8seAUdzA
    xbzm+Zk68hvVYpYVJs2wTLG8Byh6gBzANrZQsNh9FJbM+/ITcIF4JOmj8vgY3JZDqfdk
    AGfw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616576968;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=yB/8Uhnzd1/xooMgfdD4Et3/1vkehg7i7SNI6qXYDhc=;
    b=rjX7LRkvMok6xwjUKPA0c0kTeekOY/xoiWWgQx5mDSjqkEBg5jFB596MYYZ5ma7EdY
    pun7SV41n1m3l+rOBEhfn+NWKy94jJYCb1rD+IqXmJXFu6MSRpiy2pLRmq2C4GFMOuAt
    vKr7oT82o4azB3HBIAhHYtrBkpi//noZVB6Ify9wwBwUD1/y/HWJ6/AEJDFThOrWllD7
    rj9ff5f19Q4TPMQyYkfPELDNs9RpOLc6QI0lPazUItNBGHRsN6joU3pRfQZaCTfXY1AB
    ltNHtCgaeJ5pLttA/N2+UkQKMfBFBVOIrVMtnZ/YXDWQFBXgmNLDdAPHKPDA//GKsiLj
    2bHA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id L00b52x2O99R00P
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 24 Mar 2021 10:09:27 +0100 (CET)
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rong Chen <rong.a.chen@intel.com>,
        Patrick Menschel <menschel.p@posteo.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
 <a5599800-53f4-c53f-abcc-e166ea9028b9@rasmusvillemoes.dk>
 <080d9e5c-fe1f-4a64-2938-8ca6d8a98d78@hartkopp.net>
 <0a8e8e95-c1a2-ede6-9f87-1ab7a0a155e3@rasmusvillemoes.dk>
 <212c8bc3-89f9-9c33-ed1b-b50ac04e7532@hartkopp.net>
 <1a6dd272-8bc2-57dc-5592-47a08493193a@rasmusvillemoes.dk>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <2c82ec23-3551-61b5-1bd8-178c3407ee83@hartkopp.net>
Date:   Wed, 24 Mar 2021 10:09:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1a6dd272-8bc2-57dc-5592-47a08493193a@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 23.03.21 21:54, Rasmus Villemoes wrote:
> On 23/03/2021 19.59, Oliver Hartkopp wrote:
>>
>>
>> On 23.03.21 15:00, Rasmus Villemoes wrote:
> 
>>> Now what CONFIG_* knobs are responsible for putting -mabi=apcs-gnu in
>>> CFLAGS is left as an exercise for the reader. Regardless, it is not a
>>> bug in the compiler. The error is the assumption that this language
>>>
>>> "Aggregates and Unions
>>>
>>> Structures and unions assume the alignment of their most strictly
>>> aligned component.
>>
>> (parse error in sentence)
> 
> It was a direct quote, but I can try to paraphrase with an example. If
> you have a struct foo { T1 m1; T2 m2; T3 m3; }, then alignof(struct foo)
> = max(alignof(T1), alignof(T2), alignof(T3)). Same for a "union foo".
> 
> But this is specifically for x86-64; for (some flavors of) ARM, other
> rules apply - namely, alignof(T) is 4 unless T is char or short (or
> (un)signed variants), ignoring bitfields which have their own rules.
> Note that while
> 
> union u {char a; char b;}
> 
> has alignment 4 on ARM and 1 on x86-64, other types are less strictly
> aligned on ARM; e.g. s64 aka long long is 8-byte aligned on x86-64 but
> (still) just 4-byte aligned on ARM. And again, this is just for specific
> -mabi= options.
> 
>>> Each member is assigned to the lowest available offset with the
>>> appropriate
>>> alignment. The size of any object is always a multiple of the object‘s
>>> alignment."
>>>
>>> from the x86-64 ABI applies on all other architectures/ABIs.
>>>
>>>> I'm not a compiler expert but this does not seem to be consistent.
>>>>
>>>> Especially as we only have byte sizes (inside and outside of the union)
>>>> and "A field with a char type is aligned to the next available byte."
>>>
>>> Yes, and that's exactly what you got before the anon union was
>>> introduced.
>>
>> Before(!) the union there is nothing to pad.
> 
> Just to be clear, my "before" was in the temporal sense, i.e. "prior to
> commit ea7800565a128", all the u8s in struct can_frame were placed one
> after the other. But after that commit, struct can_frame has a new
> member replacing can_dlc which happens to occupy 4 bytes (for some
> ABIs), pushing the subsequent members __pad, __res0 and len8_dlc
> (formerly known as __res1) ahead.
> 
>>>> The union is indeed aligned to the word boundary - but the following
>>>> byte is not aligned to the next available byte.
>>>
>>> Yes it is, because the union occupies 4 bytes. The first byte is shared
>>> by the two char members, the remaining three bytes are padding.
>>
>> But why is the union 4 bytes long here and adds a padding of three bytes
>> at the end?
> 
> Essentially, because arrays. It's true for _any_ type T that sizeof(T)
> must be a multiple of alignof(T). Take an array "T x[9]". If x[0] is
> 4-byte aligned, then in order for x[1] to be 4-byte aligned as well,
> x[0] must occupy a multiple of 4 bytes.
> 
> It doesn't matter at all that this happens to be an anonymous union.
> Layout-wise, you could as well have a definition
> 
> union uuu { __u8 len; __u8 can_dlc; }
> 
> and made struct can_frame
> 
> struct can_frame {
>     canid_t can_id;
>     union uuu u;
>     __u8 __pad;
>     ...
> };
> 
> (you lose the anonymity trick so you'd have to do frame->u.can_dlc
> instead of just frame->can_dlc). You have a member with alignof()==4 and
>   sizeof()==4; that sizeof() cannot magically become 1 just because that
> particular instance of the type is not part of an array. Imagine what
> would happen if the compiler pulled subsequent char members into
> trailing padding of a previous compound member. E.g. consider
> 
> struct a { int x; char y; } // alignof==4, sizeof==8, offsetof(y)==4
> struct b { struct a a; char z; }
> 
> If I have a "struct b *b", I'm allowed to do "&b->a" and get a "pointer
> to struct a". Then I can do memset(&b->a, 0, sizeof(struct a)). Clearly,
> z must not have been placed inside the trailing padding of struct a.
> 
> Rasmus
> 

Thanks Rasmus!

@Marc: Looks like we can not get around the __packed() fix :-(

At least we now have some more documentation to be referenced and I 
would suggest to point out that some compilers handle the union 
alignment like this.

To make clear in the comments what we are suppressing here any why.

Many thanks,
Oliver
