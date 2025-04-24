Return-Path: <linux-can+bounces-3473-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA8A9B012
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 16:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242817A2FCE
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596C15B0EC;
	Thu, 24 Apr 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgM7+aJi"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A6130E58
	for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503384; cv=none; b=W9GO2buQVwSg0aRx09uE3VjkOHqCM3wE94JaT96/T17cL6xSBYQDKdBMce9yCoVCqKt5cZe/shSLB/yYi5viie0ETC6JO08q3vtL4xbNj6crGISmY2M+8AHPfoGjblFC31NBl/JVao7CJQSm/dvnhoE/2QmJ4BotvZdCOXphSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503384; c=relaxed/simple;
	bh=zwdZgqdDKmE3Viq+cnCSXsknPD78NVVb7eQv3Kk0QXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOQ/KqYtrtXIfd132rZXSRVZWRuy9naqUAVKXRXwxwb5FRvymBGU6k2u6nE8OJ4pBhQ4s18X93lL188UX/y0+1XAaxUszAQKLgpN/TmlfAYsjxb5objRMdSNWQjmNE97vXbRgA57gUHDkzchEpmqIjXycPCsX7/aKlW3GTZU4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgM7+aJi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745503381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Aaw3Dx4UhHqcEGsD63cd3h5ILZfjEGKNvg/X0u8iQ8=;
	b=cgM7+aJixYpMbL8LuCQvRJhJV+kA4fXSaFgxopS+wQir5q/4cYlmZaZ/eAvVxdsBLPbq5S
	QoNrIiTqJIcZV4Y8BPmH+AoASih2wNsf64BPOahSRYTK3w5UCIHTHXIOvtjD2h7BKBkHIH
	GxJFRdmwmRSvUUezcX+msBnEOCA1QkI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-KpQVPCzEP_mc6MeS5yIHdw-1; Thu, 24 Apr 2025 10:02:25 -0400
X-MC-Unique: KpQVPCzEP_mc6MeS5yIHdw-1
X-Mimecast-MFC-AGG-ID: KpQVPCzEP_mc6MeS5yIHdw_1745503344
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39c184b20a2so409451f8f.1
        for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 07:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503344; x=1746108144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Aaw3Dx4UhHqcEGsD63cd3h5ILZfjEGKNvg/X0u8iQ8=;
        b=Du8emTMHpcZ9XFrHUnw7fcs3gQI9grJPN+npMZVVnpxVwiTa5ZlziiPLlOkwTG4dXj
         KzLapN8ZEoXw6xxDrmzeURZ7XEt1WayeeJIVxKxdNmH5XIYeDMoyAryySv/bBjXYJJZo
         8QGLOs/Ieu7HVCKopWRkIhxYM85xeyGsCtq/qKCsFFfp40TbT00z9zNWDltRmyf2d3x7
         QVbzqyFLJBlXVvZ950imdG2sJxAHvZg9O40mgnmJO9FpEYsfCHZymu1j2LzylmHt1cXA
         n34mMBhHAgXj+S7Pk2QYp8J/DORvbWwctU50RIzylIpnvLPRdfRvWRz+SR07PyyWa5h8
         I6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUcerWpY3qIdvam6b53Gfpjgv0fL3bLCWrANRRx1u10pWgYo404oAACjsnd27KXK+CZOb7TbkuNQ5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyun52F273MjUkiEDSAskwOvoe5iYkAOlDWsQKndjIupryq0Flh
	3tdhD6Cz/oHk3FffYLCQRSSJ1HWNUVsUYuxLkjCC5m3wHgxCWZ085t7CUOQmhlzwjmiBzaY54Pb
	DS/LRkw/HWsKj0SdwilGxoM6IH8gTWpkhmGSqN84Q7DVucC1vRPHhGeoAzQ==
