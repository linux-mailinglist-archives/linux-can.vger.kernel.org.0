Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B080F2DB17A
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 17:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgLOQcu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 11:32:50 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:15206 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbgLOQcp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 11:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608049732;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=UW+zVhmWc2fTvPOcQT80SXN4jU6Kiv8vcy7TEe7PDBM=;
        b=GQdd9b3kU55c5M+kudCZxRJX0hEssTAArm1Ee74vtUmZ48i60c3V7o4c3f+p5TxLJF
        KiTCa3XU/OPleiEZT4DqZ0pb0q864CWH1W2qZd8icSpViQnCt6PfdOA56nupw+GH2DEy
        5vVs72PpXuY8CBPLmeWkjgrWL+hAYXag/RTsNAWXvcAi6HLG2Vq6itxRK6tO93dLKctg
        j33c+jmHTQ6SppdXz4sOaY+cW+PRDVkDmfZi5h3Xeln1cZgw12sOJp2mn4epXTjcc/mc
        4O2Yx1UB2vWf2A00LVdlwNwYsAy6gQPyYwkiIJnphEMRh/saYbWVlJDGyqIoZZflE1sM
        342A==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.8.3 SBL|AUTH)
        with ESMTPSA id d0af4dwBFGSo5Cj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 15 Dec 2020 17:28:50 +0100 (CET)
Subject: Re: [PATCH 1/2] can: dev: add can_len2dll_len()
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <20201215125549.540918-1-mkl@pengutronix.de>
 <CAMZ6Rq+0oreKdMLTS-U0L+6PBTyXHVikk=jT5+9n7H7pAG4Z+Q@mail.gmail.com>
 <f187798d-8145-f1d7-5e4a-b5fcf7c4c110@pengutronix.de>
 <da843e0e-c1b1-691d-1da2-1b65b90812ec@hartkopp.net>
 <4a659d33-17a8-f305-9469-e81a1a109936@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f510fbcb-deff-447d-1fd5-e6cdf78340dd@hartkopp.net>
Date:   Tue, 15 Dec 2020 17:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <4a659d33-17a8-f305-9469-e81a1a109936@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15.12.20 16:05, Marc Kleine-Budde wrote:
> On 12/15/20 3:51 PM, Oliver Hartkopp wrote:
>>>>> +static const u8 len2dll_len[] = {
>>>>> +       0, 1, 2, 3, 4, 5, 6, 7, 8,      /* 0 - 8 */
>>>>> +       12, 12, 12, 12,                 /* 9 - 12 */
>>>>> +       16, 16, 16, 16,                 /* 13 - 16 */
>>>>> +       20, 20, 20, 20,                 /* 17 - 20 */
>>>>> +       24, 24, 24, 24,                 /* 21 - 24 */
>>>>> +       32, 32, 32, 32, 32, 32, 32, 32, /* 25 - 32 */
>>>>> +       40, 40, 40, 40, 40, 40, 40, 40, /* 33 - 40 */
>>>>> +       48, 48, 48, 48, 48, 48, 48, 48  /* 41 - 48 */
>>>>> +};
>>>>
>>>> I totally misunderstood what you wanted to do in my previous
>>>> email. I thought that the numbers were placeholders and that
>>>> the final goal was to take into account the CRC as you previously
>>>> mentioned in your first email.
>>>
>>> Sorry, should have been clearer about functionality of that table/function.
>>>
>>>> This function is just here to sanitize the data length, right?
>>>> Then we could simply name it can_fd_sanitize_len().
>>>
>>> sanitized_len sounds good.
>>
>> Yes and once you are a it:
>>
>> Won't it make more sense to use
>>
>> return can_fd_dlc2len(can_fd_len2dlc(len));
> 
> I'm using that construct in the mcp251xfd driver, too. Will remove the table....

I'm not really sure whether it's more efficient to have multiple tables 
or more code and testing ...

>> instead of creating a new table telling the same as the existing static
>> const u8 len2dlc[] table?
> 
> Can we get rid of the pad table in ISOTP aswell? :)

Ah, that one is a bit different (see the first line).

Nice try :-D

Oliver
