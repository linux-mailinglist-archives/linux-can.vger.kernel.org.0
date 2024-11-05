Return-Path: <linux-can+bounces-1906-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B09BD286
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534611C21C85
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566E1D9593;
	Tue,  5 Nov 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PbeTKL07"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8117BED0
	for <linux-can@vger.kernel.org>; Tue,  5 Nov 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824684; cv=none; b=HCn5orgO1eumISLuxxaEa4GHG+rIZrTk7rcm5yWx0FQi6lE8334l3OLgFBEgAEYPg2a3hFESDB55wemHwPW2pWkTnVV8eqYKqP8k8ePgIXI05XV0m9SO+jfPYJi2YQ7YxBpSn/8e/QJx9/r+AeSvGyOraoIoLz45kwnr2T9PZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824684; c=relaxed/simple;
	bh=UPG74iaw03x8PRm0dgzbZb+xiF4olBPTv0VLsJp9BrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIOgWAaYzPTvf+cTXlXIs8HMQn3ALNM3w3ahXIgHMnFP/bAlJfzLvkfeCd9N0uv7uSKh8aQ2IZl9RksX0yHyTDVmUxONXYtbezruWcULAukHyQBieoLAdWPtbAoi1cauMS3mztf/+KYOexnXwDMX5bQVfS5Mx9hEMtWzcC2lZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PbeTKL07; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa086b077so735581566b.0
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2024 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730824679; x=1731429479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUEePHhzip2qYreLmdf4/2hJkUby3Nwn2S52dXJDtZo=;
        b=PbeTKL073V+NATs3/A9c7aIcno5rR+dDGrhkseH8MdMAbJC4ZIFLItDKI/4BaFYOkn
         ZysKOqG3eDCts72ymJvr/G6wbpr0gDZsjT2vs4Yvwhpb4VkgyyqdIVGPP4ewBq+sBZkF
         G5te0qBnqX7z2oz3bjWXwZydsb8dAZtdF+TJKoVxffhPmz020HPIfTCi3AQwfDa+JwRZ
         AlkkjDQnXi07t/vZ1rOt+nbHZ04wLNaTNi7735KDxIXE4F0MzN9ufoirVTJ1UUwuDm+/
         s28QBqE6nA+x+pYg/rRbS6HnfXwD4JYkxcA/5jMkl9hBP7kqUiXFMdqnEz9sZ6dNamn8
         69EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730824679; x=1731429479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUEePHhzip2qYreLmdf4/2hJkUby3Nwn2S52dXJDtZo=;
        b=HllRjasfGNdRHR228jjAdmdHGK3AMBwkSPQL1NQGiZzImKIL+sczOO7XV5+I6Xp5Tk
         SvIt90W3WUDRhUrlsmLmfpdLQzntLUv+Jf+q7u4YPi4REBAQyffAzBSuYI6hLxpIcnv8
         mlzIOO3Q7j92yOYGktkKgs8kztf0hrvKbA6f96i9oe/v2cYLYaGmdd6zX74eMn9w9O9K
         9CIJGoAQXQiwQPSKa+hop1mWv1QOW8uYfc3aAwph6igUzdFwADu+1Khh0JPJmzwSqoSg
         Abg1CGuZ+RqiU2hExXg5o/EMgk60NfJm/icrjytw8o3WtcwtFajUeNeokIenxEOyN4gz
         cQbg==
X-Forwarded-Encrypted: i=1; AJvYcCWxrPq+K+Kxf0IpmIuRK0iJxRcJH2ex8D5LxfVST6U/mAhsSTymUPQb5oGz4BZCTnmvio8J/GLGvhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2j4eNy4h/K/YNq5OfqAWjTJBvi+HrXSH15RqnfwKIfuFN3hgq
	0j/TL8f1bCtH6KqO5g6y+SXL9vUtr5OIW76fn0nPlx54PI0Hz1T1Pbr0BNhiNDY=
X-Google-Smtp-Source: AGHT+IG+KxFLAR0AN9YcgxLFtld6q5VPRj8YAKWGs178AyrLxQ0OcOk3eUVjRWsZWWXJmrtI1lvZDw==
X-Received: by 2002:a17:907:e6cb:b0:a9e:b0a3:db75 with SMTP id a640c23a62f3a-a9eb0a41a10mr331603966b.35.1730824678803;
        Tue, 05 Nov 2024 08:37:58 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f9b6dsm155109066b.158.2024.11.05.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:37:58 -0800 (PST)
Date: Tue, 5 Nov 2024 17:37:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <ZypJ4ZnR0JkPedNz@nanopsycho.orion>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105094823.2403806-1-dmantipov@yandex.ru>

Tue, Nov 05, 2024 at 10:48:23AM CET, dmantipov@yandex.ru wrote:
>Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
>new skb, I assume that the same should be done for an initial one

It is odd to write "I assume" for fix like this. You should know for
sure, don't you?


>in 'j1939_session_new()' just to avoid refcount underflow.
>
>Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
>Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
>Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>---
>v2: resend after hitting skb refcount underflow once again when looking
>around https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
>---
> net/can/j1939/transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
>index 319f47df3330..95f7a7e65a73 100644
>--- a/net/can/j1939/transport.c
>+++ b/net/can/j1939/transport.c
>@@ -1505,7 +1505,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
> 	session->state = J1939_SESSION_NEW;
> 
> 	skb_queue_head_init(&session->skb_queue);
>-	skb_queue_tail(&session->skb_queue, skb);
>+	skb_queue_tail(&session->skb_queue, skb_get(skb));
> 
> 	skcb = j1939_skb_to_cb(skb);
> 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
>-- 
>2.47.0
>
>

