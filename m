Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF430FDF4
	for <lists+linux-can@lfdr.de>; Thu,  4 Feb 2021 21:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhBDUTB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Feb 2021 15:19:01 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:30170 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbhBDUTA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Feb 2021 15:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612469702;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
        Subject:Sender;
        bh=WruN6FW+unoQ+s5sIWUbCA39Xu0NlNViYDemMrOhlx4=;
        b=nXElvc4x+nRaFiwtQyVqypt5qrqusyls1LdlUb3ZKLYSFPv6BiOEHpul7BjO6DRPPP
        5f/SNhGdQeunxvBXT7mdhKgI3uP4TX/y8h72ihvL4F3umb8OzOAVlAQqKjFGPAkwvyXc
        DwZdlAJpPalf4HdXT+/9lyCg1RD3EULtmY5y4JWVZbdKLfxm8vFVyu6am+evr1Fa+mTt
        WDLOBaQD2M6p6s5o4/sQwsqrFJzPO9skvI/G3rUPPuMcETuulKUCClabKrwg1mLCIFHN
        T/K0D8gIYr+SC5hjCIsh2/xvc0QtE21orP+ln4/IO+ooOAQ6Oww03dqU7yZ0cZ+UZUDf
        OY9w==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVch5kkU2"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.17.0 DYNA|AUTH)
        with ESMTPSA id U025c8x14KF109A
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 4 Feb 2021 21:15:01 +0100 (CET)
Subject: Re: correct length of bcm message
To:     Patrick Menschel <menschel.p@posteo.de>,
        linux-can <linux-can@vger.kernel.org>
References: <ff7c731b-6b98-79d7-b652-6ba2fe0afc3c@posteo.de>
 <c859e653-af2b-332c-f3d0-cf2525d1382a@posteo.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d73f45d8-da19-2d09-78ea-318faa98e7aa@hartkopp.net>
Date:   Thu, 4 Feb 2021 21:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c859e653-af2b-332c-f3d0-cf2525d1382a@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Patrick,

On 04.02.21 18:47, Patrick Menschel wrote:
> Am 04.02.21 um 16:38 schrieb Patrick Menschel:
>> Hi,
>>
>> is anyone writing to BCMSocket on the Raspberry Pi from Python3 ?
>>
>> I'm digging through an endianess / alignment issue on armhf platform.
>>
>> My testcode [1] that I wrote years ago on works on X86_64 platform but
>> fails on armhf platform with OSERROR 22 "invalid argument".
> 
> Some more details.
> 
> The length on X86_64 results in 72 bytes which are consumed by bcm.
> 
> On armhf it results in 52 bytes which cause OSError: [Errno 22] Invalid
> argument.
> 
>>
>> Then I started concatenating bytes by hand instead of using ctypes.
>>
>> What I came around is that frames[0] is somehow expected to be 8 bytes
>> length although it should be 16 bytes.

struct can_frames[0] is used in this struct definition to point out, 
that this struct is followed by a number (0..257) struct can_frame's.

This creates a padding at the end of struct bcm_head, so that the struct 
can_frame (which is always 64 bit aligned) can be directly concatenated.

Regards,
Oliver

>>
>> struct bcm_msg_head {
>> ...
>>          struct can_frame frames[0];
>> };
>>
>> I ended up inserting padding 8 bytes instead of frames[0] value and that
>> actually works.
> 
> I have to amend that, it's 4 padding bytes.
> 
> struct.pack("=IIIllllII4xIB3x8s",opcode,flags,count,ival1_sec,ival1_usec,ival2_sec,ival2_usec,can_id,nframes,can_id,can_dlc,data)
>                         ^^ padding bytes
> 
> Sending the resulting 56bytes to bcmsocket gets me a cyclic message on
> armhf.
> 
>>
>> That makes my overall BCMHead 40 bytes and the complete bcm message
>> including the can frame 56bytes.
>>
>> [1] https://github.com/menschel/pysocketcan
>>
> 
> Thanks,
> Patrick
> 
