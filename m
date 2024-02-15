Return-Path: <linux-can+bounces-277-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B517856219
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 12:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345BCB2674B
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F012AAE9;
	Thu, 15 Feb 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAnP4cRv"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249012A14D
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997430; cv=none; b=Az6E/DnyM5O3GzAUPfVlv3lgoZr3fLJIeQxAFWItKdEHphTVeYnu67qs5o1gz7BFTf+NfkOQMrw8VWEotlVk+YZAYHCt2lktz+F2+r+Upjme4vXg1j1UbSpDqU7hD0peBu3w2+2/DbxFwpEMFopnoSP9G8ftKaauyGfzZVlwQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997430; c=relaxed/simple;
	bh=UTRi7hArcqCF9bXSNX38RRRB1wn578S0xhbsL7prpqY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G69gfINEdIc5Z1CU/vHWkvg2Ih4iIVsvt5ifFTlRTNQdyHAVt+TZKxV+HbKOBf58mqKG3V5uDmiGO3gy0HFQQ6QGIsNjwSQp4RzRGuPWPazFzgcTKz0Buzf/RWPfQTbkToGPZYtDorBxg6PjxsyueNWNC0IeTVqnhY0RDIWgEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAnP4cRv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707997427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UTRi7hArcqCF9bXSNX38RRRB1wn578S0xhbsL7prpqY=;
	b=gAnP4cRvAx0XowRGdqAWGLslU1Ge1FLnEaME1yNNnqgTEJQkHiv9e+R766SKDfbMjEKaPS
	1S0RGSU/2zyganXZQKwrvVvUWJRgUSytKXHJKgTErgzVZ/z0ayjYLd1QOIrDu35Xp0cBT3
	Qx50JfQ5H2iTnHgE4PYi46TXHq2uKMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-kSPtKfu0Ns2le5y1M2rhtQ-1; Thu, 15 Feb 2024 06:43:45 -0500
X-MC-Unique: kSPtKfu0Ns2le5y1M2rhtQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-411b1d7223eso1272995e9.0
        for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 03:43:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707997424; x=1708602224;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTRi7hArcqCF9bXSNX38RRRB1wn578S0xhbsL7prpqY=;
        b=JbHkb9G788jQjEBRRhWNQeFhtSXgSoO7dMIh/EIs31wGrRQX7579C6PbP2yhZp+2u9
         7Q3drVagrosINft1RaJ1F3LiHsZhuViXsxb7w+pM+Ty90ji4Rnnm1giEDJF4Ww9hijkX
         WBf4uYU9eMwXsU4XNwYFWWXC4fwhsI1VzT34I+yslT7Ikr4WG9LZVcTq8BtIWInGfswZ
         2Ld39GSyqjStZeE+0YDvZkhgwuHGrBdLRYAp/vSRsSiPK43FbIXUgQBdIYuzN8r8UiAW
         0t31mARAyUxCiVQldtsCtw6R9AG7nDNjeOf728OVPJ67BL+KU5y51nFuPnYh+CT0l2ZY
         tHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU26jGTOkGGcO2A3jRrMaE11jbGzN+giVsipyqxpJqfhYd8a1cMtxaZyHnuI878rKNMoDXlXJHl/dVqkKWtSs/+oMU5kJgAkmoZ
X-Gm-Message-State: AOJu0YzFmGM/WSPPW0uSsvgdmasMTydCCdn93uNrPzfYdc2KNMH4PPow
	BK7Otz/tqPO3HWYPp3alm/oN00InCYQKHkJO4pJXZfDowzOWGo3FBtQYRUL+tW2y3D/TqFAIFC6
	W9eRQXsLIXBWmL4wnr8RZl4p9k6EJF3UkRAig9jhXAnCTqD8X8MrlBhnFKg==
X-Received: by 2002:adf:e192:0:b0:33b:88a0:a1e9 with SMTP id az18-20020adfe192000000b0033b88a0a1e9mr1241969wrb.4.1707997424726;
        Thu, 15 Feb 2024 03:43:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6fWRSpuP+qqQhHlkiHh+C8785vsVrTNxgZJ6WL7wHZ9ZTF07eM+CnZRjh83y1aBmZ51+hFw==
X-Received: by 2002:adf:e192:0:b0:33b:88a0:a1e9 with SMTP id az18-20020adfe192000000b0033b88a0a1e9mr1241957wrb.4.1707997424410;
        Thu, 15 Feb 2024 03:43:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-156.dyn.eolo.it. [146.241.227.156])
        by smtp.gmail.com with ESMTPSA id u5-20020a056000038500b0033b66ce7ae9sm1576625wrf.84.2024.02.15.03.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 03:43:43 -0800 (PST)
Message-ID: <1b9377e954adab3cd007d77f8e618d3d49753f6f.camel@redhat.com>
Subject: Re: [PATCH net 1/3] can: j1939: prevent deadlock by changing
 j1939_socks_lock to rwlock
From: Paolo Abeni <pabeni@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Ziqi Zhao <astrajoan@yahoo.com>, 
	syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com, Oleksij Rempel
	 <o.rempel@pengutronix.de>, stable@vger.kernel.org
Date: Thu, 15 Feb 2024 12:43:42 +0100
In-Reply-To: <20240214140348.2412776-2-mkl@pengutronix.de>
References: <20240214140348.2412776-1-mkl@pengutronix.de>
	 <20240214140348.2412776-2-mkl@pengutronix.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-14 at 14:59 +0100, Marc Kleine-Budde wrote:
> From: Ziqi Zhao <astrajoan@yahoo.com>
>=20
> The following 3 locks would race against each other, causing the
> deadlock situation in the Syzbot bug report:
>=20
> - j1939_socks_lock
> - active_session_list_lock
> - sk_session_queue_lock
>=20
> A reasonable fix is to change j1939_socks_lock to an rwlock, since in
> the rare situations where a write lock is required for the linked list
> that j1939_socks_lock is protecting, the code does not attempt to
> acquire any more locks. This would break the circular lock dependency,
> where, for example, the current thread already locks j1939_socks_lock
> and attempts to acquire sk_session_queue_lock, and at the same time,
> another thread attempts to acquire j1939_socks_lock while holding
> sk_session_queue_lock.

Just FYI, Eric recently did a great job removing most rwlock in
networking code, see commit 0daf07e52709 ("raw: convert raw sockets to
RCU").

I'm unsure if the same reasoning apply to can, but perhaps you could
consider converting this code to RCU for net-next.

Cheers,

Paolo



