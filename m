Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C617C2FAC0B
	for <lists+linux-can@lfdr.de>; Mon, 18 Jan 2021 22:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394475AbhARVBs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jan 2021 16:01:48 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:29535 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394375AbhARVBm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jan 2021 16:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611003521;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=6kNxsqf//4wRgwZV+SrrsXO7curH4XWpPUceW7Id1Bo=;
        b=FFpssivtQKeIeggAn9riMWATt/yGUDqbkFC8fBFWV8eFWaM1BQkZTv2d72MWVQRiFS
        1oX9gnDZZZ9fLMjkvWGROAcbOspbuQPbPzWfwwpGf9lDSOD5KmdFOGhSdH1DvB2ptfju
        FVOlwO4ZPpBCWcYkjiZhjOXRpd8A5hzCfs0alKvpDshRn0nMQGHy0Cw9Va9f+jNKU12N
        ufq8BA1qkLbklJqDrbybH4FjlcDaNrkdRNezSAdGXuS6l5GWUiK4IRUrstrgIJoptPlY
        Hq+c3pU78gOxyF3DPZrahYgXp26VR34jSQpLJuJb4Ol12OHyx1s1lpiGVcwj6KhUbPfg
        H6eA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGX8h6k0QL"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0IKwee6e
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 18 Jan 2021 21:58:40 +0100 (CET)
Subject: Re: [PATCH v3] can: length: can_fd_len2dlc(): make length calculation
 readable again
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
References: <20210118201346.79422-1-socketcan@hartkopp.net>
 <6ef62f6d-c53d-1fe6-7983-3cafc201c516@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <34875dce-5159-1fc5-3ada-25b9b864dd57@hartkopp.net>
Date:   Mon, 18 Jan 2021 21:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6ef62f6d-c53d-1fe6-7983-3cafc201c516@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 18.01.21 21:16, Marc Kleine-Budde wrote:
> On 1/18/21 9:13 PM, Oliver Hartkopp wrote:
>> In commit 652562e5ff06 ("can: length: can_fd_len2dlc(): simplify length
>> calculcation") the readability of the code degraded and became more error
>> prone. To counteract this, partially convert that patch and replace open coded
>> values (of the original code) with proper defines.
>> Also double check the correct length mapping table size at build time.
>>
>> Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
>> Fixes: 652562e5ff06 ("can: length: can_fd_len2dlc(): simplify length calculcation")
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/length.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
>> index d35c4e82314d..d085cb26d00d 100644
>> --- a/drivers/net/can/dev/length.c
>> +++ b/drivers/net/can/dev/length.c
>> @@ -25,16 +25,21 @@ static const u8 len2dlc[] = {
>>   	11, 11, 11, 11,			/* 17 - 20 */
>>   	12, 12, 12, 12,			/* 21 - 24 */
>>   	13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
>>   	14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
>>   	14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
>> +	15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
>> +	15, 15, 15, 15, 15, 15, 15, 15	/* 57 - 64 */
>>   };
>>   
>>   /* map the sanitized data length to an appropriate data length code */
>>   u8 can_fd_len2dlc(u8 len)
>>   {
>> -	if (len >= ARRAY_SIZE(len2dlc))
>> +	/* check for length mapping table size at build time */
>> +	BUILD_BUG_ON(ARRAY_SIZE(len2dlc) < CANFD_MAX_DLEN + 1);
>                                          ^^^
> What about "!="?

"<" makes sure that the table is long enough
"!=" makes sure it has a specific length

So "<" looks easier to understand to me.

¯\_(ツ)_/¯

Regards,
Oliver
