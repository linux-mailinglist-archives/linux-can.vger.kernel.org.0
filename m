Return-Path: <linux-can+bounces-164-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC5183D753
	for <lists+linux-can@lfdr.de>; Fri, 26 Jan 2024 11:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4BF1C2DDB2
	for <lists+linux-can@lfdr.de>; Fri, 26 Jan 2024 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34013FEE;
	Fri, 26 Jan 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJtNWKwG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091610799
	for <linux-can@vger.kernel.org>; Fri, 26 Jan 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261103; cv=none; b=DrFtCLlbZMUvpilWaX394rhv7d5Y8Ppe9o3+OTqRdKUZzmr47iByFL6n9VB6ojVYUglGvZrMvSuFVhzG/wWRACxh8K4iUxs97CEaNnRcUu6U47A5td+ASONPpPwxpvgvdi/AR0UaVGXknyVXPHKWCfq5fTBwZ9kUMjgIbw1NSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261103; c=relaxed/simple;
	bh=jtgPd0w47VDdBKOJmWSDQ2PD+TMf07rfa2e5MOO571E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XLTuiSPqzwKd2oPRdzaZ474Fn1/59+BSJfxRNhye3z1xQiJ2JWhRkmnuwv/dQpDngFnb4ZVeVKOZgOlvaBHg0F063A0D2PdZExSpcgwmE2rG83OPMaHZHNh/9r865bgK/kVqBVcczAf0/SvpbyZ8ArfMI7oV9M2bte7geKaV7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJtNWKwG; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-40ee418e7edso1718985e9.2
        for <linux-can@vger.kernel.org>; Fri, 26 Jan 2024 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706261100; x=1706865900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUVfoErdleo4sA3wFQtWGr64XO7F3R6wijbrc9axpwY=;
        b=dJtNWKwG3bU/yDVeIvtMQAu01lMwwNY93VFUyUTgBHVIm9E9BdnVRMcQdWwdK8ppBd
         nkvAoEyxUb7wdUfUdOPQrjVrszchXDVltnk3I/GyoWIgkEm8q6dblb8evBqE9/8A4tfU
         GG8e7lX2s3FWYzCQCGF7auj+FlELLekcSCVOsPZnQb4qpi6fo/JwQg/5Rml1WIiO5ikW
         LWRQoWyYrzMkSZbjKn3NNmagMDYORkJUpPnmqt8YF+pk8/8kCbnrljvJeqHN7QpmI37k
         VP98ZOR69bI7YJEjkpPxAktc8yBjTStNED6Sffjen6LpY3VTiaOTSqm1Nf1KO6ajkPhL
         KQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261100; x=1706865900;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUVfoErdleo4sA3wFQtWGr64XO7F3R6wijbrc9axpwY=;
        b=qtUOEuKweg2+zjZbfighXX6Qest0zdcq/kOMhn/pRal5ouu7BQ7RlOqkCcX8E93rrY
         iEqF0xbc0zeid/UmtS0jys8T2iubnoFcCYMY+YpyLzpUOnXe8Ae0JreDaGMiQmMiyVTm
         FJVKToFBOYVIzhV1I3LPqem6MEbNUhy1YR6G3dqeJ4Itlyai/BECOyf8YZ5WcbirHHKQ
         bthLcxDP/awfG3COyCh7zZguN1B4yl4G9bEC3oJgSGymzXNbFtKCJWcsfrWbXbIoWta3
         N03M0FDqVCFEWjHok4X5OmViRhR7iKCkr06N8E073ghpbicWGlKgEuSerXZNSgyhdZzA
         lffg==
X-Gm-Message-State: AOJu0Yxds5p/qiCnUVnQkS/rdesIrnevkXDN0eTHDT7EtOBarbGfR3/R
	d9Odo0D+Mjb9QEkEWLcj0WXLRsMh8ctQyX8NZpySmFrNiM/sZ05/H4bENGkZMCc=
X-Google-Smtp-Source: AGHT+IFxPG2qIAEQrjjR6XJBibDlp83m/uQBn6/l1XOc6f9qPf/GDTwJNpqBofYZIwO8YDbYbCAnGw==
X-Received: by 2002:a05:600c:348e:b0:40e:e44e:dce7 with SMTP id a14-20020a05600c348e00b0040ee44edce7mr126858wmq.73.1706261099946;
        Fri, 26 Jan 2024 01:24:59 -0800 (PST)
Received: from ?IPV6:2a04:ee41:81:c881:4ddc:8a65:96b1:8429? ([2a04:ee41:81:c881:4ddc:8a65:96b1:8429])
        by smtp.gmail.com with ESMTPSA id cw6-20020a170907160600b00a2d5e914392sm415104ejd.110.2024.01.26.01.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 01:24:59 -0800 (PST)
Message-ID: <28531c8e-1d3f-4bf1-9ab1-d3e5582a4915@gmail.com>
Date: Fri, 26 Jan 2024 10:24:58 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] can: bcm: add recvmsg flags for own, local and remote
 traffic
Content-Language: en-US
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20240120081018.2319-1-socketcan@hartkopp.net>
From: Nicolas Maier <nicolas.maier.dev@gmail.com>
In-Reply-To: <20240120081018.2319-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 20/01/2024 09:10, Oliver Hartkopp wrote:

> v3:
> * add missing initialization of msg flags and check for the needed cb
>   space for sockaddr_can and the msg flags only once

Thanks!

Best regards,
Nicolas

