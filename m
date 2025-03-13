Return-Path: <linux-can+bounces-3054-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F422A5FFEC
	for <lists+linux-can@lfdr.de>; Thu, 13 Mar 2025 19:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FF94223C1
	for <lists+linux-can@lfdr.de>; Thu, 13 Mar 2025 18:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E191DDC23;
	Thu, 13 Mar 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOtfQx8A"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F91531C5
	for <linux-can@vger.kernel.org>; Thu, 13 Mar 2025 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891745; cv=none; b=G46wxqMvyNzYHtWWlfL0IWgcdoWIcQwyW684gWcJ2NqmoDTSw8WJChYFpZnoWf3bbZDNbgLeMg+h6xWkyCJ2thOewu3lrnLAPP4qCCntd5RpeXUsbKwKZfrgM75H8qamHjy/rFTwJE0VSG6wnLkG5l85DD+tVEfd/yNKQ1HmhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891745; c=relaxed/simple;
	bh=vGaveTKeKgCxAmnC9EQ4sn2CMv/qBrgjuvuYfa1RVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axr9CKYZp+ScvEr23eFMGrzguiydypb6yn67IoYltw88jt9YdpTQ5d8C8237WhSJI5STFMe9UojknJiqfvHETCxB4aejmkR0uxOax/jrkVyV0fvXZweniOzqIu4p0o98V1fIOjgdIwhkwAcajyBIVTuIrvQPfRTLDuD4Qhlm2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOtfQx8A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741891743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9aZe+iaudDpMDo0mPe7/sxlSIcMfnUdZ2EM2OaZ1sk=;
	b=TOtfQx8A4BAlHF0herogC60yzLNoeULbCTZTDpfhS4Iopv3cTBlnlJNz/4ttQMnnaHOvKH
	Pxs8rmrjlD6D5zcTkhp7hCz4x0H8MVkkqXln1OYbiyXoTDCvEDp1eXDXrKJcPnEHGWQwGp
	egZj84V+i2xP+tbCe/CsqYTeWLm4klE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-d81y4eydM5Ka2VZE8cyhqA-1; Thu, 13 Mar 2025 14:48:59 -0400
X-MC-Unique: d81y4eydM5Ka2VZE8cyhqA-1
X-Mimecast-MFC-AGG-ID: d81y4eydM5Ka2VZE8cyhqA_1741891738
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fe32a30so648759f8f.1
        for <linux-can@vger.kernel.org>; Thu, 13 Mar 2025 11:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741891738; x=1742496538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9aZe+iaudDpMDo0mPe7/sxlSIcMfnUdZ2EM2OaZ1sk=;
        b=wbsxI0fjMP0RJDpyQ5Owig490Hx+M5U6b2jmgoI28fChKzrmbOVmKtD67kSqXUoJq2
         eLuLNJ9n+nqYDDi0ySJoQznT+bR8S+ndtaUV86DEJ9Kiq6LTru1alNrcd9rU6xSxEMc/
         ZAjGFIMWt61MB5tteKGnuJcBgyNsPrBbCE/mmWTA5QVWZ2AU1Qm8fHinoHZTQn427N6q
         Z5dy89gZT14mr2TamMG9cIUrohg50qNvNF/3gDYf23OukxwQ3BxOLACNOqxknQwh9qrJ
         vQyqN8a4djhYEYhumTVgLMEqTKA5LJuauCIW5TrKOIr5FQNe2LBhVFb0/ZuU0QU6U6m8
         kKUA==
X-Forwarded-Encrypted: i=1; AJvYcCUOrAcf04DxVsLiZxF5OHBhXYZVt0uUPuSUFcLDd9UyBo6+KAcBwfXTwMLAaiOznn5/LS8MsCduFy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGT9QhlbX/yF0s1xWRIZj4SmxCUQJfQqggOGcPdWlaYBlVboD2
	ss0vKL8wpCFy+i9fQNCpSNNNuyzKNghjO0mggyERFBVSLDmw50eBCDDJ8rIrcw4uBMTX5e0Chgc
	hw8AgheO+HQpgigsIDjqSBx0atyDhdMcfwcpLy3VHQP7E6gfw91rg4elZVA==
X-Gm-Gg: ASbGncsrtwEfNVe2w+yboh68FwbYgn8VlSNDcPqKr1KsjYwZfuSg9HvaTPWgCDwjGZW
	rWCkuUrtTA6ZffpyrmOtp3MaAVGLE+GP0pIMl0xpWV5S3C+GaXIGrFTXaOeRsAhuFBR00vXPJdT
	w7oHPbpvA2Jra94dDJ9P9ka11nCRiOcMCNX9mdldpj3s20xmZri2h9CGdg7uZQleXZe6wxTUdzk
	QfvMif3xVq4qz7/IWU1wgbu02C834TRCYvQ44SXrdAJoKGsiSdw3Znvn4UO2gAS8otKuS8wT6zb
	9wTEIYPDKw==
X-Received: by 2002:a05:6000:178b:b0:391:c78:8895 with SMTP id ffacd0b85a97d-396eb8c4c24mr52373f8f.50.1741891738536;
        Thu, 13 Mar 2025 11:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiTFy8KH7Dv3eYYsTrcbBbEoTNapIuB3vn5zSLGQGf/vt0sASshS9p0fTfDPLfBsj9yQoDA==
X-Received: by 2002:a05:6000:178b:b0:391:c78:8895 with SMTP id ffacd0b85a97d-396eb8c4c24mr52362f8f.50.1741891738209;
        Thu, 13 Mar 2025 11:48:58 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm3076694f8f.11.2025.03.13.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:48:57 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:48:55 +0100
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
Message-ID: <Z9Molw9U+1MYCtFh@fedora>
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

What are the changes in the specification that should be taken into
account for the next series?

Thanks, Matias.


