Return-Path: <linux-can+bounces-2701-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64CCA1D4D6
	for <lists+linux-can@lfdr.de>; Mon, 27 Jan 2025 11:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECC1165309
	for <lists+linux-can@lfdr.de>; Mon, 27 Jan 2025 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7441FDE20;
	Mon, 27 Jan 2025 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmHFQDoV"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00A1FDA86;
	Mon, 27 Jan 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975158; cv=none; b=hMi4tis9JNP2tvt5ho+1RBWH06eLUapM0Rk46bk8F5EGs4zMoyGeKpjbrPSUIvtaJ+g4peHVu6+3sv99HSD6uUPXHEeWvk1uHp2kHb/jJ25iO9feIZRgy4d4dqZIzLHwgx+VF7W9RqfJB93aq3M3MzoszyTvpwb+eAvNAkUI5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975158; c=relaxed/simple;
	bh=ADvqvVJx5NrxaNgOcJ/ES1arTuX9/tUYcouTIU2fsJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9BjTBGdDB1yWD5Gp9M9ZPPC2l9QcJKj5gAkgySaCjRwUd66q1R1IYfUV9HU+pka9duJbaS/wN7cVe4KnXADQoDHmgl7g4cPpkOPkEAIYvXQ/uj+oRksAkvPk8ze3IlCgiR7XfUNDTfkrt62nW6TwIrpEOjpcbbRHM2uPBzZoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmHFQDoV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so43998775e9.3;
        Mon, 27 Jan 2025 02:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737975155; x=1738579955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADvqvVJx5NrxaNgOcJ/ES1arTuX9/tUYcouTIU2fsJI=;
        b=cmHFQDoVMvTQw0TWni2h1rM3DpF4dvT2BNOVEygC3M76RXX3/I9W+z0WhkWHQwd9iG
         XMHtsOan0mDlQE0pa9cpJZJqSghZh137KlYCdMeoD8wzTFIL6TQIECgnsLe3HhGAnHcL
         nL2ztsMadUL0t+aAtqAL+HQeOP0/hZTmUbFH2Cyb4lox30KBOj0ZPXot7rzkdIoHgLxQ
         8HvmekXzZRq8341zpWA4yM2wDUAzvkeFSCzUtaZRkYI3PEDB5VcQpcEhWuLkj9ULFCK1
         x9z+OmVfFOzFtzOH0DMGcxUnsl6uWg4psQy1e74KQyVTU8Md5xKHt3X+5EJr3aegdMCH
         98Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737975155; x=1738579955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADvqvVJx5NrxaNgOcJ/ES1arTuX9/tUYcouTIU2fsJI=;
        b=CWWAqKstrb1EdOd2dXs0ptrPZefOsgNjqSK0oEq6cJPTn8zygX53jeCoR38xL69PPI
         l3V5VgsmAXnu4Mo0fTrlGY+crzdxDaTVbwtyxdPVa1461Z4K62omcK3ONYls6nokAP+2
         1KAHFhN93CiX48NYVbDC1KkNoBqKATnv9O9yuRG/oeeeJZD/xtLvolTf124L2m2Rw4fA
         6d+wjPNkJ24PsM0cCL1jI+4ceG4KTBJYMD8G5uAraXg9oVC9KhqWXrLTel/nREUWbcCE
         dHEZj8+fR1Fzwv51/u9mGz2fSl12teITdrSwzEgu5M/sPrdkdhB8WH2CyB+8vRXfofhG
         oqsA==
X-Forwarded-Encrypted: i=1; AJvYcCU3h/j6QB7QqnFSw7n0wDLMcX2RPJYXcEOhNVDT41wxn3DEDYhqRRSNNM0/TiiZndvZ0hoF3R1cPrwbd/CN@vger.kernel.org, AJvYcCVXVcpJkDbiygw4+3zD6l5v5rb2w6IgkOU9alETL58piRF9oahhwogs/qm/2zIgt4+A3OxJp1xNnFc=@vger.kernel.org, AJvYcCXAsEpMPkrUhealL1es3beAay6yUR7p1cQ5atVyv+8HfKSasrUkPpTx84JuHyKbhLCoyFsFU1uq@vger.kernel.org, AJvYcCXHuRz3AKPnN9LCLW66iR23fCczZp4LpXrxFw56+HsqQu5JoNlqh3X1JH/xYKkxxaB4TFDCEitCoLfv@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZpbbVyfK7O2ipr/m+21HcQ3epyqERxs06udUfax+HrwJn3p8
	O46JzOS7EJFT5JNc5ydUmHBVGX2sY4MM7BZwHf0PbssokG/RKp5l
X-Gm-Gg: ASbGncvlHyfcvjy33TqYe5ztuF/qQBrd3SRUcmh24/MgHl0+SUOc61q2WYy3PpZXo9J
	L5cz+MpI4AuDT7REH39cT7gvQcU24a43X4hT9RGwzHA0pn0fNr7GVJ2Lskuvev87Dt5AN2xtNQo
	+CcAmqSDIO9XfmDHUNxNzP5o+cEWQtjYz9LAq3ELiixLJmZf4kd/y6pDs+N1Kp53wrn7+qmpnIo
	7wp7mflRNTDsaVXQnP0kcD/MRhZNuNKeNcfxTydSB0HXpjxB56lbduGcg6Z/tnN6ICQPg6T04M+
	8dI33wqdXx1A2u3C1wqr1A==
X-Google-Smtp-Source: AGHT+IEgpzbSjsuqjQId01p+RPqeHrhSFk6HkwDvd4tGyN8bqiyDwlOekgzKmPN0g+igJw9RgC9ajQ==
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4389191b819mr374688965e9.13.1737975154471;
        Mon, 27 Jan 2025 02:52:34 -0800 (PST)
Received: from [192.168.1.14] ([197.63.236.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d6f8sm10524823f8f.28.2025.01.27.02.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 02:52:34 -0800 (PST)
Message-ID: <5cddb702-1cfa-4961-a7a5-dd0c759379dd@gmail.com>
Date: Mon, 27 Jan 2025 12:52:31 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] documentation: networking: fix spelling mistakes
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: shuah@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net
References: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
 <69da3515-13c8-4626-a2b8-cce7c625da43@intel.com>
 <5248fbae-982e-4efa-9481-5e2ded2b4443@gmail.com>
 <009d8ff8-7b77-4b3c-b92a-525b1d6bd858@intel.com>
Content-Language: en-US
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
In-Reply-To: <009d8ff8-7b77-4b3c-b92a-525b1d6bd858@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 10:16 AM, Przemek Kitszel wrote:

> this patch is fine for -net, as this is fixing the bugs in the text,
> those are rather special, as there is no risk of regression :)
> I'm not sure if Fixes tag is necessary for spelling fixes though.

Makes sense. Thanks.
Khaled

