Return-Path: <linux-can+bounces-5178-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A0BD84DA
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 10:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4207842499C
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6F2DF71C;
	Tue, 14 Oct 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="ngGd1scu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="cxNKIHTN"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980322D876F;
	Tue, 14 Oct 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432103; cv=pass; b=HdXXWotKYh78/i9u3Ee8gxHFjW7QX28rWvMiTaRTiMzPVEYuLGadcjsV5qgdjxACbrKWcrkxoXHR68VilpwuBklc7w2Yful0S1WG5F1VzwHYWfU1cJLqCKMD74rt+Xt4RbcgcLKvtiJPoCoTYJg6gne6iwnnPaIDWRjLKULL8qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432103; c=relaxed/simple;
	bh=+KOCzTUQxF7tBG8tIQArtu0WukAm1yPCMNY0jgO/01A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smv8gHCiwesSzU+oIEYpj60FlXuKxrJEASsKgW8RbToAgs5xovNLKTTjGGMPRW7+qZ/BDwXQqktxzHnQuwyqhXmXDVyYNOpq5BZTCPsAiTLxZuRc9fs/Lw9vpWBcVHYPJpL30f6ELim9fnf4gFxCKft+jCBwEA2alaecAQV68xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=ngGd1scu; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=cxNKIHTN; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-glw0.prod.antispam.mailspamprotection.com; s=arckey; t=1760432100;
	 b=JXCtVIFRhgOtJzCDDH7CiOqK13YaILrtEmI0Xf8JaWJxVRurBpqZzySPpjzngQIeEiW2Sh1rac
	  4fxqvP0MK2UZNBrFCUfX4JEThWQIjyA00+yAkdQkPS36mvo9/MNWe+OoLQ93122pO34TnuLKmu
	  MxCf4xXD5AkJTnujWBMaTNBrKrqDLMfS2Trvslnt/bJRqyL2JquYP6kxDASdsBDcY6EIdInVfd
	  XAzU9fp+aXcbajV31S7E7P1imt2Ug+ac8dCY2Fxk2owvYGq21mXWZ9iI9A9cv9o8aKmDkrn49o
	  2k8z1bZR4dUS3Y0GV1Oqu4uEjGMemMjZhPT7uviXXawPZg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-glw0.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-glw0.prod.antispam.mailspamprotection.com; s=arckey; t=1760432100;
	bh=+KOCzTUQxF7tBG8tIQArtu0WukAm1yPCMNY0jgO/01A=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=EpwfR2gcZL36igiG1iyKMBxqn8SQEm/gyy9Flsaq6Tk6oENFTBeJlbnxQEy/GxDyte92MJtPGB
	  adDhjb11fnnfMzzSiV3wFEGgDo4l8xowWMfDMEinnWgFsMGbQAizI0Rxb4SgnnXQVioCLeCbjL
	  pSXHGPEJZqUv4YjKPqT2k21deQhRTHwggBL+7bKqYbwdYtuLhJklyytKUoeAHEKFhKLoh1b47C
	  8UYH1I0rwE6RIalvqzm69Cf2Db1z+oJyHlctIhFY9YnNndfLXEGC/4Qs0PbelzVFhNymjh/H12
	  8BjJ+KV91ZYPlcVKNpFJ+csRmEyrXoTgM+2+2d+tpyg7Kw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=+RRcVYG+JUhl3wwxa7uQJx37j5Sku3cHAniytdo2VwQ=; b=ngGd1scuyL146Rjl0fZAqcXeID
	F+xueOFpnVES7xVlo3yf0p6UVSbP9rsn4pkn5ahUdYTMeecTqKCvag8favFgXYywFlYzOsBkmfCQ1
	K3R/FwBKEtBd6Ahew60E42MCpAnQRkmrR7O2sA78LZFDwsSrWSoBgVWdu+cu5co/KgsE=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-drbk.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8Yvg-000000063Jf-1U9W;
	Tue, 14 Oct 2025 06:54:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=+RRcVYG+JUhl3wwxa7uQJx37j5Sku3cHAniytdo2VwQ=; b=cxNKIHTNYmuzDNfeOKfMSXI46U
	HXOanL9R91tN80jMXt+g62vZhFF46VPRinAMUPxr1ZCeUnrqsYsyLtmQPuLt/vJPwGCGUsGLbGvFu
	1tKEk4BT3+rasp2VKC1WjtVb0M9JQDmAuFt1Vp1/6BE7axLKcgmUCvGCczdUGS7ikmQ0=;
Received: from [87.16.13.60] (port=63318 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8YvQ-000000003P6-0BXm;
	Tue, 14 Oct 2025 06:54:24 +0000
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Harald Mommer <harald.mommer@opensynergy.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Date: Tue, 14 Oct 2025 08:54:23 +0200
Message-ID: <2332595.vFx2qVVIhK@fedora.fritz.box>
In-Reply-To: <aO0qZ4kKcgpRmlIl@fedora>
References:
 <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box> <aO0qZ4kKcgpRmlIl@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: daf0a63d4e4924339fe71702a2ced5de
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v8Yvg-000000063Jf-1U9W-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-glw0.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Monday, 13 October 2025 at 18:35:51 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > [...]
> > 
> > > +
> > > +/* TX queue message types */
> > > +struct virtio_can_tx_out {
> > > +#define VIRTIO_CAN_TX                   0x0001
> > > +	__le16 msg_type;
> > > +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > > +	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > > +	__u8 padding;
> > > +	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > > +	__le32 flags;
> > > +	__le32 can_id;
> > > +	__u8 sdu[64];
> > > +};
> > > +
> > 
> > sdu[] here might be a flexible array, if the driver allocates
> > virtio_can_tx_out structs dyncamically (see above). This would be
> > beneficial in case of CAN-XL frames (if/when they will be supported).
> > 
> 
> If we use a flexible array for sdu[] here, then we will have a problem
> when defining the virtio_can_tx struct since it is not in the end of the
> structure. I think it is a good idea to define it as a flexible array
> but I do not know how. 

In this case, I'd move struct virtio_can_tx_out at the end of the
virtio_can_tx struct - in this way, sdu[] would be at the end:

struct virtio_can_tx {
	struct list_head list;
	unsigned int putidx;
	struct virtio_can_tx_in tx_in;
	struct virtio_can_tx_out tx_out;
};

Maybe an additional comment declaring why it is done this way would
be a good idea? Also considering that the two structures are defined
in different files.

Francesco





