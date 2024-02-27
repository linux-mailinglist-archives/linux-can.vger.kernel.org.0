Return-Path: <linux-can+bounces-348-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB6868B81
	for <lists+linux-can@lfdr.de>; Tue, 27 Feb 2024 10:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64997B22679
	for <lists+linux-can@lfdr.de>; Tue, 27 Feb 2024 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DDA3D68;
	Tue, 27 Feb 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsIwWfnE"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD854BCB
	for <linux-can@vger.kernel.org>; Tue, 27 Feb 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024562; cv=none; b=Png7S/8ABAvKr8scf5RU0hX49zckP4bWVvyudmF7tJMYKNA7w1Y04wXpCWjckG1i4/6gUOPiPA0mRxs+FCYXYZ2TsZ0+4VmltDvpZVqh2KpP/+hXmbGwqB7cAJAd+i7VoAwSuA+7gE2+s9Bl8Yom3LIMEpYgv0oCHyy1rW51BOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024562; c=relaxed/simple;
	bh=tjjn7VUHBtOLwll7FyS+3XVo+LQcNfHgZW2kSvy4R78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkuwbe9ckX9KYU9hUzmX9GL1yfZJWeF3X9atqVt2UxAY5YcemNK4wTGto1o2fm91W9SLP8CFEmx5eV+ZXhKHKKRVMUcngpJY3Q8sUfiwHfqEwxnhhKwEuBYazXOSoC5hTMMdDgSBLaEb4kSHARd3nSHT2cJasTS+uiAJi+KjQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsIwWfnE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709024559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlpacEWacryyrIlJZOoZ2EmsNR8IKw7FDvlRQtzIliY=;
	b=YsIwWfnEq7ad8JV2gj72KBoF/HpMcsDty3Y4F0E8dGuGQf8YWYFPLd3f8YrHkrBYKtklah
	hZgHKSuufMMSlQXiOitlh/cde2Y67vZmqxruOYxa7dtXhKEIBjdDrjmqtMBHv7KuWxHVWf
	PZrq2ktxhS0tPK+pQjR6PXoKhI7Oqs8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-BldydX7HPn6KGoacEiReeA-1; Tue, 27 Feb 2024 04:02:37 -0500
X-MC-Unique: BldydX7HPn6KGoacEiReeA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42dd52a27f7so47517831cf.2
        for <linux-can@vger.kernel.org>; Tue, 27 Feb 2024 01:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024557; x=1709629357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlpacEWacryyrIlJZOoZ2EmsNR8IKw7FDvlRQtzIliY=;
        b=c0cfb4pDq3GEuyyGUk9Vn0m/EWc/H1Uvz6fdE3sz1x51u/KCvmzsBbWJzIkTE4ZTDC
         OG7VERZRwSQyUxWEwVgJgjYu84JI6gokbPVZ6mzB3xD0bvE06vQzuXZzW3nEze1uBas+
         LVkvKepbtkCJslxrKOJjS1bNfRAvmYiZZL+xNWnFHbGHlepEtfI87d/KyrVnZUhk81WO
         UHszCqShUhfcC+mvWuXC8mEoWOHeCof9jKLx+xBxrKCd0MOaZ6y6SeMRvaCRJrUkliqD
         woyYv9rpQN78sVAV8HX91xzzp+ih/NVkuGvbWgNEeDr57hpkDId9veSPMwQC2BmO2PNo
         XsuA==
X-Forwarded-Encrypted: i=1; AJvYcCW8zKnKucAzT7AO8l5LIOCxPtR1ThiT3BL2OneRgVJClLp0bGkNeSo8ZTIK5qVGoI19PMVXtDVXXiDOZxGrGnZGZ7ofpUxC95OE
X-Gm-Message-State: AOJu0YwuR1KfqFzwKBmqm30jHl7i9Qzq4pzMPBgYxgO2G8oC63CY8eCI
	vyN8dqUDqaeZSFZ/z4K3a/dEZ3keLkBBoLmi0xEnAV4Kvypp/KZIN1YkfIj55h0hRwqYOv2qtZp
	eADFpHdF8OeKONkrDit7Y29PCjeIZGPTpmm9Gc314ov+gY4gep23l57r35yE2wminPw==
