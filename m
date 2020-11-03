Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A461B2A4F04
	for <lists+linux-can@lfdr.de>; Tue,  3 Nov 2020 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKCSiS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Nov 2020 13:38:18 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:10725 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSiS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 13:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604428696;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JWlyJV6jTygayB2NK22+/r7E4o1Dnj7XD9HEDXQjiWU=;
        b=IDT+kttTT02jRcqKxtIG9KGkRNYPEvIZ7KxnWuVJ6Q/Z+Ayy4UCdgYua3a9fMOnUZK
        wpVs3qZ6QdzcwR/alsy+beqHTN2K8B9ZrPtQfFETIiJvQ9vYU8xINECGBAbyZOzqBq5+
        UiknqW/+Za4B/AEV3lqsXHYcOn864alG9pGt0qGM0TbkUmtuNck7EbO8zgsxBbnV92j3
        I84jFEl71v+FVR0UwWk119jzrviuBDebrjLh9rEDcamsZZVn83sxQGl8fpmBbusttof9
        HB93d2npyc+UrpY/oxqsTuAJ17FnzpkAgCxqIasGqlYu2LI2JJJ4ILh8NINY6ih9Lmgt
        DUCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT57T0lTwqN2w="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA3IcCGOh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 3 Nov 2020 19:38:12 +0100 (CET)
Subject: Re: [PATCH] cangen: allow DLC > 8 in increment generation mode if -8
 option is given
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
References: <20201103165130.1907-1-mailhol.vincent@wanadoo.fr>
 <b339bb62-3835-81c3-ff91-fda124bbb549@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <17220721-19c8-058d-eaae-888feb0a4ca3@hartkopp.net>
Date:   Tue, 3 Nov 2020 19:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b339bb62-3835-81c3-ff91-fda124bbb549@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 03.11.20 18:01, Marc Kleine-Budde wrote:
> On 11/3/20 5:51 PM, Vincent Mailhol wrote:
>> Currently, the -8 option allows DLCs greater than 8 in mix mode only.
>>
>> Add the option to also generate such DLCs in increment
>> mode. e.g.: 'cangen -8 -Li can0'
>>
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>>   cangen.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/cangen.c b/cangen.c
>> index 5c86f26..06a1931 100644
>> --- a/cangen.c
>> +++ b/cangen.c
>> @@ -171,7 +171,7 @@ int main(int argc, char **argv)
>>   	struct pollfd fds;
>>   
>>   	struct sockaddr_can addr;
>> -	static struct canfd_frame frame;
>> +	static struct canfd_frame frame = { 0 };

I've omitted this change as a static variable is initialized with zero 
by default.

>>   	struct can_frame *ccf = (struct can_frame *)&frame;
>>   	int nbytes;
>>   	int i;
>> @@ -386,7 +386,6 @@ int main(int argc, char **argv)
>>   
>>   	while (running) {
>>   		frame.flags = 0;
>> -		ccf->len8_dlc = 0;
>>   
>>   		if (count && (--count == 0))
>>   			running = 0;
>> @@ -428,7 +427,8 @@ int main(int argc, char **argv)
>>   						ccf->len8_dlc = frame.len;
>>   
>>   					frame.len = 8; /* for about 50% of the frames */
>> -				}
>> +				} else
>> +					ccf->len8_dlc = 0;
> 
> nitpick:
> 
> please use { } on the else side, too
> 

Added the {}'s and committed the patch on 
https://github.com/hartkopp/can-utils.

Also added some stuff to support 'fixed' raw DLC values in combination 
with the '-8' option.

Thanks,
Oliver

>>   			}
>>   		}
>>   
>> @@ -507,12 +507,20 @@ resend:
>>   		if (dlc_mode == MODE_INCREMENT) {
>>   
>>   			incdlc++;
>> +			incdlc %= CAN_MAX_RAW_DLC + 1;
>>   
>> -			if (canfd && !mix) {
>> -				incdlc &= 0xF;
>> +			if (canfd && !mix)
>>   				frame.len = can_dlc2len(incdlc);
>> +			else if (len8_dlc) {
>> +				if (incdlc > CAN_MAX_DLEN) {
>> +					frame.len = CAN_MAX_DLEN;
>> +					ccf->len8_dlc = incdlc;
>> +				} else {
>> +					frame.len = incdlc;
>> +					ccf->len8_dlc = 0;
>> +				}
>>   			} else {
>> -				incdlc %= 9;
>> +				incdlc %= CAN_MAX_DLEN + 1;
>>   				frame.len = incdlc;
>>   			}
>>   		}
>>
> 
> Marc
> 