X-Gm-Gg: ASbGnctAmz+ch4iOZHliEG0hkAe8jHTntZ1mGOTu52QSx31EdGHutPB/6rrhqQ3L/FO
	ehYSgh4iRnjGuiqjuGhPjrE/X6+mCC79B4TTJnJa2Mk5wjuAV27gm22yXRw6+zNuCXya49x0lHJ
	vknPQL4h11OofAqDWDxq6odbINjMokYyxa3lVRxVcyRED32lJlo8NOVF1i4OqAWtZTtYdcweHZe
	I534QUA4DbbwyW/9RZkc5TRScpTw8TgE3xaaR6v4CwWhFTcHk3CH0GFJorrHSDkeV88BdIQj4Ys
	IQt3SIHeH6G5BHuCehpbMBqpmJHlP3V6mABjiu3Z3MzX
X-Received: by 2002:a05:6000:401f:b0:392:c64:9aef with SMTP id ffacd0b85a97d-3a06cf5c4cemr2510558f8f.20.1745503342827;
        Thu, 24 Apr 2025 07:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMmdHuRh26hxX1NOR2DOUw8CVhfW7e812bb/UgYtY/gXRNn/UEXH5+zfXwRwtCYWQHMcC6TA==
X-Received: by 2002:a05:6000:401f:b0:392:c64:9aef with SMTP id ffacd0b85a97d-3a06cf5c4cemr2510337f8f.20.1745503340675;
        Thu, 24 Apr 2025 07:02:20 -0700 (PDT)
Received: from [172.16.17.99] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a36c4sm22153595e9.13.2025.04.24.07.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:02:20 -0700 (PDT)
Message-ID: <a28ff624-c73a-4e16-867a-66e423315c29@redhat.com>
Date: Thu, 24 Apr 2025 16:02:19 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: can: Document test_raw_filter test cases
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <710557cef8fb8472628862d9b65edcf7aeb32bb5.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.04.25 09:44, Vincent Mailhol wrote:
> On Tue. 22 Apr. 2025 at 21:03, Felix Maurer <fmaurer@redhat.com> wrote:
[...]
>> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
>> index 7fe11e020a1c..8d43053824d2 100644
>> --- a/tools/testing/selftests/net/can/test_raw_filter.c
>> +++ b/tools/testing/selftests/net/can/test_raw_filter.c
>> @@ -101,94 +101,113 @@ FIXTURE_VARIANT(can_filters) {
>>         int exp_num_rx;
>>         int exp_rxbits;
>>  };
>> +#define T_EFF (CAN_EFF_FLAG >> 28)
>> +#define T_RTR (CAN_RTR_FLAG >> 28)
> 
> I do not like this
> 
>   >> 28
> 
> shift. I understand that it is part of the original design, but for
> me, this is just obfuscation.
> 
> Why just not using CAN_EFF_FLAG and CAN_RTR_FLAG as-is for the
> expected values? What benefit does this shift add?

I agree, that looks like magic numbers and the original design is not
very nice here. The main reason for the >>28 is that later on values are
shifted by T_EFF and/or T_RTR, so they shouldn't be too large (with the
>>28, the shift value later is in the range 0-14). See below for a
slightly different idea.

>> +/* Ignore EFF flag in filter ID if not covered by filter mask */
>>  FIXTURE_VARIANT_ADD(can_filters, base_eff) {
>>         .testcase = 2,
>>         .id = ID | CAN_EFF_FLAG,
>>         .mask = CAN_SFF_MASK,
>>         .exp_num_rx = 4,
>> -       .exp_rxbits = 4369,
>> +       .exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
>                          ^
> What is the meaning of this 1?

The 1 means that a packet will be received with no flags set.

The whole rxbit thing took me a while to understand and the result now
is not straightforward either. Let's see if we can come up with
something better.

The exp_rxbits is basically a bitfield that describes which flags should
be set on the received frames. Maybe this could be made more explicit
with something like this:

.exp_rxbits = FRAME_NOFLAGS | FRAME_EFF | FRAME_RTR | FRAME_EFFRTR,

And in the receive loop something like this:

rxbits |= FRAME_RCVD(frame.can_id);

Of course, the definitions of these macros would still have the >>28,
but at a central point, with better explanation. Do you think that's
more understandable? Or do you have a different idea?

Thanks,
   Felix