X-Received: by 2002:ac8:7cb5:0:b0:42e:71bf:fb92 with SMTP id z21-20020ac87cb5000000b0042e71bffb92mr8237057qtv.40.1709024556892;
        Tue, 27 Feb 2024 01:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEktM+QuiKRjrNahkKKCp6g6mPsIdmLJBBljJdl/Jpj1OjlZw9vIz8CtyenrJ+CoAmXDtw3rw==
X-Received: by 2002:ac8:7cb5:0:b0:42e:71bf:fb92 with SMTP id z21-20020ac87cb5000000b0042e71bffb92mr8237041qtv.40.1709024556554;
        Tue, 27 Feb 2024 01:02:36 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87546000000b0042dce775a4bsm3405359qtr.3.2024.02.27.01.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:02:36 -0800 (PST)
Date: Tue, 27 Feb 2024 10:02:33 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can:
 Device specification.
Message-ID: <Zd2lKYLGT8ZEFzZd@fedora>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
 <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
 <ZdX3xgM36iOVhr3V@fedora>
 <20240221-juggling-uproar-9518b4901f41-mkl@pengutronix.de>
 <877circsh3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877circsh3.fsf@redhat.com>

On Mon, Feb 26, 2024 at 01:36:40PM +0100, Cornelia Huck wrote:
> On Wed, Feb 21 2024, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> 
> > On 21.02.2024 14:16:54, Matias Ezequiel Vara Larsen wrote:
> >> On Wed, Feb 21, 2024 at 01:49:31PM +0100, Marc Kleine-Budde wrote:
> >> > On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
> >> > > > > +The length of the \field{sdu} is determined by the \field{length}.
> >> > > > > +
> >> > > > > +The type of a CAN message identifier is determined by \field{flags}. The
> >> > > > > +3 most significant bits of \field{can_id} do not bear the information
> >> > > > > +about the type of the CAN message identifier and are 0.
> >> > > > > +
> >> > > > > +The device MUST reject any CAN frame type for which support has not been
> >> > > > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
> >> > > > > +schedule the message for transmission. A CAN frame with an undefined bit
> >> > > > > +set in \field{flags} is treated like a CAN frame for which support has
> >> > > > > +not been negotiated.
> >> > > > > +
> >> > > > > +The device MUST reject any CAN frame for which \field{can_id} or
> >> > > > > +\field{sdu} length are out of range or the CAN controller is in an
> >> > > > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
> >> > > > > +NOT schedule the message for transmission.
> >> > > > > +
> >> > > I am not very familiar with CAN but how does the device figure out that
> >> > > the can_id is out of range?
> >> > 
> >> > In classical CAN we have the standard CAN frames, which have an 11 bit
> >> > ID, and there are extended CAN frames, which have 29 bits ID. Extended
> >> > frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.
> >> > 
> >> > So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
> >> > out of range.
> >
> > Another option would be an extended frame (VIRTIO_CAN_FLAGS_EXTENDED
> > set) and using more than 29 bits.
> >
> >> Thanks Marc for the explanation. Do you think that it would be
> >> worthwhile to add that to the spec at some point?
> >
> > Yes that makes sense as it clarifies what's meant by out of range for
> > CAN-IDs, for the valid length a reference to
> > \item[VIRTIO_CAN_F_CAN_CLASSIC (0)] and \item[VIRTIO_CAN_F_CAN_FD (1)]
> > might be added.
> 
> [virtio mailing lists are supposedly down for migration right now, I
> hope there's some kind of backfill happening later...]
> 
> If the question comes up, it does make sense to add a
> clarification... as the virtio-can spec is already voted upon and
> merged, we'd need a patch on top. Not sure if it would qualify as an
> editorial update or a vote would be needed, best to see it first :)
> 
I will submit two patches regarding the changes proposed in this thread.

Matias


