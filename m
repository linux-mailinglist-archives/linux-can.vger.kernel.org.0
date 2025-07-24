Return-Path: <linux-can+bounces-4111-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FBAB108A8
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33B3189EC2E
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F126B971;
	Thu, 24 Jul 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR1YjAjO"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB115855E
	for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355451; cv=none; b=WnwBW0aI7FxgNET9xji503+aAp9ti4eclbr6/6OS6kJwC0iexqCUqc3paoVjQxSiI7nMgLSWK0a/c/vg9TfLZ08vJKPA6YplOom7VzyD1pYxuJFbRDMoByafVz31uH/TOPont0sLJ1Kvci2yhhrtdxRM4CPCrY40i5yTz6QDMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355451; c=relaxed/simple;
	bh=LK+eM7ri+qCxrNiOBSntEiCUbg9C0ThQBTKvjOhtdgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+UkGuGq0/zbdFOt3JRRCIz+tLUVOODRLr+NHALAD2K5Crn9HX8WRUs0yzF6OohThhcb+5m9zqLmS/j+WxEZw2Xs9CHj/6D9CAZp0/rVXQNGi6VcBxJF0RiVwqCTxx3bzG1joFHBis30GPhBWFKS44OWfVmAwJf0FXt4srabfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OR1YjAjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753355448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2NCP1lrwfKiTcn3WuPGNaIgWCOJinwqwpt4Tm+WLqM=;
	b=OR1YjAjO+03pWe60ssj37EIXsV+WNZC3PJlo56OLd58nQfEuQ6DZMj3FN/Y9uA3uBsJ1/J
	JzPVOjf7bZjBwkoCwa0Zoz79ldXJ/r405BTikPnojfgknPDKxIqA17EpdmrZLalfpwqRJe
	ANKqE472ugn2RUj6Y3jA6Yw74s6XjKc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-R2nUN80_Mb-ubjoe75nygQ-1; Thu, 24 Jul 2025 07:10:46 -0400
X-MC-Unique: R2nUN80_Mb-ubjoe75nygQ-1
X-Mimecast-MFC-AGG-ID: R2nUN80_Mb-ubjoe75nygQ_1753355444
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b76d51048eso645814f8f.2
        for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 04:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355444; x=1753960244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2NCP1lrwfKiTcn3WuPGNaIgWCOJinwqwpt4Tm+WLqM=;
        b=O6ZBo9Ui1eF2gf+ONpgIY8qGSc4jn80o8podug1s69VLMCJTRbI7MDvO01KSvYSd6e
         VDHQNNjRGOlpUwJYFztz428Olpoa0kQ2uWSXlSt8uJDFcxAcWStWsAy8rgpNWNOWRKr6
         UTNKF0ORvA2KrX+8PhKnEwyPb0RkSd2fb/DU/YcbrO0gCYTHYFTs7aEeIcTCVVMsaozD
         1uwp2/6qvxF6efD2pxtAJs3dOstwJjo0otNwMwe9qWdThNVG5OIFN2LaZqpDN9w6Eh2s
         UYPrWVEfbRbZq5HEds8Y1r5zZpBlivaI5CfxjYceSD+R5ijBypVGDDzH4L1IUyl/AaBg
         cACQ==
X-Forwarded-Encrypted: i=1; AJvYcCW154eXOdqw86M94ZA+iUHImiVvLBhSV16/qak0cDpbh/nKYLGIu62sblo0XCrjQXdVcNLZcxRHhNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAFImBSmP+goblW3qUZY7lNECV07gXn4MUb8RCZC6W5GmgG27
	pGku7J9Is5FXIjbZic06bdByttdkRkfmh9fF/hkbzx5O2lFQTKwGKHQdCic+18sKaR6O/tNZGJp
	nsZI8C4JZ7GNTx/GYuOzn5iEDyo14FUB5pwAJy2ibol/ErSEd5AFKroIPWT5VhjtgAZuH9g==
X-Gm-Gg: ASbGnctrPhSz+dZHnwXkbfqyWdqrrBJqm/HzKDVe5XMVC2NAckoGC3DRvykhgj4W8pw
	f7DZ12PdpYXub0KqX3Aqn+CSct+BrQCGM49zpjib6PfKjxFYeatNC7YOIIl9+mOYdF/lI8nvGTM
	Emrwmtj+sBTBkNENMeMawvIE0TiAnbiOLyzutV555SvQTP/m/3RlPtTJrSimcbKzNeQw4WJPCrL
	DO6S5XjeJGfpgNdjCID3O3DMM7M/1BJIVXnzzDeTOOHPHMT5OpYU1grRHmVab+q7wi435HbCr22
	Twf+FAw+cA8xaBuyYB881qITZp89/ZggnVBvsfec4/wxD494mfgKFBUjJDFzNN4qaVRM6pgHWtq
	8vJk+359HaXQ=
X-Received: by 2002:a05:6000:24ca:b0:3b5:f8d5:5dba with SMTP id ffacd0b85a97d-3b768f1e4eamr5530370f8f.30.1753355443942;
        Thu, 24 Jul 2025 04:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLgvu7WVeFYwOdmE9OOfus6okmx5qDI03XAQNzVJFNryVZLGLzJXFmX0HYKc8pK0SB7TCTRw==
X-Received: by 2002:a05:6000:24ca:b0:3b5:f8d5:5dba with SMTP id ffacd0b85a97d-3b768f1e4eamr5530344f8f.30.1753355443457;
        Thu, 24 Jul 2025 04:10:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587057797csm16591985e9.29.2025.07.24.04.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:10:42 -0700 (PDT)
Message-ID: <df9f3f4a-10be-40f6-8409-2ce016d8a4c9@redhat.com>
Date: Thu, 24 Jul 2025 13:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] can: kvaser_pciefd: Simplify identification of
 physical CAN interfaces
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org
References: <20250724073021.8-1-extja@kvaser.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 9:30 AM, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser PCIe based CAN interfaces.
> 
> Changes in v3:
>   - Fixed typo; kvaser_pcied -> kvaser_pciefd in documentation patch
> 
> Changes in v2:
>   - Replace use of netdev.dev_id with netdev.dev_port
>   - Formatting and refactoring
>   - New patch with devlink documentation

Since you are cc-ing the netdev ML, please respect the 24h grace period
between submissions:

https://elixir.bootlin.com/linux/v6.15.7/source/Documentation/process/maintainer-netdev.rst#L15

Thanks,

Paolo


