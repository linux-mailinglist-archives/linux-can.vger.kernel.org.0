Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6173B3126A6
	for <lists+linux-can@lfdr.de>; Sun,  7 Feb 2021 19:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhBGS1S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 7 Feb 2021 13:27:18 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:19906 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGS1R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 7 Feb 2021 13:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612722203;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
        Subject:Sender;
        bh=hnbcsvjB0aAzoi2XylNmKq2AMKPQaxSezQL2SYddjEU=;
        b=aPiJC8l6DPrPb2UZiBMI8pc+em+efCbF7B7U7xtMGSC1FWw7kc+Zayf5MVe7x/ZRTR
        OZuPHwPEaeb6IhjlIsjNes8xUB5VQ4yjrILMNdB1AiW90wC92ff9Wb0/hNyqLh2hViRB
        m4//mf2LBntdKdKg8JJbQzuHYJZD5mnErjc3Ced1ToojscMCE5571fm1WhTjDsh3YpaI
        QjoUXihs4Qw/tkMQRqPgMR18xJrAoNJAwdD+jrVKS5ZORXPfv5kEAU8WvT9fcjZlbQfC
        dHAqMrSQK76pAyMZRCpDJT4dIIYACIBrTN0xhOSxKu+Kmf4+YK6DgVMZJF3fdelJiGwv
        TJcw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGUch5mUj/"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.17.1 DYNA|AUTH)
        with ESMTPSA id R0883bx17INM0G4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 7 Feb 2021 19:23:22 +0100 (CET)
Subject: Re: correct length of bcm message
To:     Patrick Menschel <menschel.p@posteo.de>,
        linux-can <linux-can@vger.kernel.org>
References: <ff7c731b-6b98-79d7-b652-6ba2fe0afc3c@posteo.de>
 <c859e653-af2b-332c-f3d0-cf2525d1382a@posteo.de>
 <d73f45d8-da19-2d09-78ea-318faa98e7aa@hartkopp.net>
 <b987ec8d-d1a8-34e3-7c8b-4ce0bbd4b30f@posteo.de>
 <7f9ffbe7-8926-3874-9261-03e26f711b8d@hartkopp.net>
 <f0b2d6de-9254-be02-abd6-0373834b574b@posteo.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ea71b986-7826-0566-44e6-703cbd76e49a@hartkopp.net>
Date:   Sun, 7 Feb 2021 19:23:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <f0b2d6de-9254-be02-abd6-0373834b574b@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 07.02.21 07:33, Patrick Menschel wrote:
>>> Interesting to know, apparently native alignment is 8 on X86_64 linux
>>> and 4 on armhf linux. That's why it worked on X86_64.
>>>
>>> Regarding python ctypes module, setting _pack_=8 has no remedy effect on
>>> armhf platform, so I'll move to struct module.
> 
> Hi,
> 
> tying some loose ends here.
> My final solution to force alignment after bcm_msg_head to the next 8
> byte boundary in python3 is to use an alignment hack of struct module.
> https://docs.python.org/3/library/struct.html#struct-examples
> 
> struct.pack("IIIllllII0q",opcode,flags,count,ival1_sec,ival1_usec,ival2_sec,ival2_usec,can_id,nframes)
> 
> The "0q" is a zero length long long which causes padding up to the next
> 8 byte boundary.

Excellent! Exactly what is needed here.

Thanks,
Oliver

> This works for ARMHF (40 bytes) and X86_64 (72 bytes).
> 
> Regards,
> Patrick
> 
