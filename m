Return-Path: <linux-can+bounces-3045-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B588A5DDFC
	for <lists+linux-can@lfdr.de>; Wed, 12 Mar 2025 14:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689F77A1DAB
	for <lists+linux-can@lfdr.de>; Wed, 12 Mar 2025 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6485215539A;
	Wed, 12 Mar 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv/3pAYv"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E523FC40
	for <linux-can@vger.kernel.org>; Wed, 12 Mar 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786098; cv=none; b=NtlxtwL+d24t52YNsn9fRH1OCjIKngG/Pp6QNJIr9npcOA8ZQeEEJCULUw70EEPDY4GY28Gy07PcAMsxQrL2lXhVR0l6VPuZOxtN14zVu2mY+cJW2XCgFEU4nkKBwYIhk1kfg71fcDm21hXXMoA18jZ6anf0L6Epn5btwWjmAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786098; c=relaxed/simple;
	bh=bppsgeCLPOVJeGMR97jVKd7rPBeAw9kXU5zpyCLPEJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKXOLe78EYb6rJFom3ZC1VSnq1nsk2gMmdSU+XbNMEEu08bk6gKd2XgslF+QiN2mg/yUTksStCgbXER8fdcFaqbEuaLH9+AYtbUG8nK0g6rHDVQlBa5Zs5IHrMIate0zjBs6K/xjuW5d2aDrt5dooLAlsMk8X61cjjz2imQd7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sv/3pAYv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cd4wn8Fv1QUp8UgtRjUbrAGy6ACAXSarUlDGzc+cAok=;
	b=Sv/3pAYvpBsFn/8q7A3AwpJzWoAL7ZWKhDdhph+JQWMntNHZbZWSLeboWS2rSByT4G7Bru
	CARtot8l0Jzrivn64QJcchrnwFEVSyjQHu1DPAqUciatwAIlElc+Dr3DJuIvDbyR3Bjra5
	C9MkD7kNjmed91M9frOLe51cvrXCJP4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-IKox6tbgOUCtu2zG4BxAQQ-1; Wed, 12 Mar 2025 09:28:14 -0400
X-MC-Unique: IKox6tbgOUCtu2zG4BxAQQ-1
X-Mimecast-MFC-AGG-ID: IKox6tbgOUCtu2zG4BxAQQ_1741786093
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so29197215e9.1
        for <linux-can@vger.kernel.org>; Wed, 12 Mar 2025 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786093; x=1742390893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd4wn8Fv1QUp8UgtRjUbrAGy6ACAXSarUlDGzc+cAok=;
        b=Cqg5YH6VbNdBhKPVhZnBcNz0avP65W9PgmMRSXilnRWGpPQvEBVz45ZbR0ffnqVxZz
         q2nIYpLMyXV/drkZPMmuaAZdAp19l5VU9DO8lbqdO313S1Yghwbn70+stz9Q2P86glbI
         u3xiFETUcZG1RXrHwbBIb6nfpK8atM1kQcnkpS1KOIEwZ7S6v4Gd8z1ihnOmP7SBx1is
         Y5EmhsYXXMRuNBNCEpcgZXEVhSV3udIG1Qpjj51O2b3WA5kE8Z7eVEi/DRNm/Xp+X1IV
         Xg21gAoAJXrdMvkmjQxBJcsdgraH0vWg5Fft7OeWELxO+AOTTXmbk9q18k/IxWPQlqR+
         RZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcUkbHcv4TEyswRyOzOo5DzKPrbqdm/OLzv5ZCJzC1i0dYG9TG29W0gyA3qnAKo1xetd8AMNiboLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3Ko30UwDpvVpMPxImqxklpsn4+I08s/kXKtZRhTRM2DDrIim
	8KUSKNXT0Iwy4NKYlOH8vjfR+84qUJenp9HjJoznp8ZUf64T3yyTUR5n+wAJaLFayGj+/NOAY+b
	MeNl0+43mEIepE2D5+2/vOhcijHw9HGgTgVpnWYHDEQjUDGtnBbAZ9hgiXA==
X-Gm-Gg: ASbGncvhN1lMEAGg0JEpZGqiqCngkr+wQOr4wgQAV1nh4EsjcK3Je5GBXdpIEyZOgob
	laNOfDryarlEOiPnt5pJ//RMqKPZBpEcM8zQU+fgEfAGBuYPVJtL3pha2lEv4ozo9Z4qRZ1osTG
	Wky6Nsmwv+vKB9Hkwb+zVR171VZ5bIWSCzNL77/vBSbMUvd50xrSlQLA/34baFgs6cg2hWtRMcB
	mmNU3TM4fpFkBpeMjcRJbyHKT2FZBDdeyyByjOiUxwZfpJCcUpvm1ksP3/OndYz95Nuv0Xq0uxz
	b5qnDtYNWA==
X-Received: by 2002:a05:600c:198b:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43cf5fe5e0emr116970145e9.4.1741786093071;
        Wed, 12 Mar 2025 06:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrFZYXg7iC/H/VXbl+Ds5zQUdtIQbQ9fB3jQl6MW8bK6C7iTZoHzvzY6YXwej9HbMobpTCbw==
X-Received: by 2002:a05:600c:198b:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43cf5fe5e0emr116969905e9.4.1741786092685;
        Wed, 12 Mar 2025 06:28:12 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72eb5fsm22019125e9.8.2025.03.12.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:28:12 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:28:10 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@opensynergy.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
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
Message-ID: <Z9GL6o01fuhTbHWO@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
 <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>

On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > Hello,
> > > 
> > > I thought there would be some more comments coming and I could address
> > > everything in one chunk. Not the case, besides your comments silence.
> > > 
> > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > 
> > > > Hi,
> > > > a few nits below, should there be a v6.
> > > > 
> > > 
> > > I'm sure there will be but not so soon. Probably after acceptance of the
> > > virtio CAN specification or after change requests to the specification are
> > > received and the driver has to be adapted to an updated draft.
> > > 
> > What is the status of this series?
> 
> There has been no movement from the Linux side. The patch series is
> quite extensive. To get this mainline, we need not only a proper Linux
> CAN driver, but also a proper VirtIO specification. 

Thanks for your answer. AFAIK the spec has been merged (see
https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). 

> This whole project is too big for me to do it as a collaborative
> effort.
> 

What do you mean?

Thanks, 

Matias


