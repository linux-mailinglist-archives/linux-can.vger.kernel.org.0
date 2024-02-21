Return-Path: <linux-can+bounces-338-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A91D85D952
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 14:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB72B240CD
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A5C29AB;
	Wed, 21 Feb 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZExeCK6x"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD846BB52
	for <linux-can@vger.kernel.org>; Wed, 21 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521423; cv=none; b=FWMgiAZhn9m/Id21PoSCKvLiVNf7wZqrPIf5mhQhSei+j8tGkcm5/ZpACNErYgSaoBjOiWgaG7OVijR4wAejDg215FZDkAti5fZDEKM2whCWqs2RLdQyiiU+SOZfDkMxkHEe2k/47R27bvSqR9Q4cT3PzuDRuSWw0lBusxFczKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521423; c=relaxed/simple;
	bh=Zy49exQngjBnqtJm9LbsD/Y7AaCQipJaILR8EsS+9y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESMMBAT8uzrIliis79iqB1DhkQZ3+1PVvlFpeWAkwACq8uVPKgSdhf6wLl5P0Fy3hWPuei+JEhwCcVTwciCkZopBUyTHmGkyvag0n65OwfUnMZw/GF3F8nZJd4a2i9IIcibV0h3Vs3VyOFwY6uxEN7AZTRvVgTiH5zWVPEPVlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZExeCK6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708521420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/w1WDwOHGakhJUAR/C6JZj5tsVNs/vIQZ9PZvXihR0=;
	b=ZExeCK6xk3w6UjWhSajjUShW7yIJyFzmdMnri7cqbqlYQ2pt76EnfHRQ37qi8r7goscbg6
	6Jq4fkXZmpNNc/o5cZfYLb3T1ZD4go2P3dwf52oXp3ZC2QaFc2+N75FN5sryXowgW+o/AK
	N3Q3GBfjAvZOVYMV0Sbd0e/VxCyWS60=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-COc188c8MRWvZvrvLL475Q-1; Wed, 21 Feb 2024 08:16:58 -0500
X-MC-Unique: COc188c8MRWvZvrvLL475Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d256d36f6bso5158601fa.0
        for <linux-can@vger.kernel.org>; Wed, 21 Feb 2024 05:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521417; x=1709126217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/w1WDwOHGakhJUAR/C6JZj5tsVNs/vIQZ9PZvXihR0=;
        b=Ot9uJonHiaYqlGvuIJFvbKudjNu6w0DRFDVc16+pqyBpfPGMhV1tVbGjSg4S+N9S2E
         LML1mw7FSPZZpw1H8SB1bazOVFeJEmqwdQktmcHlKhLf1ph9B0Xfj5S+lNqURGu1G9DJ
         H0ziYPs3kl69N6yy7OSuO1aRMuKdrZCdBbxcHOvJ7jxlaIdf0i8jlfFkRce9ERTfLMWf
         80y+GDV63NwSdGUCTX9okJZixQURoOsrhbGIR+7v+LpgYeEVqxPMAPcI3US3cVijKAdX
         mnseh667QQq6VVPH6zOd3vIIzdO3K5N8mT2bKhNWXkL8uIPu0UUdo4mhVdR8OLT7lUFN
         2GJg==
X-Forwarded-Encrypted: i=1; AJvYcCUaulGto5ZCXY7dJSX/Dm29SWeLRJ50gkVHpMFcttKpfclLawiWdKpm3NxGnqG4sNJNzomD6Pje1Y/M2OjQeF1c3560h/Esf6Hq
X-Gm-Message-State: AOJu0Yz5eiQDraMnzBo7cMlgFz5sPX5/lKpSsdF0AWnjVea+Xmlk5hXw
	XW/q0sFZjf/Pa7eoL2XvRYHCBWrb/rOks924MCJdywvbdGxx/93VX2vzj2fegYFoIJg9kGBuvH0
	kk8vNMo8quna0oPYeddULwkHCa8XPqLc8ZXkpj/NMM4WZIykRJdrGPY7Ju8I4tQdSSQ==
X-Received: by 2002:a2e:9858:0:b0:2d2:31f4:35c with SMTP id e24-20020a2e9858000000b002d231f4035cmr6596916ljj.25.1708521417005;
        Wed, 21 Feb 2024 05:16:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqTrtmtAQXm6a084V0K36E+nFmsfirlA7sHCUWcc7J24nFFUapF0/gtS/pp7AUV6Fb2PWRSQ==
X-Received: by 2002:a2e:9858:0:b0:2d2:31f4:35c with SMTP id e24-20020a2e9858000000b002d231f4035cmr6596894ljj.25.1708521416595;
        Wed, 21 Feb 2024 05:16:56 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d5687000000b0033ce727e728sm16677525wrv.94.2024.02.21.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:16:56 -0800 (PST)
Date: Wed, 21 Feb 2024 14:16:54 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can:
 Device specification.
Message-ID: <ZdX3xgM36iOVhr3V@fedora>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
 <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>

On Wed, Feb 21, 2024 at 01:49:31PM +0100, Marc Kleine-Budde wrote:
> On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
> > > > +The length of the \field{sdu} is determined by the \field{length}.
> > > > +
> > > > +The type of a CAN message identifier is determined by \field{flags}. The
> > > > +3 most significant bits of \field{can_id} do not bear the information
> > > > +about the type of the CAN message identifier and are 0.
> > > > +
> > > > +The device MUST reject any CAN frame type for which support has not been
> > > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
> > > > +schedule the message for transmission. A CAN frame with an undefined bit
> > > > +set in \field{flags} is treated like a CAN frame for which support has
> > > > +not been negotiated.
> > > > +
> > > > +The device MUST reject any CAN frame for which \field{can_id} or
> > > > +\field{sdu} length are out of range or the CAN controller is in an
> > > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
> > > > +NOT schedule the message for transmission.
> > > > +
> > I am not very familiar with CAN but how does the device figure out that
> > the can_id is out of range?
> 
> In classical CAN we have the standard CAN frames, which have an 11 bit
> ID, and there are extended CAN frames, which have 29 bits ID. Extended
> frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.
> 
> So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
> out of range.
> 
Thanks Marc for the explanation. Do you think that it would be
worthwhile to add that to the spec at some point?

Matias.


