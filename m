Return-Path: <linux-can+bounces-4004-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C27B06D71
	for <lists+linux-can@lfdr.de>; Wed, 16 Jul 2025 07:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093933AF957
	for <lists+linux-can@lfdr.de>; Wed, 16 Jul 2025 05:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8702E88B5;
	Wed, 16 Jul 2025 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNJmO0Vo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584022E88AC;
	Wed, 16 Jul 2025 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644714; cv=none; b=ObasxgP+4/00DEGFlDnBFQwqwD8SDFIiFJjbB/plmuEXe0LwaB+2LB3Adn5V7nCcQLDNVYhInE5hCuo7cY3hoRFXyiV81cnWz+V03F1wwSeOCtxPN2XKmeFFe3KW0jApTXiTu/cWRU/xzAIKodv/VXUNIAycil/0wBKJYtGsXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644714; c=relaxed/simple;
	bh=eGdmZ5ZlH53gCPFGCYBewJegI1vbomC/3tBl4QNtNbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+ykEXh8XXQ9V74OYdXq3wGiZunD4ALUxnTLUWjAKzOSXM2jM2rJgL/H53x7gIsP6ftvkfWawghf5hHp3W/t5YKnwPsWiYamnS4zQ44L3tdUaRHbv09dH2lmiKz3pqmqt4DEL4EeaMD9z2FVz4U8acENOwgB6dj5vxy9uMGaT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNJmO0Vo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so9525793a12.0;
        Tue, 15 Jul 2025 22:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752644710; x=1753249510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsFglb7UC5zu8qt+U6fwU5eJBn30GK+9qLadqgQeJ5k=;
        b=FNJmO0VoQSA6e70i3ehANlcn39RM/lej6jt7Uy22LE6f8B+0yv+HXEH4fSRf4wYbog
         3VtqdojVD3Sz9MboPjncioIQGj1vEiE4/NjVaMydQz6QUcUzXqIis6FTWHZy8YhrbGdi
         Bq4OfP9FTxKHmZPPjNzPqf+syaVfA75rz34BECZWJNeOQ5B339rq2q1UgbnkBXQlQWdn
         QXbQbRQAvFUy/F9EO4QvULw6Rzn5/QmBM6QwIOb+FpTpM7EbhnWuO1YajRaG7xOTFKUS
         EgxhKoBPi08jCdl1RseojInZ0/N+QcYAvme7Q4H55BEHwyN88AMe7ETHQTpDICtoVw8J
         tTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752644710; x=1753249510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsFglb7UC5zu8qt+U6fwU5eJBn30GK+9qLadqgQeJ5k=;
        b=VRvs+385GYciSygomnsSHhivpjbxWEk8xKAR2T4e05VczqoBsDDIGtTJEH1HYVFFIj
         tlxCXvb42r4lqWYmn+0fdxkd1lGlCKu2e3xxBD+JPbFl6epDo33WLd0k2MhB0sUNdC9o
         YFFHwnT9G1fDyu3hL0k//9ECZ7mFeOxMiHerpgGpNXSewceHc+3na9CRYxIk2KGrVT52
         ppTFhlZ4W6BvBPhwotYMNQayGkkW2WhDHX2bcMgpk5TfYhU1fAr+9de6hgCGmEfaJMZ3
         Q7axm11MYFuU96F5DZ6zTlDqsfzUJtQ8kA6k4GQRC7ryRqEQrniN1APuqRcQTZ+wzqAm
         IgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUimEL9Bnz4N5+6SESK+t/1m62WDd3bCxoax0dvpQanBefa8KIw8J1ot1LS/reny32vR2r/OaaLsbwFCqqo@vger.kernel.org, AJvYcCUnkH3QrHlW47quMZJRCczlxRGko0Phr7doCW8jkiEmCiIrIAACGafoU1NgrpUo16h1DHXVcwJ+OxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7pJX1pzqpyt0m2dLghZdv+ZYosmh+HQmI9Ys+p4+FlaeWmB1
	MColElIHiz/270KKfQascPJbj1LkCiRwZGP8+lpKeylBcDxIfVKStQh7KEbkoTPC
