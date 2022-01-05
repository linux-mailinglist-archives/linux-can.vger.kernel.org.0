Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796D9484EC3
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 08:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiAEHgv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 02:36:51 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:15295 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiAEHgv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 02:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641368205;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=mqcfN4VZvfIc+dXM40dAuQlcuNM9mgx/rihU9AHE+ZI=;
    b=EdC+n8NL4DDurJ0BL1fRnL6GTA0+/a9rl7Gtju4ke65wru0PEdjQxGMJoByS7SzYZ5
    Vvng8OYUgDXQ54k92DJ4jg4fHcyQP3aHN6kUyoD38+1rS+NCZmNQS+TOzHkJXwrbZ72Q
    BM6LWUDKfrcejgP503m6FZADt4lINYdWt0xi5dprrbTlXBK1mtX0nzCITOD9s8TmlCkv
    JodBKOv+zcOkk3aXPRnNbXbc0P/Ed80eqyjqezb9Zagr7PbqyltQl6vD1E8uyX9kHGxH
    7IAbcbhecWdikRbfNncj3eYEwHEhjPav+XFJf3lEF5R0RLP1zSvmHeh1rKqYyzmGSyO4
    PkMA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.35.3 AUTH)
    with ESMTPSA id k081c3y057ajyGG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 5 Jan 2022 08:36:45 +0100 (CET)
Subject: Re: can-isotp: TX stmin violations
To:     Patrick Menschel <menschel.p@posteo.de>,
        =?UTF-8?Q?Maik_Allg=c3=b6wer?= <maik@llgoewer.de>
Cc:     linux-can@vger.kernel.org
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
 <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
 <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
 <6175074d-6562-91c9-3dce-22ca99815910@posteo.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <19adffae-443c-78bc-fb8c-61ec792a7b6d@hartkopp.net>
Date:   Wed, 5 Jan 2022 08:36:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6175074d-6562-91c9-3dce-22ca99815910@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04.01.22 22:18, Patrick Menschel wrote:
> Am 04.01.22 um 13:37 schrieb Oliver Hartkopp:
>>> actually spec says *average* gap time should not fall below STMIN.
>>
>> I did not see this average gap recommendation so far.
>>

> 
> the *average* info is from a german translation.
> 
> There is a note at the end of the section where it states that due to
> jitter in networking, *average* st's comply to STmin.

Aah!

In fact the discussion hits a valid point. On the one side you might 
think about a time slotted receive task that might only be able to 
process a frame inside this slot. At least in the 'very early' days of 
CAN transport protocols I've heard about such weird implementations.

On the other side (as we can see from the jitter in Maiks's original 
question) we face different requirements in todays implementations. Here 
an *average* result makes sense. But this is no implementation 
requirement but a testing requirement to relax the STmin timing checks then.

Thanks for the recap!

Best regards,
Oliver

