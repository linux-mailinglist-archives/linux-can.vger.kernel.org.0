Return-Path: <linux-can+bounces-475-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF278B019B
	for <lists+linux-can@lfdr.de>; Wed, 24 Apr 2024 08:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5733E2820BF
	for <lists+linux-can@lfdr.de>; Wed, 24 Apr 2024 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22308156C5B;
	Wed, 24 Apr 2024 06:15:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19C15687B;
	Wed, 24 Apr 2024 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939335; cv=none; b=sJhW8h5I76gt3QiL9nuPGeosFZUvcEZuvObK642TOHSGFM5LFoHayHJGTBxb2eKakgK5qJc43vuvi++2X1gY5+dNuJNkPDPFbEV1gTuJg4shzktiLNcVmcyy3sVpWQ8HlwfloJWb7LCZPm15YLBgdzZel77MBZp58H+zPICsYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939335; c=relaxed/simple;
	bh=vMO+DFILXoyb7iwJpDH8ieiDviQVQ7QOcuN7oO8jlqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3SpX1gJKQmhwiL0Q3MJ7LWSHFJSva/rz34JoMVN95P8feYfK0ch5j+QeRLOg6SLKf3mt5kobkYhqMkzvJV/3OIVjvTFzBX9+YmbtTrNGfT/2/lyiyfPUP0Qjrdw3x7vM0CaQrMamVaG8BWXdKolBcxz1Htp8R6a7TzOnrhu2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-347e635b1fcso5277487f8f.1;
        Tue, 23 Apr 2024 23:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713939332; x=1714544132;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erh0Gt44u9bwypDp6pfR19f30ehxnih0kYMkHEpiiOw=;
        b=snaDlxQi21tLXPRnZuHIzCv+G1yFa/jZyjNsRRmXPK1ctVvHwKi7vlkmuJ15pzz2bt
         yHMt7qWIVQngOkxNZDRhe7he2xndk8WrpJFCZQEu1CvcDhT5eJbJTKBYKrUCBnlSKf6D
         +7omWFsq21sZy7vki7r2GrboTVzwjNmjyzWIQsN/zfoCbHanEuC43AoBYhpSjUKvGfGs
         kwP798q46KsGv/pB2phJugMAtxKFaqwuB3GRVvas3EWEJpBcwSiZOlJ0TmZsCdmyvr0u
         DhqV6shmkzOF06t3OVq0GMYlZOmIU1FKSReYbzGcyErx80Xmh9KmT5GI4hxce7mseGx2
         Ba0g==
X-Forwarded-Encrypted: i=1; AJvYcCUpAcSr9apkstRjNaS8xdfqoFARTcUksH/aQcsjKO3AlnbOmGE8/0mtOUH76tBKyF3ASlLihCTMKw1qFmEzzUJc03Y6ip+mEuAIZ+QunyWDobbgUdq0LLJSj6xyZfcTX2jYO8c+Cscd+++HzTRP5wHjvXJDvc8nmlL8Xkscn3yXS/T8+5CBPvqzHowreCfiUnGPkDhj+Ph3u2u5qARzVLZWwFdXJA7Buz5EfkK21oWANMYFr7wL2KJW
X-Gm-Message-State: AOJu0Yx5yK4MIn4zJQYIA11mV15PJcWnQZik7zhbctxNCG3kPleDV8d6
	B3E/t8uVi4FH6jRegkh+u1ALbxoNDPkiOXj5miBbtrZ4KA8AbcRD
X-Google-Smtp-Source: AGHT+IF1J8Bxr1J7aRMYu4+FjNkjMLEXaizH4EdaleVHAG7lKl3ae1ngmVQcZoyegZXp5GMEc26Oqw==
X-Received: by 2002:a5d:4e03:0:b0:343:af1f:491f with SMTP id p3-20020a5d4e03000000b00343af1f491fmr889773wrt.14.1713939331630;
        Tue, 23 Apr 2024 23:15:31 -0700 (PDT)
Received: from [172.16.1.217] ([80.95.105.245])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm16120882wri.95.2024.04.23.23.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:15:29 -0700 (PDT)
Message-ID: <6337b846-f229-42be-a344-920263d2d927@kernel.org>
Date: Wed, 24 Apr 2024 08:15:27 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] can: Add LIN bus as CAN abstraction
To: christoph.fritz@hexdev.de
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andreas Lauser <andreas.lauser@mercedes-benz.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
 <20240422065114.3185505-2-christoph.fritz@hexdev.de>
 <cf9109ac-f17b-4812-aa50-449b8fb9504e@kernel.org>
 <43a8b0484e5b4e7d550a665aa4f7b37186d030f7.camel@hexdev.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <43a8b0484e5b4e7d550a665aa4f7b37186d030f7.camel@hexdev.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23. 04. 24, 11:33, Christoph Fritz wrote:
>>> --- /dev/null
>>> +++ b/include/net/lin.h
>>> @@ -0,0 +1,97 @@
...
>>> +/* special ID descriptions for LIN */
>>> +#define LIN_ENHANCED_CKSUM_FLAG	0x00000100U
>>> +
>>> +static const unsigned char lin_id_parity_tbl[] = {
>>
>> This ends up in every translation unit you include lin.h into. Bad.
> 
> This is also being used by a serial lin driver. But I guess most of the drivers have no need for this. Mhm, ... any ideas?

If needs be, put it to a .c and keep an extern here.

thanks,
-- 
js
suse labs


