Return-Path: <linux-can+bounces-1957-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F19C4172
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 16:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3FECB22F9B
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1881A08DF;
	Mon, 11 Nov 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qyx86sdC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F91BC58
	for <linux-can@vger.kernel.org>; Mon, 11 Nov 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337422; cv=none; b=Xg8P6wk2gy0w+sma03OHUg+ESG30trRSJylGdy6VVX50s59l+cJ5SoRmZSPt2wmfeggPiBEbOggm+9fzIquTehiff09/vJGozFWurlDnOC5WSjD+Cq2hrg0b1orQqLtu7gBmdD06zcQY6LjlobFZn1V3jW298kSItLVJnmEuX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337422; c=relaxed/simple;
	bh=JkRX2B4UeaVLNLBNucoi7/eZO+bxQoKH6hvY//x8l38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g98EOlTNCnvLGj7ub02h9mUlSDw/BKwVLRr3gRu4EuSScjggB6Ri1xEioyPZM77ooPOlUQGHeuMSIj1+fvmmP0ScvSMaJbGY456kdQnTBoXCeiI3iPX4I2MER5dSuTVkQk2rkd/0icwn96acJkW6N+B4tdlsXuGXk41U0daElao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qyx86sdC; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id AVwutNhCCl0HrAVwvtRtlp; Mon, 11 Nov 2024 16:03:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731337411;
	bh=bdgTqkBy2jzszH+dWeFzlDCpw25QSahlUzYjOUZx1xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qyx86sdC1vwcKymK1wmVLNazRi//0CgZfQMqEA5Z/k5+GgcbjaPyjy15sqBHVmxHs
	 e/fR0gn132FSJxCd7knl4aAXSZbNzou0KmasB8cTlm2dtoSTnvzY2ye9Wyf1H00SDV
	 Wnk/iTs7s2QsaTeAK5IzMkSG/6AEwJ2z7MMyAGs/CTi9TTheFKGYkrrGSmFE4GSvYx
	 w1EMh5dSvSR6pCKoBGLUCVnqHoZ2ECF9VkiZJSe6rV21IWk/acjdNvJ21ozz6AQkNU
	 T70quH3qRjzYVfoOQmmEDASn+iN9nybFZptIGperR/xFyLOTqX073hSh8WF2Ibck4X
	 LaVOQ0NwZ/TgA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Nov 2024 16:03:31 +0100
X-ME-IP: 124.33.176.97
Message-ID: <8ea3c2b2-7b8b-4532-9c72-7ed12813038c@wanadoo.fr>
Date: Tue, 12 Nov 2024 00:03:27 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] iplink_can: add CAN XL
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Nawrath <mbro1689@gmail.com>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
 <20241110160406.73584-18-mailhol.vincent@wanadoo.fr>
 <ff161f8d-6302-47b1-984d-8964eb75fc9f@hartkopp.net>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <ff161f8d-6302-47b1-984d-8964eb75fc9f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2024 at 23:13, Oliver Hartkopp wrote:
> On 10.11.24 17:01, Vincent Mailhol wrote:
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>>   ip/iplink_can.c | 209 +++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 196 insertions(+), 13 deletions(-)
>>
>> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
>> index 54acc65c..43018c54 100644
>> --- a/ip/iplink_can.c
>> +++ b/ip/iplink_can.c
>> @@ -26,6 +26,10 @@ static void print_usage(FILE *f)
>>           "\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n \t  
>> dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
>>           "\t[ tdcv TDCV tdco TDCO tdcf TDCF ]\n"
>>           "\n"
>> +        "\t[ xl-dbitrate BITRATE [ xl-dsample-point SAMPLE-POINT] ] 
>> |\n"
>> +        "\t[ xl-dtq TQ xl-dprop-seg PROP_SEG xl-dphase-seg1 
>> PHASE-SEG1\n \t  xl-dphase-seg2 PHASE-SEG2 [ xl-dsjw SJW ] ]\n"
>> +        "\t[ xl-tdcv TDCV xl-tdco TDCO xl-tdcf TDCF ]\n"
>
> s/xl-d/x/ ?
>
> xsample-point seems more handy than xl-dsample-point

Makes sense. Then, what about:

   sed -i "s/xl-d/x/g;s/xl-/x/g" ip/iplink_can.c

This will give:

   - xbitrate, xtq, xprop-seg, xphase-seg2, xsjw
   - xtdc-mode, xtdcv, xtdco, xtdcf

Note that the above sed command is fully functional. I already staged it 
in my local repo, works fine. I will not send a new series just for this 
one. Instead, you can just try the sed command and tell me what you think!

Vincent Mailhol


