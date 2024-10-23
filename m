Return-Path: <linux-can+bounces-1726-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF49ACEC9
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D561F210D5
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2451C4605;
	Wed, 23 Oct 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f82v/4q9"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8B1B5ED0
	for <linux-can@vger.kernel.org>; Wed, 23 Oct 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697347; cv=none; b=qlG8ighfufqN6jtzNfeUTAtM0mUfBITGQ7EQEWWu14wwsCBC1+8DiCxeyANSYf4zHL1xFKr12IwPog3z6bZzyM6HZonCt4J9PJWjVNJR1lzVwA63h6SXqArlbhf9E2R6vkGY+ACT5O1FIBj02qVd0llduBV/5+91xgKKZoRZOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697347; c=relaxed/simple;
	bh=Lay0sC5K6rq0VAqpyxWGdF6TkJm2LJaUVXVvAx347Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC/lO7pTDdUYE/Tx3fE2tpZ/tYBLJljAvRWqbIjBFCzCOcxppNIY+0R49YP6mbkiQ3wLZvUOvSs0TpvegHvwiqA2SwIWWhZa12VMheBFDbv1dAVSJNTP3O/0TOjOmAIQHBE1BzitX7eNSbCp7Mkkdd6Q/9KMDFk8j933plSBLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f82v/4q9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729697344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRXPIQa8/UnabLqZN5OZ+a/o9qqQPUk3TiZx06VNNCE=;
	b=f82v/4q94xkjYcZzJQG3+sjIO6CSwEAUqxOE/JHmhsoYIswXL1iZiLEyNrA0WWzjbdNgqO
	QSXF9oRylnnLb3x/VxZWh2Ez6jDuCG6jhd/Sa5mPx4kf+vjGxPcbJpqcvxvpRw+DGstsvR
	vgaRv7J4MEnup8miCe3kULgyoAI9gsM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599--aAFDGrTOCadH-Kf0cq2Rg-1; Wed, 23 Oct 2024 11:29:03 -0400
X-MC-Unique: -aAFDGrTOCadH-Kf0cq2Rg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43157e3521dso50026545e9.1
        for <linux-can@vger.kernel.org>; Wed, 23 Oct 2024 08:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697342; x=1730302142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRXPIQa8/UnabLqZN5OZ+a/o9qqQPUk3TiZx06VNNCE=;
        b=o3RogfEr1R8gs39GOXKdjxxG+Fvi9VjSoDIdYzcGAfbqtcsHWnqnGh0fNDo1Xsmb72
         E+edQ2ZYFwr3Ty2KGipRHP94VNDZ8+Kqx+pCb9/2YJYds08LwhfGpIAF5c/u1nfHn+g8
         1XvJT1GM4quxV4IBcYWhidaQo8OHe3K93uPChnki+MnAUkLGPvVSPklteAdsnEVw3xJL
         cRvSHsLNdTHJW3iok08aepQBRKmqQzv8G8xhV0Pon/S0vnZ9xjcWPB9QE5yGVdzMfkk1
         Ymr2M2AKYM9pO8AV2/Z5k7/JaGIcnp4ZurRQNp65QfpI9D+HytMVEaJPFOGm+cRP+W44
         9nWw==
X-Forwarded-Encrypted: i=1; AJvYcCX1RYGeGriLdLjAyU3kibdiM4voRuaAEUIKajCkvztZNMvvlcxjXc5JaApOGGmohnvie/RhBejqi5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFns9Pfjpky5XyfLQrAkWg4hBeSzEd4bAYvIpQfv/XTkpGJFu6
	8pm3K52JqsSSoUWHvFgAa4KimG+WcXk8j2VZB12wMjoZIQR4e0Tf7/kHVJ6ZySEFWQ26R5nZ/JT
	OE7l4sKrxVHU4IRokhXoX/61VG8ANJtBh2qLj8c/IvyJrSWuqszCCl06qqA==
X-Received: by 2002:a05:600c:4fce:b0:431:5533:8f0c with SMTP id 5b1f17b1804b1-4318425fb2bmr27023195e9.29.1729697341935;
        Wed, 23 Oct 2024 08:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0NsFUQ1Fkis9uHy3hbRQkI6b7h+jb2jFvCVSxu1PisOSaB4LZBrqLbl5m7MF+P66KHu0yZA==
X-Received: by 2002:a05:600c:4fce:b0:431:5533:8f0c with SMTP id 5b1f17b1804b1-4318425fb2bmr27022785e9.29.1729697341488;
        Wed, 23 Oct 2024 08:29:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c508ddsm19428425e9.40.2024.10.23.08.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:29:01 -0700 (PDT)
Message-ID: <306d6221-3cfa-4268-89f4-9331d69287e7@redhat.com>
Date: Wed, 23 Oct 2024 17:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix error in J1939 documentation.
To: =?UTF-8?Q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
 robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, corbet@lwn.net
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241023145257.82709-1-alexander.hoelzl@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241023145257.82709-1-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/23/24 16:52, Alexander Hölzl wrote:
> The description of PDU1 format usage mistakenly referred to PDU2 format.
> 
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
> ---
>  Documentation/networking/j1939.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/j1939.rst b/Documentation/networking/j1939.rst
> index e4bd7aa1f5aa..544bad175aae 100644
> --- a/Documentation/networking/j1939.rst
> +++ b/Documentation/networking/j1939.rst
> @@ -121,7 +121,7 @@ format, the Group Extension is set in the PS-field.
> 
>  On the other hand, when using PDU1 format, the PS-field contains a so-called
>  Destination Address, which is _not_ part of the PGN. When communicating a PGN
> -from user space to kernel (or vice versa) and PDU2 format is used, the PS-field
> +from user space to kernel (or vice versa) and PDU1 format is used, the PS-field
>  of the PGN shall be set to zero. The Destination Address shall be set
>  elsewhere.

You need to CC netdev or this patch will be lost,

Thanks,

Paolo


