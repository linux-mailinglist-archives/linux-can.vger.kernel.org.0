Return-Path: <linux-can+bounces-4822-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C593B936EE
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 00:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85611907A06
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B72FD1CF;
	Mon, 22 Sep 2025 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xInuqUXf"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E877285068
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578967; cv=none; b=O+e5MyA7HZJg0W+VjLzhQVh5aTYFsZckAb3vVNy3mcx/VImffglfOxJB/OqDijVxcoDyp9Cmj/TM4qmYHJjC2QC8VkUrsD51HLtJQjy1XHgn2yU0B72wcr+2LvIttJ3Abmq4oIevArKCcGCSkk6JJVY2fANNBt35zwM2KewE3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578967; c=relaxed/simple;
	bh=IbFE1oms2PmcouUl/usEZlCEVpv+9x2ciXv88pSf95Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aT/n6ICNu01vXNeWSLhviwD43MbufHEYdnU5TIwJbrh+ZqsAM3BwL3qM24y50Y5x23nIp45krJ2aMcP2Z1KwYmDGb16sG681gsnGF0qzabeCeCfxGoJy0EexB7V+tFJrVdRbsO/xCHYLVNiTULEBiDctSBa0qId9MQorGGxbDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xInuqUXf; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-79ad9aa2d95so42986656d6.1
        for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758578964; x=1759183764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYnuc6j9qhLWOo/rZQKKbBmIkoY02H/yL7nkkmtQpxU=;
        b=xInuqUXf3Pqp+x74N9wFfgvpzAhwa+5bALmt6ibQQ7XeuKxNbaCeumKda3DexrwpVg
         Kzcyr0kPY71WfAVfJAm+/nPnv1tVSyV+EYBuUi5NNcI4NuuhIsudQELz9OXTaiBbE6CO
         tn1mpbFEZMu05y4iedP9eRzselTi5ZUeJRyhSmPaxCZGyhe08/ym9om63nr0mdiRPQOy
         0O3ck2rZOApODsezNG2ThkttLMa9fv1z801Ov75m/FvJ6bSNaM7VFq2oxJdKBBfz7xw+
         9GKv9HT2nMQSj3n89ZxolFFcJwRFGp0ACh7TrjipAGeZGBxmTRxuQlNUNJWRRKWobfmN
         AIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578964; x=1759183764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYnuc6j9qhLWOo/rZQKKbBmIkoY02H/yL7nkkmtQpxU=;
        b=XvEIi0kBm7Kf0rixCG/7N1UHpXSsGwq3AePCz2u4+f3Arvz+XS1n5fOaBtchdyUaZ+
         ciWuCKehbnc6S3/tw3x6P6qgw8J0dROIUZaBRVyGKFn9PECX+BH9F0jk+BILbW5K+eP4
         esxOc0Jd2nQKPJP3kI2oBCb7vMTe0FDWHaKJrPWSlI+PD1EQ+z7YW+3q/Ixt6X3vUVTN
         3Pkj9bZVDCUr3pOTaIEF+iTeIg6/aTcVYg/0t7JpCNDhPCIFJrqz01Lr8Hi9VKdWqmCd
         xis/fdA5HAYzImuCYq/3ve1zfGPq7iEH0S5z8hoy3a8X18vFNfBiMkDtpRynyzZAR/7y
         7UwA==
X-Forwarded-Encrypted: i=1; AJvYcCVDz1+WCwW/FwCPqI+0/S15iFXsBXPheOKEz4I3EVHguRUsHoUNaww0Rh6g/wfdIshDTxRQghOQPV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqmv0oNhzbIBSQiIyZK/FyGqcsr7qLQ2HnNbmk1vwJPa/7nbq
	fM0AHbbAESZf0s0H29R2hGS2mT0hg3VDy7YNt+0HS99qSmdUfqaXWcKisEM8FTAPwik=
X-Gm-Gg: ASbGncvfF7cMC+Gxw3uFqGzLOBj5i53kdtEBkekPXfDBl5USZOmDZcUYU+ep9ynl6M3
	L5MFPJEE0+r2kwqB8d0F18yX7cGnZeTX38+21IceLFtY9ZWeSaGeSbU4mYTk+ud7NCgwjSartcT
	OvoZ4sugM8BUB6pROesVuTBEkdB8NXGFdv6bXr+0DL8V6CQXJ9ISiicjsC0URcRKW+RU9AGHSH7
	zkWAVoUp87fXrBAsTg1S8Fd8XvmUln7x87kRjP0kJcUgfTJOgkiuvlIqXqaYa7dME+pIId2u+TC
	DF5kYh6as233j/GDyiGCMxcQwvptIS9An8Cod1inYoAWMIWMYIBjC7bAwodsF/XNXU+xdq+23K0
	/MrpSajVjUDCloBmAFsjKdcnLl1INjjadhrGtyrtgiyKo0Bbs+cYODS7Vzm9sXq9lgsn0V/bodg
	KfmQUOrOcA/A==
X-Google-Smtp-Source: AGHT+IH/Wx6XCxh+/R42m/n4pGW4Li0DeICaefpsliWbAkhEalUfjSoqc1W0yev1gXFbG0yEVMaLoA==
X-Received: by 2002:a05:6214:1c8d:b0:790:551a:a689 with SMTP id 6a1803df08f44-7e70381f88amr5363076d6.26.1758578964227;
        Mon, 22 Sep 2025 15:09:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793446acfa6sm79182216d6.14.2025.09.22.15.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:09:24 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:09:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 3/3] iplink_can: factorise the calls to
 usage()
Message-ID: <20250922150920.78b95c44@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-3-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-3-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:32 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> usage() is called either if the user passes the "help" argument or passes
> an invalid argument.
> 
> Factorise those two cases together.
> 
> This silences below checkpatch.pl warning:
> 
>   WARNING: else is not generally useful after a break or return
>   #274: FILE: ip/iplink_can.c:274:
>   +			return -1;
>   +		} else {
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---

Not accepting most checkpatch stuff in iproute2.
Better to not have code churn

