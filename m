Return-Path: <linux-can+bounces-2889-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04634A3D49C
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 10:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6B0189DC9E
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CA41EE7D6;
	Thu, 20 Feb 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjrsvpyZ"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF451EC017
	for <linux-can@vger.kernel.org>; Thu, 20 Feb 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043447; cv=none; b=rK/owhMernGJ3417iISk7TvdLKyG8xabB6KQtypVYPgoyyTubd93l8cwvLWWv/NyspSbnPIXc/8KCAkiaU1PKTK0Nj4XWKcMXfy9dyOn5RHQu3xcA/i4o31uECmzotwZO3H5PifVXq75leUOpv8Tsx+P5ryH9UJvsG6pRIJOoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043447; c=relaxed/simple;
	bh=a3+Uw5nVO+cw7ntRiZGpf+zboyTLjMdXzQPtLUgoPq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQhhHSqHqNcFYt/FIqMXKcLQT/m9x3rQrjALSlZC4a88F9Br02mdnj2k6fnfwwNYDVXit3SXQdlgZnm0qw2rqQslz93dN2XenicRC80aaSK9g1x2A+OPGIxpVbYGzw51l/cp9V2nthdoBJILSZuUBFjpKL5bCrAb9U0lxg2z4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjrsvpyZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740043445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzqj336A1rXg1HGlLKXDNm3cA/qnoePyfzqLG4eld78=;
	b=EjrsvpyZz4MO9DFML63KoWOjSKhqNpWFeb2xaLm3JpNZYjiTQ7aqpD5GGzzPXf+FQ1/4Hm
	jdQp+JzoWjpp1JdXRMqj9vsd6ZFxbNcWR8opHp8huI8aUl7btzz2aVzMc2Pp7HRxQa5m7x
	0FGyVnHnivrmbO/PWznWoqjen29OmD0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-K7vf-Tf7MYak7lsQH4YXLw-1; Thu, 20 Feb 2025 04:24:02 -0500
X-MC-Unique: K7vf-Tf7MYak7lsQH4YXLw-1
X-Mimecast-MFC-AGG-ID: K7vf-Tf7MYak7lsQH4YXLw_1740043441
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so3298325e9.2
        for <linux-can@vger.kernel.org>; Thu, 20 Feb 2025 01:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740043441; x=1740648241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzqj336A1rXg1HGlLKXDNm3cA/qnoePyfzqLG4eld78=;
        b=WDCpo2CS6Kj5ZSGE8NG9pH0+t9vjZlxx9kW5LTaOoZ9uGKrqZ+6GPQofXQXfy/Mh0K
         WOO8ykQ1TFY+Sh1VsVDBi2VtnhbAWEwOvapJ8+QJOmCjj1HNthcQ8PLJXmY79hVUZ9FK
         Ma3wcONXIQImh3ZJvY7mHRlxSmcnJ91rd4+K0yhYqA6ZcpE9im3r+I4sPXuOI7fdq8ia
         jvQmItyp+qPu90cvet/N+sZwrXyJrc0S09rw+tTwHBK/Nn7c6HCr1fTbOu/Ar9KPcp22
         NlEaj+QQBQnr8iEAksYhIzQ3p5G+FqEUmODifJajwx+vRZFSp1ijLjPb4wbn6Ly2j+8H
         KvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXALDnpMsDFc/QYwI2brdYfxR6ujvdq1jdbwxq6/bsX2bvs0wr/MNha2/DoSsyuNyOAqOW7xm8TZq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybcIZgNg8TW8l6dnpwNQ24+ZcC5Hc+/prlnLI4ArS3odqyRhlK
	lsPv7gjdu0B33qSQIDbGWQpa1PNc7r+kEBRZkot++Li8Pr5Q1cjHWo4+MIrmkE5ed/Yn5Pg1ljs
	wFp3sbneWkMBNIc4sOuRto7f2qViPrwqLeWE1FMNsjtx7HSyDGzTdozJxmA==
X-Gm-Gg: ASbGncsuEo+oL7xk6xM0MGcEWtUMulDxFfrNkDPrYGwv5Js8qVyybo/CYQJ3FcsJjw2
	2zj3mg9vq3jyJG/xv/gVrymeDL9gmy+3XOLUM+z189r4innD3lMx958qAGhEKB+RnNRd28UgyzA
	UnOdDLVOAKmUgj6GgsNYwVlqAUEWc4WZrMsigGUNAatj9EcFPayfd5aziD8bQ113gNahff5l12X
	fnWIakn1HJPtQ1gQhEui+4OgPlH4gUYAh1dU60JIa/lAUFOmeHX4roz+/V9CGT+LvdrzWi2aKUV
	qDH3CkJ4TGIJySmG/5Kr+aCz1U/AB2KVpg0=
X-Received: by 2002:a5d:59ac:0:b0:38f:3e39:20ae with SMTP id ffacd0b85a97d-38f3e3931demr16440043f8f.43.1740043441169;
        Thu, 20 Feb 2025 01:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXL3ai8YtSaeWY+YHH0xkK64FUIXlC+iWZe4227svZ8Bilgl6lzjsdOhfHv1/5wwtY5FCP0Q==
X-Received: by 2002:a5d:59ac:0:b0:38f:3e39:20ae with SMTP id ffacd0b85a97d-38f3e3931demr16439927f8f.43.1740043440607;
        Thu, 20 Feb 2025 01:24:00 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f561bee3esm5459947f8f.21.2025.02.20.01.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 01:24:00 -0800 (PST)
Message-ID: <fdf36ae8-10bc-44d8-94c0-b793b84b94f1@redhat.com>
Date: Thu, 20 Feb 2025 10:23:59 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/12] pull-request: can-next 2025-02-19
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20250219113354.529611-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/19/25 12:21 PM, Marc Kleine-Budde wrote:
> Hello netdev-team,
> 
> this is a pull request of 12 patches for net-next/master.

Just FYI, since a little time, the name of the net and net-next trees
main branch is indeed 'main' - to better fit the inclusive language
guidelines.

Cheers,

Paolo


