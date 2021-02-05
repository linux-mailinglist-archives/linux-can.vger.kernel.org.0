Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981C9310759
	for <lists+linux-can@lfdr.de>; Fri,  5 Feb 2021 10:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBEJJf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Feb 2021 04:09:35 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:32714 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBEJHQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Feb 2021 04:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612515735;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
        Subject:Sender;
        bh=+2O5Spxqd/9qgoTVNeF7y6the3JZSkF5BJhY46QGDY4=;
        b=UdgXd439oXveSk7IaUqLkAQTfylOHXpJ36dpDPTpqq/s6RZlVKbLoN6d4trt2FXVBd
        YtZ8JXDOCaqiXZHtIseIKvxxy7vhLbI6qc7zMK49SAtoJWvTYtYktKuSGmmEejHhtwp2
        RNTbJGDaPs4jIBMUZA1wCfXsKBcGyBSPlxSRKKPjjat+eBfJLrbsLtSDML776D5CW3PL
        HkjTyuQec+SRDoWdcJw0Cusn1nj8cxWqr1Yi0MXYRWGJKaN+grwP/2vjmjFbmZXo7it3
        DclmvK2L8F02w2wHrIuetZ14SmXwLFXnLHaxGOfbzV3JJzuG9ZuIqqOvYQ4+cFq3n8tX
        vXEw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.17.0 DYNA|AUTH)
        with ESMTPSA id y063a2x1591x0RB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 5 Feb 2021 10:01:59 +0100 (CET)
Subject: Re: correct length of bcm message
To:     Patrick Menschel <menschel.p@posteo.de>,
        linux-can <linux-can@vger.kernel.org>
References: <ff7c731b-6b98-79d7-b652-6ba2fe0afc3c@posteo.de>
 <c859e653-af2b-332c-f3d0-cf2525d1382a@posteo.de>
 <d73f45d8-da19-2d09-78ea-318faa98e7aa@hartkopp.net>
 <b987ec8d-d1a8-34e3-7c8b-4ce0bbd4b30f@posteo.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7f9ffbe7-8926-3874-9261-03e26f711b8d@hartkopp.net>
Date:   Fri, 5 Feb 2021 10:01:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <b987ec8d-d1a8-34e3-7c8b-4ce0bbd4b30f@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 05.02.21 09:27, Patrick Menschel wrote:

> Am 04.02.21 um 21:14 schrieb Oliver Hartkopp:
>> struct can_frames[0] is used in this struct definition to point out,
>> that this struct is followed by a number (0..257) struct can_frame's.
>>
>> This creates a padding at the end of struct bcm_head, so that the struct
>> can_frame (which is always 64 bit aligned) can be directly concatenated.
> 
> so this behavior is caused by this alignment
> 
> struct can_frame {
>      ...
>      __u8    data[8] __attribute__((aligned(8)));
> }
> 
> and walks back upwards to
> 
> nframes (end at 36 bytes)
> ...
> < 4 bytes gap >
> ...
> frames (start at 40 bytes)
> 
> Should the alignment not be defined on structure instead?
> 
> struct can_frame __attribute__((aligned(8))) {
> ...
> }

Hm, the original idea was to be able to access the data[] with a 64 bit 
aligned access, e.g. to initialize the content by a single assignment.

The can_id and the other stuff (len, flags, padding, whatever) before 
the data[] section is intentionally also 64 bit long.

So it should be no difference in functionality.

> Interesting to know, apparently native alignment is 8 on X86_64 linux
> and 4 on armhf linux. That's why it worked on X86_64.
> 
> Regarding python ctypes module, setting _pack_=8 has no remedy effect on
> armhf platform, so I'll move to struct module.

Regards,
Oliver
