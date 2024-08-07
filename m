Return-Path: <linux-can+bounces-1160-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7795194A251
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 10:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F0E2817A5
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF4719A28F;
	Wed,  7 Aug 2024 08:02:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499C1917FE;
	Wed,  7 Aug 2024 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017754; cv=none; b=VIdg/vkQJ0ABf6gep4uDQAscXtSbThHnetml+If8YH1SvxuFOxF9JrgewzcyAwjdHjVKgxljcArmhJcksTK62PU9YvcnG+d2PqNblw6Ddwow92UslgBxGhwMdFMKL/tCTMe11PzZ199aX1BeZBSMAJVkL4ASIzUTL3iwSyan4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017754; c=relaxed/simple;
	bh=RnXps038cqMUBSYUKNHarGm7JUWChcI8wAu4YRKIVpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er/b0UaUyS/V3KG8kCiWzbOcq9PT5K7a20TUrsmBEqYrvdK8Mtn3Z2t0b7lIFr4qyGM+GwpDzekQkUJep5kn4qo28UqyQEH6MBb3hYkKYVkN9vXWieqKrpZUAeHGpUiuDq7Vzv3rX8k/6Kpeac/qGVVTLyDsmGIrelBG8yeh2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso2164727a12.1;
        Wed, 07 Aug 2024 01:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017751; x=1723622551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhOUX7lFr4TBM0dnZ/4tpzOwJP7lJ5v+5a9Ieroj11Y=;
        b=F7xGwKjJpXJuH4aWRV8mCt88zBy5bO0P6CnsE9LP/z53ha9D76yIUbNho1OQkrI+VL
         kbN/NKXj6dohx8c/FoqQydUE3JC0xGslZ74xZQJmBVX6o0BGm9RaUNdgq5C5eiMeNxH3
         LIW563FuNO7XOISLGvTFODu4RwfXTMf/BaJ5Zpmzb5wEFtX8aepXqh0clKfK1KOIp7AL
         P8tRiCPNCxX6x5DrkaGz30rlfVy4uOwhRlPj7hDEFSfKV0H/GTFtK8Laqnl9P7obQdpz
         H11TBYjoWqY8O+ARyJ9u7bplPlV+Hu+avSruS0JgFGrf+j1EYNkAp18qpWWnTEXoveqS
         7jTA==
X-Forwarded-Encrypted: i=1; AJvYcCVbWa1tcogDWOfGprHnyC8PZ+Vln9+vKRsHhDhmeIp0sq5Bxj6mCy0+9RuNPYDMDcF/stBuJpfvLzXOFY+5u0RC3h5lGS11kF019h1RR2h0MvPMHmZAT6J2h9CW6euynHOrrFRqr+d77Sb3IOD/vvlwHOnryC9iYoxh6iSnzzDY
X-Gm-Message-State: AOJu0Yz7Bjon0+xKmTqtpV/BXTTupzKz7iLL0s0iASIpaGsX6B1jrPxI
	qMPzrdAvrG3cD48yrgKmg8tTX70+emhZjRjdERbMNLC3B6Qg4MHw
X-Google-Smtp-Source: AGHT+IGAVAq79xPJf5aKbKvbiZvrrimSm0HPo3Za8H/ky/m/krm8l//jgWINqK5Z742ER1LG6eg2cw==
X-Received: by 2002:aa7:cad6:0:b0:5b4:40e3:b12f with SMTP id 4fb4d7f45d1cf-5b7f3ad6bc7mr11913253a12.13.1723017751246;
        Wed, 07 Aug 2024 01:02:31 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a140f13sm6828634a12.43.2024.08.07.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:02:30 -0700 (PDT)
Date: Wed, 7 Aug 2024 01:02:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de,
	kuba@kernel.org, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, mkl@pengutronix.de,
	netdev@vger.kernel.org, o.rempel@pengutronix.de, pabeni@redhat.com,
	robin@protonic.nl, socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Message-ID: <ZrMqFN4vE7WHRBjE@gmail.com>
References: <000000000000af9991061ef63774@google.com>
 <tencent_2878E872ED62CC507B1A6F702C096FD8960A@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2878E872ED62CC507B1A6F702C096FD8960A@qq.com>

Hello Edward,

On Wed, Aug 07, 2024 at 09:42:40AM +0800, Edward Adam Davis wrote:
> Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")
> 
> Root cause: In commit c9c0ee5f20c5, There are following rules:
> In debug builds (CONFIG_DEBUG_NET set), the reference count is always  decremented, even when it's 1

That is the goal, to pick problems like the one reported here. I.e, the
reference shouldn't be negative. If that is the case, it means that
there is a bug, and the skb is being unreferenced more than what it
needs to.

> This rule will cause the reference count to be 0 after calling skc_unref,
> which will affect the release of skb.
> 
> The solution I have proposed is:
> Before releasing the SKB during session destroy, check the CONFIG_DEBUG_NET
> and skb_unref return values to avoid reference count errors caused by a 
> reference count of 0 when releasing the SKB.

I am not sure this is the best approach. I would sugest finding where
the skb is being unreferenced first, so, it doesn't need to be
unreferenced again.

This suggestion is basically working around the findings.

Thanks for looking at this problem.
--breno

