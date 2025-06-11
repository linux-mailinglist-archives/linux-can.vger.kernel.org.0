Return-Path: <linux-can+bounces-3807-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22772AD543B
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 13:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E673516976F
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7825BEEA;
	Wed, 11 Jun 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPLHyVGY"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AE25BEE3
	for <linux-can@vger.kernel.org>; Wed, 11 Jun 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641999; cv=none; b=OBohT4BMZ/IXVxprGENR58dujLofYIY+CsUka6AcsGAsoRnUvbIi1uXBQl2SKEys8pnR0tmKd4qWNDepHqqrtafXAN0cO4ljhwj61CnA9s9U9W1WKh3lx1GMuGO6/GDftET1NAoaV1vLkf/CROlYoh5ibdPpKQIod9AXgdZEsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641999; c=relaxed/simple;
	bh=QPPFuoZ3d4W5VV8HW1sVSL7jX4Xs4dHXPiQH8dRGzic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atQuEUTw3T6uLbkwXRAA5KPsPErrnVSfe2xwltpnlbBWLQqH2SbTVWPavjPyajLCpW478gJMGNm9lmHEPCRNDWYM9bbg3zEdOah0HYqNYKYrt8R1dKqy5vaaPwv3ezOEOCXfpXiB/9xcD4y/hXqqS6gIQDTgTFwhh9z2QuyF4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPLHyVGY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749641996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyBz4kAiu10VL86LEJ1Vf5IRYzjxg7iBJOh/zIIAubM=;
	b=UPLHyVGYmJ+in/z5NNMRkrR8n2N1Jzvy6Lk3Rmy3RGbw7TI9+TNVpzz5oYiU8gDkrvBrmL
	i7IHKdM1HPN89nuAqGZITexUZGYYGuwww7hePB3cGSpmjDBZU6h7JiFCIYU/JbjTI1/OKI
	co/Z+4Ouo6dxQoDy58vUdE5hmDZUwnY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-tAuAj7o_PVO_OAdWXtT3uw-1; Wed, 11 Jun 2025 07:39:55 -0400
X-MC-Unique: tAuAj7o_PVO_OAdWXtT3uw-1
X-Mimecast-MFC-AGG-ID: tAuAj7o_PVO_OAdWXtT3uw_1749641994
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3848162f8f.2
        for <linux-can@vger.kernel.org>; Wed, 11 Jun 2025 04:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641994; x=1750246794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyBz4kAiu10VL86LEJ1Vf5IRYzjxg7iBJOh/zIIAubM=;
        b=DxAv1KSoEKZ0X8ZjHqXmwgsGH/51rUacptbxk0XrGkR27sQbEUK4pNo4k06g6de6MW
         EfnByWtgiN169rrhqOXRQV0x7UtGb3dBL0XstzT2kW49GmHliT6Sk9Q0sXT3R2mjgHS/
         EoqCP1nfvnqTjUJa4UTYWMKTwDtnzZVEcbmeHJifzi+p7jijzT9HIh1atj1s0XohSCVd
         rYy1oUmhCTbMnh6Sx5+GovK7HePGYNloXtn5hivM3udpHFi9t6uRaByhxCTD5tTI5SG9
         XuMR7qPzmuQErvbJr1HyysTXAxnL8Z4/RxbwwZKPKw2leMh8RhJQ50MNnPnviA4ki7le
         Fagg==
X-Forwarded-Encrypted: i=1; AJvYcCWXtg40GeLDSqbMR3PVmDOGr+OxT2J7JfPVrMWJ1XZ0uOiY98bPtGLc9O4PKP5AnVfE5xLUATom+dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKK9IunRnjWEuK/smgvkBoYOs7Cc8iqIyT4OXDs060JKI0/swK
	NQV8XBGMlcLoVmWi9uhgdx7J6VY4/nFFwgnr4k/94ZT3+cwoHkrqb1IY+JyV9dS3CILYivbjjrP
	Ybczf48PNzol9FvZ5roZs1p63ZDpdpc0rcreuyOJ4WWgiBpZujwShGiMxWvIfpyWk3QkwstR+
X-Gm-Gg: ASbGnctZfNjt+SZM4kPPIOI+/ZnjXW4itOvKl/8Fu0aYHIxW9tSmK+iZjvfnr+UhQTm
	a553c3VEAk4xHl6cdx9ugM0D33ArxK6uekB82Jhb8HChIB/r48p4QH+7vGI54OURkh4fAcrSC4H
	t9ZJb5mB6vu9pXwLdmtsIbUdDVkbcCGgHCryjsCUeea8dbpqIGsmlnCCYdBbJsqD4BVfmtdQdTw
	O6nc381HFUK/9Q8zVFFrnUATbHbbjqjHWbdIIs7A157HAQ5bFV72XYoOCjOtdD5n6rLM6O5sL2s
	OSINUyifu6kGee6zR/WdDHfftid9DYjLF72iM7rDVio=
X-Received: by 2002:a05:6000:430a:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3a558a31835mr1993893f8f.47.1749641993872;
        Wed, 11 Jun 2025 04:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRUBKlfDmwu/XPXakdq33ilj8R46WG1+OEU6DJFMDzXj+rsrCDUY8YS9lGv5cDnB6ADuhUxg==
X-Received: by 2002:a05:6000:430a:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3a558a31835mr1993872f8f.47.1749641993479;
        Wed, 11 Jun 2025 04:39:53 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531fe85260sm31418165e9.0.2025.06.11.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:39:51 -0700 (PDT)
Date: Wed, 11 Jun 2025 13:39:49 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
	davem@davemloft.net, linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 6/7] can: add drop reasons in the receive path
 of AF_CAN
Message-ID: <aElrBfTYkepfUxD-@dcaratti.users.ipa.redhat.com>
References: <20250610094933.1593081-1-mkl@pengutronix.de>
 <20250610094933.1593081-7-mkl@pengutronix.de>
 <20250610155039.64ccdbda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610155039.64ccdbda@kernel.org>

On Tue, Jun 10, 2025 at 03:50:39PM -0700, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 11:46:21 +0200 Marc Kleine-Budde wrote:
> > Besides the existing pr_warn_once(), use skb drop reasons in case AF_CAN
> > layer drops non-conformant CAN{,FD,XL} frames, or conformant frames
> > received by "wrong" devices, so that it's possible to debug (and count)
> > such events using existing tracepoints:
> 
> Hm, I wonder if the protocol is really the most useful way 
> to categorize. Does it actually help to identify problems on
> production systems?
> 
> AFAIU we try to categorize by drop condition. So given the condition
> is:
> 
> 	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) 
> 
> my intuition would be to split this into two: "not a CAN device" and
> "invalid CAN frame". 

hello,

yes, that makes sense: I will post a follow-up patch soon.

thanks,
-- 
davide