X-Gm-Gg: ASbGncuJ41dkqm7Ct6ojXdJGurolTDOFUaUPB1A0okeRJZT/r16u2SLBfVMtaLQnJO6
	J4pxEchmwZCjKT33KxZl+4yplZbuCUp4U3ustNmCHfYTwVMRs0jZMJqaiR+IlECmNY/T4HqLpdx
	YCrRIAC5B9L9JD2E5FSCOW8NAOpqsxX4eM0ne5MqzFhzmO72ssr1K21hlEf+CwHCPRENJEAoT/b
	AglIJN2AUb1hZxxQjnysxb59CpvKL+PuSaC7xTOwJhaWrfmCd7J8surndEhFUHlwHIo3ltd7kCY
	3PHFdvkf5oJ2jGZ5Hpl7yYwnvJGlIiqH5He+1yJqnvvDXG+HsNHhlPotJCh5g+042CAYRT+4lJu
	bqpErq1E/wGj0ERB8ZkWWRDJV9YWcpltiVBmDAFJX4+h1GyUJMokbRVHSzQhLT1sKrczNM3vX8b
	IpOgNJ
X-Google-Smtp-Source: AGHT+IHLPZTLnuMNuUUdI1MJK0ukO6DIc9Ucb96DB0s5wllcZ5aFYj53D4KvvbjOVgLPh1ZZH1aBHA==
X-Received: by 2002:a17:907:1c10:b0:ae3:7c8c:351d with SMTP id a640c23a62f3a-ae9ce1acb18mr129050666b.56.1752644710226;
        Tue, 15 Jul 2025 22:45:10 -0700 (PDT)
Received: from [10.196.68.116] (213142096019.public.telering.at. [213.142.96.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e8f9b4sm1135555166b.11.2025.07.15.22.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 22:45:09 -0700 (PDT)
Message-ID: <988d9355-2243-4187-b4ab-78652a1fb008@gmail.com>
Date: Wed, 16 Jul 2025 07:45:08 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
Content-Language: en-GB
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mailhol.vincent@wanadoo.fr, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20250714175520.307467-1-andrey.lalaev@gmail.com>
 <20250715-almond-zebra-of-perception-9d2e6c-mkl@pengutronix.de>
 <b8221fe9-a167-4bcc-81bf-fb793712b48e@gmail.com>
 <20250715-smart-ultra-avocet-d7937a-mkl@pengutronix.de>
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <20250715-smart-ultra-avocet-d7937a-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2025 16:29, Marc Kleine-Budde wrote:
> On 15.07.2025 16:24:22, Andrei Lalaev wrote:
>> I was also surprised because this callback isn't marked as mandatory
>> and that there are no additional checks.
>>
>>>
>>> What about this fix?
>>>
>>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>>> index 13826e8a707b..94603c9eb4aa 100644
>>> --- a/drivers/net/can/dev/netlink.c
>>> +++ b/drivers/net/can/dev/netlink.c
>>> @@ -285,6 +285,12 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>>>          }
>>>  
>>>          if (data[IFLA_CAN_RESTART_MS]) {
>>> +                if (!priv->do_set_mode) {
>>> +                        NL_SET_ERR_MSG(extack,
>>> +                                       "device doesn't support restart from Bus Off");
>>> +                        return -EOPNOTSUPP;
>>> +                }
>>> +
>>>                  /* Do not allow changing restart delay while running */
>>>                  if (dev->flags & IFF_UP)
>>>                          return -EBUSY;
>>> @@ -292,6 +298,12 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>>>          }
>>>  
>>>          if (data[IFLA_CAN_RESTART]) {
>>> +                if (!priv->do_set_mode) {
>>> +                        NL_SET_ERR_MSG(extack,
>>> +                                       "device doesn't support restart from Bus Off");
>>> +                        return -EOPNOTSUPP;
>>> +                }
>>> +
>>>                  /* Do not allow a restart while not running */
>>>                  if (!(dev->flags & IFF_UP))
>>>                          return -EINVAL;
>>
>> Thanks for the patch. As expected, it fixes the kernel OOPS,
>> but the interface never leaves the BUS_OFF state.
> 
> Which device and which firmware are you using?
> 
> The gs_usb/candlelight interface is un(der)defined when it comes to
> bus-off handling.
> 
> I think the original candlelight with the stm32f072 does auto bus-off
> recovery. Not sure about the candlelight on stm32g0b1.
> 
> regards,
> Marc
> 

Sorry, my bad for not mentioning it earlier. I have several USB-CAN adapters:
  - two are based on STM32F072 (not original CandleLight, but using the same FW)
  - one is a original CandleLightFD on STM32G0B1, that I used for testing

And all of them behave exactly as you described:
  - both STM32F072-based automatically recover from BUS_OFF and I see
    it in `ip -details link show can0`
  - STM32G0B1-based doesn't recover and I have to down/up interface to restore it

Since this is expected behavior and no kernel OOPS occurs,
I will switch to your patch.

Thanks a lot for the patch and your help!

-- 
Best regards,
Andrei Lalaev

