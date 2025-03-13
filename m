Return-Path: <linux-can+bounces-3051-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D9A5E8FD
	for <lists+linux-can@lfdr.de>; Thu, 13 Mar 2025 01:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA901899AEB
	for <lists+linux-can@lfdr.de>; Thu, 13 Mar 2025 00:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D3F9E6;
	Thu, 13 Mar 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFjkCsOv"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2772E339B
	for <linux-can@vger.kernel.org>; Thu, 13 Mar 2025 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825604; cv=none; b=OBPjf966gttj+6r4ymrqcaj5rk35e6pPYMQ2nxh+Ockj+gqjLkbr9xRym7S7q0WD0zLl0S0IwILQ7l1z9vAZ13m6EJZ/doxaomdrDcazfFeT3nTOCoYts0jkTPQqlOVnNKuaw9mDNOxVmrkWTJPgIBZDhlaTdyn9sxKLOlkJEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825604; c=relaxed/simple;
	bh=6Rc6J3Ph6dfxqwkjoMVz7ABCl1ew9fnFyyH4KQ9IHWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kD0R6RhIJOmuL2LpEr1jO1HSSUPDO0V1ojfzz0b39KC/LPlfzV+gMG7WRrK+xQr6yjtdKFDSueOUve9unqmgC+/K9rPwYUueaJDQ3DS+cy7ozlC6RltZEW3DKtI+zmrddESZh5NoyQHwKYwZHqq50WKsx6l43+zX3oh5YsugES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFjkCsOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741825600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xc6FM+mqWnW8B2obbyayW6a16PfjrreKGG+xe06AIA=;
	b=UFjkCsOv2d7emEV4mdhEbI5mm18RaVyez2mvxoR97mut307EZ2dV8OmOKi33sSgmiY2cdx
	oORB0Q3MTEmGL3rUDMn9/Np4/xuN95B9NgZi/ruseSEqhD8G54Cz09e+Mhc37NPqcOtacW
	mOHd7ce4fqF602i2geW5fTvaQ9Ffj/s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-X-UVCGhLPuyTycHPc9ff0Q-1; Wed, 12 Mar 2025 20:26:39 -0400
X-MC-Unique: X-UVCGhLPuyTycHPc9ff0Q-1
X-Mimecast-MFC-AGG-ID: X-UVCGhLPuyTycHPc9ff0Q_1741825598
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3010db05acfso660779a91.3
        for <linux-can@vger.kernel.org>; Wed, 12 Mar 2025 17:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825593; x=1742430393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xc6FM+mqWnW8B2obbyayW6a16PfjrreKGG+xe06AIA=;
        b=mpZtHCQ8o36tortsmgPhEOUFAyFRnIh60FIKPmft2vvJ0wl7YWWq+v0Ft6E25FJiFn
         wAlbWQvkie2zfDSKHHkNYhliLkXPCyDZX+p4UWnQ6I1JQYnlpwb6VaigqCoAmlN3i82k
         MpWLMpLHr8uylrW06lwUq7zhvVqir3XhbweOCTSyKXsgbXZvEAvLszqIkL2xJ/2PTBMG
         ua3uStHz7XKy+vd27S/uzetGOw2W89giN4PbvcOw74HBiU4Fbk5w7nZPpnGxtGbwFunI
         J9+iepP/6cMulK7IXp8m8du48YETTeyR+UdNit2e3V3vooZhcqy3r9PlzyfsckmZTD6M
         TTzg==
X-Forwarded-Encrypted: i=1; AJvYcCWcgGJVyv+D9cdds4iyJ1Fh6ga5/YPHNrNLQ4ghJfTnt5tFGFQ646ULMZslUSkJlwqo4ZIxE0TDDY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8/51TjAGmy15EyqyP6s7O+2Gez41vmqoUrEGTLAVMDyix9xM
	qFbIcCC8HCw64zCe4j4lrkuA/T8AttVqn36gDWlADI0xQiMaqjLSwPNTMIfH6gLxtRYhk+YjUzq
	EfZKLSQTfXSdnXsBsg5m0wTNh8KKK98jDFxTv1m9JOheKufKQzj9WEIVbMW/jBEnjtPDzrrEXBW
	XpVpVTch3zDnnU3AgOKOPpw7IugrorHVwS
X-Gm-Gg: ASbGncsEcl5KA4K+idjlEKT5cB3Q673GLGAC4CDx1VRtd+LmiJoD8dr70Vh0hB0/aob
	CnOYJajDoHZXV7J/uePD5A/EjZQxYrMB0Zv+bZ6jAewRQJSO1yxUmoh6+lELip10+YXzoEA==
X-Received: by 2002:a17:90a:d2c6:b0:2ff:4f04:4266 with SMTP id 98e67ed59e1d1-2ff7cef5c11mr28261641a91.23.1741825593460;
        Wed, 12 Mar 2025 17:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3dWZ4QwsfIUvoSozMvh5gYtrSDcXVdnTP4UK28eIoOYkpHPAKxIFpR9h9De/pEc9Z+J0NEctSIkQBCBJ5tuk=
X-Received: by 2002:a17:90a:d2c6:b0:2ff:4f04:4266 with SMTP id
 98e67ed59e1d1-2ff7cef5c11mr28261612a91.23.1741825592977; Wed, 12 Mar 2025
 17:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr> <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora> <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
 <Z9GL6o01fuhTbHWO@fedora> <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
In-Reply-To: <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Mar 2025 08:26:21 +0800
X-Gm-Features: AQ5f1Jotgxkur0pCBX2T6-2ZHfB5Ly_E8Asn7gts-0i5WF5UC5k-dBCU_8yc-ak
Message-ID: <CACGkMEtHZB8bLMqepRxd3qvtXWA8g_5pofNBw1=XvxF4ANr6Cg@mail.gmail.com>
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, Harald Mommer <harald.mommer@opensynergy.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:36=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 12.03.2025 14:28:10, Matias Ezequiel Vara Larsen wrote:
> > On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> > > On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > > > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > > > Hello,
> > > > >
> > > > > I thought there would be some more comments coming and I could ad=
dress
> > > > > everything in one chunk. Not the case, besides your comments sile=
nce.
> > > > >
> > > > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > > >
> > > > > > Hi,
> > > > > > a few nits below, should there be a v6.
> > > > > >
> > > > >
> > > > > I'm sure there will be but not so soon. Probably after acceptance=
 of the
> > > > > virtio CAN specification or after change requests to the specific=
ation are
> > > > > received and the driver has to be adapted to an updated draft.
> > > > >
> > > > What is the status of this series?
> > >
> > > There has been no movement from the Linux side. The patch series is
> > > quite extensive. To get this mainline, we need not only a proper Linu=
x
> > > CAN driver, but also a proper VirtIO specification.
> >
> > Thanks for your answer. AFAIK the spec has been merged (see
> > https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4).
>
> Yes, the spec was merged. I think it was written with a specific
> use-case (IIRC: automotive, Linux on-top of a specific hypervisor) in
> mind, in Linux we have other use cases that might not be covered.
>
> > > This whole project is too big for me to do it as a collaborative
> > > effort.
> >
> > What do you mean?
>
> I mean the driver is too big to review on a non-paid community based
> effort.

If you can split the path into smaller ones, I'm happy to review.

Thanks


>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


