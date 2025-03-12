Return-Path: <linux-can+bounces-3043-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94306A5DA70
	for <lists+linux-can@lfdr.de>; Wed, 12 Mar 2025 11:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3501898D8D
	for <lists+linux-can@lfdr.de>; Wed, 12 Mar 2025 10:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF8237707;
	Wed, 12 Mar 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhaNzZuA"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E015A858
	for <linux-can@vger.kernel.org>; Wed, 12 Mar 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775481; cv=none; b=iiRQ3JXM3ayY5pW1FLk9Au8U1dKgddavbTRwrjO2/mJ7SSGeS/jN7Kd4qgeSI/aJ7kPWq2LcgzUaf58gTOr2W2OlcOpCXhfyJ7VqlFkqx6ISuV+JHkmrW/dydMjqTcxJgEDcXvfPGZnuwkl/3YEsHNx2p4dimWvQb/FFlcXnYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775481; c=relaxed/simple;
	bh=P99lE3mJwXPj+GEbmP0xwX+rf4eTqzBXZGRaykWQ8v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKJ6SlUaO6TiqF8wH9LyAAW9JSl/S++6G0q+5/eXyMoWr88NL39aYLp6PfhsWTSnUIj1WIhpdYObanU1luz9myBP1D7mNfxU4CoKUwXC7yFzlIMZ/ucPDt3YRC/evF85vsLaFEUB59K+gyGLN5JA+4ldVVbm7nC+eCv5Q2fxXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhaNzZuA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741775478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx0qYAqk+Ndkh+zCqVoXeKfQLXTHj6djYkow7w5DHN4=;
	b=JhaNzZuA/KZTKA0gxXCl5msYwoHcs6YTaTvimCdD8BB0VAHTOR+UOzLmHlmUuKTfuexhSe
	elmn5X1qQfK5brk00mD7s1eWSkNcVZHeuFeaVe7BqpPeKW8weRt3Wt3JnuoTrLxEsrLN5s
	QbG8Ncn6eUWGbzWWjAB+5FKaekdy7eg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-BR5t29ZmNayaSphYR_HDvw-1; Wed, 12 Mar 2025 06:31:17 -0400
X-MC-Unique: BR5t29ZmNayaSphYR_HDvw-1
X-Mimecast-MFC-AGG-ID: BR5t29ZmNayaSphYR_HDvw_1741775476
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so26175945e9.3
        for <linux-can@vger.kernel.org>; Wed, 12 Mar 2025 03:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775476; x=1742380276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx0qYAqk+Ndkh+zCqVoXeKfQLXTHj6djYkow7w5DHN4=;
        b=KcN24U0BrRVPXN53/2AEbo27Dq4fmC2dJ86uAJM/tXkgTtz2xdc13fRB93J8WqiZFf
         v4Qzy8Ws2k7/QJgIg2yQBKabLYA3sTO84V46+WANsEAbJzEE/nyR9raUUc1ptBg29tQQ
         D8GNiPGfyelleY+Rfi0Is6edXI4nNJ4CBCn9ZaQPDlh44pmjf8Bn7wkR1hMzrPNzf9fd
         q30RnLAXn2MJ0vAVablGVtobIWJuUyDJKkIgnFVe/LtXzS7G5fquJxFCVWeXqnRrjkGz
         HB4i6YpVn/5UjoBMyitcylpFDK3YGWxIYLQDtDZRgoY62GKn62b+7TSaFZCspNfUd+VX
         b/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNVjmSbfmh7SNSsGNj5l8N+Xgw44Xma7x6HqOTgwzKS+ftr1LruhEeoz0jsYelrdxauJntTTYsfmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqaJDyNUktWRBPN44JD28uds4c5s39+Ss55OiNU0sYJnkaOrqa
	ZHFQwdQ0M3bAOc7oBShd+sej8VNR7O8L2sqf34kHqNvBdma3XdSwYxxDsBVd1FtDidO0zRvVA4x
	x8ahNl7jJknYxZ2wZqzeA3G6rY93PUFyr0Lwf5vA9mA+n9qmOPwgVyoZYPg==
X-Gm-Gg: ASbGnctSX18SVPBG8FFv1+ys5KfqWlOIXOaBl/TL9ke7OkJe3nhyf7yQDJOvGUK9j0V
	fJYIi6D93HRtaYFAxvfo9N0mq8lpFkphHiCoCeH87BI2+d+ax///1w609ep/De3qIB6k644+HUh
	UvUOOWgqU6pUZFYI03jJTP/AazEIZ4XI0umJd2dkTp+o8sf6eW4DPsBrSWnHiPMQisi7REJvcge
	aVDezoYsU0V2HHGoRmOeyDNwE9oyyLkEp1joHzc4mVvVsltQDrsOdt0t+aT81pLCicTEXCaFD/p
	Jf8qhlJYNw==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr90683925e9.14.1741775475784;
        Wed, 12 Mar 2025 03:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMo39VgoZH85nAphCFnLGhSo95m+X8Gu22NIYuOsLFerRQWzuG2jF+y+KHgzz3MHJwbiYZow==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr90683655e9.14.1741775475423;
        Wed, 12 Mar 2025 03:31:15 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72eb5fsm17374525e9.8.2025.03.12.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:31:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:31:12 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9FicA7bHAYZWJAb@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>

Hello,

On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> Hello,
> 
> I thought there would be some more comments coming and I could address
> everything in one chunk. Not the case, besides your comments silence.
> 
> On 08.01.24 20:34, Christophe JAILLET wrote:
> > 
> > Hi,
> > a few nits below, should there be a v6.
> > 
> 
> I'm sure there will be but not so soon. Probably after acceptance of the
> virtio CAN specification or after change requests to the specification are
> received and the driver has to be adapted to an updated draft.
> 
> 
What is the status of this series?

Thanks, Matias.


