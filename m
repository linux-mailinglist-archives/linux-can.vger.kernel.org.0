Return-Path: <linux-can+bounces-1681-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC4299DADF
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 02:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E09282FCC
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 00:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFBD3BBF6;
	Tue, 15 Oct 2024 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUsV0w4f"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB531BF58;
	Tue, 15 Oct 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953554; cv=none; b=IGm+Re2b+cgUP7S0dwylLfW4U9VLw9+qe0oYtfv//bkcoR/zFRgIThXQXRO6Cw0Nf3+nFdieVaebvJgrnfcWkZfDcyebhzk/Lrjja28OMEXISPYMH4PBek5U2RYD1ti5+szxTzf3OBl+n1SsjkICJ0hXoOf5wSUJRDbMzdMm95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953554; c=relaxed/simple;
	bh=aVKfZJ4eEpOYJu+6LVskjGJAV3K8Q656V8WpGjiOEso=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UeFhEpwFUyw5JGSdzxk/anLOQBubDnmAytmoAtZ5halNo1YmHFiA9LhN7Kvmb1UCbB8nelbwgsbBNSlfsFNwykdZmhhjkhiqO84J/qoN40Y1/A3ZVkE5qw/KayjZ0zWmBzBckwVGwpAj2NsiBXIk1taw6bV1DKSFYctCngW2HI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUsV0w4f; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7ac83a98e5eso408703385a.0;
        Mon, 14 Oct 2024 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728953552; x=1729558352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aYX219RK+CaWry4o0T9wVu7qlr1XF5G4zHAtaRKlIU=;
        b=MUsV0w4fomBWYZr05GqjfEN2mIhs41pygkqZknQ5f2nELAV/Dc4r3ZszWbYSN8ctuv
         nNo190AyPvNUG9FlMsggLnKmb0ZyffKTffsM3G7IDPrd9rkCVe8qlIPFSnYJQRZK1dZy
         z7mo9VjL2OT7d/biUqaIWSTOBovnQMuHXDrVDkXr2IJgKrVDGjgQK2VoVkTq9vP8TG1n
         o2IJBVtyivvPEGAFURHhSmhp2o+JOaNrKHsJ3mCH0I91T2R0iTI1ijj/DbO1OlNwjYeM
         KIw+gbA7bizbYuOhKtkSvHHqxdC/8aOzvLt6ANUcBmYhl8s0RYMHLxgoQj7+c3pXhHZG
         T9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953552; x=1729558352;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2aYX219RK+CaWry4o0T9wVu7qlr1XF5G4zHAtaRKlIU=;
        b=nxLEvpyS9nQ15NgCqhs26915V0Ulvf9lxS2nnS0RIlxvDPtifChiNnXUpH4Ip++rsX
         bcZKAbUznHJNrdRZPE+jUmFekLsK7cVRr9mvYaDKXGrhrJ+8E66XYp2jwcJWvtW8noJd
         tGCA2pIMdJW4ydik7qJxsPGmljRRuFIH/etsthfiwVwBoRT/A2dRFxQAEbGHMaLSiMf4
         K5TYDN5jVRVsUm+3ESHxUQB3z9G3W4HCgROZzFTmtCSYb3LnlNrFCd3HWVLkhi/QjQ1n
         mL6vI7OkFaMwHvZA/doAo/SiwTxwew7pSGN2a3tFIlCoVwI5PgzX6nunnUlsXzv3YmMr
         CFSw==
X-Forwarded-Encrypted: i=1; AJvYcCVkh8FHx7kviVPlsD4wzc4NJ4qhaHgAdIBd2cT4mW877Zi+Bzz2Z27lWlkmo5EUvSX4kh31UH2KZhJJ+w==@vger.kernel.org, AJvYcCW4RaElOADJvGC2q8eAuSpyJT6XKS9+5VqO5weVvuXZMRBzkh1M0B586kVD+Gl5yGAC9nrsH8UAu7aWCCMgt5g=@vger.kernel.org, AJvYcCWR0gXHZvcEdNYzk0ypKdnJvLGu12tgaDNPilEw3SqsmH5TtCzcwAKhaAjQseor6ozXW9Sdb/8g@vger.kernel.org, AJvYcCWYSm2RNw3rC8aINeKyQhCq22S37et+10ZSnhW9T9rdnq4iRmvr1nAcruln3ARtAvIJGbbQqqR5VnEckYQG@vger.kernel.org, AJvYcCXriFA686ew/qLj+B6BF8jLMFQVYYoUjAxx0W9NE3EXX0vI7n7MEaimtGimbjOSmvm6HmePtpZ6g1XU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kTrr6bmtmOiFMUzCzbSXCXhtWQleeoW/hoy4cjl6rcJEkDfw
	QnWK73E6BJeKzBwnnVApeh8ERaX/FxIIaEIs5h8hoHPJ3hK0LZey
X-Google-Smtp-Source: AGHT+IFbmtgU86GpXLnwWNb+P/+we0eWd+N28TohoCcxIS9tuL/e9rBJv8T+QvMJ+TVmhykYKs2KDg==
X-Received: by 2002:a05:620a:4547:b0:7ac:e8bf:894a with SMTP id af79cd13be357-7b112517b5cmr2674571185a.20.1728953552152;
        Mon, 14 Oct 2024 17:52:32 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13616735fsm10528285a.19.2024.10.14.17.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:52:31 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:52:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ignat Korchagin <ignat@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-bluetooth@vger.kernel.org, 
 linux-can@vger.kernel.org, 
 linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com, 
 kuniyu@amazon.com, 
 alibuda@linux.alibaba.com, 
 Ignat Korchagin <ignat@cloudflare.com>
Message-ID: <670dbccfd4c2_2e17422947e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241014153808.51894-2-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
 <20241014153808.51894-2-ignat@cloudflare.com>
Subject: Re: [PATCH net-next v3 1/9] af_packet: avoid erroring out after
 sock_init_data() in packet_create()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ignat Korchagin wrote:
> After sock_init_data() the allocated sk object is attached to the provided
> sock object. On error, packet_create() frees the sk object leaving the
> dangling pointer in the sock object on return. Some other code may try
> to use this pointer and cause use-after-free.
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

