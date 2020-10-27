Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CFF29AD60
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 14:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbgJ0Ndn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Oct 2020 09:33:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:23015 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440836AbgJ0Ndn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 09:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603805621;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=sUbGqGetIXipFDmzu4UzL6JUV2xJAscm1MSQ5UnSGpQ=;
        b=MebmrMikf3PyLdaVkthzTsg5Ng0FWQpq7/8LdEWp6spsLGaXiCfY8QHYGG0cHoMH+I
        JsCav/ESqgoCSCtzbQ5X1RPCG9Esptb6dAQ4Z+pdQeL42Eqemsl8I+HPZN/8M8Qy22ox
        IuwS8mAgp2V2DcHHnfqI2fkCHo2MNBUuNFIHIfY4TLtfvAFpktkjl8aDZTZR+odKaouP
        gdCg+B4dwTVnurhEfaSZKH7z0GZj9U0nvHtnP0NHlx/2B9TLGi7MvNEr4CRl8Q2Hv1ko
        3HhquJdL4bBFxLHT4839t5fvKF5a4zDPhW4Cy3eFpgmuTH87NEhSQZFoMvny5zm3pB7D
        +gog==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xvyl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.2 SBL|AUTH)
        with ESMTPSA id j075f4w9RDXc33W
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 27 Oct 2020 14:33:38 +0100 (CET)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
 <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
Message-ID: <f36d3351-46d1-3c4c-0e2e-f6c92fea2474@hartkopp.net>
Date:   Tue, 27 Oct 2020 14:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 27.10.20 14:23, Oliver Hartkopp wrote:
> On 27.10.20 14:06, Marc Kleine-Budde wrote:

>>> +    union {
>>> +        /* CAN frame payload length in byte (0 .. CAN_MAX_DLEN)
>>> +         * was previously named can_dlc so we need to carry that
>>> +         * name for legacy support
>>> +         */
>>> +        __u8 len;
>>> +        __u8 can_dlc; /* deprecated */
>>> +    };
>>
>> There was an old compiler version, which struggled with C99 
>> initialized unions
>> within structs.....So this change would break existing source, but I 
>> think that
>> old compilers are long gone (for good).
> 

It looks like we only run into a problem when the elements of the union 
have a different size:

https://stackoverflow.com/questions/11812555/how-to-zero-initialize-an-union

Which is not the case with len and can_dlc (both __u8).

> Good to know. Do you know 'version numbers', so that we may place a 
> warning somewhere?
> 
> I still have a 2.6.28 system here (gcc 2.95) - but I would not know why 
> updating the can-utils there today. Maybe for the cansniffer ;-)
> 
> Btw. when it is only about the initialization of static struct 
> can_frame's, I can also check for these cases in can-utils.
> 
> Best,
> Oliver
